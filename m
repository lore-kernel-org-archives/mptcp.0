Content-Type: multipart/mixed; boundary="===============2233025072938658354=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Updated net-next merge
Date: Mon, 21 May 2018 09:41:26 -0700
Message-ID: <20180521164126.GB9303@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1805181657560.16804@johnferg-ivm.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 634

--===============2233025072938658354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 18/05/18 - 17:10:43, Mat Martineau wrote:
> =

> Hello everyone -
> =

> I updated the master branch at https://github.com/multipath-tcp/mptcp_net=
-next
> =

> There was a conflict this time, due to an upstream change in the pacing
> timer callback from hard irq to soft irq context:
> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/73a6bab5aa2a83cb7d=
f85805e08bc03b4065aea7
> =

> =

> Here's the fixup commit with the relevant changes to tcp_tsq_handler() and
> its call to mptcp_tsq_flags():
> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/6ae85f7b54d5766131=
170b363cbeb86e421ced26

this looks good to me!


Cheers,
Christoph


--===============2233025072938658354==--
