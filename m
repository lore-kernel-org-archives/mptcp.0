Content-Type: multipart/mixed; boundary="===============7071745486155961810=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 03/13] mptcp: add wmem_queued accounting
Date: Mon, 18 Nov 2019 22:45:28 +0100
Message-ID: <20191118214538.21931-4-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2588

--===============7071745486155961810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Peer could ack data at TCP level but refrain from sending mptcp-level ACKs.
This could result in a growing the mptcp socket backlog indefinitely.

We should thus block mptcp_sendmsg until the peer has acked some of the
sent data.

In order to be able to do so, increment the mptcp socket wmem_queued
counter on memory allocation and decrement it when releasing the memory
on mptcp-level ack reception.

Because TCP performns sndbuf auto-tuning up to tcp_wmem_max[2], make
this the mptcp sk_sndbuf limit.

In the future we could add experiment with autotuning as TCP does in
tcp_sndbuf_expand().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a432abfb176..9ad5bd5c2437 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -139,8 +139,11 @@ static inline bool mptcp_frag_can_collapse_to(const st=
ruct mptcp_sock *msk,
 =

 static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
+	int len =3D dfrag->data_len + dfrag->overhead;
+
 	list_del(&dfrag->list);
-	sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
+	sk_mem_uncharge(sk, len);
+	sk_wmem_queued_add(sk, -len);
 	put_page(dfrag->page);
 }
 =

@@ -304,6 +307,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		if (!dfrag_collapsed) {
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
+			sk_wmem_queued_add(sk, frag_truesize);
+		} else {
+			sk_wmem_queued_add(sk, ret);
 		}
 =

 		/* charge data on mptcp rtx queue to the master socket
@@ -711,6 +717,7 @@ static int mptcp_init_sock(struct sock *sk)
 		return ret;
 =

 	sk_sockets_allocated_inc(sk);
+	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
 =

 	return 0;
 }
-- =

2.23.0

--===============7071745486155961810==--
