Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5F20B0F
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662483; cv=none; b=moopkjJZPFtezBhD6XwU995jhZ87lf6rBtoRR4vXTdBIzJHLIt/drTGT3DH+wpNDLUwSbQ58DTk7vg3DGy2ifk8+lbUIZfLetu9giuVY4pf/Xvb8qVBxMSMwmqX+nA4i+9fUTUKAZEmXy0MsB+lRAsQEsnerVnoNCiZGGXitvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662483; c=relaxed/simple;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1BUoKcQgnkH1AWrAUJ11r15BGj+bpKgauh63tFeWXlu/m08j4+1qiYtmuyEGJG9fwecC+MR+UjER7SYqILkzGwYKhlqdsZtmS6EMBJ75kZfh9WsJmOU8AUyoTJ28iDdqVzcpE0KTeC6jCXsuJmFSR/3TLDRgVOwIFV5yAUG8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV0Ya5gs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV0Ya5gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31420C4CEC6;
	Mon, 30 Sep 2024 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662483;
	bh=G/L/qe+cBFfXmT3vO7fZ9m3E8qsGSV8Hh3uQMPlRCag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV0Ya5gs9IKNmsozdCAwkw8i44nO30pSKtEydX5OLiaxS0X8b2a8175q2PJ8LixFE
	 j2/sisglvGLL0P30CNgDJodMLs2GIHckC6JJTIslKIOApda+wl7+CR8fLYCjDlIE3I
	 G/ZxNFof0IBfEBk09pmsRzE9m7KlXfLHY3zyCxf9XOgXtkksvBXioerCIyw9dt4v3m
	 OCe4MyYtCh3QPI7oNILZKhbhmYclLrO24QhEIBHw+AK7b/zoarfqz7DhPNf1GxAVPH
	 HTBtTkhK7tApiYtFX0Q6WXMh22bmoRNu8IZaE1TUnQhoLEn5MwenyhSI4Z3PzoosNt
	 L0p6MEZ4+X70g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] mptcp: use __lookup_addr in pm_netlink
Date: Mon, 30 Sep 2024 10:14:27 +0800
Message-ID: <1e14239344f39796d7c950e10bda951f5f51ac7d.1727662123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
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

