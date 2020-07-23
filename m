Content-Type: multipart/mixed; boundary="===============0806783174516971626=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: zero token hash at creation time.
Date: Wed, 22 Jul 2020 17:57:49 -0700
Message-ID: <20200722.175749.2262678023965125909.davem@davemloft.net>
In-Reply-To: 9c1619337f0fa54112c0fe6f0e0100ded392ac3e.1595431172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5198

--===============0806783174516971626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 22 Jul 2020 17:20:50 +0200

> Otherwise the 'chain_len' filed will carry random values,
> some token creation calls will fail due to excessive chain
> length, causing unexpected fallback to TCP.
> =

> Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Tested-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks Paolo.
--===============0806783174516971626==--
