Content-Type: multipart/mixed; boundary="===============5952318009988664163=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 01/13] tcp: factor out tcp_build_frag()
Date: Thu, 12 Nov 2020 15:12:54 -0800
Message-ID: <20201112151254.14e3b059@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20201112150831.1c4bb8b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6707

--===============5952318009988664163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2020 15:08:31 -0800 Jakub Kicinski wrote:
> On Thu, 12 Nov 2020 18:45:21 +0100 Paolo Abeni wrote:
> > +		skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
> > +				tcp_rtx_and_write_queues_empty(sk));  =

> =

> no good reason to misalign this AFAICT

Maybe not worth respining just for this, I thought there are build
warnings but seems it's mostly sparse getting confused.

Is there a chance someone could look into adding annotations to socket
locking?
--===============5952318009988664163==--
