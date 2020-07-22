Content-Type: multipart/mixed; boundary="===============3342442899444716166=="
MIME-Version: 1.0
From: 'Christoph Hellwig' <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/24] bpfilter: switch bpfilter_ip_set_sockopt to
 sockptr_t
Date: Wed, 22 Jul 2020 10:00:23 +0200
Message-ID: <20200722080023.GC26554@lst.de>
In-Reply-To: f9493b4c514441b4b51bc7e4e75e8c40@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5163

--===============3342442899444716166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 08:36:57AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 20 July 2020 13:47
> > =

> > This is mostly to prepare for cleaning up the callers, as bpfilter by
> > design can't handle kernel pointers.
>                       ^^^ user ??

No, it can't handle user pointers.=20
--===============3342442899444716166==--
