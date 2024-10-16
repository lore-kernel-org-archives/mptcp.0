Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3C205125
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069973; cv=none; b=YnTEEO55tN1FVS1Ivy2prYBQBDYrl3qMpLpDcIaDf438kTI0pDL9hs6XbzBpb1kAtm6JhAY3c8GJ69ti1nGXTOL5vCndKKvu9wif1DIE3cLRyxzriUssW3JO8bgYD1r1iWnbSnaE6ZK69rtYDegX1eN7ENJnp7PSHEwXs6CxhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069973; c=relaxed/simple;
	bh=ZJXQ8uNJ3Z4VO1rjzECqY1E+6bKfK8oP5+YnjMOQb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkWJu9ADfrBiJ75I68ko3OGzcaEqjGNZrj157jtP7TuVKwXBqz9GK3wFKI9Os6vF7+z2hZuwTS0ski3dc2j4kYps7X1eff7lcuzYWITGBBcaEzEpBlb/u+8fIRd+ElVFFtWLkGG7X1Tbtcx8Dh3B3iSg8zePmDZTBePsI756Y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjri2RH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjri2RH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F236C4CEC5;
	Wed, 16 Oct 2024 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069973;
	bh=ZJXQ8uNJ3Z4VO1rjzECqY1E+6bKfK8oP5+YnjMOQb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zjri2RH1q0PzghYkYdKw2BBndUb486gh/3fbbEM5Rn6zocl6JC0ER2whBj5dSpCj2
	 H7/cK2vozSkkDLzOsBo8LclRYB4UBFn+lIGElnHp0LQG1xnROOP5IsFUOg9Cy/InF8
	 MhfC8Aj2/LCu3DSLNejleuKDQ7UT2XlikOFxfgDQK7scLWynHFcuGrZ0mJp1s6PyAg
	 MrpX4Q5ylOhza9qDhoPdNwt7ZLfhtq7PGry8WkmIjz5DtgSD6W2i+e+aLyOMJOHSkG
	 yV7bwmqklZKK2sop/ArV0LKG11mLmDCmPuaGt1L/+XPw/yJjIXRBdeJhngknkBb9w4
	 RmKmYbnAdpPdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 04/33] mptcp: use sock_kfree_s instead of kfree
Date: Wed, 16 Oct 2024 17:12:08 +0800
Message-ID: <6f1789ccf1cbe2db89b95a08ad2ef0467b1de028.1729069853.git.tanggeliang@kylinos.cn>
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

The local address entries on the userspace_pm_local_addr_list are allocated
by sock_kmalloc(). It's better to use sock_kfree_s() to free them, instead
of using kfree().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 00a7f9dd90cf..3fb5713cd988 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -91,6 +91,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
 
 	mptcp_for_each_address_safe(msk, entry, tmp) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
@@ -98,7 +99,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
 			list_del_rcu(&entry->list);
-			kfree(entry);
+			sock_kfree_s(sk, entry, sizeof(*entry));
 			msk->pm.local_addr_used--;
 			return 0;
 		}
-- 
2.43.0

