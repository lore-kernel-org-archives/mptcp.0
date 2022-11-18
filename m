Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D56194
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668797176; x=1700333176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W4JEU4Lb4cxuCiSU7pc8DfutGIIeuWjfS0GfiBOJA8E=;
  b=V5CwCRiLGmZ2J0d+RrhxurdkGLU4J+m0rkQM1yvc5OxaHmTfeEY6QMKS
   iGrGJHWqXODrIGy89fZY5j7ZU47LZz1xSj8Vvep71RFZJSLa/l7CSRlrT
   Z61scjrUiZUlxfmG4AzSzk0V+O+xtZsrARhtP1nvUpm10zicBH2S9B3CQ
   6KfY47vFgBbYPDB+phr1hoRN/JUGZlRflM59MmKyOFACEwsiVejv3D+dy
   6rN0Sch3Xt+NZkk93jjXXy6NN3ISBZvCWDQ9crh1wHpIO3BP9Dvx8zAKu
   LQd7MbhA3y8z9bR6UE1MDFpe4205gLljqnuOYaNTv9+jXhDTpX76mjl6q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314356551"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314356551"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746102229"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746102229"
Received: from mjenkins-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.47.242])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/2] mptcp: more detailed error reporting on endpoint creation
Date: Fri, 18 Nov 2022 10:46:08 -0800
Message-Id: <20221118184608.187932-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
References: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Endpoint creation can fail for a number of reasons; in case of failure
append the error number to the extended ack message, using a newly
introduced generic helper.

Additionally let mptcp_pm_nl_append_new_local_addr() report different
error reasons.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/genetlink.h |  3 +++
 net/mptcp/pm_netlink.c  | 24 +++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index d21210709f84..ed4622dd4828 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -125,6 +125,9 @@ static inline void genl_info_net_set(struct genl_info *info, struct net *net)
 
 #define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG((info)->extack, msg)
 
+#define GENL_SET_ERR_MSG_FMT(info, msg, args...) \
+	NL_SET_ERR_MSG_FMT((info)->extack, msg, ##args)
+
 /* Report that a root attribute is missing */
 #define GENL_REQ_ATTR_CHECK(info, attr) ({				\
 	struct genl_info *__info = (info);				\
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fdf2ee29f762..d66fbd558263 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -912,10 +912,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX)
+	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+		ret = -ERANGE;
 		goto out;
-	if (test_bit(entry->addr.id, pernet->id_bitmap))
+	}
+	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
+		ret = -EBUSY;
 		goto out;
+	}
 
 	/* do not insert duplicate address, differentiate on port only
 	 * singled addresses
@@ -929,8 +933,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
 			 */
-			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))
+			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
+				ret = -EEXIST;
 				goto out;
+			}
 			if (entry->addr.id)
 				goto out;
 
@@ -1016,16 +1022,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
-	if (err) {
-		pr_warn("kernel_bind error, err=%d", err);
+	if (err)
 		return err;
-	}
 
 	err = kernel_listen(ssock, backlog);
-	if (err) {
-		pr_warn("kernel_listen error, err=%d", err);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
@@ -1329,13 +1331,13 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-			GENL_SET_ERR_MSG(info, "create listen socket error");
+			GENL_SET_ERR_MSG_FMT(info, "create listen socket error: %d", ret);
 			goto out_free;
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
-		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
+		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
 	}
 
-- 
2.38.1

