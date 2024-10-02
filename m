Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880A1CF7D4
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881330; cv=none; b=e4a1SAx+6vTS+5k9N8ewI2vTV7psyagFlGZk9Udtwrf/RsRgRIM5awSi9VYMlBlPo+ZGhV1M4CYK4LsKZnye2nXIy6+q7Ti85wl3HDlLjvItBaBc59n1+oh6ZpFSO6XeAIOWymC4fk1od+Hu6nic6dGYFXGyUZ7a0bived9yMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881330; c=relaxed/simple;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTsYi5LphxWm532QrXC3Ns0xGC6/w4ytBptpZg9WU5oYXGyXM8KjPxOx+2zpXNUqcXGeurYAdFiapWF8PVMGuMLtyDCdPEXDwhNmj/SHsRsdi+Bg4WlJGNLq88LMOduUggj53Zm4FIK7ZMjrwEODlFjjz+2hBSrm9xLRU1Fujw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhp2ODTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhp2ODTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA34C4CED1;
	Wed,  2 Oct 2024 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881329;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhp2ODTUNNq6Dx8gyxDB5IPqFDqB3kCS/LA0/6bEGLLxwzjrXUl1A9ByPxiX8DEyG
	 X9o15WRZgDKTIErN5r8dSguwZPk+/rl3TajPuXeyQzDe4mq9YHLJqo+lXJS4gzl6FK
	 56YDt2Qeke4vm2OJFn3qIlmu7eDuYQYNXd8ukEq+Pc76MscjWvSFiO2WyFHhBt5t7B
	 O6sH03XTjwV6EbemvrdgTidBD6iQ0NxWeU5zD5Xdw5tT77nuJwcl9WPZpVD1ZiuiVc
	 nOVzJgXutoLdJXlXMFC1O17NvF+oORyb+DLDpNByDCuZ96iemTtiaOCIOIjH8fmOkn
	 Rg9OqJTvm+lFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/9] mptcp: use __lookup_addr in pm_netlink
Date: Wed,  2 Oct 2024 23:01:53 +0800
Message-ID: <aa7c3cfe776180b185da09205bf19a0188b2e4c8.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper __lookup_addr() can be used in mptcp_pm_nl_get_local_id()
and mptcp_pm_nl_is_backup() to simplify the code if using
list_for_each_entry_rcu instead of list_for_each_entry in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6fcbfcbc0edb..e1907dad3bc4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,7 +524,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
@@ -1144,12 +1144,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	if (entry)
+		ret = entry->addr.id;
 	rcu_read_unlock();
 	if (ret >= 0)
 		return ret;
@@ -1179,12 +1176,9 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 	bool backup = false;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	if (entry)
+		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	rcu_read_unlock();
 
 	return backup;
-- 
2.43.0

