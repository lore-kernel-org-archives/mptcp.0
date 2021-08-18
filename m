Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F86D19
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:28:13 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mGInr-000448-Rn; Wed, 18 Aug 2021 12:28:11 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 2/5] mptcp: add MPTCP_INFO getsockopt
Date: Wed, 18 Aug 2021 12:27:53 +0200
Message-Id: <20210818102756.30734-3-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818102756.30734-1-fw@strlen.de>
References: <20210818102756.30734-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its not compatible with multipath-tcp.org kernel one.

1. The out-of-tree implementation defines a different 'struct mptcp_info',
   with embedded __user addresses for additional data such as
   endpoint addresses.

2. Mat Martineau points out that embedded __user addresses doesn't work
with BPF_CGROUP_RUN_PROG_GETSOCKOPT() which assumes that copying in
optsize bytes from optval provides all data that got copied to userspace.

This provides mptcp_info data for the given mptcp socket.

Userspace sets optlen to the size of the structure it expects.
The kernel updates it to contain the number of bytes that it copied.

This allows to append more information to the structure later.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/socket.h     |  1 +
 include/uapi/linux/mptcp.h |  4 ++++
 net/mptcp/sockopt.c        | 40 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index fd9ce51582d8..a2326a963232 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -364,6 +364,7 @@ struct ucred {
 #define SOL_KCM		281
 #define SOL_TLS		282
 #define SOL_XDP		283
+#define SOL_MPTCP	284
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f66038b9551f..c450feba6f9c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <linux/types.h>
+#include <linux/in.h>
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -193,4 +194,7 @@ enum mptcp_event_attr {
 #define MPTCP_RST_EBADPERF	5
 #define MPTCP_RST_EMIDDLEBOX	6
 
+/* MPTCP socket options */
+#define MPTCP_INFO 1
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 54f0d521a399..f7683c22911f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -673,10 +673,14 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = &msk->sk.icsk_inet.sk;
-	bool slow = lock_sock_fast(sk);
 	u32 flags = 0;
+	bool slow;
 	u8 val;
 
+	memset(info, 0, sizeof(*info));
+
+	slow = lock_sock_fast(sk);
+
 	info->mptcpi_subflows = READ_ONCE(msk->pm.subflows);
 	info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
@@ -702,6 +706,27 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
+static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *optlen)
+{
+	struct mptcp_info m_info;
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(struct mptcp_info));
+
+	mptcp_diag_fill_info(msk, &m_info);
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &m_info, len))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -716,6 +741,17 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
+				      char __user *optval, int __user *optlen)
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
@@ -738,6 +774,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
+	if (level == SOL_MPTCP)
+		return mptcp_getsockopt_sol_mptcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 
-- 
2.31.1

