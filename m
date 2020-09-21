Content-Type: multipart/mixed; boundary="===============6564035553736938608=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3] mptcp: Wake up MPTCP worker when DATA_FIN
 found on a TCP FIN packet
Date: Mon, 21 Sep 2020 16:57:58 +0200
Message-ID: <20200921145759.1302197-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5964

--===============6564035553736938608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
information would be stored but the MPTCP worker did not get
scheduled. In turn, the MPTCP socket state would remain in
TCP_ESTABLISHED and no blocked operations would be awakened.

TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
subflow receive queues, so schedule the MPTCP worker when a skb with
DATA_FIN but no data payload is moved from a subflow queue. Other cases
(DATA_FIN on a bare TCP ACK or on a packet with data payload) are
already handled.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/84
Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    This is a resend of v1 and v2 with the same code modification. The
    previous versions did not get delivered to vger.kernel.org but did go
    to other recipients. There is a known issue with the SMTP server on
    the Intel side. Sorry for the multiple versions.
    =

    The only modifications compared to v1 and v2 are in the commit message:
    - Paolo's ACK is back: it was accidentaly dropped.
    - My SOB is at the end, being the new sender of this patch from Mat.

 net/mptcp/subflow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 34d6230df017..31316cfeb4d0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -733,7 +733,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 =

 	if (mpext->data_fin =3D=3D 1) {
 		if (data_len =3D=3D 1) {
-			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
+			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq);
 			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
@@ -744,6 +744,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 				skb_ext_del(skb, SKB_EXT_MPTCP);
 				return MAPPING_OK;
 			} else {
+				if (updated && schedule_work(&msk->work))
+					sock_hold((struct sock *)msk);
+
 				return MAPPING_DATA_FIN;
 			}
 		} else {
-- =

2.27.0

--===============6564035553736938608==--
