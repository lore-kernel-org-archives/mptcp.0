Content-Type: multipart/mixed; boundary="===============4026397732920724633=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH mptcp-next 3/6] mptcp: add prio_changed flag
Date: Thu, 05 Nov 2020 18:50:20 +0800
Message-ID: <d4d26e6344d7e4a039a3f908cd716e7110ae0308.1604572610.git.geliangtang@gmail.com>
In-Reply-To: 8d79f5c026f70bd840665e4055b460d28e89cbc6.1604572610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6560

--===============4026397732920724633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch add a new flag named prio_changed in msk. When we received
the MP_PRIO suboption, we set this flag to true.

In mptcp_subflow_get_send, we check whether prio_changed is set. If it
is, we pick a new subflow to send data.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a4dc4aa39ad8..b6f4f54e6546 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -195,6 +195,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 prio=
_bkup)
 =

 	spin_lock_bh(&msk->pm.lock);
 	subflow->backup =3D prio_bkup;
+	WRITE_ONCE(msk->prio_changed, true);
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6bd06c724d5..7a7561ba9edf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1133,7 +1133,8 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
+	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd)) &&
+	    !READ_ONCE(msk->prio_changed)) {
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk =3D  mptcp_subflow_tcp_sock(subflow);
 			*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
@@ -1180,6 +1181,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 		msk->last_snd =3D send_info[0].ssk;
 		msk->snd_burst =3D min_t(int, MPTCP_SEND_BURST_SIZE,
 				       sk_stream_wspace(msk->last_snd));
+		WRITE_ONCE(msk->prio_changed, false);
 		return msk->last_snd;
 	}
 	return NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 871b73046de0..c3386a6a7a16 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -240,6 +240,7 @@ struct mptcp_sock {
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		prio_changed;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
-- =

2.26.2

--===============4026397732920724633==--
