Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32906434E4E
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800582; cv=none; b=BDAFWmA+WiExzQDu/GWpCszFjEIMUwe53E/ZnApfesaxwlSsiBOkpFNSXFeGftvmMZLJPA8c4K9HKpyr7xNBUIb9QBjLhYq8mAyPYQwypRq1+sneN/b2X/dsx8R+0iBR8CXQ+5U4oXJK5ES9g6Rfi2g5QsRSPiNng1qu/WpzZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800582; c=relaxed/simple;
	bh=gmDhrjY9+UOFIzJ6CbaOzWk+RWnmGShFvi2LylfDJis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=minh1j9PutaINCrIOa1l/YdATmvH88gXj1+oR6kxFl93a+ElGxH6BttSBDOc4f9mQvA1vIv7Oy7fKXaRRYmL9+A9w186VtIBMD+GJCEPBXnZga0lxnQZo480bKn5INbo2FVSmh5bnNQVBbX6LH9KT++EqkINb+BhUmlykkkjtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZmS9qUm; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZmS9qUm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784800579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0v4t/rEpX4QHM5Hi2RaMsXumoLpJDPxZ+R8uPvGIvQ=;
	b=NZmS9qUmDVwuFlVvu4iLPST/96hSk4he2eJKpiGttAmcugRgUjRTbU12bW3Qt/M3Qwqx3+
	mIOTx/1cfOtNgNptnBpvqyjOUG907YjJy/RL3DdxpsI7P4io4kzJFPqXX8nqnn3g1Bv208
	JkPUq1tPr5cemQDcy5Udl9Bi3K+yl/w=
From: Gang Yan <gang.yan@linux.dev>
Date: Thu, 23 Jul 2026 17:55:57 +0800
Subject: [PATCH mptcp-next 1/2] mptcp: pm: userspace: decrement
 local_addr_used when remove
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-localaddr-v1-1-ce84b865594a@kylinos.cn>
References: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
In-Reply-To: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

mptcp_userspace_pm_append_new_local_addr() increments msk->pm.local_addr_used
when a new local address is appended, and mptcp_userspace_pm_delete_local_addr()
decrements it when an entry is removed via the subflow destroy path. The
mptcp_pm_nl_remove_doit() netlink REMOVE_ADDR handler, however, only unlinks
the matching entry from msk->pm.userspace_pm_local_addr_list via
list_del_rcu() without touching the counter, so the counter is not changed every
time userspace removes an address by id.

Decrement msk->pm.local_addr_used under the pm lock right after list_del_rcu(),
mirroring the increment site, so the counter stays in sync with the actual
number of entries left in the list.

Assisted-by: Codex:GLM-5.2
Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 73094bdbdbf2..6402226a9f0e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -334,6 +334,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	list_del_rcu(&match->list);
+	msk->pm.local_addr_used--;
 	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addr_entry(msk, match);

-- 
2.43.0

