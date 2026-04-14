Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118D146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173652; cv=none; b=jLRfotQJam3LoiA1SDt+61YxoINmIFOHsLAARvmhcrVNTdJ3QI8XsXaP2w3E4o1xPjJt+ciOPhosS1xZ5UHZBEVU+6D3xGSc3aKqHI1cn2rF5tgVVb3FDYaGmi3kheokn/4rUxJDcXA+O79g0HqzWsI5HRwOasHMU/RmNtQlGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173652; c=relaxed/simple;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzEl5rLhzDlLxVRgf6OFeC8QhbBY2eE2S5EbFK9gdH+jD/wBcVTgZVx2B/YMkHzpceEDFAa7P00zWYZnPuncNnUHxUHeWLiZPzxqEm8o3TmvCB3bk/yBn4P3/rEDcx5vYr087adbs6dY/vlQq8EIeObmxLTgqQ1HqRfxG03JfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXJamstN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXJamstN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1EC2BCB6;
	Tue, 14 Apr 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173652;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kXJamstNM8xdQzaMoCuKywVryFNGFVd7NZkSVgkpUlKzAke18HRTFVVqFbKwlGw1d
	 ZiN8Q7sVYeCNs4JO46S78QfT0mIr9FnIXXAWw0/AfgQ1iVt6DNIlhxRTotg4XaOvjS
	 Xe4/Ig3q0s9dOc3M3WN5LRjcPEO0p2t95rhIsS41OZ42YuZm1ZIlxu0Gv0ddR4cdtM
	 f7AZfviJl7FRNW+jT9RQpoXCXONwGtTq028xE5r81Ca6dKJPZXOdrq294Jzof8f//M
	 0CWhtBGbJ+6qQKNzNMzkx4dcm+TaQE4kb7lNnnDK7fGaX+Tops7VnzdCCF9vBzq3sQ
	 +3e0bFBQOV6qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:54 +0200
Subject: [PATCH mptcp-net v4 01/20] mptcp: pm: kernel: correctly retransmit
 ADD_ADDR ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-1-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXkcTszOufki1Xn+Df3DH/9ULa+wT5Q55jcrZfXNr
 js2X/R2dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEnpmR4bakhDDv/neGzXLX
 Mri3LZb/eXX2lXvpT77Hvo5t/Mrd1srIsCUz791G4ZCta0JU/n09/Ujn1/Lz2yd3BO29s0H/quD
 WSgYA
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

