Content-Type: multipart/mixed; boundary="===============2202473746498499440=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: use rightmost 64 bits in ADD_ADDR HMAC
Date: Tue, 19 May 2020 12:39:35 -0700
Message-ID: <20200519.123935.2150930371716574515.davem@davemloft.net>
In-Reply-To: 20200519164534.147058-1-todd.malsbary@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4427

--===============2202473746498499440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Todd Malsbary <todd.malsbary(a)linux.intel.com>
Date: Tue, 19 May 2020 09:45:34 -0700

> This changes the HMAC used in the ADD_ADDR option from the leftmost 64
> bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
> =

> This issue was discovered while adding support to packetdrill for the
> ADD_ADDR v1 option.
> =

> Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> Acked-by: Christoph Paasch <cpaasch(a)apple.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks.
--===============2202473746498499440==--
