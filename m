Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C922631
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684963790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ucgcRlYSg2xAZJv++wjCvOInGeVt2PDJQ0JcaJgXuY=;
	b=I7QbsN9SeBGGOBB2ino/9Rgoc4cHF4h0lKCE9D10TM50QA4XwbZh1+mNHSZioWZ2kvDT7j
	Wsj7Bw9sauASTTwxZLswGcQcBrBc82dTBTSqJjacfHPElY+wd5VJL80dILtuCl/OBNgFzu
	3h1/SXlMzI/BFiOlmjmqAhF9PMvdgpE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-WgV6lE5_O0mPEfUIhaVGVA-1; Wed, 24 May 2023 17:29:47 -0400
X-MC-Unique: WgV6lE5_O0mPEfUIhaVGVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B85101A53A;
	Wed, 24 May 2023 21:29:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 157D6407DEC3;
	Wed, 24 May 2023 21:29:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v5 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
Date: Wed, 24 May 2023 23:29:18 +0200
Message-Id: <400326ed4b59e6c9878fc4a406c2bf406876ee72.1684962909.git.pabeni@redhat.com>
In-Reply-To: <cover.1684962909.git.pabeni@redhat.com>
References: <cover.1684962909.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - full_info struct re-design (Florian)
 - fix build issue on 32 bit hosts

v3 -> v4:
 - full_info struct re-design (Florian)

v2 -> v3:
 - added missing changelog (oops)
---
 include/uapi/linux/mptcp.h |  24 +++++++
 net/mptcp/sockopt.c        | 133 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index a124be6ebbba..ee9c49f949a2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -249,9 +249,33 @@ struct mptcp_subflow_addrs {
 	};
 };
 
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_full_info {
+	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_tcpinfo_user;
+	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_sfinfo_user;
+	__u32		num_subflows;		/* must be 0, set by kernel (real subflow count) */
+	__u32		size_arrays_user;	/* max subflows that userspace is interested in;
+						 * the buffers at subflow_info/tcp_info
+						 * are respectively at least:
+						 *  size_arrays * size_sfinfo_user
+						 *  size_arrays * size_tcpinfo_user
+						 * bytes wide
+						 */
+	__aligned_u64		subflow_info;
+	__aligned_u64		tcp_info;
+	struct mptcp_info	mptcp_info;
+};
+
 /* MPTCP socket options */
 #define MPTCP_INFO		1
 #define MPTCP_TCPINFO		2
 #define MPTCP_SUBFLOW_ADDRS	3
+#define MPTCP_FULL_INFO		4
 
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 770279e0a598..b6f6fa1eb53b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -14,7 +14,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 
-#define MIN_INFO_OPTLEN_SIZE	16
+#define MIN_INFO_OPTLEN_SIZE		16
+#define MIN_FULL_INFO_OPTLEN_SIZE	40
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -977,7 +978,8 @@ static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
 }
 
 static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
-				  char __user *optval, int __user *optlen)
+				  char __user *optval,
+				  int __user *optlen)
 {
 	int len, copylen;
 
@@ -1158,6 +1160,131 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 	return 0;
 }
 
+static int mptcp_get_full_info(struct mptcp_full_info *mfi,
+			       char __user *optval,
+			       int __user *optlen)
+{
+	int len;
+
+	BUILD_BUG_ON(offsetof(struct mptcp_full_info, mptcp_info) !=
+		     MIN_FULL_INFO_OPTLEN_SIZE);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < MIN_FULL_INFO_OPTLEN_SIZE)
+		return -EINVAL;
+
+	memset(mfi, 0, sizeof(*mfi));
+	if (copy_from_user(mfi, optval, MIN_FULL_INFO_OPTLEN_SIZE))
+		return -EFAULT;
+
+	if (mfi->size_tcpinfo_kernel ||
+	    mfi->size_sfinfo_kernel ||
+	    mfi->num_subflows)
+		return -EINVAL;
+
+	if (mfi->size_sfinfo_user > INT_MAX ||
+	    mfi->size_tcpinfo_user > INT_MAX)
+		return -EINVAL;
+
+	return len - MIN_FULL_INFO_OPTLEN_SIZE;
+}
+
+static int mptcp_put_full_info(struct mptcp_full_info *mfi,
+			       char __user *optval,
+			       u32 copied,
+			       int __user *optlen)
+{
+	copied += MIN_FULL_INFO_OPTLEN_SIZE;
+	if (put_user(copied, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, mfi, copied))
+		return -EFAULT;
+	return 0;
+}
+
+static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
+				      int __user *optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	unsigned int sfcount = 0, copied = 0;
+	void __user *tcpinfoptr, *sfinfoptr;
+	struct mptcp_full_info mfi;
+	int len;
+
+	len = mptcp_get_full_info(&mfi, optval, optlen);
+	if (len < 0)
+		return len;
+
+	/* don't bother filling the mptcp info if there is not enough
+	 * user-space-provided storage
+	 */
+	if (len > 0) {
+		char __user *infoptr;
+		int mptcp_info_len;
+
+		infoptr = optval + MIN_FULL_INFO_OPTLEN_SIZE;
+		mptcp_info_len = min_t(unsigned int, len, sizeof(struct mptcp_info));
+		mptcp_diag_fill_info(msk, &mfi.mptcp_info);
+
+		copied += mptcp_info_len;
+	}
+
+	mfi.size_tcpinfo_kernel = sizeof(struct tcp_info);
+	mfi.size_tcpinfo_user = min_t(unsigned int, mfi.size_tcpinfo_user,
+				      sizeof(struct tcp_info));
+	sfinfoptr = u64_to_user_ptr(mfi.subflow_info);
+	mfi.size_sfinfo_kernel = sizeof(struct mptcp_subflow_info);
+	mfi.size_sfinfo_user = min_t(unsigned int, mfi.size_sfinfo_user,
+				     sizeof(struct mptcp_subflow_info));
+	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct mptcp_subflow_info sfinfo;
+		struct tcp_info tcp_info;
+
+		if (sfcount++ >= mfi.size_arrays_user)
+			continue;
+
+		/* fetch addr/tcp_info only if the user space buffers
+		 * are wide enough
+		 */
+		memset(&sfinfo, 0, sizeof(sfinfo));
+		sfinfo.id = subflow->subflow_id;
+		if (mfi.size_sfinfo_user >
+		    offsetof(struct mptcp_subflow_info, addrs))
+			mptcp_get_sub_addrs(ssk, &sfinfo.addrs);
+		if (copy_to_user(sfinfoptr, &sfinfo, mfi.size_sfinfo_user))
+			goto fail_release;
+
+		if (mfi.size_tcpinfo_user) {
+			tcp_get_info(ssk, &tcp_info);
+			if (copy_to_user(tcpinfoptr, &tcp_info,
+					 mfi.size_tcpinfo_user))
+				goto fail_release;
+		}
+
+		tcpinfoptr += mfi.size_tcpinfo_user;
+		sfinfoptr += mfi.size_sfinfo_user;
+	}
+	release_sock(sk);
+
+	mfi.num_subflows = sfcount;
+	if (mptcp_put_full_info(&mfi, optval, copied, optlen))
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
@@ -1231,6 +1358,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
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

