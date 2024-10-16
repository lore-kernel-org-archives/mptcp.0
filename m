Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD6204F9D
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069970; cv=none; b=Hj4mgTAZXlH+zrQLKJGKHy27L1ZTQVvPgeoCUjVfk+Cyv5I9813DWwsrxgZXwiCDeg14VLrFNgL3qGAjfiS75oX1+k9gIwLM9LJg9onJx7bAulf0VPTPDXwEK5wBvJZAYupPIFBpxFWOJaXosIz6/IYCXLeVTekODTyVUBNOpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069970; c=relaxed/simple;
	bh=t1Vs7CzvUMnE0bifUeMFM2eeNfmqwTgytf+gcz9YhaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugAzCfxpL3JWMEb8yGXpfW7K8mZyJqv+kGn3gEpWsyDv4IB6zkgtlB3tZo2KEVy5KZXRdybGPQ2YNH+H2BYKZVu8//QIznITABSL1bc73hppPBjnrXucB8xNbStJg96j8NDvP03eqDR3LI3S3mqKLDBxl2qjjuvKcWGdC7d5yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXI7kkQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXI7kkQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD7BC4CEC5;
	Wed, 16 Oct 2024 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069970;
	bh=t1Vs7CzvUMnE0bifUeMFM2eeNfmqwTgytf+gcz9YhaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXI7kkQ7vSgqNABnd9EEXGA7zLxLaB0C3cx56/E8aDeEM7UItlAL2kejFCD4rQDeg
	 OfU2WprS1fBEhARE7aJGBP44vClIrn0PjKfP0VxjxBD9bNJcR/I1AKWjoWdWNudTKe
	 NMIxpgQsIcVvKXe6XVuCJJbOtR2ZxQKVBsVWljopXx41d6ESFivOXoVS1Dz325vFrK
	 pepdeZioXj6GGe3nVkCwHWoyzIi77NyuF6LHpqNKHceZLHl+JYsJ8JVyz9Xrcyvy+4
	 kYvVtYyfUhOvTeFDfLeM6j9mJ1H4dgZKqMCXpD8fyT5juSPP1f6HoGidWJbfE7ubk+
	 a0mrY0E8KxGGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 02/33] mptcp: use __lookup_addr in pm_netlink
Date: Wed, 16 Oct 2024 17:12:06 +0800
Message-ID: <02d8e47d8900fe16587b8fb33b4ccdc21b4852a0.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
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
index d37fefbaf34f..1664fa993058 100644
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
2.43.0

