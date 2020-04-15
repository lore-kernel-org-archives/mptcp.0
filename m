Content-Type: multipart/mixed; boundary="===============5898830747279796182=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 3/7] mptcp: handle mptcp listener destruction
 via rcu
Date: Wed, 15 Apr 2020 19:19:50 +0200
Message-ID: <20200415171954.15321-4-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4182

--===============5898830747279796182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Following splat can occur during self test:

 BUG: KASAN: use-after-free in subflow_data_ready+0x156/0x160
 Read of size 8 at addr ffff888100c35c28 by task mptcp_connect/4808

  subflow_data_ready+0x156/0x160
  tcp_child_process+0x6a3/0xb30
  tcp_v4_rcv+0x2231/0x3730
  ip_protocol_deliver_rcu+0x5c/0x860
  ip_local_deliver_finish+0x220/0x360
  ip_local_deliver+0x1c8/0x4e0
  ip_rcv_finish+0x1da/0x2f0
  ip_rcv+0xd0/0x3c0
  __netif_receive_skb_one_core+0xf5/0x160
  __netif_receive_skb+0x27/0x1c0
  process_backlog+0x21e/0x780
  net_rx_action+0x35f/0xe90
  do_softirq+0x4c/0x50
  [..]

This occurs when accessing subflow_ctx->conn.

Problem is that tcp_child_process() calls listen sockets'
sk_data_ready() notification, but it doesn't hold the listener
lock.  Another cpu calling close() on the listener will then cause
transition of refcount to 0.

Fixes: 58b09919626bf ("mptcp: create msk early")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2bdfe2ea35bb..955b3d99bc21 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1387,6 +1387,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk, st=
ruct request_sock *req)
 		msk->ack_seq =3D ack_seq;
 	}
 =

+	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
 	bh_unlock_sock(nsk);
@@ -1788,6 +1789,8 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 		goto unlock;
 	}
 =

+	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+
 	err =3D ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-- =

2.24.1

--===============5898830747279796182==--
