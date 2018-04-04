Content-Type: multipart/mixed; boundary="===============0292329705531131811=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 00/12] Make subflow establishment lockless
Date: Wed, 04 Apr 2018 17:54:42 +0200
Message-ID: <4335219f-bb96-d31c-e518-995623ea22fe@tessares.net>
In-Reply-To: 20180326073215.83607-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 503

--===============0292329705531131811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 26/03/2018 09:32, Christoph Paasch wrote:
> The most recent TCP stack supports lockless listeners. For MPTCP, we
> however are still taking the meta-lock when creating new subflows (cfr.,
> tcp_v4_rcv and mptcp_lookup_join).
> =

> This patchset makes subflow establishment lockless by using lockless
> procedures in the stack, RCU-lists, atomic operations,...

Thank you for this nice patch set! I took me a bit of time to even start =

the review, sorry for that!

Unfortunately, today, I have been interrupted in my review again. But =

here are already a few comments for the first 7th patches. I will =

continue to look at them ASAP!

Cheers,
Matt

> Christoph Paasch (12):
>    mptcp: Cleanup
>    mptcp: Improved debugging
>    mptcp: Use correct tcp_queue when calling mptcp_fragment
>    mptcp: Use mptcp_can_new_subflow where possible
>    mptcp: Render mptcp_sub_inherit_sockopts lockless
>    mptcp: Make mptcp_set_new_pathindex lockless
>    mptcp: Remove cnt_subflows
>    mptcp: Remove cnt_established
>    mptcp: Rename tw_lock to mpcb_list_lock
>    mptcp: Make subflow-list an RCU-list
>    mptcp: Don't take meta-lock when receiving third ACK
>    mptcp: Make mptcp_do_join_short and mptcp_lookup_join lockless
> =

>   include/net/mptcp.h          | 120 ++++++++++-----------------
>   net/ipv4/af_inet.c           |   9 ++-
>   net/ipv4/ip_sockglue.c       |   7 +-
>   net/ipv4/tcp.c               |  31 ++++---
>   net/ipv4/tcp_ipv4.c          |  41 +---------
>   net/ipv4/tcp_minisocks.c     |   9 ++-
>   net/ipv6/tcp_ipv6.c          |  41 +---------
>   net/mptcp/mctcp_desync.c     |  22 ++---
>   net/mptcp/mptcp_balia.c      |  21 ++---
>   net/mptcp/mptcp_binder.c     |  23 +++++-
>   net/mptcp/mptcp_coupled.c    |  52 +++++-------
>   net/mptcp/mptcp_ctrl.c       | 187 ++++++++++++++++++++++++++++--------=
-------
>   net/mptcp/mptcp_fullmesh.c   |  30 ++++---
>   net/mptcp/mptcp_input.c      | 150 ++++++++++++----------------------
>   net/mptcp/mptcp_ipv4.c       |  34 +++-----
>   net/mptcp/mptcp_ipv6.c       |  15 ++--
>   net/mptcp/mptcp_ndiffports.c |  17 +++-
>   net/mptcp/mptcp_olia.c       |  28 ++++---
>   net/mptcp/mptcp_output.c     |  50 ++++++++----
>   net/mptcp/mptcp_redundant.c  | 151 +++++++++++++++++++++++++++-------
>   net/mptcp/mptcp_rr.c         |  22 +++--
>   net/mptcp/mptcp_sched.c      |  32 ++++----
>   net/mptcp/mptcp_wvegas.c     |   5 +-
>   23 files changed, 586 insertions(+), 511 deletions(-)
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============0292329705531131811==--
