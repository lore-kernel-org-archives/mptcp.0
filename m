Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB740F9EC
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deIhZmUy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSdqxbpKtl1EqadsNb/cqGZSWH3ZsvlKh/9nSVcuGVI=;
	b=deIhZmUyFJZHK5Dr3Ebq8zzAq3zcoqK1REYnLTuQ0RRCKrxIu1dcpFZWKRUi0CmQdmgRMW
	p+nIxTZ8j/zI6sHNQU/QM/BCamh+vLx0RFbBFbN1jexBc1nIVW+FYhwG4SKH5X8UveK67S
	8qNuu0c1S/yttOIGDNTwvuIsiwDNblk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 03/14] mptcp: dump addrs in userspace pm list
Date: Tue, 19 Dec 2023 16:19:14 +0800
Message-Id: <4b675a9502b0e830308dfcc7cd36084929958bb6.1702973751.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702973751.git.geliang.tang@linux.dev>
References: <cover.1702973751.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch renames mptcp_pm_nl_get_addr_dumpit() to in-kernel netlink PM
dump addrs function mptcp_pm_nl_dump_addr(), then invoke both in-kernel PM
mptcp_pm_nl_dump_addr() and userspace PM mptcp_userspace_pm_dump_addr()
dump addrs functions in mptcp_pm_nl_get_addr_dumpit().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 29fdef4cfdfd..812dc719269a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1700,8 +1700,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1743,6 +1743,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_nl_dump_addr(msg, cb) +
+	       mptcp_userspace_pm_dump_addr(msg, cb);
+}
+
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
-- 
2.35.3

