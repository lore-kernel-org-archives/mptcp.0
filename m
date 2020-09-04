Content-Type: multipart/mixed; boundary="===============4284527525315686625=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: Wake up MPTCP worker when DATA_FIN
 found on a TCP FIN packet
Date: Thu, 03 Sep 2020 17:35:31 -0700
Message-ID: <20200904003531.291283-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 5716

--===============4284527525315686625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
information would be stored but the MPTCP worker did not get
scheduled. In turn, the MPTCP socket state would remain in
TCP_ESTABLISHED and no blocked operations would be awakened.

TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
subflow receive queues, so schedule the MPTCP worker when a skb with
DATA_FIN but no data payload is moved from a subflow queue. Other cases
(DATA_FIN on a bare TCP ACK or on a packet with data payload) are
already handled.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

This patch is targeted at the -net tree, but also applies to net-next
without conflict. If it looks ok, we can carry it in the export branch
until it gets merged to both -net and net-next.

net/mptcp/subflow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8cac2655c82..3297233dece7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -731,7 +731,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 =

 	if (mpext->data_fin =3D=3D 1) {
 		if (data_len =3D=3D 1) {
-			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
+			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq);
 			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
@@ -742,6 +742,9 @@ static enum mapping_status get_mapping_status(struct so=
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

base-commit: 556699341efa98243e08e34401b3f601da91f5a3
-- =

2.28.0

--===============4284527525315686625==--
