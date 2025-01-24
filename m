Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972C33998
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702707; cv=none; b=sEkLEgEs/b6BG7H+P0pLEUVqMAZbItuL9nd5D4rrbkGqZmrkNto0nUke1JzUEIzYRc32wSGer94XCFIq83xwl/g/rGIIMW2avRTv2v/fJTYD3SNoP2+IzPvSOCuhEQ534hqmqVSj2fVdKFOFFzT9QU11d96lllj2K/y/VNq1IRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702707; c=relaxed/simple;
	bh=qb3ggLqWFC15kD9lMbjAJaVce+m0JAuYIMvRNzDZbc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr4t5CSjYg8G+XpOaR1nAtHG7PiLStByB4SfPgFF3/HQJwB+C7ZCsl+46ZkgnrMafK+0oGJ6FEhsTAuhJEVAULzHBw9OBG66JPGIteDKK+xuXFcGwVkLb5XQo27fFa5UC8vMLzPebYkDH2HkaiK6NnSxl3AXXMnTyzeqpZbXoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqEpqEFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqEpqEFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D85C4CED2;
	Fri, 24 Jan 2025 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702707;
	bh=qb3ggLqWFC15kD9lMbjAJaVce+m0JAuYIMvRNzDZbc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqEpqEFpIukbJYX2Xsipqh7ZnlKRHoeyZ3jIN5qR7DXJbEdEzdxaniiK6fvU1FTNH
	 lOagRVaD3tFwACU7C8rI2MZmusdp1FKQpZ+OVJAFGfYaQdJ4V5DR42kiMYj/pawooR
	 8P5thRJuZCvMiTnJgKELI/8OxvTZZIlaiPcYJDEPcaKtt8rSqtqzFeHpnl/tfgO76z
	 ohHwrCNPm3uxuA9wDufCzNi1ttjPHKYjd6LXNmU+U/7Iym/qbvy3jmDMGwH8btA+6N
	 JYC1CHmEWN9IBuzLZ9FEB5kowM2DjAOlrv4hnQ7ylKDtS+yXd7ovfpdQ1I5dvvk1Wf
	 2fyIgejQuDikw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 3/5] mptcp: drop match in userspace_pm_append_new_local_addr
Date: Fri, 24 Jan 2025 15:10:45 +0800
Message-ID: <60d5c99bccec0f105acbfc1154203aa0490653a3.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bedd6f9ebc8b..a16e2fb45a6c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -48,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -63,16 +62,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -90,7 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.43.0

