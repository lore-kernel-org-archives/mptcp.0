Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27112EA171
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247091; cv=none; b=bNzl1TbX7XWhm4zUEkswVsE+xKJUvoqZI1WRVrIcM4VgJ5Kw09qn6z1qUKzyHq7dG+vseXwPM7Voo+0o3LjuKO5Eo/kTPl8PewBLlZuUxh0Dj7ckwINrBY/JxtE/FMQ9tJGkxePXA4wDjBSrnkqMEWdHXjpnYExBMvd+V8ah7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247091; c=relaxed/simple;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOvkcqI1xVoAeoub8daCXAWwJcfTFLIQd+nVEpAwTHXNQJyfJctCx8sMKL3MKxu1CgD1qpHlkOV1dDUMYpJ1MeBTSiMctsqSeQ2JHvmo+CHoqaN3e+rjdR9dzYaKI3dIwhctkJ8eu2FP3WdHsrjqiekjRITeofS8vc3gyRwS7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thqf0L4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thqf0L4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A2C2BCB5;
	Wed, 15 Apr 2026 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247091;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Thqf0L4wpYNFC23Wag0O0tD9uo/tNqXUVuw8v/lwGQIu3JN9lHDHXflX4BWNCLDp8
	 pFf1uqq99x+nSz/4CpBVdeCYJEX0z3MX2KwLmo9ARNdrTJS2ZDevAoBgLc4ucIVXVH
	 lkiJVcDQKw2Etij7dOmlqr2zljlxh1xWWKuc3t9Z3d+ZNngfHgz9TPRRhEXkWIKt8N
	 koGTYs6Xmj1qTqi/8AtTB3Jd5KGGQo4FP84EUeH2fTXBxe7Wjqd8MvXrPSGyho5xv2
	 TGHWgFQ7xtgrf/ikF/jDjP4RCVHBLP7UjR9cFFDH9NlARkNuneoDQfZGGCBGau/6oj
	 SJnMFx34SyLvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:49 +0200
Subject: [PATCH mptcp-net v5 01/20] mptcp: pm: kernel: correctly retransmit
 ADD_ADDR ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-1-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJyofvV/iE7NbyaNBf3X73e2t4WUqa+dm7nVVezzzz
 zSZ92d3dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkN4vhr1BgeHDeg/RPczjz
 FEuTt23Wi5xtWS+Qnjq/R+38W32DDkaGtZIX7yw42Jq87eOBusDuJOOHR5/mvJ9i01mot6bj6Os
 QFgA=
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

