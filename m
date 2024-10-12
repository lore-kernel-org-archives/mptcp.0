Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5521922CA
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742807; cv=none; b=h7MDoYEZchfwU4vZvhSSivAFrFIHpAIjHxamB6Q+OcilLRX8PCkMM7zi9ls/df4huiu+ItaYUW4amKqxVkXn806V5oO+pNgO6174uPC7xisLK6IP2mCrZvQtDk4ipIFhp5LxjLjedtYJLekFj0lv/jo8BwuDihehEeYEmItPt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742807; c=relaxed/simple;
	bh=zDs5f+dKLug4HQh5+daVjeNyaW4UwNZ0HjcVHGItBa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfBHA6NX9QKHrb4DKgiCspLU/tUTXRv/FnB9VrJszgyeLsJYodm+aTG0QJj1WHSTBcJ+nUsc+pbMSuv26s9+qyamEqSqJN/ZlY97y34y3ZYXv4t/RDuczel4NLN3A6Q68S52EZ02AKyJ+lc1BUmpcqAraWoRo07AlqVhid+w+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbMSJow3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbMSJow3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FFFC4CEC6;
	Sat, 12 Oct 2024 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742806;
	bh=zDs5f+dKLug4HQh5+daVjeNyaW4UwNZ0HjcVHGItBa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbMSJow3EX0i24dc1tWJMrVLk3y+SW8kyZA+N7gK6DHyJk6D0mqG2VZd079VDjYTi
	 l5ept9vgHNL5nn9d9M255YJQ486w0RicYwQ/vKSBoeof4yHwdBOygF7VGMaSmAsiNB
	 8z4ErF7GwBsp/42AXmJE+8hVq2PsZiDDrjxGQi17XPTGxJj4H6cdgItLn5ANcxCrLq
	 fHYtjw4E8DNH3fDJYee4zpUQrq2FP0VnQLyGt9dmIf8E/Ml57BGtSPqQWA+vdarxbw
	 kZ5Jxf2dOM0LAFIvbGjQY5nWHpVOvJ9Ydj2DVI0RZcal1+5sVvtli2xHNE3b7ofjxe
	 sMt2iUId2Xn9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/11] mptcp: use sock_kfree_s instead of kfree
Date: Sat, 12 Oct 2024 22:19:45 +0800
Message-ID: <c1248556f14628db9158bfea22e5f241e27a39ae.1728742592.git.tanggeliang@kylinos.cn>
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

The local address entries on the userspace_pm_local_addr_list are allocated
by sock_kmalloc(). It's better to use sock_kfree_s() to free them, instead
of using kfree().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4baa2a7dfd26..a06b83fd42e2 100644
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

