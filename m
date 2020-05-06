Content-Type: multipart/mixed; boundary="===============8915611158231435168=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/7] mptcp: avoid blocking in tcp_sendpages
 due to skb alloc
Date: Wed, 06 May 2020 15:02:24 +0200
Message-ID: <20200506130228.1478-4-fw@strlen.de>
In-Reply-To: 20200506130228.1478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4322

--===============8915611158231435168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If memory is tight, tcp_sendpages may fail because it can't
allocate the skb head.

Now that we pass DONTWAIT to tcp_sendpages it won't block anymore on the
subflow socket when this happens.

We can avoid such allocation failure in tcp code by preallocating an skb
skb when we pick the subflow to use.

If it fails, we can wait on the mptcp socket until memory becomes
available.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab6599dfda59..f28c131c010e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -488,6 +488,22 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, st=
ruct page_frag *pfrag,
 	return dfrag;
 }
 =

+static bool mptcp_sendmsg_alloc_skb(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	if (sk->sk_tx_skb_cache)
+		return true;
+
+	skb =3D alloc_skb_fclone(sk->sk_prot->max_header, sk->sk_allocation);
+	if (skb) {
+		skb_reserve(skb, sk->sk_prot->max_header);
+		sk->sk_tx_skb_cache =3D skb;
+	}
+
+	return sk->sk_tx_skb_cache !=3D NULL;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, struct mptcp_data_frag *dfrag,
 			      long *timeo, int *pmss_now,
@@ -504,6 +520,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	u64 *write_seq;
 	size_t psize;
 =

+	if (!ssk->sk_tx_skb_cache) {
+		ssk->sk_tx_skb_cache =3D sk->sk_tx_skb_cache;
+		sk->sk_tx_skb_cache =3D NULL;
+	}
+
 	/* use the mptcp page cache so that we can easily move the data
 	 * from one substream to another, but do per subflow memory accounting
 	 * Note: pfrag is used only !retransmission, but the compiler if
@@ -656,9 +677,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
 	struct sock *backup =3D NULL;
 =

-	sock_owned_by_me((const struct sock *)msk);
+	sock_owned_by_me(sk);
+
+	if (!mptcp_sendmsg_alloc_skb(sk))
+		return NULL;
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
@@ -1478,6 +1503,7 @@ static void mptcp_destroy(struct sock *sk)
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
 =

+	kfree_skb(sk->sk_tx_skb_cache);
 	sk_sockets_allocated_dec(sk);
 }
 =

@@ -1688,6 +1714,7 @@ static struct proto mptcp_prot =3D {
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
+	.max_header	=3D MAX_TCP_HEADER,
 	.sockets_allocated	=3D &mptcp_sockets_allocated,
 	.memory_allocated	=3D &tcp_memory_allocated,
 	.memory_pressure	=3D &tcp_memory_pressure,
-- =

2.26.2

--===============8915611158231435168==--
