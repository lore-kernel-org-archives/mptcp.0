Content-Type: multipart/mixed; boundary="===============3151781331497969984=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] mptcp: refactor recvmsg()
Date: Wed, 18 Sep 2019 11:35:23 +0200
Message-ID: <e6e290abe9088b32db3bdd2e69b19df2208b8a08.1568799121.git.pabeni@redhat.com>
In-Reply-To: cover.1568799121.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1876

--===============3151781331497969984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current implementation tries to handle exceptional sitations
(no mapping, bad subflow sequence number) without baling out, but
that makes debugging existing bugs very difficult.

Also duplicate MPTCP data due to retransmissions are hard to track,
because we discard the duplicate mapping and skip the following pkts
lacking the map without any fourther control.

This changeset refactor the main loop to return an error code to the
user space for unhandled exceptional condition. It also track explicitly
the number of duplicate MPTCP data bytes to be discarded: duplicate
mapping are still considered valid, and we just discard the bytes
belonging to such mapping.

This makes debugging easier, and also clean-up a bit the existing code

v1 -> v2:
 - rewrite warn and debug message to fit a single line

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
I'm ok to squash this into commit 786f07cf97f1 ("mptcp: Implement MPTCP rec=
eive path")
---
 net/mptcp/protocol.c | 113 ++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 66 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fba7e00df4ff..dc59baeca0c7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -452,17 +452,6 @@ static int mptcp_read_actor(read_descriptor_t *desc, s=
truct sk_buff *skb,
 	return copy_len;
 }
 =

-static int mptcp_flush_actor(read_descriptor_t *desc, struct sk_buff *skb,
-			     unsigned int offset, size_t len)
-{
-	pr_debug("Flushing one skb with %zu of %zu bytes remaining",
-		 len, len + offset);
-
-	desc->count =3D 0;
-
-	return len;
-}
-
 enum mapping_status {
 	MAPPING_ADDED,
 	MAPPING_MISSING,
@@ -568,6 +557,12 @@ static void mptcp_wait_data(struct sock *sk, long *tim=
eo)
 	remove_wait_queue(sk_sleep(sk), &wait);
 }
 =

+static void warn_bad_map(struct subflow_context *subflow, u32 ssn)
+{
+	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
+		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -611,7 +606,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 	while (copied < len) {
 		enum mapping_status status;
-		size_t discard_len =3D 0;
 		u32 map_remaining;
 		int bytes_read;
 		u64 ack_seq;
@@ -627,20 +621,27 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		if (status =3D=3D MAPPING_ADDED) {
 			/* Common case, but nothing to do here */
 		} else if (status =3D=3D MAPPING_MISSING) {
-			if (!subflow->map_valid) {
-				pr_debug("Mapping missing, trying next skb");
-
-				arg.msg =3D NULL;
-				desc.count =3D SIZE_MAX;
-
-				bytes_read =3D tcp_read_sock(ssk, &desc,
-							   mptcp_flush_actor);
-
-				if (bytes_read < 0)
-					break;
+			struct sk_buff *skb =3D skb_peek(&ssk->sk_receive_queue);
 =

+			if (!skb->len) {
+				/* the TCP stack deliver 0 len FIN pkt
+				 * to the receive queue, that is the only
+				 * 0len pkts ever expected here, and we can
+				 * admit no mapping only for 0 len pkts
+				 */
+				if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
+					WARN_ONCE(1, "0len seq %d:%d flags %x",
+						  TCP_SKB_CB(skb)->seq,
+						  TCP_SKB_CB(skb)->end_seq,
+						  TCP_SKB_CB(skb)->tcp_flags);
+				sk_eat_skb(sk, skb);
 				continue;
 			}
+			if (!subflow->map_valid) {
+				WARN_ONCE(1, "corrupted stream: missing mapping");
+				copied =3D -EBADFD;
+				break;
+			}
 		} else if (status =3D=3D MAPPING_EMPTY) {
 			goto wait_for_data;
 		} else if (status =3D=3D MAPPING_DATA_FIN) {
@@ -658,60 +659,39 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
 			/* Mapping covers data later in the subflow stream,
-			 * discard unmapped data.
+			 * currently unsupported.
 			 */
-			pr_debug("Mapping covers data later in stream");
-			discard_len =3D subflow->map_subflow_seq - ssn;
+			warn_bad_map(subflow, ssn);
+			copied =3D -EBADFD;
+			break;
 		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
 						  subflow->map_data_len)))) {
 			/* Mapping ends earlier in the subflow stream.
-			 * Invalidate the mapping and try again.
+			 * Invalid
 			 */
-			subflow->map_valid =3D 0;
-			pr_debug("Invalid mapping ssn=3D%d map_seq=3D%d map_data_len=3D%d",
-				 ssn, subflow->map_subflow_seq,
-				 subflow->map_data_len);
-			continue;
-		} else {
-			ack_seq =3D get_mapped_dsn(subflow);
-
-			if (before64(ack_seq, old_ack)) {
-				/* Mapping covers data already received,
-				 * discard data in the current mapping
-				 * and invalidate the map
-				 */
-				u64 map_end_dsn =3D subflow->map_seq +
-					subflow->map_data_len;
-				discard_len =3D min(map_end_dsn - ack_seq,
-						  old_ack - ack_seq);
-				subflow->map_valid =3D 0;
-				pr_debug("Duplicate MPTCP data found");
-			}
+			warn_bad_map(subflow, ssn);
+			copied =3D -EBADFD;
+			break;
 		}
 =

-		if (discard_len) {
-			/* Discard data for the current mapping.
-			 */
-			pr_debug("Discard %zu bytes", discard_len);
+		ack_seq =3D get_mapped_dsn(subflow);
+		map_remaining =3D subflow->map_data_len - get_map_offset(subflow);
 =

+		if (before64(ack_seq, old_ack)) {
+			/* Mapping covers data already received, discard data
+			 * in the current mapping
+			 */
 			arg.msg =3D NULL;
-			desc.count =3D discard_len;
-
-			bytes_read =3D tcp_read_sock(ssk, &desc,
-						   mptcp_read_actor);
-
-			if (bytes_read < 0)
-				break;
-			else if (bytes_read =3D=3D discard_len)
-				continue;
-			else
-				goto wait_for_data;
+			desc.count =3D min_t(size_t, old_ack - ack_seq,
+					   map_remaining);
+			pr_debug("Dup data, map len=3D%d acked=3D%lld dropped=3D%ld",
+				 map_remaining, old_ack - ack_seq, desc.count);
+		} else {
+			arg.msg =3D msg;
+			desc.count =3D min_t(size_t, len - copied, map_remaining);
 		}
 =

 		/* Read mapped data */
-		map_remaining =3D subflow->map_data_len - get_map_offset(subflow);
-		desc.count =3D min_t(size_t, len - copied, map_remaining);
-		arg.msg =3D msg;
 		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
 		if (bytes_read < 0)
 			break;
@@ -730,7 +710,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 				 subflow->map_data_len);
 		}
 =

-		copied +=3D bytes_read;
+		if (arg.msg)
+			copied +=3D bytes_read;
 =

 wait_for_data:
 		if (copied)
-- =

2.21.0


--===============3151781331497969984==--
