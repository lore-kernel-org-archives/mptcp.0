Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458121FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684999058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB87SoBDvcKQNNXi0xbWf4SFsnaqUO9Fj+iF7wlsBSM=;
	b=RkODbgeci50zIgABah6T4ZhyYP16Y/W7sbEVuk99QKBMsfDcjOkP3nc+NOEtYYJtyfkMDG
	tc4EtbsfFMfskN4fksUZ1QjkRH1ezQ9XhUiBtJIJqgvABCfoPp04d/6ZsSbMFAmmvQ+c2P
	BH5g7fZz5bkirePrFYg7SqM24TnTnm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-lZ6l5gUlNYKU647FXJXKNg-1; Thu, 25 May 2023 03:17:31 -0400
X-MC-Unique: lZ6l5gUlNYKU647FXJXKNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2359985A5BE;
	Thu, 25 May 2023 07:17:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A01492B0A;
	Thu, 25 May 2023 07:17:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v6 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
Date: Thu, 25 May 2023 09:17:12 +0200
Message-Id: <6445ff289e2784aca7f93847fea85abf304c9d50.1684997011.git.pabeni@redhat.com>
In-Reply-To: <cover.1684997011.git.pabeni@redhat.com>
References: <cover.1684997011.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
information all-at-once (everything, everywhere...), in a consistent
manner.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - fix compiler warning - unused variable

v4 -> v5:
 - full_info struct re-design (Florian)
 - fix build issue on 32 bit hosts

v3 -> v4:
 - full_info struct re-design (Florian)

v2 -> v3:
 - added missing changelog (oops)
---
 include/uapi/linux/mptcp.h |  24 +++++++
 net/mptcp/sockopt.c        | 127 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

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
index 770279e0a598..bfbe0378e997 100644
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
 
@@ -1158,6 +1160,125 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
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
+			       u32 copylen,
+			       int __user *optlen)
+{
+	copylen += MIN_FULL_INFO_OPTLEN_SIZE;
+	if (put_user(copylen, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, mfi, copylen))
+		return -EFAULT;
+	return 0;
+}
+
+static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
+				      int __user *optlen)
+{
+	unsigned int sfcount = 0, copylen = 0;
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
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
+		mptcp_diag_fill_info(msk, &mfi.mptcp_info);
+		copylen += min_t(unsigned int, len, sizeof(struct mptcp_info));
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
+	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
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
@@ -1231,6 +1352,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
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

