Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F717109F
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676964; cv=none; b=sNJkRPZxKnXTU26x5QqwG4bttGwfXC0STvyEZaTmXGLsQWGtCUVPXKhokL8duXdsqpsXjlRETvcDq12q+QiqmzuT8s5U2Sy+qzjy0qJ+4MM5rtEXeE1VsVdgX0ETNHbdCydj+xXHOlqX5vKeShz5a1bbqC3ddvfeUaeRvv5GxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676964; c=relaxed/simple;
	bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vqa6OXZGr/e/1ZJLOb2bY+ka+FqBOGx+8CYIsVHwtVCIxYgHJcECOCok6VKA7poTQ1w2bSZA0MH2bMJ5QUNbMqTvwzCe5GgkvClYGRmka33q8U+Y9H7XghxF6Mu6m7Auqtvg7EhQESmUFx1ROeuxSz2ve5q9ne8I239rGp3uJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMaIaH8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMaIaH8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E38C32782;
	Mon, 22 Jul 2024 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676964;
	bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hMaIaH8lPO/hnlr+JRiy6k9WNFYIDPpjJ0YmFBf1CgwbbyZCSitx18EIRqKAPFaQ0
	 1rrsFqTKfL7BMHEf4DtqWt12kamBCr+tYsJaYCYaokMQAhjdlPNgfbrHJXAnCwF110
	 TECTO1snIAVeyR1f1rLjV9JKbegSFZBpyiGqUcDZFewOQALo0mZsyD023g8YEswkx7
	 NfgN7oG1nVcly6LllbNhJ6byc+jcPnZkvZ/cSrB9pUW3WPBZ+qk6fDhScn/IdnCaFm
	 vk7X1yCaF7bxzGvj1kXraaa9xK4iyyOfvy+6WzvF13Xp4yvEh8fLggnidkllSfASsq
	 a8DP5LuEcjsuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:48 +0200
Subject: [PATCH mptcp-net v4 10/23] mptcp: pm: re-using ID of unused
 removed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-10-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWpn36hFrbu0NIyss85jyxA5/wzGWRaUxIs
 gfoLonNIKCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 cyHaEAC6hlOLFlG4e9ccQdmufi87zQxqhuUcwMVebM2o3L9uQzVSi+ct334Y/0okkJMRoiagdDt
 1amrQfGkfL74e3S485DycFwBHu/d9pR3WloHjWv9VmuBAlSCEB3u17e2J8aCvaA7rKv1oqQfC6F
 gq44YOTCXAYiImKpfMMu5eMH3COqfPv7ObYEHamnyEllm9IcEw2/Ty/IcUjz38IPQwS/DXOR9Ue
 fc+BTJDrp/XeQbtyDBvygMtkjZtxJBDiA1LBatevFOCYqHj1OfizsJAKNhX2OgVAfG6EAlKllYs
 D7LbvH9oeN2AOK8b82cEzb/SgI7+vam6aw96wV5bLfghELoW3P9FWoG46YTDxXSWxu/W285VDOU
 uMlLnlZThJztRkLXGjOfvN+CTTzR8YOselkO1jNuUdX5xvDzInxw/0KTt63ZaXoDbb+AoMlhido
 +HQhhyMGgTjPTpiNtRvgD5LT/gaX/C9Fx+AEeUx0ixrxniViMv9yAzPPzwLDZ7/f6xD9pBSOjB9
 T5svXWycaKXiVxZSjc9EIa4EaAqVGCIe4fo9y8GVuOJxDJaMGPCnVgobwRCy354e/tfn4r7Nd4M
 x0TQFGQV8Q+Gqfi+lpFWeBQ/ZNZs9MuQd/B2FDpaGi0NpGmJcyoSrxX83DXDrLqjJUccHzFtT6J
 7CiAmJTeWeXxahg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'subflow' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the 'subflow' endpoint if
no subflow is attached to it.

While at it, the local_addr_used counter is decremented if the ID was
marked as being used to reflect the reality, but also to allow adding
new endpoints after that.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - Add new line before 'if (remove_subflow) {' block. (Geliang)
---
 net/mptcp/pm_netlink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d44d318dce03..bdbf27fe89e0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1454,8 +1454,17 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:

-- 
2.45.2

