Content-Type: multipart/mixed; boundary="===============2757628199198812010=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: properly empty DSS/no ack option
Date: Fri, 13 Dec 2019 10:01:57 -0800
Message-ID: <20191213180157.10551-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 2970

--===============2757628199198812010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DSS not carrying data ack are not emitted at all, due bad checks in
mptcp_established_options_dss(), fix that.

Additionally, fix the condition to accept MPC+data pkt in
subflow_check_data_avail(): do not look for 0 ack_seq - that is valid
value - check explicitly the 'can_ack' field.

Finally move remote_key/seq initialization from recvmsg() to
subflow_check_data_avail(), no need to wait for user space for such update.
This last change does not fix any real issue, just clean a bit the code.

This fixes the current self-test failures (run ns1->ns4 ~200 times successf=
ully)

Squash-to: "mptcp: process MP_CAPABLE data option."

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/options.c  |  8 ++++++--
 net/mptcp/protocol.c |  6 ------
 net/mptcp/subflow.c  | 13 ++++++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bc3352af6c15..250871290b8d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -397,6 +397,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	struct mptcp_sock *msk;
 	unsigned int ack_size;
+	bool ret =3D false;
 	u8 tcp_fin;
 =

 	if (skb) {
@@ -420,12 +421,15 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 		if (skb && tcp_fin &&
 		    subflow->conn->sk_state !=3D TCP_ESTABLISHED)
 			mptcp_write_data_fin(subflow, &opts->ext_copy);
+		ret =3D true;
 	}
 =

 	opts->ext_copy.use_ack =3D 0;
 	msk =3D mptcp_sk(subflow->conn);
-	if (!msk || !READ_ONCE(msk->can_ack))
-		return false;
+	if (!msk || !READ_ONCE(msk->can_ack)) {
+		*size =3D ALIGN(dss_size, 4);
+		return ret;
+	}
 =

 	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c64d9414f23..6eadc5d6cdce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -347,12 +347,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 =

 		lock_sock(ssk);
 		while (mptcp_subflow_data_available(ssk) && !done) {
-			if (unlikely(!msk->can_ack)) {
-				msk->remote_key =3D subflow->remote_key;
-				msk->ack_seq =3D subflow->map_seq;
-				msk->can_ack =3D true;
-			}
-
 			/* try to read as much data as available */
 			map_remaining =3D subflow->map_data_len -
 					mptcp_subflow_get_map_offset(subflow);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f4370764013d..3ae4297ac42d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -444,11 +444,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		/* if msk lacks the remote key, this subflow must provide an
 		 * MP_CAPABLE-based mapping
 		 */
-		if (unlikely(!READ_ONCE(msk->ack_seq))) {
-			if (subflow->mpc_map)
-				break;
-			ssk->sk_err =3D EBADMSG;
-			goto fatal;
+		if (unlikely(!READ_ONCE(msk->can_ack))) {
+			if (!subflow->mpc_map) {
+				ssk->sk_err =3D EBADMSG;
+				goto fatal;
+			}
+			WRITE_ONCE(msk->remote_key, subflow->remote_key);
+			WRITE_ONCE(msk->ack_seq, subflow->map_seq);
+			WRITE_ONCE(msk->can_ack, true);
 		}
 =

 		old_ack =3D READ_ONCE(msk->ack_seq);
-- =

2.23.0

--===============2757628199198812010==--
