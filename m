Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FA20B1F
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PS8qbzlE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNeO5mCFeLkcIdu4zKWU1hjv/f1xF4J5kcjmOLtZFu8=;
	b=PS8qbzlEcxD5DXqhbIcHIMWjWK4dapTih8Nwz4kl108Nglqfn6vMMRQ0WHSoFlTNWbPqfR
	R/wJHW5HDTCWiU2RphFnof5RIIRpUYk8p3XA6ry4apSLmctufh9/jLLcVJUjsEt31ASWI4
	UByOv3WPdbyrWEANRphr5P50+RKUe/w=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 09/12] mptcp: implement mptcp_userspace_pm_get_addr
Date: Mon, 11 Dec 2023 16:15:31 +0800
Message-Id: <b5ba34cabaa840cf5d13658cbc4631ce015f2928.1702282411.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282411.git.geliang.tang@linux.dev>
References: <cover.1702282411.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch implements mptcp_userspace_pm_get_addr() to get an address
from userspace pm address list according the given 'token' and 'id'.
Use nla_get_u32() to get the u32 value of 'token', then pass it to
mptcp_token_get_sock() to get the msk. Pass 'msk' and 'id' to the helper
mptcp_userspace_pm_lookup_addr_by_id() to get the address entry. Put
this entry to userspace using mptcp_pm_nl_put_entry_info().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 24 ++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2a5ba2826262..696a86e22fb6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -586,3 +586,27 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	return msg->len;
 }
+
+int mptcp_userspace_pm_get_addr(struct net *net, struct genl_info *info,
+				struct nlattr *token, u8 id)
+{
+	u32 token_val = nla_get_u32(token);
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	int ret = -EINVAL;
+
+	msk = mptcp_token_get_sock(net, token_val);
+	if (!msk)
+		return ret;
+
+	if (!mptcp_pm_is_userspace(msk))
+		return ret;
+
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	if (!entry) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		return ret;
+	}
+
+	return mptcp_pm_nl_put_entry_info(info, entry);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a82a42c57c3d..de263fd53389 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_userspace_pm_get_addr(struct net *net, struct genl_info *info,
+				struct nlattr *token, u8 id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

