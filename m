Content-Type: multipart/mixed; boundary="===============7996567199426374705=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "mptcp: Implement MPTCP receive path"
Date: Fri, 13 Dec 2019 17:18:59 +0100
Message-ID: <0af08ed870804a5999858cb7ce676a4cfeb9fb22.1576253891.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2959

--===============7996567199426374705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/subflow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cfc90c471460..da10b5092d8d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -237,7 +237,7 @@ static void warn_bad_map(struct mptcp_subflow_context *=
subflow, u32 ssn)
 static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-	unsigned skb_consumed;
+	unsigned int skb_consumed;
 =

 	skb_consumed =3D tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
 	if (WARN_ON_ONCE(skb_consumed >=3D skb->len))
@@ -284,9 +284,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 	if (!mpext || !mpext->use_map) {
 		if (!subflow->map_valid && !skb->len) {
 			/* the TCP stack deliver 0 len FIN pkt to the receive
-			* queue, that is the only 0len pkts ever expected here,
-			* and we can admit no mapping only for 0 len pkts
-			*/
+			 * queue, that is the only 0len pkts ever expected here,
+			 * and we can admit no mapping only for 0 len pkts
+			 */
 			if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
 				WARN_ONCE(1, "0len seq %d:%d flags %x",
 					  TCP_SKB_CB(skb)->seq,
-- =

2.23.0

--===============7996567199426374705==--
