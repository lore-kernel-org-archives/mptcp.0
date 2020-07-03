Content-Type: multipart/mixed; boundary="===============0133011874414407733=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix DSS map generation on fin
 retransmission
Date: Fri, 03 Jul 2020 18:06:04 +0200
Message-ID: <1fa7663816c25b247db50501cf3d9df01729dc28.1593792286.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4908

--===============0133011874414407733==
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
Reported-by: syzbot+42a07faa5923cfaeb9c9(a)syzkaller.appspotmail.com
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index df9a51425c6f..8f940be42f98 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -449,9 +449,9 @@ static bool mptcp_established_options_mp(struct sock *s=
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
@@ -503,7 +503,7 @@ static bool mptcp_established_options_dss(struct sock *=
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

--===============0133011874414407733==--
