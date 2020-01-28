Content-Type: multipart/mixed; boundary="===============1310034806554967376=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v1 4/4] mptcp: handle tcp fallback when
 using syn cookies
Date: Tue, 28 Jan 2020 17:41:50 +0100
Message-ID: <cb174326-928a-4037-b366-68f9eecb52c1@tessares.net>
In-Reply-To: 20200128150125.26625-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3542

--===============1310034806554967376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 28/01/2020 16:01, Florian Westphal wrote:
> We can't deal with syncookie mode yet, the syncookie rx path will create
> tcp rsk instead of mptcp rsk, i.e. we get OOB access because we treat
> tcp rsk as mptcp rsk:
> =

> TCP: request_sock_subflow: Possible SYN flooding on port 20002. Sending c=
ookies.  Check SNMP counters.
> BUG: KASAN: slab-out-of-bounds in subflow_syn_recv_sock+0x451/0x4d0 net/m=
ptcp/subflow.c:191
> Read of size 1 at addr ffff8881167bc148 by task syz-executor099/2120
>   subflow_syn_recv_sock+0x451/0x4d0 net/mptcp/subflow.c:191
>   tcp_get_cookie_sock+0xcf/0x520 net/ipv4/syncookies.c:209
>   cookie_v6_check+0x15a5/0x1e90 net/ipv6/syncookies.c:252
>   tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1123 [inline]
>   [..]
> =

> Bug can be reproduced via "sysctl net.ipv4.tcp_syncookies=3D2".

Thank you for looking at that!

> Note that MPTCP should work with syncookies (4th ack would carry needed
> state), but it appears better to sort that out in -next so do tcp
> fallback for now.

Indeed, it makes sense.

> I decided to remove the ifdef on tcp_rsk "is_mptcp" member because
> if (IS_ENABLED()) is easier to read than "#ifdef IS_ENABLED()/#endif" pai=
r.

I agree with you that it is easier to read but will it be OK for =

upstream? Should we use a bitfield and include 'tfo_listener' in it?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1310034806554967376==--
