Content-Type: multipart/mixed; boundary="===============4723688395470925295=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 19/26] net/ipv6: switch ipv6_flowlabel_opt to
 sockptr_t
Date: Mon, 27 Jul 2020 18:15:55 +0200
Message-ID: <20200727161555.GA7817@lst.de>
In-Reply-To: 20200727133331.GA1851348@shredder
X-Status: 
X-Keywords:                  
X-UID: 5323

--===============4723688395470925295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have to admit I didn't spot the difference between the good and the
bad output even after trying hard..

But can you try the patch below?

---
From cce2d2e1b43ecee5f4af7cf116808b74b330080f Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch(a)lst.de>
Date: Mon, 27 Jul 2020 17:42:27 +0200
Subject: net: remove sockptr_advance

sockptr_advance never properly worked.  Replace it with _offset variants
of copy_from_sockptr and copy_to_sockptr.

Fixes: ba423fdaa589 ("net: add a new sockptr_t type")
Reported-by: Jason A. Donenfeld <Jason(a)zx2c4.com>
Reported-by: Ido Schimmel <idosch(a)idosch.org>
Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 drivers/crypto/chelsio/chtls/chtls_main.c | 12 +++++-----
 include/linux/sockptr.h                   | 27 +++++++++++------------
 net/dccp/proto.c                          |  5 ++---
 net/ipv4/netfilter/arp_tables.c           |  8 +++----
 net/ipv4/netfilter/ip_tables.c            |  8 +++----
 net/ipv4/tcp.c                            |  5 +++--
 net/ipv6/ip6_flowlabel.c                  | 11 ++++-----
 net/ipv6/netfilter/ip6_tables.c           |  8 +++----
 net/netfilter/x_tables.c                  |  7 +++---
 net/tls/tls_main.c                        |  6 ++---
 10 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/che=
lsio/chtls/chtls_main.c
index c3058dcdb33c5c..66d247efd5615b 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -525,9 +525,9 @@ static int do_chtls_setsockopt(struct sock *sk, int opt=
name,
 		/* Obtain version and type from previous copy */
 		crypto_info[0] =3D tmp_crypto_info;
 		/* Now copy the following data */
-		sockptr_advance(optval, sizeof(*crypto_info));
-		rc =3D copy_from_sockptr((char *)crypto_info + sizeof(*crypto_info),
-				optval,
+		rc =3D copy_from_sockptr_offset((char *)crypto_info +
+				sizeof(*crypto_info),
+				optval, sizeof(*crypto_info),
 				sizeof(struct tls12_crypto_info_aes_gcm_128)
 				- sizeof(*crypto_info));
 =

@@ -542,9 +542,9 @@ static int do_chtls_setsockopt(struct sock *sk, int opt=
name,
 	}
 	case TLS_CIPHER_AES_GCM_256: {
 		crypto_info[0] =3D tmp_crypto_info;
-		sockptr_advance(optval, sizeof(*crypto_info));
-		rc =3D copy_from_sockptr((char *)crypto_info + sizeof(*crypto_info),
-				    optval,
+		rc =3D copy_from_sockptr_offset((char *)crypto_info +
+				sizeof(*crypto_info),
+				optval, sizeof(*crypto_info),
 				sizeof(struct tls12_crypto_info_aes_gcm_256)
 				- sizeof(*crypto_info));
 =

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index b13ea1422f93a5..9e6c81d474cba8 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -69,19 +69,26 @@ static inline bool sockptr_is_null(sockptr_t sockptr)
 	return !sockptr.user;
 }
 =

-static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
+static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
+		size_t offset, size_t size)
 {
 	if (!sockptr_is_kernel(src))
-		return copy_from_user(dst, src.user, size);
-	memcpy(dst, src.kernel, size);
+		return copy_from_user(dst, src.user + offset, size);
+	memcpy(dst, src.kernel + offset, size);
 	return 0;
 }
 =

-static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t s=
ize)
+static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
+{
+	return copy_from_sockptr_offset(dst, src, 0, size);
+}
+
+static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
+		const void *src, size_t size)
 {
 	if (!sockptr_is_kernel(dst))
-		return copy_to_user(dst.user, src, size);
-	memcpy(dst.kernel, src, size);
+		return copy_to_user(dst.user + offset, src, size);
+	memcpy(dst.kernel + offset, src, size);
 	return 0;
 }
 =

@@ -112,14 +119,6 @@ static inline void *memdup_sockptr_nul(sockptr_t src, =
size_t len)
 	return p;
 }
 =

