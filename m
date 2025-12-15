Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744725D527
	for <mptcp@lists.linux.dev>; Mon, 15 Dec 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819850; cv=none; b=pG6B8o1fkugZtweQlSbcGcsiPb0WeknvVw/1Jl34bHrtGyKqGxeWvK8gt2cqQ6CX/qID0M1rkeJf6g9f0z4F8a0H76/tyfkrLIFpG9mhegY1zaHrwuNEK6+S/+k1NlSGPI6mYwbqNkmGQuT03Vbp/N48NWyX0BYPrfhYtadnbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819850; c=relaxed/simple;
	bh=x2aTVaJ0qy/yO0HkATUqukE16K0k8UQlnJT1GAKjEUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNyJtPbD/J8HKx/gKL1oiOU37C+loH/yOjtz2eDWCDO67P0uy52iv7v1d+zJqLiKmcE+vBpUZAyalDEVEYEiTefYwsQ0bJ8s36LY6Sp/Xc9ZIhGA13Xz4OhGBB4AMRzNLWITHMRFIPfrE7xWxdYI+6bz3PxVhLM58ppmc9YJAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtMi5NgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtMi5NgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67661C4CEF5;
	Mon, 15 Dec 2025 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765819849;
	bh=x2aTVaJ0qy/yO0HkATUqukE16K0k8UQlnJT1GAKjEUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KtMi5NgKk885SbWHDzpHUgJ93ZlQdw3Bt3pfaoGHLzivpiRWmDeDw560Af8pp+8PH
	 PfwEl5+oqbHXnW6+y73lhb/Tz0qpaPs3GAjMg3YoHQSpTbCAgJ+Hxs58rWDOU6irsi
	 IS873iuV0w12y2qRfDNDWH5uEU0C99hdMvGGNez1em+rCW3eyydFzgI7V6HSZpo3gc
	 MZwyRFJauepuF9/5DzWKTdCpCR28lIUlp7ahJXlmMXHAv2yyJJBBZHKbSwmPY4QnoX
	 PQO58Hp/vmnc4pQ41t0d1vbgAsJozAO6wo/Z7duWiCink+IhgqTyZIVZ6bxCkBDjjx
	 V9CN+wAEe9eCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Dec 2025 18:30:19 +0100
Subject: [PATCH mptcp-net 2/2] mptcp: pm: in-kernel: clarify
 mptcp_pm_remove_anno_addr()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-issue-606-mark-subflow-endp-avail-v1-2-2f1b36da8993@kernel.org>
References: <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
In-Reply-To: <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x2aTVaJ0qy/yO0HkATUqukE16K0k8UQlnJT1GAKjEUo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIdXI/7r7xn9qDgVKRr2RWnl3JHr3tt6QoOOnf5VuUqY
 23f80leHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJesrI8Fbl547XAft0VOaa
 Bm50v3X1V1T6l0t1SYZrLut8/Ptwcisjw7YV3gbaheGLSyVtJ4gu8vX8ujcu7xl/nVbVloivZa2
 XWAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The variable 'ret' was used, but it was not cleared what it was, and
probably led to an issue [1].

Rename it to 'announced' to avoid confusions.

While at it, remove the returned value of the helper: it is only used in
one place, and the returned value is not used.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/606 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 51bcfcec882d..8cbfcf67a9b1 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1045,24 +1045,23 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
-	bool ret;
+	bool announced;
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
-	if (ret || force) {
+	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
-		if (ret)
+		if (announced)
 			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-	return ret;
 }
 
 static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)

-- 
2.51.0

