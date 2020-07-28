Content-Type: multipart/mixed; boundary="===============1593192969666261116=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 01/12] mptcp: Allow DATA_FIN in headers
 without TCP FIN
Date: Tue, 28 Jul 2020 15:11:59 -0700
Message-ID: <20200728221210.92841-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5344

--===============1593192969666261116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RFC 8684-compliant DATA_FIN needs to be sent and ack'd before subflows
are closed with TCP FIN, so write DATA_FIN DSS headers whenever their
transmission has been enabled by the MPTCP connection-level socket.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3bc56eb608d8..0b122b2a9c69 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -482,17 +482,10 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	struct mptcp_sock *msk;
 	unsigned int ack_size;
 	bool ret =3D false;
-	u8 tcp_fin;
 =

-	if (skb) {
-		mpext =3D mptcp_get_ext(skb);
-		tcp_fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	} else {
-		mpext =3D NULL;
-		tcp_fin =3D 0;
-	}
+	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
 =

-	if (!skb || (mpext && mpext->use_map) || tcp_fin) {
+	if (!skb || (mpext && mpext->use_map) || subflow->data_fin_tx_enable) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -502,7 +495,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		if (mpext)
 			opts->ext_copy =3D *mpext;
 =

-		if (skb && tcp_fin && subflow->data_fin_tx_enable)
+		if (skb && subflow->data_fin_tx_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret =3D true;
 	}
-- =

2.28.0

--===============1593192969666261116==--
