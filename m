Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAE1FDD
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684936222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lj+tBXYvbndjJD/pWpIbeW3GxYgMLW4dQEortLPRZXw=;
	b=eA07e6ePqpnA4t29iTVnZUVEV+Q8fegR1QvRDRaFqczFTNXTAbkIFRV4+tJIbPmvPD8UlM
	jLkcqJ+xjX73owCayIcZe6+j4PhmgocDsyG6mergdRgIULBvGCO/BcU1jZKgggadDS+dUx
	F/Pcuzx9RTIUJhxt1oS0b3aQOQHVfLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-M2j8U5OkNLWGFyNyxgDe-g-1; Wed, 24 May 2023 09:50:20 -0400
X-MC-Unique: M2j8U5OkNLWGFyNyxgDe-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABE23101A593;
	Wed, 24 May 2023 13:50:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16E797AE4;
	Wed, 24 May 2023 13:50:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v4 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
Date: Wed, 24 May 2023 15:50:07 +0200
Message-Id: <72ebf53600698f09b96900f8b3fbd2d4c1261b6c.1684935727.git.pabeni@redhat.com>
In-Reply-To: <cover.1684935727.git.pabeni@redhat.com>
References: <cover.1684935727.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Some user-space applications want to monitor the subflows utilization.

Dumping the per subflow tcp_info is not enough, as the PM could close
and re-create the subflows under-the-hood, fooling the accounting.
Even checking the src/dst addresses used by each subflow could not
be enough, because new subflows could re-use the same address/port of
the just closed one.

This patch introduces a new socket option, allow dumping all the relevant
information all-at-once (everything, everywhere...), in a consistent manner.

To reuse the existing helper to manipulate the new struct, keep the binary
layout of the initial few fields the same as mptcp_subflow_data.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - full_info struct re-design (Florian)

v2 -> v3:
 - added missing changelog (oops)
---
 include/uapi/linux/mptcp.h |  25 ++++++
 net/mptcp/sockopt.c        | 165 +++++++++++++++++++++++++++++++++----
 2 files changed, 174 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..37c46cf05795 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -12,6 +12,7 @@
 #include <linux/in.h>		/* for sockaddr_in			*/
 #include <linux/in6.h>		/* for sockaddr_in6			*/
 #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
+#include <linux/tcp.h>		/* for tcp_info				*/
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -244,9 +245,33 @@ struct mptcp_subflow_addrs {
 	};
 };
 
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_subflow_full_info {
+	__u32		size_subflow_full_info;	/* size of this structure in userspace */
+	__u32		num_subflows_kern;	/* must be 0, set by kernel (real subflow count) */
+	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_tcpinfo_user;
+	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_sfinfo_user;
+	__u32		num_subflows_user;	/* max subflows that userspace is interested in;
+						 * the buffers at subflow_info_addr/tcp_info_addr
+						 * are respectively at least:
+						 *  num_subflows_user * size_sfinfo_user
+						 *  num_subflows_user * size_tcpinfo_user
+						 * bytes wide
+						 */
+	__aligned_u64	subflow_info_addr;
+	__aligned_u64	tcp_info_addr;
+} __attribute__((aligned(8)));
+
 /* MPTCP socket options */
 #define MPTCP_INFO		1
 #define MPTCP_TCPINFO		2
 #define MPTCP_SUBFLOW_ADDRS	3
+#define MPTCP_FULL_INFO		4
 
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d4258869ac48..59a174ee1d54 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -14,7 +14,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 
-#define MIN_INFO_OPTLEN_SIZE	16
+#define MIN_INFO_OPTLEN_SIZE		16
+#define MIN_FULL_INFO_OPTLEN_SIZE	48
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -943,12 +944,13 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
 	return 0;
 }
 
-static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
-				  char __user *optval,
-				  u32 copied,
-				  int __user *optlen)
+static int __mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
+				    int size_subflow_data_kern,
+				    char __user *optval,
+				    u32 copied,
+				    int __user *optlen)
 {
-	u32 copylen = min_t(u32, sfd->size_subflow_data, sizeof(*sfd));
+	u32 copylen = min_t(u32, sfd->size_subflow_data, size_subflow_data_kern);
 
 	if (copied)
 		copied += sfd->size_subflow_data;
@@ -964,25 +966,30 @@ static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
 	return 0;
 }
 
-static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
-				  char __user *optval, int __user *optlen)
+static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
+				  char __user *optval,
+				  u32 copied,
+				  int __user *optlen)
+{
+	return __mptcp_put_subflow_data(sfd, sizeof(*sfd), optval, copied, optlen);
+}
+
+static int __mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
+				    int min_info_optlen_size,
+				    char __user *optval,
+				    int __user *optlen)
 {
 	int len, copylen;
 
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	/* if mptcp_subflow_data size is changed, need to adjust
-	 * this function to deal with programs using old version.
-	 */
-	BUILD_BUG_ON(sizeof(*sfd) != MIN_INFO_OPTLEN_SIZE);
-
-	if (len < MIN_INFO_OPTLEN_SIZE)
+	if (len < min_info_optlen_size)
 		return -EINVAL;
 
 	memset(sfd, 0, sizeof(*sfd));
 
-	copylen = min_t(unsigned int, len, sizeof(*sfd));
+	copylen = min_t(unsigned int, len, min_info_optlen_size);
 	if (copy_from_user(sfd, optval, copylen))
 		return -EFAULT;
 
@@ -991,7 +998,7 @@ static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
 	    sfd->size_user > INT_MAX)
 		return -EINVAL;
 
