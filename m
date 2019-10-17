Content-Type: multipart/mixed; boundary="===============1598113885801633796=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] mptcp: deal better with out-of-sequence mapping
Date: Thu, 17 Oct 2019 11:00:38 +0200
Message-ID: <d02b8158d9a29799f3b9b6e7d98bb4f3d094db8d.1571258477.git.pabeni@redhat.com>
In-Reply-To: cover.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2202

--===============1598113885801633796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

map colaescing is an evil early optimization, drop it.
Instead ensure we process correctly any map we receive while
there is a pending, active, one:

- allow replacing only with identic mapping
- explicitly bail if the new map covers only data in future skbs
  as we don't support map caching (yet)

Squash-to: "mptcp: Implement MPTCP receive path"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 51 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e6e0f782f5e..3858187df4ce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -180,6 +180,19 @@ static void warn_bad_map(struct mptcp_subflow_context =
*subflow, u32 ssn)
 		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 =

+static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	unsigned skb_consumed;
+
+	skb_consumed =3D tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(skb_consumed >=3D skb->len))
+		return true;
+
+	return skb->len - skb_consumed <=3D subflow->map_data_len -
+					  mptcp_subflow_get_map_offset(subflow);
+}
+
 static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
@@ -260,36 +273,22 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
 	}
 =

 	if (subflow->map_valid) {
-		/* check for in-sequence new map; since the current mapping
-		 * still valid, we can't replace it yet; instead just
-		 * coalesce it
-		 */
-		if (subflow->map_seq + subflow->map_data_len =3D=3D
-		    mpext->data_seq) {
-			subflow->map_data_len +=3D mpext->data_len;
-			if (unlikely(subflow->map_data_len > 1 << 30)) {
-				unsigned delta =3D subflow->map_data_len >> 1;
-
-				/* to avoid len overflows, just drop old bits of
-				 * the current mapping when it becomes really
-				 * big. delta is larger then the max map len
-				 * carried by the MPTCP extension, so the map
-				 * start will still be lower then the SSN
-				 */
-				subflow->map_data_len -=3D delta;
-				subflow->map_subflow_seq +=3D delta;
-				subflow->map_seq +=3D delta;
-			}
-			goto validate_seq;
+		/* Allow replacing only with an identical map */
+		if (subflow->map_seq =3D=3D map_seq &&
+		    subflow->map_subflow_seq =3D=3D mpext->subflow_seq &&
+		    subflow->map_data_len =3D=3D mpext->data_len) {
+			skb_ext_del(skb, SKB_EXT_MPTCP);
+			return MAPPING_OK;
 		}
 =

-		/* Allow replacing only with an identical map  */
-		if (subflow->map_seq !=3D mpext->data_seq ||
-		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
-		    subflow->map_data_len !=3D mpext->data_len)
+		/* If this skb data are fully covered by the current mapping,
+		 * the new map would need caching, which is not supported
+		 */
+		if (skb_is_fully_mapped(ssk, skb))
 			return MAPPING_INVALID;
 =

-		goto validate_seq;
+		/* will validate the next map after consuming the current one */
+		return MAPPING_OK;
 	}
 =

 	subflow->map_seq =3D map_seq;
-- =

2.21.0

--===============1598113885801633796==--
