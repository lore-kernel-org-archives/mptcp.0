Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE7125BD
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ab0DCfxU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQzPOKzALhlcTTVN4YZHZgQULMs1UKux4rzRxPo0vZ0=;
	b=ab0DCfxU1kur91iNq2u4IOY7sgOdgVk7ZpPHlbR80FiQ8ebbzbDXTlS4+O4xVkSdR737mC
	VgKCd2yJp/7OYNcx6/6yWq/XqN3UXeS0OCMXvVitIisZuPxz+eQq/ei0SGPECeYYeguQIn
	PuFCnQDf9DA2beIA4dJYPIvuyxGFc5Y=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 02/14] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Tue, 19 Dec 2023 16:19:13 +0800
Message-Id: <66f2d1ffbdece95a755594d7d2c209b771424d11.1702973751.git.geliang.tang@linux.dev>
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

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. Use mptcp_token_get_sock() to get the
msk from the given token, if userspace PM is enabled in it, traverse
each address entry in address list, put every entry to userspace using
mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 51 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..5494293537bb 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -550,3 +550,54 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	int id = cb->args[0];
+	int ret = -EINVAL;
+	struct sock *sk;
+	void *hdr;
+
+	if (!info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return ret;
+
+	msk = mptcp_token_get_sock(net, nla_get_u32(info->attrs[MPTCP_PM_ATTR_TOKEN]));
+	if (!msk)
+		return ret;
+
+	if (!mptcp_pm_is_userspace(msk))
+		return ret;
+
+	sk = (struct sock *)msk;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id <= id)
+			continue;
+
+		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+		if (!hdr)
+			break;
+
+		if (mptcp_nl_fill_addr(msg, entry) < 0) {
+			genlmsg_cancel(msg, hdr);
+			break;
+		}
+
+		id = entry->addr.id;
+		genlmsg_end(msg, hdr);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+	cb->args[0] = id;
+	return msg->len;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b0b3fa65ae5..7c0d592a9a45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1029,6 +1029,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

