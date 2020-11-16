Content-Type: multipart/mixed; boundary="===============0793204446503121338=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 10/13] mptcp: try to push pending data on
 snd una updates
Date: Mon, 16 Nov 2020 10:48:11 +0100
Message-ID: <4904fdfcf76b73394a731ae7a7e32b2a2407c7b4.1605458224.git.pabeni@redhat.com>
In-Reply-To: cover.1605458224.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6748

--===============0793204446503121338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous patch we may end-up with unsent data
in the write buffer. If such buffer is full, the writer
will block for unlimited time.

We need to trigger the MPTCP xmit path even for the
subflow rx path, on MPTCP snd_una updates.

Keep things simple and just schedule the work queue if
needed.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9b30c4b39159..821daa922ca3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -725,6 +725,7 @@ void mptcp_data_acked(struct sock *sk)
 	mptcp_reset_timer(sk);
 =

 	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
+	     mptcp_send_head(sk) ||
 	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
 		mptcp_schedule_work(sk);
 }
@@ -1840,6 +1841,8 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(msk);
 =

 	__mptcp_move_skbs(msk);
+	if (mptcp_send_head(sk))
+		mptcp_push_pending(sk, 0);
 =

 	if (msk->pm.status)
 		pm_work(msk);
-- =

2.26.2

--===============0793204446503121338==--
