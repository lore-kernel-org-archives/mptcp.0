Content-Type: multipart/mixed; boundary="===============8530204106366401027=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/2] mptcp: dispose initial struct socket when
 its subflow is closed
Date: Fri, 12 Feb 2021 18:31:42 +0100
Message-ID: <5a9ae0d3-0461-d466-8e68-efce4b2736bf@tessares.net>
In-Reply-To: 6b7526a1-62b8-8054-c77f-8ee99bcffd64@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7775

--===============8530204106366401027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 12/02/2021 18:18, Matthieu Baerts wrote:
> Hi Florian, Paolo,
> =

> On 12/02/2021 11:04, Paolo Abeni wrote:
>> On Fri, 2021-02-12 at 00:42 +0100, Florian Westphal wrote:
>>> Christoph Paasch reported following crash:
>>> dst_release underflow
>>> WARNING: CPU: 0 PID: 1319 at net/core/dst.c:175 dst_release+0xc1/0xd0 =

>>> net/core/dst.c:175
>>> CPU: 0 PID: 1319 Comm: syz-executor217 Not tainted =

>>> 5.11.0-rc6af8e85128b4d0d24083c5cac646e891227052e0c #70
>>> Call Trace:
>>> =C2=A0 rt_cache_route+0x12e/0x140 net/ipv4/route.c:1503
>>> =C2=A0 rt_set_nexthop.constprop.0+0x1fc/0x590 net/ipv4/route.c:1612
>>> =C2=A0 __mkroute_output net/ipv4/route.c:2484 [inline]
>>> ...
>>>
>>> The worker leaves msk->subflow alone even when it
>>> happened to close the subflow ssk associated with it.
>>>
>>> v2: fix helper function name
>>>
>>> Fixes: 866f26f2a9c33b ("mptcp: always graft subflow socket to parent")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/157
>>> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
>>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> =

> Thank you for the patches and the reviews!
> =

>> Both patches LGTM, thanks!
>>
>> perhaps we can drop the changelog info for upstream submission? (in any
>> case no need for a v3, I guess commit messages can shaped at submission
>> time)
> =

> I can sure do that!

Patch 1 was placed at the bottom with Paolo's Ack, my RvB tag and a =

declared 'msk':

- 114aa23af898: mptcp: reset last_snd on subflow close
- Results: 7bd6ce758374..c09ee43e88b6

Patch 2 was placed just before your netlink series with Paolo's Ack:

- 24c84fc55050: mptcp: dispose initial struct socket when its subflow is =

closed
- Results: c09ee43e88b6..8ea9c48639fd

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8530204106366401027==--
