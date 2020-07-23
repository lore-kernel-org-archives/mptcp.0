Content-Type: multipart/mixed; boundary="===============4232661866213988582=="
MIME-Version: 1.0
From: 'Christoph Hellwig' <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 13/26] bpfilter: switch bpfilter_ip_set_sockopt to
 sockptr_t
Date: Thu, 23 Jul 2020 13:44:58 +0200
Message-ID: <20200723114458.GA31363@lst.de>
In-Reply-To: 621e193e4af74d8198ed87d6a9ce8260@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5242

--===============4232661866213988582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 11:16:16AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 23 July 2020 07:09
> > =

> > This is mostly to prepare for cleaning up the callers, as bpfilter by
> > design can't handle kernel pointers.
> =

> You've failed to fix the sense of the above...

The sense still is correct.
--===============4232661866213988582==--
