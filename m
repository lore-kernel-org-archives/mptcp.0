Content-Type: multipart/mixed; boundary="===============8766032991040653381=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 13/26] bpfilter: switch bpfilter_ip_set_sockopt to
 sockptr_t
Date: Thu, 23 Jul 2020 11:16:16 +0000
Message-ID: <621e193e4af74d8198ed87d6a9ce8260@AcuMS.aculab.com>
In-Reply-To: 20200723060908.50081-14-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5241

--===============8766032991040653381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 23 July 2020 07:09
> =

> This is mostly to prepare for cleaning up the callers, as bpfilter by
> design can't handle kernel pointers.

You've failed to fix the sense of the above...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============8766032991040653381==--
