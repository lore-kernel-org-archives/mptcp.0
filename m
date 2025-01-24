Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0933998
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702706; cv=none; b=iC+7W6H4jFA5ti04PRxtvGMbaTY1U+sygOqgBm5dqHS87cUX261v4qetg2ttk/AS2SpvqQqEJ48w24nA+pKQHPdaITfp3HReJRexmrYlnCQZIT/+gVu3a1yDAMFHE4HS6dzUsRqHBP0q7zwup6stiv3FMIZxyUiUSRCYA8iH7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702706; c=relaxed/simple;
	bh=W7zjOPOB5nfWseLfq1dIAE2m2KefystM9K0R/2dCtyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmhqRGPQ30V+1MBbRUShMIQ6gSlLIU4zmVIKkCLUpuoZHvsHuWljrxLEHu7AP6oUbM9D6qxHMc7FlIo6Zk2M0FfDMe0o9cxcDB5nLmDoRfwOhKNOMWYhV2m4vtN7msETWbh0bjUerkyNSR2ZWQ6hN5rW34tx606lM2oAxnPxxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNlf4dtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNlf4dtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B43DC4CEE1;
	Fri, 24 Jan 2025 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702705;
	bh=W7zjOPOB5nfWseLfq1dIAE2m2KefystM9K0R/2dCtyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNlf4dtSNc+gL8YQh6hW0SR4rQ57ZZs4B2VN+JoJn7QDOSGzOGdoI6Xkqq/CW9IS9
	 nexGuKSJHx7e6kkEQdsyRdPDgPGenA8rMOXc4oH8sB0gddJtxffP//HcIvZkcTyGmB
	 Pvb4c2sM7T1lSKzMbi5jgWPJmWOlAUnfMaAMKq2L24Kx/xauxsVQj7jIbhbW3h53cv
	 Oon6faTCC3FFFgKsaxudcwISFZI3+FmIL/9QZJxZodREuh/mH92hnFULgpZo9o6Cf/
	 8bL5h7Vevo9QrU2MZdzeCyCianR1pCizArcaImAiLg/OH8Z7fP7/yDbA8TD8Kb/zRI
	 78jKVQsLd8+pA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] mptcp: add mptcp_pm_genl_fill_addr helper
Date: Fri, 24 Jan 2025 15:10:44 +0800
Message-ID: <408b422f50568114b69a4231fbf7c6548915b88f.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To save some redundant code in dump_addr() interfaces of both the
netlink PM and userspace PM, the code that calls netlink message
helpers (genlmsg_put/cancel/end) and mptcp_nl_fill_addr() is wrapped
into a new helper mptcp_pm_genl_fill_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 12 +-----------
 net/mptcp/pm_userspace.c | 12 +-----------
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b1f36dc1a091..16cacce6c10f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -489,6 +489,27 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EINVAL;
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
+		return -EINVAL;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 99705a9c2238..02e2945911df 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1798,7 +1798,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
-	void *hdr;
 	int i;
 
 	pernet = pm_nl_get_pernet(net);
@@ -1813,19 +1812,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			if (entry->addr.id <= id)
 				continue;
 
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
+			if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
 				break;
 
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
-				genlmsg_cancel(msg, hdr);
-				break;
-			}
-
 			id = entry->addr.id;
-			genlmsg_end(msg, hdr);
 		}
 	}
 	rcu_read_unlock();
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b69fb5b18130..bedd6f9ebc8b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -641,7 +641,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
 
 	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
 
@@ -659,19 +658,10 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
+		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
 			break;
 
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
-
 		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
 	}
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c1232bfd722..bac5c925a72f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1061,6 +1061,9 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
 		       struct mptcp_pm_addr_entry *entry);
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.43.0

