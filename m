Content-Type: multipart/mixed; boundary="===============3199366264803485397=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v4 0/4] fix syzkaller splats reported by
 Christoph
Date: Tue, 28 Jan 2020 17:24:51 +0100
Message-ID: <45e893021c8f86f71605543379cba96080e224cd.camel@redhat.com>
In-Reply-To: 20200128150125.26625-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3541

--===============3199366264803485397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-28 at 16:01 +0100, Florian Westphal wrote:
> This fixes the syzkaller splats with reproducers that Christoph forwarded
> to the mailing list, including the one wrt. slab oob in syncookie mode.
> =

> First patch moves free of the cached extension pointer to the destroy
> callback to make sure no other call path can allocate a new one.
> Actually net-next should be fine in this regard (no msk work queue yet),
> but as Paolo pointed out it looks bogus when 3rd patch calls it with
> mptcp lock already released.
> =

> 2nd patch fixes a crash with set/getsockopt interface and resolves
> a lockdep splat due to calls to rtnl_lock while already holding the msk l=
ock.
> =

> I resolved both in the same patch because the fixes need to touch the same
> spot.
> =

> 3rd patch fixes another lockdep splat, this time during mptcp_close
> but again related to rtnl_lock.
> =

> Last patch avoid OOB access when syncookies are used.
> This should be resolved differently, as mptcp v1 can use 4th ack to
> recover state, but that will be more intrusive so this fix downgrades to
> TCP instead.
> =

> See patches for more detailed explanation.
> =

>  include/linux/tcp.h   |    2 --
>  net/ipv4/syncookies.c |    4 ++++
>  net/ipv4/tcp_input.c  |    3 +++
>  net/ipv6/syncookies.c |    3 +++
>  net/mptcp/protocol.c  |   48 ++++++++++++++++++++++++++++---------------=
-----
>  net/mptcp/subflow.c   |    5 ++++-
>  6 files changed, 42 insertions(+), 23 deletions(-)

Except for the already reported note on patch 2/4, I think the others
patches are good.

Thanks Florian for fixing our mess ;)

/P

--===============3199366264803485397==--