-	if (sfd->size_subflow_data < MIN_INFO_OPTLEN_SIZE ||
+	if (sfd->size_subflow_data < min_info_optlen_size ||
 	    sfd->size_subflow_data > len)
 		return -EINVAL;
 
@@ -1001,6 +1008,19 @@ static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
 	return len - sfd->size_subflow_data;
 }
 
+static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
+				  char __user *optval,
+				  int __user *optlen)
+{
+	/* if mptcp_subflow_data size is changed, need to adjust
+	 * this function to deal with programs using old version.
+	 */
+	BUILD_BUG_ON(sizeof(*sfd) != MIN_INFO_OPTLEN_SIZE);
+
+	return __mptcp_get_subflow_data(sfd, MIN_INFO_OPTLEN_SIZE,
+					optval, optlen);
+}
+
 static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 				    int __user *optlen)
 {
@@ -1146,6 +1166,117 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 	return 0;
 }
 
+static int mptcp_get_full_subflow_info(struct mptcp_subflow_full_info *sffi,
+				       char __user *optval,
+				       int __user *optlen)
+{
+	struct mptcp_subflow_data *sfd = (struct mptcp_subflow_data *)sffi;
+	int len;
+
+	BUILD_BUG_ON(sizeof(*sffi) != MIN_FULL_INFO_OPTLEN_SIZE);
+
+	len = __mptcp_get_subflow_data(sfd, MIN_FULL_INFO_OPTLEN_SIZE,
+				       optval, optlen);
+	if (len < 0)
+		return len;
+
+	if (sffi->size_tcpinfo_kernel)
+		return -EINVAL;
+
+	if (sffi->size_sfinfo_user > INT_MAX)
+		return -EINVAL;
+
+	return len;
+}
+
+static int mptcp_put_subflow_full_info(struct mptcp_subflow_full_info *sffi,
+				       char __user *optval,
+				       u32 copied,
+				       int __user *optlen)
+{
+	struct mptcp_subflow_data *sfd = (struct mptcp_subflow_data *)sffi;
+
+	return __mptcp_put_subflow_data(sfd, sizeof(*sffi), optval, copied, optlen);
+}
+
+static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
+				      int __user *optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	unsigned int sfcount = 0, copied = 0;
+	struct mptcp_subflow_full_info sffi;
+	void __user *tcpinfoptr, *sfinfoptr;
+	int len;
+
+	len = mptcp_get_full_subflow_info(&sffi, optval, optlen);
+	if (len < 0)
+		return len;
+
+	/* don't bother filling the mptcp info if there is not enough
+	 * user-space-provided storage
+	 */
+	if (len > 0) {
+		struct mptcp_info mptcp_info;
+		char __user *infoptr;
+		int mptcp_info_len;
+
+		infoptr = optval + sffi.size_subflow_full_info;
+		memset(&mptcp_info, 0, sizeof(mptcp_info));
+		mptcp_info_len = min_t(unsigned int, len, sizeof(struct mptcp_info));
+
+		mptcp_diag_fill_info(msk, &mptcp_info);
+
+		if (copy_to_user(infoptr, &mptcp_info, mptcp_info_len))
+			return -EFAULT;
+
+		copied += mptcp_info_len;
+	}
+
+	sffi.size_tcpinfo_kernel = sizeof(struct tcp_info);
+	sffi.size_tcpinfo_user = min_t(unsigned int, sffi.size_tcpinfo_user,
+				       sizeof(struct tcp_info));
+	sfinfoptr = (void __force __user *)sffi.subflow_info_addr;
+	sffi.size_sfinfo_kernel = sizeof(struct mptcp_subflow_info);
+	sffi.size_sfinfo_user = min_t(unsigned int, sffi.size_sfinfo_user,
+				      sizeof(struct mptcp_subflow_info));
+	tcpinfoptr = (void __force __user *)sffi.tcp_info_addr;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (sfcount++ < sffi.num_subflows_user) {
+			struct mptcp_subflow_info sfinfo;
+			struct tcp_info tcp_info;
+
+			memset(&sfinfo, 0, sizeof(sfinfo));
+			sfinfo.id = subflow->subflow_id;
+			mptcp_get_sub_addrs(ssk, &sfinfo.addrs);
+			if (copy_to_user(sfinfoptr, &sfinfo, sffi.size_sfinfo_user))
+				goto fail_release;
+
+			tcp_get_info(ssk, &tcp_info);
+			if (copy_to_user(tcpinfoptr, &tcp_info, sffi.size_tcpinfo_user))
+				goto fail_release;
+
+			tcpinfoptr += sffi.size_tcpinfo_user;
+			sfinfoptr += sffi.size_sfinfo_user;
+		}
+	}
+	release_sock(sk);
+
+	sffi.num_subflows_kern = sfcount;
+	if (mptcp_put_subflow_full_info(&sffi, optval, copied, optlen))
+		return -EFAULT;
+
+	return 0;
+
+fail_release:
+	release_sock(sk);
+	return -EFAULT;
+}
+
 static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 				int __user *optlen, int val)
 {
@@ -1219,6 +1350,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case MPTCP_INFO:
 		return mptcp_getsockopt_info(msk, optval, optlen);
+	case MPTCP_FULL_INFO:
+		return mptcp_getsockopt_full_info(msk, optval, optlen);
 	case MPTCP_TCPINFO:
 		return mptcp_getsockopt_tcpinfo(msk, optval, optlen);
 	case MPTCP_SUBFLOW_ADDRS:
-- 
2.40.1

