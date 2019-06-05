Content-Type: multipart/mixed; boundary="===============0768694611581564162=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: do not warn when replacing an identical
 mapping.
Date: Wed, 05 Jun 2019 15:53:10 +0200
Message-ID: <87926986ed8572ddad3c82230f0cf9b883fbbeb9.1559742173.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1289

--===============0768694611581564162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Said event can happen due GSO/TSO, do not warn then.

Fixes: af798ed636e2 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Notes:
- I'm ok squashing this commit into the fixed one
- I can't reproduce the warn locally, need someone else to verify =

  this one
---
 net/mptcp/protocol.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e809719dcfd..65ad881daf0d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -291,6 +291,7 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 	struct mptcp_ext *mpext;
 	enum mapping_status ret;
 	struct sk_buff *skb;
+	u64 map_seq;
 =

 	skb =3D skb_peek(&ssk->sk_receive_queue);
 	if (!skb) {
@@ -325,18 +326,25 @@ static enum mapping_status mptcp_get_mapping(struct s=
ock *ssk)
 		goto del_out;
 	}
 =

-	if (subflow->map_valid)
-		pr_warn("Replaced mapping before it was done");
-
 	if (!mpext->dsn64) {
-		subflow->map_seq =3D expand_seq(subflow->map_seq,
-					      subflow->map_data_len,
-					      mpext->data_seq);
+		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
+				     mpext->data_seq);
 		pr_debug("expanded seq=3D%llu", subflow->map_seq);
 	} else {
-		subflow->map_seq =3D mpext->data_seq;
+		map_seq =3D mpext->data_seq;
+	}
+
+	if (subflow->map_valid) {
+		/* due to GSO/TSO we can receive the same mapping multiple
+		 * times, before it's expiration.
+		 */
+		if (subflow->map_seq !=3D map_seq ||
+		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
+		    subflow->map_data_len !=3D mpext->data_len)
+			pr_warn("Replaced mapping before it was done");
 	}
 =

+	subflow->map_seq =3D map_seq;
 	subflow->map_subflow_seq =3D mpext->subflow_seq;
 	subflow->map_data_len =3D mpext->data_len;
 	subflow->map_valid =3D 1;
-- =

2.20.1


--===============0768694611581564162==--
