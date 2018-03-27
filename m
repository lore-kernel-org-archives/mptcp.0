Content-Type: multipart/mixed; boundary="===============3005022692189237249=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Tue, 27 Mar 2018 14:42:58 +0200
Message-ID: <20180327124258.GH71178@MacBook-Pro-6.lan>
In-Reply-To: CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 431

--===============3005022692189237249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27/03/18 - 14:04:28, Lorenzo Colitti wrote:
> On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com>
> wrote:
> =

> > It also would allow us to expose subflows as file-descriptors to the
> > user-space. That way the user-space can do setsockopt, getsockopt,... on
> > the
> > subflows. An idea that came up in the past when we were thinking on how=
 to
> > expose an MPTCP API that allows apps to control certain things on the
> > subflows.
> >
> =

> +1 to this since it will allow client platforms to use setsockopt to, for
> example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, or with
> SO_MARK as used by Android).

Thanks, Lorenzo!

Have you seen the netlink path-manager patches that have been sent to the
mptcp-dev list?
(https://sympa-2.sipr.ucl.ac.be/sympa/arc/mptcp-dev/2018-03/msg00057.html)

The goal of them is to allow a daemon to control the creation and
destruction of subflows through netlink.


Would that be something that fits your model?


Christoph


--===============3005022692189237249==--
