Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5221081
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684863458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hN/o2ydVAaC36cvQses3L8MdLHpxPq2QKmTFAjK83NY=;
	b=jHo852uvYiBDhx7lVtEE2AZcFThjhN8D6AIZ1nfyzslGK7GY7dzJLptEZN0eoh8THwhf+i
	tS4eoLZG5cih6nPI3TXzJ0nwyZNfEq//lBiUUojFa5of+TED2yFMf+6cDnwx84MjIadxxq
	efPqs8DXJ7ErY9G9H9gWhuZITvL1kqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-9WVxSVPGNpOzB3ya-OfyGw-1; Tue, 23 May 2023 13:37:34 -0400
X-MC-Unique: 9WVxSVPGNpOzB3ya-OfyGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CF031C05AF1
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 024C1140E95D
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
Date: Tue, 23 May 2023 19:37:25 +0200
Message-Id: <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
In-Reply-To: <cover.1684863309.git.pabeni@redhat.com>
References: <cover.1684863309.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
v2 -> v3:
 - added missing changelog (oops)
---
 include/uapi/linux/mptcp.h | 16 ++++++++
 net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..f4f42d88e58b 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -12,6 +12,7 @@
 #include <linux/in.h>		/* for sockaddr_in			*/
 #include <linux/in6.h>		/* for sockaddr_in6			*/
 #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
+#include <linux/tcp.h>		/* for tcp_info				*/
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
 	};
 };
 
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+/* struct subflow_info is not supposed nor allowed to grow in
+ * future versions.
+ * If need will arise, a new socket option should be added.
+ */
+struct mptcp_subflow_full_info {
+	struct mptcp_subflow_info	subflow_info;
+	struct tcp_info			tcp_info;
+};
+
 /* MPTCP socket options */
 #define MPTCP_INFO		1
 #define MPTCP_TCPINFO		2
 #define MPTCP_SUBFLOW_ADDRS	3
+#define MPTCP_FULL_INFO		4
 
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d4258869ac48..b4d04d5dc1f7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1146,6 +1146,79 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 	return 0;
 }
 
+static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
+				      int __user *optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	unsigned int sfcount = 0, copied = 0;
+	int mptcp_info_len, len, size_user;
+	struct mptcp_subflow_data sfd;
+	char __user *infoptr;
+
+	len = mptcp_get_subflow_data(&sfd, optval, optlen);
+	if (len < 0)
+		return len;
+
+	/* don't bother filling the mptcp info if there is not enough
+	 * user-space-provided storage
+	 */
+	infoptr = optval + sfd.size_subflow_data;
+	if (len > sizeof(struct mptcp_subflow_data)) {
+		struct mptcp_info mptcp_info;
+
+		memset(&mptcp_info, 0, sizeof(mptcp_info));
+		mptcp_info_len = min_t(unsigned int, len, sizeof(struct mptcp_info));
+
+		mptcp_diag_fill_info(msk, &mptcp_info);
+
+		if (copy_to_user(infoptr, &mptcp_info, mptcp_info_len))
+			return -EFAULT;
+
+		len -= mptcp_info_len;
+		copied += mptcp_info_len;
+		infoptr += mptcp_info_len;
+	}
+
+	sfd.size_kernel = sizeof(struct mptcp_subflow_full_info);
+	sfd.size_user = min_t(unsigned int, sfd.size_user,
+			      sizeof(struct mptcp_subflow_full_info));
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		++sfcount;
+		if (len >= size_user) {
+			struct mptcp_subflow_full_info sinfo;
+
+			memset(&sinfo, 0, sizeof(sinfo));
+			sinfo.subflow_info.id = subflow->subflow_id;
+			mptcp_get_sub_addrs(ssk, &sinfo.subflow_info.addrs);
+
+			/* don't bother filling the tcp info if the storage is too small */
+			if (sfd.size_user > sizeof(struct mptcp_subflow_info))
+				tcp_get_info(ssk, &sinfo.tcp_info);
+
+			if (copy_to_user(infoptr, &sinfo, sfd.size_user)) {
+				release_sock(sk);
+				return -EFAULT;
+			}
+
+			infoptr += sfd.size_user;
+			copied += sfd.size_user;
+			len -= sfd.size_user;
+		}
+	}
+	release_sock(sk);
+
+	sfd.num_subflows = sfcount;
+	if (mptcp_put_subflow_data(&sfd, optval, copied, optlen))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 				int __user *optlen, int val)
 {
@@ -1219,6 +1292,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
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

