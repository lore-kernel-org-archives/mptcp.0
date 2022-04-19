Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F5184E
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650409431; x=1681945431;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/iFnbVCLgNbBdIBKxTr0KFqIBKEons583QnvOCkLszc=;
  b=SgGXuuD7+6HSyBJbMdsYAWrXtL20MY3FLTY/tgt4j9+iMoTrvxzdbZSk
   KRtWAbpNYftsDR6xNPLdLM+wIjWNz0CcylbZEQ9Vt22PNrDJgtY3n1HMp
   M8wqBk30KXgvZNgQbHcOK0Z3r5sx1CmkFXm4nzT0i03LZBJZ8kT8iRz96
   Rpqa9ih46Q40dkD0fkGfn43RjPFUNpGHEl0eO+KqHI+ms0yxjC7EkI+tk
   xdOiP9c2Xck+ion2sQT87RchnEOcvFY1jWzWVjrrsLdX1P5bxcEKLZKzX
   ZfxwX95jc35zbZq8DpTeutAoSrakVikOqpHZvSN3mtr0SnhN88Shm/jtm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263654612"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263654612"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625832521"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/3] Squash-to: mptcp: netlink: allow userspace-driven subflow establishment
Date: Tue, 19 Apr 2022 19:03:40 -0400
Message-Id: <20220419230340.2263545-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220419230340.2263545-1-kishen.maloor@intel.com>
References: <20220419230340.2263545-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_userspace.c | 59 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d8f6126b952..9f6b5eda5524 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -251,13 +251,13 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
+	int err = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
-	int ret;
 
 	if (!laddr || !raddr || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
-		return -EINVAL;
+		return err;
 	}
 
 	token_val = nla_get_u32(token);
@@ -265,39 +265,41 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-		return -EINVAL;
+		return err;
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		return -EINVAL;
+		goto create_err;
 	}
 
-	ret = mptcp_pm_parse_addr(laddr, info, &addr_l);
-	if (ret < 0) {
+	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
-		return -EINVAL;
+		goto create_err;
 	}
 
 	if (addr_l.id == 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		return -EINVAL;
+		goto create_err;
 	}
 
-	ret = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (ret < 0) {
+	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-		return -EINVAL;
+		goto create_err;
 	}
 
 	sk = &msk->sk.icsk_inet.sk;
 	lock_sock(sk);
 
-	ret = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
+	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
-	return ret;
+ create_err:
+	sock_put((struct sock *)msk);
+	return err;
 }
 
 static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
@@ -366,12 +368,12 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
+	int err = -EINVAL;
 	u32 token_val;
-	int ret;
 
 	if (!laddr || !raddr || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
-		return -EINVAL;
+		return err;
 	}
 
 	token_val = nla_get_u32(token);
@@ -379,34 +381,34 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-		return -EINVAL;
+		return err;
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		return -EINVAL;
+		goto destroy_err;
 	}
 
-	ret = mptcp_pm_parse_addr(laddr, info, &addr_l);
-	if (ret < 0) {
+	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
-		return ret;
+		goto destroy_err;
 	}
 
-	ret = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (ret < 0) {
+	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-		return ret;
+		goto destroy_err;
 	}
 
 	if (addr_l.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
-		return -EINVAL;
+		goto destroy_err;
 	}
 
 	if (!addr_l.port || !addr_r.port) {
 		GENL_SET_ERR_MSG(info, "missing local or remote port");
-		return -EINVAL;
+		goto destroy_err;
 	}
 
 	sk = &msk->sk.icsk_inet.sk;
@@ -416,9 +418,12 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
+		err = 0;
 	} else {
-		ret = -ESRCH;
+		err = -ESRCH;
 	}
 
-	return ret;
+ destroy_err:
+	sock_put((struct sock *)msk);
+	return err;
 }
-- 
2.31.1

