Content-Type: multipart/mixed; boundary="===============0889051527082617448=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix DSS map generation on fin
 retransmission
Date: Fri, 26 Jun 2020 11:10:40 +0200
Message-ID: <931b43323a1bd913745dca440b26f85bb25e062c.1593162557.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4810

--===============0889051527082617448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The RFC 8684 mandates that no-data DATA FIN packets should carry
a DSS with 0 sequence number and data len equal to 1. Currently,
on FIN retransmission we re-use the existing mapping; if the previous
fin transmission was part of a partially acked data packet, we could
end-up writing in the egress packet a non-compliant DSS.

The above will be detected by a "Bad mapping" warning on the receiver
side.

This change addresses the issue explicitly checking for 0 len packet
when adding the DATA_FIN option.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
this should go on "top" of export branch, just before the "DO NOT MERGE"
changes.
Hopefully should not conflict with others

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f464f8669dfc..46470194b8ca 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -451,9 +451,9 @@ static bool mptcp_established_options_mp(struct sock *s=
k, struct sk_buff *skb,
 }
 =

 static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
-				 struct mptcp_ext *ext)
+				 struct sk_buff *skb, struct mptcp_ext *ext)
 {
-	if (!ext->use_map) {
+	if (!ext->use_map || !skb->len) {
 		/* RFC6824 requires a DSS mapping with specific values
 		 * if DATA_FIN is set but no data payload is mapped
 		 */
@@ -505,7 +505,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 			opts->ext_copy =3D *mpext;
 =

 		if (skb && tcp_fin && subflow->data_fin_tx_enable)
-			mptcp_write_data_fin(subflow, &opts->ext_copy);
+			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret =3D true;
 	}
 =

-- =

2.26.2

--===============0889051527082617448==--
