Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB72
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 15:23:43 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1m6aD3-0003Fv-NZ; Thu, 22 Jul 2021 17:02:01 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [RFC] mptcp: add MPTCP_INFO getsockopt
Date: Thu, 22 Jul 2021 17:01:54 +0200
Message-Id: <20210722150154.10608-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its not compatible with mptcp.org kernel one:
1. mptcp.org defines 'struct mptcp_info', but we already have this for
   inet_diag.

2. 'struct mptcp_info', as defined by mptcp.org has different layout for
   32/64 bit arches.
   This is a problem for 32bit binaries on 64bit kernels.

For those reasons a new 'struct mptcp_info_opt' is added which contains
aligned_u64 fields to store the userspace buffer addresses.

'struct mptcp_sub_info' is added as per mptcp.org kernel, but I don't
like this structure.  I think 'src' and 'dst' are confusing terms.

AFAICS 'src' really is 'local address' (getsockname) and 'dst' is peer
(getpeername).

Given mptcp-next has IPPROTO_MPTCP, this adds SOL_MPTCP.
This also gives ample space to add mptcp specific sockopts.

In light of this, I wonder if it would make more sense to split the
functionality.

Examples:

getsockopt(fd, SOL_MPTCP, SUBFLOW_ID, subflow_ids, &count);

sa.sa_family = subflow_ids[0];
getsockopt(fd, SOL_MPTCP, SUBFLOW_GETPEERNAME, &sa, &len);
..
sa.sa_family = subflow_ids[0];
getsockopt(fd, SOL_MPTCP, SUBFLOW_GETSOCKNAME, &sa, &len);

tcp_info.tcpi_state = subflow_ids[0];
getsockopt(fd, SOL_MPTCP, SUBFLOW_TCP_INFO, &tcp_info, &len);

...

and so on.

Alternatively one could overload e.g. the upper 8 bit:

getsockopt(fd, SOL_MPTCP, subflow_ids[0] << 24 | SUBFLOW_FOO, ...);

In any case, here is a tentative patch to add a mptcp.org-alike
MPTCP_INFO getsockopt.

