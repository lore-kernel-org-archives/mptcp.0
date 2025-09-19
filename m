Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D61BEF7E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272923; cv=none; b=LcI5ykXeRrUfN10t6UXp1FG494NjikpMAubT7/IBoGud04foB65DHL8XCArNfWMWmpUH71j+3d13aGcwrgoQGZjfp6nkpJr8ptt65HLraBeQqQkfMgYPHXMh3CnC1TGEwTPySsOWDfDoDSzw01IKdidhPOAPmsgtFKtH5Tw64OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272923; c=relaxed/simple;
	bh=KV75xVydMFyk2Mxuo9jx8uE6XJVdUgHR8JvaGbbOoos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8C6T32GqQfvTiJ7qX2bMgrpvF5k0oM+Pqbq/wzTJZ/VoMcLDuSx62z9yHEYYJ5Ui1+IzVzqL0ObgMwZ91Rrge4U6StLAqghcqn8naJWTfsfZ6fpKuFARCwcQrlz4Q60eNL1TkoUmWvsjQNMyYUf2wS9TiqOC9FJkxi5ZMo/ZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdIkL4hG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdIkL4hG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433DFC4CEF7;
	Fri, 19 Sep 2025 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272922;
	bh=KV75xVydMFyk2Mxuo9jx8uE6XJVdUgHR8JvaGbbOoos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OdIkL4hG9PngYTDGdRQ+sdITOiS0yPsF32Ml6rqMX7M8VZpcw2feC9lJdYepMS+WA
	 j9wJxQAGDn2UYSHazT67hnm+5QG/xWUTkDw+j9FNb1Y8TMpO2bhoSvSAVW9t7BUn2r
	 rJetAymfrQJ92NEbcPnWBGhzqmx8OUsRUOlNn876N4Nu73Lj3D22F4b2sjJ3Cg0zAu
	 Tqj/0Eu5MKQufkr4cOBvYmidyRhC+3aYRMgXtsWC/Mqz9Q/BIz8I1ee31/o1zf6qGX
	 T2xuHhGEpMbuJpeGUcyG671ftroyeSGNiilykZHQESwGuUk3qBlEobr5OwtXP4V/0l
	 8I5EgNqSt90Tg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:16 +0200
Subject: [PATCH mptcp-next v2 10/10] mptcp: pm: in-kernel: rename 'addrs'
 to 'endpoints'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-10-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KV75xVydMFyk2Mxuo9jx8uE6XJVdUgHR8JvaGbbOoos=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyk64pN8ZJJ06P9PlTvG9J+FrOm8e+rBS+NLtGYm6c
 yOuabLu7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI40JGhoMn/F5efDMp/KCq
 w4lZUvdtrrFu4c07XiwvF+w47TJXqyAjw3HXM1rPYxd8q+iyeLw8dsLcysAb//u1uOoPGgUKLVs
 TwA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'addrs', which in fact represents the number of declared
endpoints, and not only the 'signal' endpoints.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 39ba27aa731ae10df4c34a387b6c0e4c9c6d21cf..e84c381aa3a4e2ad8a05e4b0daa7a5e8daf2c35b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,7 +18,7 @@ struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
 	struct list_head	endp_list;
-	unsigned int		addrs;
+	unsigned int		endpoints;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
@@ -627,7 +627,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+	if (pernet->endpoints >= MPTCP_PM_ADDR_MAX) {
 		ret = -ERANGE;
 		goto out;
 	}
@@ -666,7 +666,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 				goto out;
 			}
 
-			pernet->addrs--;
+			pernet->endpoints--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
 			del_entry = cur;
@@ -701,7 +701,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
 
-	pernet->addrs++;
+	pernet->endpoints++;
 	if (!entry->addr.port)
 		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
@@ -1101,7 +1101,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
 
-	pernet->addrs--;
+	pernet->endpoints--;
 	list_del_rcu(&entry->list);
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
@@ -1182,7 +1182,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
-	pernet->addrs = 0;
+	pernet->endpoints = 0;
 }
 
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)

-- 
2.51.0

