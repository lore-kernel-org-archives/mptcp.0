Content-Type: multipart/mixed; boundary="===============6886463878138943735=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 01/26] bpfilter: fix up a sparse annotation
Date: Thu, 23 Jul 2020 08:08:43 +0200
Message-ID: <20200723060908.50081-2-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5201

--===============6886463878138943735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The __user doesn't make sense when casting to an integer type, just
switch to a uintptr_t cast which also removes the need for the __force.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 2c31e82cb953af..3bac5820062af1 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -44,7 +44,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, in=
t optname,
 	req.is_set =3D is_set;
 	req.pid =3D current->pid;
 	req.cmd =3D optname;
-	req.addr =3D (long __force __user)optval;
+	req.addr =3D (uintptr_t)optval;
 	req.len =3D optlen;
 	if (!bpfilter_ops.info.tgid)
 		goto out;
-- =

2.27.0

--===============6886463878138943735==--
