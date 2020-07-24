Content-Type: multipart/mixed; boundary="===============0430889386928567474=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v4 09/12] mptcp: Only use subflow EOF
 signaling on fallback connections
Date: Thu, 23 Jul 2020 18:11:24 -0700
Message-ID: <20200724011127.363638-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200724011127.363638-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5284

--===============0430889386928567474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP state machine handles disconnections on non-fallback connections,
but the mptcp_sock still needs to get notified when fallback subflows
disconnect.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7ab2a52ad150..1c8482bc2ce5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1159,7 +1159,8 @@ static void subflow_state_change(struct sock *sk)
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

-	if (!(parent->sk_shutdown & RCV_SHUTDOWN) &&
+	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
+	    !(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
 		mptcp_subflow_eof(parent);
-- =

2.27.0

--===============0430889386928567474==--
