Content-Type: multipart/mixed; boundary="===============7954111465714525205=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] mptcp: subflow: disallow setsockopt(...
 TCP_ULP, "mptcp")
Date: Mon, 14 Oct 2019 16:46:09 +0200
Message-ID: <ae8e4d5132a8882ae4ae558d31f200a8ef8bef96.1571061853.git.dcaratti@redhat.com>
In-Reply-To: cover.1571061853.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2108

--===============7954111465714525205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

the MPTCP ULP can be attached to a TCP socket only if the socket has been
created with sock_create_kern(): ensure that the value of sk->sk_kern_sock
is 1 in the MPTCP subflow init() function, and let it return -EOPNOTSUPP
otherwise.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/subflow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ebe93525b0aa..b40d927e71ca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -435,6 +435,13 @@ static int subflow_ulp_init(struct sock *sk)
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	int err =3D 0;
 =

+	/* disallow attaching ULP to a socket unless it has been
+	 * created with sock_create_kern()
+	 */
+	if (!sk->sk_kern_sock) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
 	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
 	if (!ctx) {
 		err =3D -ENOMEM;
-- =

2.21.0

--===============7954111465714525205==--
