Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E92A1CF
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806129; cv=none; b=KwIQ4Qelzqj/6pt9DmdTvr95C8g9WxqbeifQl7Pfh+hjfDeahDcZiEwsKLBLKJdPW+49ie+jNFu1/mZqb1ge4s05bIOXq6KOwdh7P0NksHIA8gP+Ft8TKg0dkOT8qphVSdIyPNI0ovEeVqqVm91r07ezfLNzxNz7f2b1Jlhn0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806129; c=relaxed/simple;
	bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JE3f4TLT72ilJXO3lHI/jK1wyRRCte6WcVJXhdmoBz68yyony2Vnqq+8eb/iqC8dZk/FunLVKwnaBGWQGc67cd9QXhmb0ffKXLqJU5EtBMvYuTeD9TONracSPqiLUNKqo7dlvvBZ7LFryuSeMiEc6jIuZQ/nLiKmsQT/SIFF1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrxL91EK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrxL91EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F4C4AF09;
	Fri, 16 Aug 2024 11:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806128;
	bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KrxL91EKQYorV3ke67S8u2ZWiKqqGvu9gtkPY/aDgGhV8Z4X7NkGpFN1JAEc5iPz6
	 fcSsuTZrkOBG7oILmw4WwRI5jqj5GkHV0Mg+7KGhq7aOIOF1zLBqFOPWzL4Y3VBlky
	 bPIX5/ivQeIg0Ghp5Mdr6TYsjQBmoRz8ZT/MYQx6sjZFh5Tjk3JL+mLLyFn+awkOrc
	 RseAuGiad1fkjCOXO1jgzIu8PUV/IXqWaRnqGWorkaj2GC4/9DvNKYyA5+3g/x0Y5/
	 RTfFCXjzI3ZE+tdZTHVTIXM8pN79cHOMaM8RHwMcq1Nya8JZbTZMDWCG8Ef4Viz1QJ
	 PRTroK7PQrLxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:01:55 +0200
Subject: [PATCH mptcp-net v2 01/12] Squash to "mptcp: pm: re-using ID of
 unused removed ADD_ADDR"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-1-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGtvugoj/8Sk7azYMkA/OBPV5ZgtiGfw78S0
 f7sO6We0b2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrQAKCRD2t4JPQmmg
 czgzEADMM2aR6RzUiZaasG7ga7tUJjvhiNg0YRL7QkvJ+1LQwlrYLdug70Zp9ZIuX2HXB0fqd+v
 uhUidUbIl7szVP+sn9ZembyEmLnulvAw1umfRM+Fjw78ydrByyTNzjZrMY+JCM+fK2cW9rR8YwW
 jJsyYyysFJPKaQx+ZR9o2L6q3w9DpKiuTxRHUyeg96rB/kT3suXR7jszZ/S+r0dEdRMLJgEo5mE
 tk4gA+dpxzlu69beSL4r5hnKBbw8DnPzU2p+O7wIMGPlP7MMQMq3LnTHcLZdu9Wr2GA9rC4vHYA
 dapLaSCiiGYn6r2QjxiqJT/kYwlPYEFizP8wP5cQRTeBrpFu6hobtChPv5TtVNvyltsY888Jyvz
 VB5ahhkR5p1YlPFzVgg1DJU4rJXstZiilgMbwAl5I4MpVmDywnLK56CuEhYx3JoBR4DN9TiqNdr
 xlWyQuapUcMrBvWsxlqA7BcVrMiMXrTbpoOF6oVhTTLbS0ehv8St+Ymt26S2I5ZQ4dz/7FmOU+y
 LilT/gggbRDziK1NcXkRvrwLXtj5NLBCU5XCZLeS6Zl+kpuiPGdBHADutsrv/qcW3YGtV0KBi+R
 lBqTxOxAVjXiVL+c76Rz7S8zMi/dsAUHYyI6DBVfAiGqkKetRUPruL1/sUo+wDXxamJTIXe6oPQ
 OoswAnjVTEIedrg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When removing an announced ADD_ADDR, the ID should be marked as
available only if it was announced before. Otherwise, local_addr_used
will not be decremented when removing the endpoint.

That's somehow the behaviour we had from the original patch, before the
previous Squash-to patch [1].

Link: https://lore.kernel.org/20240802-mptcp-pm-avail-v6-1-964ba9ce279f@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d3b1b459e6f3..0881983f505d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1455,8 +1455,10 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		__set_bit(addr->id, msk->pm.id_avail_bitmap);
-		msk->pm.add_addr_signaled -= ret;
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}

-- 
2.45.2

