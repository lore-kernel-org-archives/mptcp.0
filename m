Content-Type: multipart/mixed; boundary="===============4366621272474089655=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/24] bpfilter: fix up a sparse annotation
Date: Mon, 20 Jul 2020 14:47:15 +0200
Message-ID: <20200720124737.118617-3-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5105

--===============4366621272474089655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The __user doesn't make sense when casting to an integer type.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 977e9dad72ca4f..713b4b3d02005d 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -49,7 +49,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, in=
t optname,
 	req.is_set =3D is_set;
 	req.pid =3D current->pid;
 	req.cmd =3D optname;
-	req.addr =3D (long __force __user)optval;
+	req.addr =3D (__force long)optval;
 	req.len =3D optlen;
 	if (!bpfilter_ops.info.tgid)
 		goto out;
-- =

2.27.0

--===============4366621272474089655==--
