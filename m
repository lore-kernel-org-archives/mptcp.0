Content-Type: multipart/mixed; boundary="===============0776112421707742203=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix ADD_ADDR HMAC in case port is
 specified
Date: Sat, 13 Mar 2021 11:28:33 +0100
Message-ID: <d82f0041-7889-a189-bb7b-4dfec74e8120@tessares.net>
In-Reply-To: 74f12b1cf1e60fbfba1b737b8949526346afb983.1615584629.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8147

--===============0776112421707742203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Geliang, Mat,

On 12/03/2021 22:32, Davide Caratti wrote:
> Currently, Linux computes the HMAC contained in ADD_ADDR sub-option using
> the Address Id and the IP Address, and hardcodes a destination port equal
> to zero. This is not ok for ADD_ADDR with port: ensure to account for the
> endpoint port when computing the HMAC, in compliance with RFC8684 =C2=A73=
.4.1.

Thank you for the patch and the reviews!

Now in our tree with Mat's RvB and Geliang's ACK:

- 442a009d990c: mptcp: fix ADD_ADDR HMAC in case port is specified
- Results: f1ac0c54f494..0f8f3b7b5e58

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0776112421707742203==--
