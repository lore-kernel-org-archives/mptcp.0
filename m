Content-Type: multipart/mixed; boundary="===============4806524280862418735=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/22] net: streamline __sys_getsockopt
Date: Fri, 17 Jul 2020 08:23:12 +0200
Message-ID: <20200717062331.691152-4-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5050

--===============4806524280862418735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return early when sockfd_lookup_light fails to reduce a level of
indentation for most of the function body.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/socket.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 49a6daf0293b83..b79376b17b45b7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2163,28 +2163,25 @@ static int __sys_getsockopt(int fd, int level, int =
optname,
 	int max_optlen;
 =

 	sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock !=3D NULL) {
-		err =3D security_socket_getsockopt(sock, level, optname);
-		if (err)
-			goto out_put;
+	if (!sock)
+		return err;
 =

-		max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	err =3D security_socket_getsockopt(sock, level, optname);
+	if (err)
+		goto out_put;
 =

-		if (level =3D=3D SOL_SOCKET)
-			err =3D
-			    sock_getsockopt(sock, level, optname, optval,
+	max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+
+	if (level =3D=3D SOL_SOCKET)
+		err =3D sock_getsockopt(sock, level, optname, optval, optlen);
+	else
+		err =3D sock->ops->getsockopt(sock, level, optname, optval,
 					    optlen);
-		else
-			err =3D
-			    sock->ops->getsockopt(sock, level, optname, optval,
-						  optlen);
 =

-		err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
-						     optval, optlen,
-						     max_optlen, err);
+	err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname, optval,
+					     optlen, max_optlen, err);
 out_put:
-		fput_light(sock->file, fput_needed);
-	}
+	fput_light(sock->file, fput_needed);
 	return err;
 }
 =

-- =

2.27.0

--===============4806524280862418735==--
