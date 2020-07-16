Content-Type: multipart/mixed; boundary="===============6561757420088411201=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 02/12] mptcp: Return EPIPE if sending is
 shut down during a sendmsg
Date: Wed, 15 Jul 2020 17:20:26 -0700
Message-ID: <20200716002036.705306-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200716002036.705306-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5030

--===============6561757420088411201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A MPTCP socket where sending has been shut down should not attempt to
send additional data, since DATA_FIN has already been sent.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65d984f27fbb..7cdf451ea3da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -748,6 +748,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 restart:
 	mptcp_clean_una(sk);
 =

+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
+		ret =3D -EPIPE;
+		goto out;
+	}
+
 wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_send(msk);
-- =

2.27.0

--===============6561757420088411201==--
