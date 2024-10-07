Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B9199956
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298412; cv=none; b=slzGUn1xR+Msjz1+NU1bb6lJjSp249ma1WYfTprDPaZRl8SQM0BAg323LMkd2abZ6AQrlta9tqgyKNgS0cAmJK5qIFZjTzIM31KPE0usCbtdpJDE3lz+Cdq9ewk48wJhewHzNIGSZ/3GnHLAfzyoSRFcF85os54Y0pP0yLwQvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298412; c=relaxed/simple;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYGjZh9FimpfcV57+82hQkWluAeHYCnTiX+4kjd1mSMk5PSIH3lDU5zKEykvd6x9U0KgjX0OUcEU2MPhcMww2GVyZ8xdLJQC+AtalrF9ql8YSQHZM9dSRlqIzgXJLHAF8sNiKAZDe9dIJO/4a0JGD6jYYO5YoORPEny+gFX8l5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZREibZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZREibZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D27C4CECD;
	Mon,  7 Oct 2024 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298412;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZREibZC6L+n89TyEO7b0RjmACO4F9EAFXbKHiKcCkU0EqqgHfKfso16uBwwNwfnp
	 q9OwVxdC3+fUaLVeoF9xE6fyts1iO1RF/L4ONK30bd8Xq+Lz7u8hIdHf8ACq55VZqk
	 6v0kUiaqSJcVwDy74FtbP8u54pYtKkNFZNaExoYRollj+JXIBq5vIl10sRyPfTuog4
	 CwqWBYevsbYG+ZbfG4StMNdvjKesSW6kJ0mQRMmJW0nWy5/LqRvYTPYlSF6XYDI6jS
	 s7Rd1+4NRw4Ji9pIoAo8YMKRjmrIJjNZA2ORzdx6fHIu3PsX8ZcFunP7Njhd1bGDty
	 jduCFfjJiEFYw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/10] mptcp: use __lookup_addr in pm_netlink
Date: Mon,  7 Oct 2024 18:53:15 +0800
Message-ID: <c847da6e4fd8be67943ab34ec41aeee42228e32e.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
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