It depends on a tiny extra patch to move part of inet_diag to the core.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/socket.h     |   1 +
 include/uapi/linux/mptcp.h |  30 ++++++
 net/mptcp/sockopt.c        | 197 +++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 0d8e3dcb7f88..af853eadadcb 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -360,6 +360,7 @@ struct ucred {
 #define SOL_KCM		281
 #define SOL_TLS		282
 #define SOL_XDP		283
+#define SOL_MPTCP	284
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 7b05f7102321..35d90f08b376 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <linux/types.h>
+#include <linux/in.h>
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -192,4 +193,33 @@ enum mptcp_event_attr {
 #define MPTCP_RST_EBADPERF	5
 #define MPTCP_RST_EMIDDLEBOX	6
 
+struct mptcp_info_opt {
+	__u32		tcp_info_len;		/* Length of each struct tcp_info in subflows pointer */
+	__u32		sub_len;		/* Total length of memory pointed to by subflows pointer */
+	__u32		meta_info_len;		/* Length of memory pointed to by meta_info */
+	__u32		sub_info_len;		/* Length of each struct mptcp_sub_info in subflow_info pointer */
+	__u32		total_sub_info_len;	/* Total length of memory pointed to by subflow_info */
+
+	__aligned_u64	meta_info;
+	__aligned_u64	initial;
+	__aligned_u64	subflows;
+	__aligned_u64	subflow_info;		/* mptcp_sub_info[] */
+};
+
+struct mptcp_sub_info {
+	union {
+		struct sockaddr src;
+		struct sockaddr_in src_v4;
+		struct sockaddr_in6 src_v6;
+	};
+	union {
+		struct sockaddr dst;
+		struct sockaddr_in dst_v4;
+		struct sockaddr_in6 dst_v6;
+	};
+};
+
+/* MPTCP socket options */
+#define MPTCP_INFO 1
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4c68ce14843a..a78302750578 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -668,6 +668,190 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
+static int mptcp_get_diaginfo(struct mptcp_sock *msk, struct mptcp_info_opt *m_info)
+{
+	unsigned int user_len, len;
+	struct mptcp_info __info;
+
+	memset(&__info, 0, sizeof(__info));
+
+	mptcp_diag_fill_info(msk, &__info);
+
+	user_len = m_info->meta_info_len;
+	len = min_t(unsigned int, user_len, sizeof(__info));
+	m_info->meta_info_len = len;
+
+	if (copy_to_user((void __user *)m_info->meta_info, &__info, len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void mptcp_get_sub_info(const struct sock *sk, struct mptcp_sub_info *info)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	memset(info, 0, sizeof(*info));
+
+	if (sk->sk_family == AF_INET) {
+		info->src_v4.sin_family = AF_INET;
+		info->src_v4.sin_port = inet->inet_sport;
+
+		info->src_v4.sin_addr.s_addr = inet->inet_rcv_saddr;
+		if (!info->src_v4.sin_addr.s_addr)
+			info->src_v4.sin_addr.s_addr = inet->inet_saddr;
+
+		info->dst_v4.sin_family = AF_INET;
+		info->dst_v4.sin_port = inet->inet_dport;
+		info->dst_v4.sin_addr.s_addr = inet->inet_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct ipv6_pinfo *np = inet6_sk(sk);
+
+		info->src_v6.sin6_family = AF_INET6;
+		info->src_v6.sin6_port = inet->inet_sport;
+
+		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
+			info->src_v6.sin6_addr = np->saddr;
+		else
+			info->src_v6.sin6_addr = sk->sk_v6_rcv_saddr;
+
+		info->dst_v6.sin6_family = AF_INET6;
+		info->dst_v6.sin6_port = inet->inet_dport;
+		info->dst_v6.sin6_addr = sk->sk_v6_daddr;
+#endif
+	}
+}
+
+static int mptcp_get_info(struct mptcp_sock *msk, struct mptcp_info_opt *m_info)
+{
+	unsigned int tcp_info_len;
+	struct tcp_info info;
+	int err;
+
+	if (m_info->meta_info) {
+		err = mptcp_get_diaginfo(msk, m_info);
+
+		if (err)
+			return err;
+	}
+
+	tcp_info_len = min_t(unsigned int, m_info->tcp_info_len, sizeof(struct tcp_info));
+        m_info->tcp_info_len = tcp_info_len;
+
+	if (m_info->initial) {
+		struct sock *ssk = msk->first;
+
+		if (ssk) {
+			tcp_get_info(ssk, &info);
+		} else {
+			memset(&info, 0, sizeof(info));
+		}
+
+		if (copy_to_user((void __user *)m_info->initial, &info, tcp_info_len))
+			return -EFAULT;
+	}
+
+	if (m_info->subflows) {
+		const struct mptcp_subflow_context *subflow;
+		struct sock *sk = &msk->sk.icsk_inet.sk;
+		unsigned int sub_len = 0, len;
+		char __user *ptr;
+
+		lock_sock(sk);
+
+		ptr = (char __user *)m_info->subflows;
+		len = m_info->sub_len;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			unsigned int tmp_len;
+
+			tcp_get_info(ssk, &info);
+
+			tmp_len = min_t(unsigned int, len, tcp_info_len);
+			sub_len -= tcp_info_len;
+
+			if (copy_to_user(ptr, &info, tmp_len))
+				return -EFAULT;
+
+			ptr += tmp_len;
+			sub_len += tmp_len;
+
+			if (len == 0)
+				break;
+		}
+
+		release_sock(sk);
+
+		m_info->sub_len = sub_len;
+	}
+
+	if (m_info->subflow_info) {
+		unsigned int len, sub_info_len, total_sub_info_len = 0;
+		const struct mptcp_subflow_context *subflow;
+		char __user *ptr;
+
+		ptr = (char __user *)m_info->subflow_info;
+		len = m_info->total_sub_info_len;
+
+		sub_info_len = min_t(unsigned int, m_info->sub_info_len,
+				     sizeof(struct mptcp_sub_info));
+		m_info->sub_info_len = sub_info_len;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			struct mptcp_sub_info m_sub_info;
+			unsigned int tmp_len;
+
+			mptcp_get_sub_info(ssk, &m_sub_info);
+
+			tmp_len = min_t(unsigned int, len, sub_info_len);
+			len -= tmp_len;
+
+			if (copy_to_user(ptr, &m_sub_info, tmp_len))
+				return -EFAULT;
+
+			ptr += tmp_len;
+			total_sub_info_len += tmp_len;
+
+			if (len == 0)
+				break;
+		}
+
+		m_info->total_sub_info_len = total_sub_info_len;
+	}
+
+	return 0;
+}
+
+static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *_u_optlen)
+{
+	struct mptcp_info_opt m_info;
+	int ret, len;
+
+	if (get_user(len, _u_optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(struct mptcp_info_opt));
+
+	memset(&m_info, 0, sizeof(m_info));
+
+	if (copy_from_user(&m_info, optval, len))
+		return -EFAULT;
+
+	ret = mptcp_get_info(msk, &m_info);
+	if (ret)
+		return ret;
+
+	if (put_user(len, _u_optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &m_info, len))
+		return -EFAULT;
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -682,6 +866,17 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
+				    char __user *optval, int __user *optlen)
+{
+	switch (optname) {
+	case MPTCP_INFO:
+		return mptcp_getsockopt_info(msk, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *option)
 {
@@ -704,6 +899,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
+	if (level == SOL_MPTCP)
+		return mptcp_getsockopt_sol_mptcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 
-- 
2.31.1

