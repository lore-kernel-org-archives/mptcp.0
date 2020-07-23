Content-Type: multipart/mixed; boundary="===============1606251956095243489=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/26] bpfilter: reject kernel addresses
Date: Thu, 23 Jul 2020 08:08:45 +0200
Message-ID: <20200723060908.50081-4-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5206

--===============1606251956095243489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bpfilter user mode helper processes the optval address using
process_vm_readv.  Don't send it kernel addresses fed under
set_fs(KERNEL_DS) as that won't work.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/bpfilter/bpfilter_kern.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 78d561f2c54da7..00540457e5f4d3 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -70,6 +70,10 @@ static int bpfilter_process_sockopt(struct sock *sk, int=
 optname,
 		.addr		=3D (uintptr_t)optval,
 		.len		=3D optlen,
 	};
+	if (uaccess_kernel()) {
+		pr_err("kernel access not supported\n");
+		return -EFAULT;
+	}
 	return bpfilter_send_req(&req);
 }
 =

-- =

2.27.0

--===============1606251956095243489==--
