Content-Type: multipart/mixed; boundary="===============8249731660530140854=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 4/7] mptcp: fill skb extension cache
 outside of mptcp_sendmsg_frag
Date: Wed, 06 May 2020 15:02:25 +0200
Message-ID: <20200506130228.1478-5-fw@strlen.de>
In-Reply-To: 20200506130228.1478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4323

--===============8249731660530140854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp_sendmsg_frag helper contains a loop that will wait on the
subflow sk.

It seems preferrable to only wait in mptcp_sendmsg() when blocking io is
requested.  mptcp_sendmsg already has such a wait loop that is used when
no subflow socket is available for transmission.

This is a preparation patch that makes sure we call
mptcp_sendmsg_frag only if a skb extension has been allocated.

Moreover, such allocation currently uses GFP_ATOMIC while it
could use sleeping allocation instead.

Followup patches will remove the wait loop from mptcp_sendmsg_frag()
and will allow to do a sleeping allocation for the extension.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f28c131c010e..6b3141ecfced 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -685,6 +685,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 	if (!mptcp_sendmsg_alloc_skb(sk))
 		return NULL;
 =

+	if (!mptcp_ext_cache_refill(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -818,7 +821,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		tx_ok =3D msg_data_left(msg);
 		if (!tx_ok)
 			break;
-		if (!sk_stream_memory_free(ssk)) {
+		if (!sk_stream_memory_free(ssk) ||
+		    !mptcp_ext_cache_refill(msk)) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
 				 tcp_sk(ssk)->nonagle, size_goal);
 			release_sock(ssk);
@@ -1139,7 +1143,7 @@ static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
 	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
-	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
+	int orig_len, orig_offset, mss_now =3D 0, size_goal =3D 0;
 	struct mptcp_data_frag *dfrag;
 	u64 orig_write_seq;
 	size_t copied =3D 0;
@@ -1161,6 +1165,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

+	if (!mptcp_ext_cache_refill(msk))
+		goto reset_unlock;
+
 	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
@@ -1172,8 +1179,8 @@ static void mptcp_worker(struct work_struct *work)
 	orig_offset =3D dfrag->offset;
 	orig_write_seq =3D dfrag->data_seq;
 	while (dfrag->data_len > 0) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo, &mss_now,
-					 &size_goal);
+		int ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo,
+					     &mss_now, &size_goal);
 		if (ret < 0)
 			break;
 =

@@ -1181,6 +1188,9 @@ static void mptcp_worker(struct work_struct *work)
 		copied +=3D ret;
 		dfrag->data_len -=3D ret;
 		dfrag->offset +=3D ret;
+
+		if (!mptcp_ext_cache_refill(msk))
+			break;
 	}
 	if (copied)
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
-- =

2.26.2

--===============8249731660530140854==--
