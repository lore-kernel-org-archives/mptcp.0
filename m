Content-Type: multipart/mixed; boundary="===============7462800953486966370=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 04/24] net: switch copy_bpf_fprog_from_user to
 sockptr_t
Date: Mon, 20 Jul 2020 14:47:17 +0200
Message-ID: <20200720124737.118617-5-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5100

--===============7462800953486966370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 include/linux/filter.h | 3 ++-
 net/core/filter.c      | 6 +++---
 net/core/sock.c        | 6 ++++--
 net/packet/af_packet.c | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4d049c8e1fbeaa..87954ef126df77 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -20,6 +20,7 @@
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
+#include <linux/sockptr.h>
 #include <crypto/sha.h>
 =

 #include <net/sch_generic.h>
@@ -1276,6 +1277,6 @@ struct bpf_sockopt_kern {
 	s32		retval;
 };
 =

-int copy_bpf_fprog_from_user(struct sock_fprog *dst, void __user *src, int=
 len);
+int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int le=
n);
 =

 #endif /* __LINUX_FILTER_H__ */
diff --git a/net/core/filter.c b/net/core/filter.c
index 2bf6624796d86f..4cc1d381a273fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -77,14 +77,14 @@
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
 =

-int copy_bpf_fprog_from_user(struct sock_fprog *dst, void __user *src, int=
 len)
+int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int le=
n)
 {
 	if (in_compat_syscall()) {
 		struct compat_sock_fprog f32;
 =

 		if (len !=3D sizeof(f32))
 			return -EINVAL;
-		if (copy_from_user(&f32, src, sizeof(f32)))
+		if (copy_from_sockptr(&f32, src, sizeof(f32)))
 			return -EFAULT;
 		memset(dst, 0, sizeof(*dst));
 		dst->len =3D f32.len;
@@ -92,7 +92,7 @@ int copy_bpf_fprog_from_user(struct sock_fprog *dst, void=
 __user *src, int len)
 	} else {
 		if (len !=3D sizeof(*dst))
 			return -EINVAL;
-		if (copy_from_user(dst, src, sizeof(*dst)))
+		if (copy_from_sockptr(dst, src, sizeof(*dst)))
 			return -EFAULT;
 	}
 =

diff --git a/net/core/sock.c b/net/core/sock.c
index d828bfe1c47dfa..91224709869389 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1062,7 +1062,8 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 	case SO_ATTACH_FILTER: {
 		struct sock_fprog fprog;
 =

-		ret =3D copy_bpf_fprog_from_user(&fprog, optval, optlen);
+		ret =3D copy_bpf_fprog_from_user(&fprog, USER_SOCKPTR(optval),
+					       optlen);
 		if (!ret)
 			ret =3D sk_attach_filter(&fprog, sk);
 		break;
@@ -1083,7 +1084,8 @@ int sock_setsockopt(struct socket *sock, int level, i=
nt optname,
 	case SO_ATTACH_REUSEPORT_CBPF: {
 		struct sock_fprog fprog;
 =

-		ret =3D copy_bpf_fprog_from_user(&fprog, optval, optlen);
+		ret =3D copy_bpf_fprog_from_user(&fprog, USER_SOCKPTR(optval),
+					       optlen);
 		if (!ret)
 			ret =3D sk_reuseport_attach_filter(&fprog, sk);
 		break;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c240fb5de3f014..d8d4f78f78e451 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1536,7 +1536,7 @@ static void __fanout_set_data_bpf(struct packet_fanou=
t *f, struct bpf_prog *new)
 	}
 }
 =

-static int fanout_set_data_cbpf(struct packet_sock *po, char __user *data,
+static int fanout_set_data_cbpf(struct packet_sock *po, sockptr_t data,
 				unsigned int len)
 {
 	struct bpf_prog *new;
@@ -1584,7 +1584,7 @@ static int fanout_set_data(struct packet_sock *po, ch=
ar __user *data,
 {
 	switch (po->fanout->type) {
 	case PACKET_FANOUT_CBPF:
-		return fanout_set_data_cbpf(po, data, len);
+		return fanout_set_data_cbpf(po, USER_SOCKPTR(data), len);
 	case PACKET_FANOUT_EBPF:
 		return fanout_set_data_ebpf(po, data, len);
 	default:
-- =

2.27.0

--===============7462800953486966370==--
