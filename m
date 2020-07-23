Content-Type: multipart/mixed; boundary="===============0836275773367445030=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3 04/12] mptcp: Add mptcp_close_state()
 helper
Date: Thu, 23 Jul 2020 10:43:08 -0700
Message-ID: <20200723174316.131049-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200723174316.131049-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5265

--===============0836275773367445030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used to transition to the appropriate state on close and
determine if a DATA_FIN needs to be sent for that state transition.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84087982367f..06e8bfea0858 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,6 +1424,33 @@ static void mptcp_subflow_shutdown(struct sock *ssk,=
 int how,
 	release_sock(ssk);
 }
 =

+static const unsigned char new_state[16] =3D {
+	/* current state:     new state:      action:	*/
+	[0 /* (Invalid) */] =3D TCP_CLOSE,
+	[TCP_ESTABLISHED]   =3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+	[TCP_SYN_SENT]      =3D TCP_CLOSE,
+	[TCP_SYN_RECV]      =3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
+	[TCP_FIN_WAIT1]     =3D TCP_FIN_WAIT1,
+	[TCP_FIN_WAIT2]     =3D TCP_FIN_WAIT2,
+	[TCP_TIME_WAIT]     =3D TCP_CLOSE,	/* should not happen ! */
+	[TCP_CLOSE]         =3D TCP_CLOSE,
+	[TCP_CLOSE_WAIT]    =3D TCP_LAST_ACK  | TCP_ACTION_FIN,
+	[TCP_LAST_ACK]      =3D TCP_LAST_ACK,
+	[TCP_LISTEN]        =3D TCP_CLOSE,
+	[TCP_CLOSING]       =3D TCP_CLOSING,
+	[TCP_NEW_SYN_RECV]  =3D TCP_CLOSE,	/* should not happen ! */
+};
+
+static int mptcp_close_state(struct sock *sk)
+{
+	int next =3D (int)new_state[sk->sk_state];
+	int ns =3D next & TCP_STATE_MASK;
+
+	inet_sk_state_store(sk, ns);
+
+	return next & TCP_ACTION_FIN;
+}
+
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
-- =

2.27.0

--===============0836275773367445030==--
