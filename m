Content-Type: multipart/mixed; boundary="===============8086723275457078947=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/7] mptcp: fill skb extension cache outside
 of mptcp_sendmsg_frag
Date: Mon, 11 May 2020 13:55:35 +0200
Message-ID: <20200511115538.6015-5-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4363

--===============8086723275457078947==
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

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e8117837b41..778b2627c76a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -672,6 +672,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 =

 	sock_owned_by_me((const struct sock *)msk);
 =

+	if (!mptcp_ext_cache_refill(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -798,7 +801,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		if (!tx_ok)
 			break;
 =

-		if (!sk_stream_memory_free(ssk)) {
+		if (!sk_stream_memory_free(ssk) ||
+		    !mptcp_ext_cache_refill(msk)) {
 			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 			tcp_push(ssk, msg->msg_flags, mss_now,
 				 tcp_sk(ssk)->nonagle, size_goal);
@@ -1146,7 +1150,7 @@ static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
 	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
-	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
+	int orig_len, orig_offset, mss_now =3D 0, size_goal =3D 0;
 	struct mptcp_data_frag *dfrag;
 	u64 orig_write_seq;
 	size_t copied =3D 0;
@@ -1168,6 +1172,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

+	if (!mptcp_ext_cache_refill(msk))
+		goto reset_unlock;
+
 	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
@@ -1179,8 +1186,8 @@ static void mptcp_worker(struct work_struct *work)
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

@@ -1188,6 +1195,9 @@ static void mptcp_worker(struct work_struct *work)
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

--===============8086723275457078947==--
