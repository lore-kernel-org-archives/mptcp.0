Content-Type: multipart/mixed; boundary="===============1318404638438883032=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/26] net/bpfilter: split __bpfilter_process_sockopt
Date: Thu, 23 Jul 2020 08:08:44 +0200
Message-ID: <20200723060908.50081-3-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5205

--===============1318404638438883032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split __bpfilter_process_sockopt into a low-level send request routine and
the actual setsockopt hook to split the init time ping from the actual
setsockopt processing.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/bpfilter/bpfilter_kern.c | 51 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 3bac5820062af1..78d561f2c54da7 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -31,48 +31,51 @@ static void __stop_umh(void)
 		shutdown_umh();
 }
 =

-static int __bpfilter_process_sockopt(struct sock *sk, int optname,
-				      char __user *optval,
-				      unsigned int optlen, bool is_set)
+static int bpfilter_send_req(struct mbox_request *req)
 {
-	struct mbox_request req;
 	struct mbox_reply reply;
 	loff_t pos;
 	ssize_t n;
-	int ret =3D -EFAULT;
 =

-	req.is_set =3D is_set;
-	req.pid =3D current->pid;
-	req.cmd =3D optname;
-	req.addr =3D (uintptr_t)optval;
-	req.len =3D optlen;
 	if (!bpfilter_ops.info.tgid)
-		goto out;
+		return -EFAULT;
 	pos =3D 0;
-	n =3D kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
+	n =3D kernel_write(bpfilter_ops.info.pipe_to_umh, req, sizeof(*req),
 			   &pos);
-	if (n !=3D sizeof(req)) {
+	if (n !=3D sizeof(*req)) {
 		pr_err("write fail %zd\n", n);
-		__stop_umh();
-		ret =3D -EFAULT;
-		goto out;
+		goto stop;
 	}
 	pos =3D 0;
 	n =3D kernel_read(bpfilter_ops.info.pipe_from_umh, &reply, sizeof(reply),
 			&pos);
 	if (n !=3D sizeof(reply)) {
 		pr_err("read fail %zd\n", n);
-		__stop_umh();
-		ret =3D -EFAULT;
-		goto out;
+		goto stop;
 	}
-	ret =3D reply.status;
-out:
-	return ret;
+	return reply.status;
+stop:
+	__stop_umh();
+	return -EFAULT;
+}
+
+static int bpfilter_process_sockopt(struct sock *sk, int optname,
+				    char __user *optval, unsigned int optlen,
+				    bool is_set)
+{
+	struct mbox_request req =3D {
+		.is_set		=3D is_set,
+		.pid		=3D current->pid,
+		.cmd		=3D optname,
+		.addr		=3D (uintptr_t)optval,
+		.len		=3D optlen,
+	};
+	return bpfilter_send_req(&req);
 }
 =

 static int start_umh(void)
 {
+	struct mbox_request req =3D { .pid =3D current->pid };
 	int err;
 =

 	/* fork usermode process */
@@ -82,7 +85,7 @@ static int start_umh(void)
 	pr_info("Loaded bpfilter_umh pid %d\n", pid_nr(bpfilter_ops.info.tgid));
 =

 	/* health check that usermode process started correctly */
-	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) !=3D 0) {
+	if (bpfilter_send_req(&req) !=3D 0) {
 		shutdown_umh();
 		return -EFAULT;
 	}
@@ -103,7 +106,7 @@ static int __init load_umh(void)
 	mutex_lock(&bpfilter_ops.lock);
 	err =3D start_umh();
 	if (!err && IS_ENABLED(CONFIG_INET)) {
-		bpfilter_ops.sockopt =3D &__bpfilter_process_sockopt;
+		bpfilter_ops.sockopt =3D &bpfilter_process_sockopt;
 		bpfilter_ops.start =3D &start_umh;
 	}
 	mutex_unlock(&bpfilter_ops.lock);
-- =

2.27.0

--===============1318404638438883032==--
