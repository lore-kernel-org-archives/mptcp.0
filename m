Content-Type: multipart/mixed; boundary="===============0232171201905576741=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/9] mptcp: support mptcp joins
Date: Sat, 30 Nov 2019 23:48:51 +0100
Message-ID: <20191130224900.8694-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2713

--===============0232171201905576741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set aims to improve handling of multiple subflows.

There are a few remaining problems, see below, but I wanted to send what
I have now rather than keep this back.

The first two patches are new, following few patches are a resend of the
earlier RFC series, I think they're good for acceptance now.
Patch 6 had a few changes since the RFC based on Paolos feedback, please
see patch description for details.

The last two patches are there to allow cancellation/teardown of
not-yet completed join requests.  The connecting subflow flows
are placed on a 'join_list' so mptcp_shutdown can close these sockets
as well.

Last patch moves the 'eof hack' to a work queue so we don't set EOF on the
mptcp socket until all subflows have closed.  Maybe this isn't needed, I
would be fine with dropping it in favor of mptcp-level DATA_FIN and
reset handling.

The rest of this work is to have msk->conn_list contain tcp_sock structs
without an outer 'struct socket'.

The problem is that for incoming join requests (which are not subject
to accept/request socket queue), there is no 'struct socket', so the kernel
will crash.  Even when fixing those up, a NULL sk->sk_socket is problematic
as tcp stack will assume that such tcp sk is already detached from userspac=
e,
i.e. NOSPACE wakeups do not work for them.

The solution here (suggested by Paolo) is to have sk->sk_socket refer
to the mptcp parent socket structure.  This assignment is done by
a private function similar to sock_graft().

mptcp.org kernel will be able to establish multiple connections per
mptcp socket but does not consider those extra joins as established, as the
"4th ack" is missing.

A simple "tcp_send_ack" is enough, but there are two problems with this:
1. It can be lost
2. Given we are not expecting to receive any data on such flows this
   doesn't seem to be a problem.

During testing I saw that sometimes mptcp.org kernel will emit further
join requests to mptcp-next but those trigger no response (and those
packets do not even show up in perfs network drop monitor, sigh).

I also saw a UAF at mptcp_close where a sock_hold() in tcp_close()
caused a 0->1 recount transition, but  i've been unable to reproduce it so =
far
(might have been caused by a bug that has been fixed in the mean time).

The following changes since commit dd25ff04840135581b833762571aac08a2a94c6c:

  sendmsg: truncate source buffer if mptcp sndbuf size was set from userspa=
ce (2019-11-30 02:47:59 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git mptcp_multijoin_11

for you to fetch changes up to 010c2e19c2d643a87c991bf1e7d4bfc140dfdba5:

  don't flag parent socket as RCV_SHUTDOWN if one one subflow has closed (2=
019-11-30 23:21:25 +0100)

----------------------------------------------------------------
Florian Westphal (9):
      token: handle join-before-accept-completion case
      mptcp: fix race from mptcp_close/mptcp join
      copy connection id from first subflow to mptcp socket
      store tcp_sk, not socket
      add mptcp_subflow_shutdown
      make accept not allocate kernel socket struct
      pass subflow socket to mptcp_finish_connect
      subflow: place further subflows on new 'join_list'
      don't flag parent socket as RCV_SHUTDOWN if one one subflow has closed

 net/mptcp/pm.c       |  18 +--
 net/mptcp/protocol.c | 313 +++++++++++++++++++++++++++++++++++++----------=
----
 net/mptcp/protocol.h |  16 +--
 net/mptcp/subflow.c  |  56 +++++----
 net/mptcp/token.c    |   9 +-
 5 files changed, 292 insertions(+), 120 deletions(-)



--===============0232171201905576741==--
