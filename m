Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F18145335
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360963; cv=none; b=ORPOncseZozmLoftEvKye9Bmcqq0q2LR3rmi92lDYR838aV/XVwx+/wY8QQPrkac5TEmjveMW9nWp2Rfs/MhCsMpCYlr59IccqkzC2QnX/2ByioxZdcQUd8BqazoK1VFYzg+0h0DujvDy1KlxXJ4uFfUkLGo91JRrnN+9LXL5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360963; c=relaxed/simple;
	bh=YgrXMMo4GN8L0huiWAlxX8sIZfGy1uzu78azQG+3v74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXtQooRbZMmGtTXAuaHk4wuZb9LG9lgOetQt9/r3HCwDLxpO3R0cnl923tcPJQ+tXKhEm6d9kel7ckrh39m0hBni3y7dZD8VooLo4gUDZ8JMUQzJsd5KTYY7B/675PHx67o9BokiXAQKjI5tFWyaHoAV0gfWODguvEFgUg1AluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BieaDX9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BieaDX9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FD5C4CEC3;
	Thu, 31 Oct 2024 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360962;
	bh=YgrXMMo4GN8L0huiWAlxX8sIZfGy1uzu78azQG+3v74=;
	h=From:To:Cc:Subject:Date:From;
	b=BieaDX9RoDtjdUXCZf0jDbsLox85SrMx3rOTseUzWviYwDDmJo0RM2UqBjtaDO37h
	 EGHxR7/yjrDg17I2N0tgevTznv9rz1p/UKQqvtmZFYoXsnVhqxldiZ7+gEGF3bybR4
	 4/SmunQlwAsRRlbnMw0a9067qKgW/iMd89zcDwuoQpRqfEdN3GKkhvQc3dSitkK5NQ
	 fAMBSMvvzYXhSg5qmhqA27+c3GvQy0IdNoEKjp3N1g1SnO/pgo8Me4cn3o2PB0f8mN
	 JNOMIcLeOBvEL04lt+GHL1om/VIhM8xRo7qu1hlLwM7Lswzzx/ucZGwEQsXgb4HKC6
	 z1m2fiye6Y0tQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: use sock_kfree_s instead of kfree
Date: Thu, 31 Oct 2024 15:49:17 +0800
Message-ID: <6a3e3dd94642cf24f3d6f97fb869d77d7315d5af.1730360928.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The local address entries on userspace_pm_local_addr_list are allocated
by sock_kmalloc(). It's better to use sock_kfree_s() to free each of them
and adjust the allocated size, instead of using kfree().

Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3b93fb01dd7..f83eeb04d7c9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -94,6 +94,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
@@ -101,7 +102,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
 			list_del_rcu(&entry->list);
-			kfree(entry);
+			sock_kfree_s(sk, entry, sizeof(*entry));
 			msk->pm.local_addr_used--;
 			return 0;
 		}
-- 
2.45.2

