Content-Type: multipart/mixed; boundary="===============2926108983514946879=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v4 10/12] mptcp: Skip unnecessary skb
 extension allocation for bare acks
Date: Thu, 23 Jul 2020 18:11:25 -0700
Message-ID: <20200724011127.363638-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200724011127.363638-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5286

--===============2926108983514946879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bare TCP ack skbs are freed right after MPTCP sees them, so the work to
allocate, zero, and populate the MPTCP skb extension is wasted. Detect
these skbs and do not add skb extensions to them.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b4458ecd01f8..7fa822b55c34 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -868,15 +868,18 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 	if (mp_opt.use_ack)
 		update_una(msk, &mp_opt);
 =

-	/* Zero-length packets, like bare ACKs carrying a DATA_FIN, are
-	 * dropped by the caller and not propagated to the MPTCP layer.
-	 * Copy the DATA_FIN information now.
+	/* Zero-data-length packets are dropped by the caller and not
+	 * propagated to the MPTCP layer, so the skb extension does not
+	 * need to be allocated or populated. DATA_FIN information, if
+	 * present, needs to be updated here before the skb is freed.
 	 */
 	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
 		if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
 		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq) &&
 		    schedule_work(&msk->work))
 			sock_hold(subflow->conn);
+
+		return;
 	}
 =

 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
-- =

2.27.0

--===============2926108983514946879==--
