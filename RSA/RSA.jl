module RSA

using Primes
using Random

# ─────────────────────────────────────────
# Key Generation
# ─────────────────────────────────────────

function find_e(phi_n)
    i = 1
    while true
        if gcd(prime(i), phi_n) == 1
            return prime(i)
        end
        i += 1
    end
end

function keygen(p, q)
    n     = p * q
    phi_n = (p - 1) * (q - 1)
    e     = big(find_e(phi_n))
    d     = invmod(e, phi_n)
    return (e, n), (d, n)  # (public key, private key)
end

function generate_keypair(bits::Int = 512)
    half = bits ÷ 2
    p = nextprime(rand(big(2)^(half-1) : big(2)^half))
    q = nextprime(rand(big(2)^(half-1) : big(2)^half))
    return keygen(p, q)
end

# ─────────────────────────────────────────
# Message Encoding
# ─────────────────────────────────────────

function string_to_int(s::String)::BigInt
    parse(BigInt, bytes2hex(Vector{UInt8}(s)), base=16)
end

function int_to_string(n::BigInt)::String
    hex = string(n, base=16)
    # pad to even length for hex decoding
    hex = length(hex) % 2 == 0 ? hex : "0" * hex
    String(hex2bytes(hex))
end

# ─────────────────────────────────────────
# Encryption and Decryption
# ─────────────────────────────────────────

# TODO: implement OAEP padding once hash functions are covered.
# Currently deterministic. Encrypting the same message twice
# with the same key produces the same ciphertext. This is a
# known limitation of this implementation.

function encrypt(message::String, public_key::Tuple{BigInt, BigInt})::BigInt
    e, n = public_key
    m = string_to_int(message)
    @assert m < n "Message too long for this key size"
    return powermod(m, e, n)
end

function decrypt(ciphertext::BigInt, private_key::Tuple{BigInt, BigInt})::String
    d, n = private_key
    m = powermod(ciphertext, d, n)
    return int_to_string(m)
end

# ─────────────────────────────────────────
# Demo
# ─────────────────────────────────────────

function demo()
    println("Generating keypair...")
    public_key, private_key = generate_keypair(512)
    e, n = public_key
    d, _  = private_key

    println("Public key:  e=$e")
    println("             n has $(ndigits(n)) digits")
    println("Private key: d has $(ndigits(d)) digits")
    println()

    println("Input your own text to encrypt:")
    message = readline()
    println("Original message:  $message")

    ciphertext = encrypt(message, public_key)
    println("Ciphertext:        $ciphertext")

    decrypted = decrypt(ciphertext, private_key)
    println("Decrypted message: $decrypted")
    println("Match: $(message == decrypted)")
end

end # module RSA

# Run demo
RSA.demo()