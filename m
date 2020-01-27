Content-Type: multipart/mixed; boundary="===============5732939390643327217=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] mptcp: fix syzkaller splats
Date: Mon, 27 Jan 2020 07:53:37 -0800
Message-ID: <20200127155337.GA13796@MacBook-Pro-64.local>
In-Reply-To: 20200126234101.7256-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3524

--===============5732939390643327217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27/01/20 - 00:40:59, Florian Westphal wrote:
> This fixes the syzkaller splats with reproducers that Christoph forwarded
> to the mailing list.
> =

> First patch fixes a crash with set/getsockopt interface and resolves
> a lockdep splat due to calls to rtnl_lock while already holding the msk l=
ock.
> I resolved both in the same patch because the fix touches the same spot.
> =

> Second patch fixes another lockdep splat, this time during mptcp_close
> but also related to rtnl_lock.
> =

> See patches for more detailed explanation.
> =

>  protocol.c |   51 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 18 deletions(-)

syzkaller has been running for 300 hours of fuzzing and none of the previous
reported issues triggered. All good! Also, no new issues for now.

Tested-by: Christoph Paasch <cpaasch(a)apple.com>


Cheers,
Christoph

--===============5732939390643327217==--
