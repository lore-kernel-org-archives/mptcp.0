Content-Type: multipart/mixed; boundary="===============6907070219754792441=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 01/13] mptcp: more DATA FIN fixes
Date: Thu, 01 Oct 2020 16:08:02 +0200
Message-ID: <b36a7c4bb7ca73ea8d93134147157c48d8a3d678.1601552158.git.pabeni@redhat.com>
In-Reply-To: cover.1601552158.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6128

--===============6907070219754792441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently data fin on data packet are not handled properly:
the 'rcv_data_fin_seq' field is interpreted as the last
sequence number carrying a valid data, but for data fin
packet with valid maps we currently store map_seq + map_len,
that is, the next value.

The 'write_seq' fields carries instead the value subseguent
to the last valid byte, so in mptcp_write_data_fin() we
never detect correctly the last DSS map.

Fixes: f7b6e548510a ("mptcp: Handle incoming 32-bit DATA_FIN values")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 4 ++--
 net/mptcp/subflow.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 45501c5f7f93..dde4340fca1f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -452,7 +452,7 @@ static bool mptcp_established_options_mp(struct sock *s=
k, struct sk_buff *skb,
 static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 				 struct sk_buff *skb, struct mptcp_ext *ext)
 {
-	u64 data_fin_tx_seq =3D READ_ONCE(mptcp_sk(subflow->conn)->write_seq);
+	u64 data_fin_tx_seq =3D READ_ONCE(mptcp_sk(subflow->conn)->write_seq) - 1;
 =

 	if (!ext->use_map || !skb->len) {
 		/* RFC6824 requires a DSS mapping with specific values
@@ -464,7 +464,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_c=
ontext *subflow,
 		/* The write_seq value has already been incremented, so
 		 * the actual sequence number for the DATA_FIN is one less.
 		 */
-		ext->data_seq =3D data_fin_tx_seq - 1;
+		ext->data_seq =3D data_fin_tx_seq;
 		ext->subflow_seq =3D 0;
 		ext->data_len =3D 1;
 	} else if (ext->data_seq + ext->data_len =3D=3D data_fin_tx_seq) {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cc70a993e934..d04a9bb9448f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -750,7 +750,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 				return MAPPING_DATA_FIN;
 			}
 		} else {
-			u64 data_fin_seq =3D mpext->data_seq + data_len;
+			u64 data_fin_seq =3D mpext->data_seq + data_len - 1;
 =

 			/* If mpext->data_seq is a 32-bit value, data_fin_seq
 			 * must also be limited to 32 bits.
-- =

2.26.2

--===============6907070219754792441==--
