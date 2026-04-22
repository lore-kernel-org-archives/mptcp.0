Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2A299929
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876042; cv=none; b=jnP8K+oNUQbU+9oPQh7fIHA0hweMnHVLkPpB9Y4WHu6BtgCoRQjocFXEWmuX6aIXu3RpJhg/yxMvzccR6BbESSMO3uhGvdj6bf0i8VZ201h1/vfWInhDCAUz2kPPNzZYmX0Je1/wGZDw1/1E+6zhXDj+LNQt2UFYZPf4ipVUBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876042; c=relaxed/simple;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oF58EMUXkSLT3N1AWcaxWaaA3n7FXh1rbsTLSlKQ0NCng6XjCWpgN6jWdzXLgYb8PwPjE8uvaXDN+9KlR4a3Mzu0hFFHix4TDP/gy8vUYJg/Lm7OXbEyUbSx3qBvIawWaf5o+mvK/gBm7VVqdAte7d9dOHtnzO4qZnIFAAkito0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snmP7txB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snmP7txB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D9C2BCAF;
	Wed, 22 Apr 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876042;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=snmP7txBXguRf+sx0TEyHYX8/P1ChU7JU4JbvadKU8r3Gm1YE8kUHQwsPTq0U+hYq
	 qTpOOW0FokJ+S2yl3qb2dAchVvk+/IbT76i32m6EYXWQtWqD1ycXOIRW6kb17+HuEc
	 LMw/jxJNZ0dzNtD7M2SS9AVaoLOXEVkZpBoYOtgWpoRn2OxbSwUyMTmmDdgBCrowAZ
	 sUDYg1oGa9OeYU3DA0SEwaEfl9c8qEq2hEMcxT5nsoDx8QWA0BcMEbLuqV7sdwgrcv
	 MEF6BkVFiLTm6rey3ZcRbR3vYaOBnB2a+/Pg34DBhuk5hKGlZnpYklC2qT/DruAI4p
	 NF5KfemwIFw+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:15 +0200
Subject: [PATCH mptcp-net v6 01/19] mptcp: pm: kernel: correctly retransmit
 ADD_ADDR ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-1-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/PwVH1d5Tn5l3gnRQ9PPXG2p2c/z4U+/ZeKNlsvho
 hsPOXxa2lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARzgxGhnmpEafX35RWb89g
 F86VuVAUueHHpPV2WYZfbX6szHKT12f4Z3W37d8qz45lJb0qCg+jnqlc+8tQbBfAmLZJcM3TILv
 tTAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding the ADD_ADDR to the list, the address including the IP, port
and ID are copied. On the other hand, when the endpoint corresponds to
the one from the initial subflow, the ID is set to 0, as specified by
the MPTCP protocol.

The issue is that the ID was reset after having copied the ID in the
ADD_ADDR entry. So the retransmission was done, but using a different ID
than the initial one.

Fixes: 8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7895fb5f982e..906a1d5ab9ed 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -347,6 +347,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < endp_signal_max) {
+		u8 endp_id;
+
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -360,19 +362,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
+		/* Special case for ID0: set the correct ID */
+		endp_id = local.addr.id;
+		if (endp_id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
 
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_addr_send_ack(msk);
 

-- 
2.53.0

