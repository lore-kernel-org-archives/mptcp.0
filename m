Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BE12E64
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqCe+LQD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fIC63ZcxcZPB630FkhMdT62aO+zJwUXcq+0JXI99IY=;
	b=XqCe+LQDQNR31vii+MzFQdlfmtfCfWdSFq39TMZxOPeYhK+i2qnfmcvFwpRh9FkGYRf69i
	kuitvpJr+uLsfYAgWK/ENVZFqqQ8nCTGCNobk11v1u9larzgCOVbv7KKUilPY7HNbPnuZP
	Km+E1HcACIyG/E+gE2f6QQt0VPwciUo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 22/25] mptcp: drop addr_match and id_match
Date: Fri,  8 Dec 2023 18:07:35 +0800
Message-Id: <ffaa34f61684fd0481dca5ce87a3b81cc143223f.1702029539.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8b015cd59aaf..f4deb3c8c99d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -58,26 +58,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0 && !set_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -96,10 +83,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0 && !set_id)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

