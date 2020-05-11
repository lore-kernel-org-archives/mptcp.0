Content-Type: multipart/mixed; boundary="===============0857023904692974924=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 0/7] mptcp: rework mptcp_sendmsg
Date: Mon, 11 May 2020 13:55:31 +0200
Message-ID: <20200511115538.6015-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4359

--===============0857023904692974924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series reworks mptcp_sendmsg logic to avoid blocking on the subflow
socket.
This is another iteration, because there were problems with the previous
one.

1. Add a new patch 1/7 to stop mptcp from accepting megabytes worth
   of data when tcp data gets acked at subflow level quickly, but not
   at mptcp level.

2. drop the patch that cached an skb in sk->sk_tx_skb_cache.
   One problem with that patch was that it sabotages an extra check
   that tcp has: when it allocates and skb it will behave slightly
   differently when the tcp write and retrans queues are empty
   wrt. wmem schedule.
   By preallocating in mptcp layer that code gets bypassed.
   Moreover, the preallocation doesn't buy anything; the
   allocation can schedule but it won't sleep forever.

3. for the 3rd patch I moved the initialisation to a single location,
   also the timer is only started before returning to userspace.
   As long was we keep looping, the timer doesn't have to be started
   here as it will be kicked by mptcp_data_acked() for the incoming
   acks.

4. xmit via lo and MPTCP is SLOOOOOOOOW in 'mmap' mode.
  However it turned out this is already the case without these patches,
  so I decided to send these patches out anyway.
  I will send another email to followup up on this.

I've preserved Paolos ACKs on patches that had no changes vs. v1.

Florian Westphal (7):
      mptcp: break and restart in case mptcp sndbuf is full
      mptcp: avoid blocking in tcp_sendpages
      mptcp: make sure timer is inited once data is pending for transmission
      mptcp: fill skb extension cache outside of mptcp_sendmsg_frag
      mptcp: fill skb page frag cache outside of mptcp_sendmsg_frag
      mptcp: remove inner wait loop from mptcp_sendmsg_frag
      net: allow __skb_ext_alloc to sleep

 include/linux/skbuff.h |   2 +-
 net/core/skbuff.c      |   8 ++--
 net/mptcp/protocol.c   | 116 ++++++++++++++++++++++++++++++++++++---------=
----
 3 files changed, 91 insertions(+), 35 deletions(-)


--===============0857023904692974924==--
