Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F420DC1
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtidiq81"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIYyStByGgOppjY5wLIwgPdI/hJqo86k/XxIGqok6iM=;
	b=mtidiq81onRorVTtn83rAq0Hf0mu/koCNGS8S3Sizk9TpbYrMD8mq7x0MJlYq90Xh3L7HG
	stqGd9SDeoY/s13JhTlJ9YHKyYYmypBu8Co8UEPPuflb9PQSEgjdXEbU9ROxB0+rZN/gLO
	4SZxqH5cnM6RV68qmz1QKtVvGHES7HA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 02/12] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Mon, 11 Dec 2023 16:15:24 +0800
Message-Id: <9e4c62819fcc70f6051fab05dd6e1beffbd8ee0f.1702282411.git.geliang.tang@linux.dev>
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

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. For each msk in this net, if userspace
PM is enabled in it, traverse each address entry in address list, put
every entry to userspace using mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 29 +++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..6f659a78c637 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -550,3 +550,32 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
+{
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+				if (mptcp_pm_nl_put_entry_msg(msg, cb, entry))
+					break;
+			}
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return msg->len;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 23d4742f3f30..a05a6745bc31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,6 +1028,8 @@ int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

