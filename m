Content-Type: multipart/mixed; boundary="===============4583981978456540572=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/22] net: streamline __sys_setsockopt
Date: Fri, 17 Jul 2020 08:23:11 +0200
Message-ID: <20200717062331.691152-3-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5052

--===============4583981978456540572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return early when sockfd_lookup_light fails to reduce a level of
indentation for most of the function body.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/socket.c | 57 +++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 770503c4ca76c9..49a6daf0293b83 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2107,43 +2107,40 @@ static int __sys_setsockopt(int fd, int level, int =
optname,
 		return -EINVAL;
 =

 	sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock !=3D NULL) {
-		err =3D security_socket_setsockopt(sock, level, optname);
-		if (err)
-			goto out_put;
+	if (!sock)
+		return err;
 =

-		err =3D BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level,
-						     &optname, optval, &optlen,
-						     &kernel_optval);
+	err =3D security_socket_setsockopt(sock, level, optname);
+	if (err)
+		goto out_put;
 =

-		if (err < 0) {
-			goto out_put;
-		} else if (err > 0) {
-			err =3D 0;
-			goto out_put;
-		}
+	err =3D BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
+					     optval, &optlen, &kernel_optval);
+	if (err < 0)
+		goto out_put;
+	if (err > 0) {
+		err =3D 0;
+		goto out_put;
+	}
 =

-		if (kernel_optval) {
-			set_fs(KERNEL_DS);
-			optval =3D (char __user __force *)kernel_optval;
-		}
+	if (kernel_optval) {
+		set_fs(KERNEL_DS);
+		optval =3D (char __user __force *)kernel_optval;
+	}
 =

-		if (level =3D=3D SOL_SOCKET && !sock_use_custom_sol_socket(sock))
-			err =3D
-			    sock_setsockopt(sock, level, optname, optval,
+	if (level =3D=3D SOL_SOCKET && !sock_use_custom_sol_socket(sock))
+		err =3D sock_setsockopt(sock, level, optname, optval, optlen);
+	else
+		err =3D sock->ops->setsockopt(sock, level, optname, optval,
 					    optlen);
-		else
-			err =3D
-			    sock->ops->setsockopt(sock, level, optname, optval,
-						  optlen);
 =

-		if (kernel_optval) {
-			set_fs(oldfs);
-			kfree(kernel_optval);
-		}
-out_put:
-		fput_light(sock->file, fput_needed);
+	if (kernel_optval) {
+		set_fs(oldfs);
+		kfree(kernel_optval);
 	}
+
+out_put:
+	fput_light(sock->file, fput_needed);
 	return err;
 }
 =

-- =

2.27.0

--===============4583981978456540572==--
