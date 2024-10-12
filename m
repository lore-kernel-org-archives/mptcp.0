Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1191922CA
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742804; cv=none; b=B9pA/nq5jaParsJ8c/aaNRUoPhXdCoCJD0JzOFsZVvknaG81PE3Lt+IgfNY75tCLvS+F+Rnx2k1Lx5+Z60+KrKfgMucbSYe1c/kmfDCmSGOiSSZB+ouch60fc10YPDJXA5hSylXUjy9C6QtPk2USahgtKqPjJMKQk3k1UcvPU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742804; c=relaxed/simple;
	bh=EpfqCeh7iwHgaOQQPw5oaL7RdTD7elimm+LB7+83eck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My8HJ5OzLtkmIFcAyuXtTaaxS7C/Z+hPBBFhmGgrybMIbxuGi8lRxA1ZJBNpKQzUfEv7PhjlGdJwi+gUHU0tez2RNIuprrZkVo5/2LqM+ZW04oVTOURRqghpnS0Q8zzPDwDXzSv3kts8KRQ5p9TV7Em73NYA3woPqOzgSAYvHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT7M1ItV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT7M1ItV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62651C4CEC6;
	Sat, 12 Oct 2024 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742804;
	bh=EpfqCeh7iwHgaOQQPw5oaL7RdTD7elimm+LB7+83eck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT7M1ItVkcv/FVJdFPQg4RzMoi8SccOOj3xLqh6MRaYg7Zxrmkqa8DgT3d6omPBe7
	 Qnam0ZP9znSW6D5FrxaXNnfBe2jKuwQSrMc3rUuTJBVT6HgnPzKYDqTn1O8lm75Da+
	 9hLag3GYIg4znsKhEeeI8PMmzui6+QxUEcDcfJTJDYDSkTNcyKvuk3dUzZWDPNudPV
	 K4s5Pxd/+cmvmREPzqf4pvCD2HutxvpRPkjKfeBR7ELIP050rjXXyYUfh0GOCfdve1
	 oXDxFBisNoPr+8WSTstoqh2ZdEiM80GayfXMIxtzZCDIQ0zq9wJUIfXqUas8nG4tiS
	 FNL24DbQZzyJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 03/11] mptcp: use __lookup_addr in pm_netlink
Date: Sat, 12 Oct 2024 22:19:43 +0800
Message-ID: <5a76491bbf4901c1c76741ec048cc31c03e8f400.1728742592.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728742591.git.tanggeliang@kylinos.cn>
References: <cover.1728742591.git.tanggeliang@kylinos.cn>
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
index 20dab8158c93..9a77395956ef 100644
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

