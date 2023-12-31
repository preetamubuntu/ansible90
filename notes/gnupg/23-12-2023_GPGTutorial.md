# GPG Tutorial

So that knowledge do not dry away.
Date: 23.12.2023

GPG is used to sign and encrypt document/data/email when at rest.

## Procedure on Rocky via vagrant

gpg is already installed on rocky9
version is listed in the command below

```bash
[vagrant@procky ~]$ gpg --version
gpg (GnuPG) 2.3.3
libgcrypt 1.10.0-unknown
Copyright (C) 2021 Free Software Foundation, Inc.
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /home/vagrant/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
AEAD: EAX, OCB
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
```

important information in the above output

- homedirectory for gpg is /home/vagrant/.gnupg
- version which is 2.3.3

### Create a public private key

before you start, you may need to install pinentry

`sudo dnf install pinentry -y`

Step:01

gpg --expert --full-gen-key

- select option 9
- select Curve 25519 using option 1
- select key expire 2y (for 2 years)
- provide all details except comments
- finally provide passphrase

Step:02
Check if all went well.

gpg --list-key

unique identifier is last 16 bits of your fingerprint. You can find them using

`echo 2A8C437D2F71DFD38686F482EBF76BED7A928043 | tail -c 16`

## What is keyring?

Keyring contains your public key and imported public keys. Key rings are located in ~/.gnupg/pubring.kbx