-static inline void sockptr_advance(sockptr_t sockptr, size_t len)
-{
-	if (sockptr_is_kernel(sockptr))
-		sockptr.kernel +=3D len;
-	else
-		sockptr.user +=3D len;
-}
-
 static inline long strncpy_from_sockptr(char *dst, sockptr_t src, size_t c=
ount)
 {
 	if (sockptr_is_kernel(src)) {
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 2e9e8449698fb4..d148ab1530e57b 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -426,9 +426,8 @@ static int dccp_setsockopt_service(struct sock *sk, con=
st __be32 service,
 			return -ENOMEM;
 =

 		sl->dccpsl_nr =3D optlen / sizeof(u32) - 1;
-		sockptr_advance(optval, sizeof(service));
-		if (copy_from_sockptr(sl->dccpsl_list, optval,
-				      optlen - sizeof(service)) ||
+		if (copy_from_sockptr_offset(sl->dccpsl_list, optval,
+				sizeof(service), optlen - sizeof(service)) ||
 		    dccp_list_has_service(sl, DCCP_SERVICE_INVALID_VALUE)) {
 			kfree(sl);
 			return -EFAULT;
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_table=
s.c
index 9a1567dbc022b6..d1e04d2b5170ec 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -971,8 +971,8 @@ static int do_replace(struct net *net, sockptr_t arg, u=
nsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1267,8 +1267,8 @@ static int compat_do_replace(struct net *net, sockptr=
_t arg, unsigned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index f2a9680303d8c0..f15bc21d730164 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1126,8 +1126,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned i=
nt len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1508,8 +1508,8 @@ compat_do_replace(struct net *net, sockptr_t arg, uns=
igned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 27de9380ed140e..4afec552f211b9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2801,12 +2801,13 @@ static int tcp_repair_options_est(struct sock *sk, =
sockptr_t optbuf,
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_repair_opt opt;
+	size_t offset =3D 0;
 =

 	while (len >=3D sizeof(opt)) {
-		if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
+		if (copy_from_sockptr_offset(&opt, optbuf, offset, sizeof(opt)))
 			return -EFAULT;
 =

-		sockptr_advance(optbuf, sizeof(opt));
+		offset +=3D sizeof(opt);
 		len -=3D sizeof(opt);
 =

 		switch (opt.opt_code) {
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 215b6f5e733ec9..2d655260dedc75 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -401,8 +401,8 @@ fl_create(struct net *net, struct sock *sk, struct in6_=
flowlabel_req *freq,
 		memset(fl->opt, 0, sizeof(*fl->opt));
 		fl->opt->tot_len =3D sizeof(*fl->opt) + olen;
 		err =3D -EFAULT;
-		sockptr_advance(optval, CMSG_ALIGN(sizeof(*freq)));
-		if (copy_from_sockptr(fl->opt + 1, optval, olen))
+		if (copy_from_sockptr_offset(fl->opt + 1, optval,
+				CMSG_ALIGN(sizeof(*freq)), olen))
 			goto done;
 =

 		msg.msg_controllen =3D olen;
@@ -703,9 +703,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct =
in6_flowlabel_req *freq,
 		goto recheck;
 =

 	if (!freq->flr_label) {
-		sockptr_advance(optval,
-				offsetof(struct in6_flowlabel_req, flr_label));
-		if (copy_to_sockptr(optval, &fl->label, sizeof(fl->label))) {
+		size_t offset =3D offsetof(struct in6_flowlabel_req, flr_label);
+
+		if (copy_to_sockptr_offset(optval, offset, &fl->label,
+				sizeof(fl->label))) {
 			/* Intentionally ignore fault. */
 		}
 	}
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_table=
s.c
index 1d52957a413f4a..2e2119bfcf1373 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1143,8 +1143,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned i=
nt len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
@@ -1517,8 +1517,8 @@ compat_do_replace(struct net *net, sockptr_t arg, uns=
igned int len)
 		return -ENOMEM;
 =

 	loc_cpu_entry =3D newinfo->entries;
-	sockptr_advance(arg, sizeof(tmp));
-	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
+	if (copy_from_sockptr_offset(loc_cpu_entry, arg, sizeof(tmp),
+			tmp.size) !=3D 0) {
 		ret =3D -EFAULT;
 		goto free_newinfo;
 	}
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index b97eb4b538fd4e..91bf6635ea9ee4 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1050,6 +1050,7 @@ EXPORT_SYMBOL_GPL(xt_check_target);
 void *xt_copy_counters(sockptr_t arg, unsigned int len,
 		       struct xt_counters_info *info)
 {
+	size_t offset;
 	void *mem;
 	u64 size;
 =

@@ -1067,7 +1068,7 @@ void *xt_copy_counters(sockptr_t arg, unsigned int le=
n,
 =

 		memcpy(info->name, compat_tmp.name, sizeof(info->name) - 1);
 		info->num_counters =3D compat_tmp.num_counters;
-		sockptr_advance(arg, sizeof(compat_tmp));
+		offset =3D sizeof(compat_tmp);
 	} else
 #endif
 	{
@@ -1078,7 +1079,7 @@ void *xt_copy_counters(sockptr_t arg, unsigned int le=
n,
 		if (copy_from_sockptr(info, arg, sizeof(*info)) !=3D 0)
 			return ERR_PTR(-EFAULT);
 =

-		sockptr_advance(arg, sizeof(*info));
+		offset =3D sizeof(*info);
 	}
 	info->name[sizeof(info->name) - 1] =3D '\0';
 =

@@ -1092,7 +1093,7 @@ void *xt_copy_counters(sockptr_t arg, unsigned int le=
n,
 	if (!mem)
 		return ERR_PTR(-ENOMEM);
 =

-	if (copy_from_sockptr(mem, arg, len) =3D=3D 0)
+	if (copy_from_sockptr_offset(mem, arg, offset, len) =3D=3D 0)
 		return mem;
 =

 	vfree(mem);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index d77f7d821130db..bbc52b088d2968 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -522,9 +522,9 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 		goto err_crypto_info;
 	}
 =

-	sockptr_advance(optval, sizeof(*crypto_info));
-	rc =3D copy_from_sockptr(crypto_info + 1, optval,
-			       optlen - sizeof(*crypto_info));
+	rc =3D copy_from_sockptr_offset(crypto_info + 1, optval,
+				      sizeof(*crypto_info),
+				      optlen - sizeof(*crypto_info));
 	if (rc) {
 		rc =3D -EFAULT;
 		goto err_crypto_info;
-- =

2.27.0

--===============4723688395470925295==--
