Content-Type: multipart/mixed; boundary="===============4191479320521644012=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 3/3] mptcp: Only send DATA_FIN with final mapping
Date: Thu, 27 Feb 2020 16:29:41 -0800
Message-ID: <20200228002941.99393-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200228002941.99393-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3820

--===============4191479320521644012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a DATA_FIN is sent in a MPTCP DSS option that contains a data
mapping, the DATA_FIN consumes one byte of space in the mapping. In this
case, the DATA_FIN should only be included in the DSS option if its
sequence number aligns with the end of the mapped data. Otherwise the
subflow can send an incorrect implicit sequence number for the DATA_FIN,
and the DATA_ACK for that sequence number would not close the
MPTCP-level connection correctly.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 90c81953ec2c..b9a8305bd934 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -304,21 +304,22 @@ static bool mptcp_established_options_mp(struct sock =
*sk, struct sk_buff *skb,
 static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 				 struct mptcp_ext *ext)
 {
-	ext->data_fin =3D 1;
-
 	if (!ext->use_map) {
 		/* RFC6824 requires a DSS mapping with specific values
 		 * if DATA_FIN is set but no data payload is mapped
 		 */
+		ext->data_fin =3D 1;
 		ext->use_map =3D 1;
 		ext->dsn64 =3D 1;
 		ext->data_seq =3D subflow->data_fin_tx_seq;
 		ext->subflow_seq =3D 0;
 		ext->data_len =3D 1;
-	} else {
-		/* If there's an existing DSS mapping, DATA_FIN consumes
-		 * 1 additional byte of mapping space.
+	} else if (ext->data_seq + ext->data_len =3D=3D subflow->data_fin_tx_seq)=
 {
+		/* If there's an existing DSS mapping and it is the
+		 * final mapping, DATA_FIN consumes 1 additional byte of
+		 * mapping space.
 		 */
+		ext->data_fin =3D 1;
 		ext->data_len++;
 	}
 }
-- =

2.25.1

--===============4191479320521644012==--
