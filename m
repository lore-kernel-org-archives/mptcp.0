Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099612B8F
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CduSA2Fj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702891513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpSBD9N/x5aEGxIPRRsMeG+JJ/FV1c5vPkV2EXAaxMg=;
	b=CduSA2Fj5BfzqY9/Ao4zSg49gBxs9qdJTtSFBo4pGm6bP0Z9pRnEFRN7KqFZoLmDqrMXbP
	f1J0KN+78eiofWElLrq/SxUJ92D+xGt96Kp5lxr1eRpBFy6t69R2zx3HnVZ4n8485GdztD
	GEwgPTT6Poj4UMIk1GHD7SGoYIbWc1o=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 01/15] mptcp: add mptcp_pm_nl_put_entry_msg helper
Date: Mon, 18 Dec 2023 17:23:30 +0800
Message-Id: <e8838803fb1baad12b567833ed0b5c759ade8325.1702891194.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702891194.git.geliang.tang@linux.dev>
References: <cover.1702891194.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extract the genlmsg related code from mptcp_pm_nl_get_addr_dumpit() into
a new helper mptcp_pm_nl_put_entry_msg(). It will be used in the userspace
PM dump_addr().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++-----------
 net/mptcp/protocol.h   |  3 +++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c84cc0908cfc..43062cd23ba3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1658,6 +1658,29 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
+			      struct netlink_callback *cb,
+			      struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+	int ret;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	ret = mptcp_nl_fill_addr(msg, entry);
+	if (ret < 0) {
+		genlmsg_cancel(msg, hdr);
+		return ret;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
@@ -1715,7 +1738,6 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
-	void *hdr;
 	int i;
 
 	pernet = pm_nl_get_pernet(net);
@@ -1730,19 +1752,10 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 			if (entry->addr.id <= id)
 				continue;
 
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
-				break;
-
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
-				genlmsg_cancel(msg, hdr);
+			if (mptcp_pm_nl_put_entry_msg(msg, cb, entry))
 				break;
-			}
 
 			id = entry->addr.id;
-			genlmsg_end(msg, hdr);
 		}
 	}
 	spin_unlock_bh(&pernet->lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b9c1b995df..23d4742f3f30 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
+int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
+			      struct netlink_callback *cb,
+			      struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.35.3

