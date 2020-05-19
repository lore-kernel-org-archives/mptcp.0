Content-Type: multipart/mixed; boundary="===============6949858820232138287=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Mon, 18 May 2020 17:30:50 -0700
Message-ID: <20200519003050.GW45434@MacBook-Pro-64.local>
In-Reply-To: 20200518222916.108513-1-todd.malsbary@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4413

--===============6949858820232138287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/05/20 - 15:29:16, Todd Malsbary wrote:
> This changes the HMAC used in the ADD_ADDR option from the leftmost 64
> bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
> =

> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>

Nice find!


Acked-by: Christoph Paasch <cpaasch(a)apple.com>

And I need to change out-of-tree MPTCP as well ;-)


Christoph

--===============6949858820232138287==--
