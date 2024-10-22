Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0C194C96
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588496; cv=none; b=LbKnDEL+BIn8Q5NFuPrv4Z5woSrMb/fD31rSViNThyXlddBG04wG8y5sf/QNFu3QNhOWrTMsV1fnwPFAEtWKStAT3vUhkTjIy/HLfHhf8lv0A53ZyX8Uj/W9nz0h2AQzjwwK3k1qALn490VtrjLYJ4SqhVt8UpMEQi+SVcC0bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588496; c=relaxed/simple;
	bh=2iW4LHvAPu92sQGKGEKkh0LXvu/1gr4UAuXmVLqVf3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhEs1MzXyJhhM12fl0LuYw0Iu1OQCHvEAk5BsUMqiFXsOfqwEiHpW5YePKURfILTmMFM1T0kESOQU+fGhQcABrUL8bBz5Jed+a3mY0OGxz8/6gm48ZO42Q8anvlKqPnW+UTV2ToQHvPV8DeyF7xKPTei+WJTvtMm2Lp2zA+t6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFryZX4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFryZX4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B7CC4CEE6;
	Tue, 22 Oct 2024 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588495;
	bh=2iW4LHvAPu92sQGKGEKkh0LXvu/1gr4UAuXmVLqVf3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFryZX4C3aoaPn7XGBSLxJgN8QbbFkiKcrDCNopTDg9pufg+pnfNJMNZlAtXsJZWX
	 TRyibYhruyc3hl6ojASDcwgQFC2AEQ3Spmk6nHq/01g9F8BMlaD2+oT78CgprBYr1m
	 fhNzYKAnNvS/SKvTbPUpCUIVV4rL+DFZ6fElIbGHLO0PAXRgeRNtm/Q/p7jeCB6zzH
	 IzVA6dOyiC0UVBEyttdadYv3IjJYf42LRUngLTthpUo+DpewSjNoo+lftpMpgk6fU0
	 VkZ7wM5f9S/qm+Jo2dP4PVatbNXWLLBoTlFH7GefqtqBhMBtcNmJoZUB+xPXc7GJ1m
	 o45vFUhARwdlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/36] mptcp: use __lookup_addr in pm_netlink
Date: Tue, 22 Oct 2024 17:14:10 +0800
Message-ID: <63ed0d182630250fda144a5ee3770a34384003fa.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
list_for_each_entry_rcu() instead of list_for_each_entry() in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab..a60a6fc04bf4 100644
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
@@ -1146,12 +1146,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
@@ -1181,12 +1178,9 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
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
2.45.2

