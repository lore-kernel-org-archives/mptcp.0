Content-Type: multipart/mixed; boundary="===============5758379896320234150=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 7/7] mptcp: prevent null deref crash on normal
 tcp sockets
Date: Wed, 15 Apr 2020 19:19:54 +0200
Message-ID: <20200415171954.15321-8-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4186

--===============5758379896320234150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Best case we get a WARN in mptcp_accept().

Worst case is a null pointer dereference when we attempt to add mptcp
options to the tcp flow: it has 'is_mptcp' set to 1, but a subflow
context with a NULL mptcp master socket (ctx->conn).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7ad9413cf9d9..f9fe59febf6a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -495,8 +495,12 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 =

 out:
 	/* dispose of the left over mptcp master, if any */
-	if (unlikely(new_msk))
+	if (unlikely(new_msk)) {
+		if (child)
+			tcp_sk(child)->is_mptcp =3D 0;
 		mptcp_force_close(new_msk);
+	}
+
 	return child;
 =

 close_child:
-- =

2.24.1

--===============5758379896320234150==--
