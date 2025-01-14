Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11722DC49
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846389; cv=none; b=SpJFnMytNwymDpKrFnu8D0osBKey7P7Fc01wXMWsEV8E4FUp8V8xdyO/LSpHHunq1Qo7Y0ZdiSZBzJR6CCi/jwFilvOZpFvl7WcmgxNyBS8Fa4Q3GFW/eeNiaQ8N50XECqShd/V47g1ITp5usZGjfZTx2iRH9HNLMtsDFkzSPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846389; c=relaxed/simple;
	bh=Ufcq4lyASb8T521KVvI4117ZOhP3VKxoVWTUBLyHiKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv+vNbXEm+BmXj6vHqcUyDvI7nGPiZJdkwru0MoBNqQTTCNTsp8bgsgi7LpJX/sMpdmkzaD7MhewVGhd+KLtC7/IZQd6dlpaW+HtvWHhGOXEavKzZTK+IxVi9hwupR02SYpmwZy7/lxTgfWAqTs4TQY9WEzfZFHC09WcTUMr96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np3E+xm9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np3E+xm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3506EC4CEE0;
	Tue, 14 Jan 2025 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846389;
	bh=Ufcq4lyASb8T521KVvI4117ZOhP3VKxoVWTUBLyHiKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np3E+xm9jQ9IBA0zd4+GpApV1GOXKOGJo1/DSjPGVHiSLtYTRkca/XrS3nTpmChoQ
	 wzkC8PCnGSZOjUXe5RcqD+ZNe0jvqNTsEn/vGD6eIXpiGQOxJlmHidLHonoruUvswl
	 i72b4du51merr/8lduN2SFeLShDOrZWGIg2Z+DRYzZCEi+VmFAqF1mnQc7lRQfW8/i
	 83R1fz5JFxDSZi4RGxQG3RYI8su37hAs8ta3m7ZmgcE2f9yr//j7e7f1OIEjic1KfP
	 X+3umGL4d3gKdEye6fth2kIPAtVI4pNGBKmbSuOMB3teQ+61C+qg3fDwXx7YocPx7Z
	 pH68g+dBunYcg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/6] mptcp: add mptcp_pm_genl_fill_addr helper
Date: Tue, 14 Jan 2025 17:19:33 +0800
Message-ID: <da0da2115cbe809725b5ae3bc168da823cec6b1d.1736845893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736845893.git.tanggeliang@kylinos.cn>
References: <cover.1736845893.git.tanggeliang@kylinos.cn>
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

This helper will also be used in BPF path managers.

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
index fef01692eaed..afd517ff260c 100644
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
+			if (mptcp_pm_genl_fill_addr(msg, cb, entry))
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
index 277cf092a870..b50462b527bd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -641,7 +641,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
 
 	bitmap = (struct id_bitmap *)cb->ctx;
 
@@ -657,19 +656,10 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
+		if (mptcp_pm_genl_fill_addr(msg, cb, entry))
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
index 6fb536de9981..54451bffd103 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,6 +1131,9 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 			 struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-- 
2.43.0

