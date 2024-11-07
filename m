Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926F19CC36
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970601; cv=none; b=Gi9w9533SaJxquEUO/xcr0b6gyc8FDcIMaO8RwjzGoEmUb73LWpEdfW8rMDw/5f0wGBnw0F6O7yJs6JczbBxmDJxkRmJCJraPeAR58Ne1Y/oOTkRH4GO0K242qppzrsNf6VDBvSl2eXSieF9sRdJnHdBn0GVp7sWkHphV6UN068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970601; c=relaxed/simple;
	bh=UeCsZxEfG4t+jeWSbmbPJW11g9vScyiLjAaeOnPjkNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oie1bGIZRy8Ziatk2uOn3xashctQa0Dwy0y9ediI6PqGFthdnEw0L7YDJyg8BZSCm+sw0Ghau8xzNcaLYc4risv3Iy2dZ+1J67Mf7MnMgoSOVkJQX8ctQcnZuLcfMB/Cgnuu+PamHe8D5yuW4xZ+1y5tghBEcZTOCCtO3El7+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL074tdr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL074tdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B105C4CED2;
	Thu,  7 Nov 2024 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730970601;
	bh=UeCsZxEfG4t+jeWSbmbPJW11g9vScyiLjAaeOnPjkNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nL074tdr7jBFTtbUbDqzjTPqFEu0rkj+fYjcvZ2Nz0efNhl3j8CXghhPOaYHRb9OK
	 ScbpezfGDw7zCY849JgdKq9VgcYo+LJhCRijwMQWkfgSpMnW/U8toive5CR/lvea8X
	 0BGbVpz2EaGpjRIL9yhNnEqWvyT3NwdoQvCk9yiP7ZisCwS9a6Ca3ZEgom8KdTfP2l
	 vjKtPn2dO4VNO/b8ACvQdYZ9fb1agZRsK0Wmc+ByGxx+TEEV1hQIApUZrZpniSYUXJ
	 FqFm9l2iZ8gYa/XXidu+gJRW8NUROwEXzZwTrw3he9DI7CKoACAYYrhIgyDUEOhnyj
	 3g3T7cDFwUr/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 07 Nov 2024 10:04:16 +0100
Subject: [PATCH mptcp-net v3 3/3] mptcp: pm: avoid code duplication to
 lookup endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-mptcp-pm-lookup_addr_rcu-v3-3-3c458d025de4@kernel.org>
References: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
In-Reply-To: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YUL4CGqIzhlMPln+WT5oVHu4NWvc7lGKFG/f9fL/Src=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLIPjXFnhfiUc0gnlVc4vtIcjZoyoryUl7JsGp
 v44pVw/+VCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyyD4wAKCRD2t4JPQmmg
 c0rdEACsuEEz4EXequBL1f5SnGTndmGTApab40O2pX5mJlusVcKGzpXWGq228ikqqChI6J42r9K
 FGKyBJtGqZGz42me0lyXacDy4O+ZYA36OXMO6+NZMOQkEY+8jCA3eydf1cYe0usgO2XJSXCsdGR
 rnCs9l2ivgYMRVXSdhC+ZHIUtFfdcOQIFamrIJbYlTSJFJ0AeTt8QVpe9Y9c4bxpCergFy7BN/4
 qu1brpXLgF/0ov9cefJpgCo9CawW4PiNums89l+JRhr1vPfT5J2erg4GD5Rfn5GgHj/h7Q0WNtZ
 OiSwf1U/DEVlR5gCAOJO/OHr/JvqnZU7hSn/ilhkjn3sRHRwMxpAXsRLk4gQkXqXGZYgSXGEvtK
 1AhNCoy7GPWpbPXcZyq6RcJ50K+d0IgBaa8OHld6GdCyXmuiJkmOJRypZ+mTcwdmX5CH0cj8cjt
 238wlEOqUvYhcVDRAP+e+x7DaCBSHOddHtSDRvaO0YJVOXaj6dsf3C8LKThsPeOkr/OS5tCeVvz
 /R/HxttnCCr5VKzI1+CZVTkgB1V7XI3ZZPruLg8qxL17RaKVlRsiH0ysfjb4jmyuxUgXicKBRRV
 RqAXic172y0Ee5DFkTVTe4bwqdoeQ++0Pv1kkHsV5KH4IHw1Ho4vlVVTR+8WltddV+0soqtZc6d
 5n7jStUg0wYRYng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper __lookup_addr() can be used in mptcp_pm_nl_get_local_id()
and mptcp_pm_nl_is_backup() to simplify the code, and avoid code
duplication.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Notes:
 - This is also for -next.
 - v3:
   - use __lookup_addr() instead of __lookup_addr_rcu() that has been
     removed in v3.
---
 net/mptcp/pm_netlink.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b005ddfd2d365b66abf42065289d74630e604f6..7a0f7998376a5bb73a37829f9a6b3cdb9a3236a2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1143,17 +1143,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
 		return ret;
@@ -1180,15 +1176,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	rcu_read_unlock();
 
 	return backup;

-- 
2.45.2

