Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1031C695
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676961; cv=none; b=OgmjV4fNKqj4NMtMFVjm5g029c12JnPWZC6FxsBiedPu1mh/PlbbIQO8yw1N/KTzr8axF84Xr9LiLhp4gto629WucnJBfU/v7Wl9uYx4oUHjducqAnocq3XZ6qri0CBkeW3+H9PQQ1yIs+WM75Fit9IxxZ6s59dhzLVHVoAqILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676961; c=relaxed/simple;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOt9kHxbqWL2JmQGHGh+irM/9c9VSLJRyiBUxXx2lDcqEBauQsJaI1VDirIjjMeFlfkAKqpGNCEQSV5OM5mI0qBsGmNOxy6Y79fqsZDYLtHXvlZppFw67fWvHqr6Gc8sbplDiDtqTMGfsaztUv1qMXX9bCMBPXxT96zKprgllIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD/xhwwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD/xhwwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088FAC4AF0D;
	Mon, 22 Jul 2024 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676961;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SD/xhwwFjeDRIPG3dQqGIlaXzkhUJTKV3YmZWrCdAKWzFmVl5BSmTSG1cLyOepRgP
	 3EV1ZoISh63QrNd9QA4pbMU2m0zD1PrUf4ZUwlqGAdjFLqg11TBT1vQpQFQmcUPb4R
	 m5yJWhhPBHGCT7Ib6Db8fLhHLBWwEUxVQItHYbkwvhy12xfOWuMuJ9lNpeFh+3Kzcf
	 TWVItxUy79cmhWZiiAPe7Ef1zC080Wl+/WQIBoZC9i9wKVNaT9WHWdeSzQVEF7Cc5m
	 zArTcTYjRpQmJ8g1TeI2hAkGqly6t0GABdqapo1/VIkI6njboqR0R+w0X6Ut8vB1S2
	 BKwIdnQKZeDhA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:46 +0200
Subject: [PATCH mptcp-net v4 08/23] mptcp: pm: re-using ID of unused
 removed ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-8-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSW53GFqDNXAWlmi5aoRcjjpfvv++NaL1eZX
 dSjLUDXruyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 cwwFEADD92YSdgEuD54EvxFIV/imGE4ZuNbTq4Rf4KZu3h6W+jwV+JnPr9YtYo33FriRe9fipuT
 oMU4P6/NkIm+y1q+RzlzKnq3DFUwxnb/62Zgv6gIfwkmSM0se+Kk1eZ2rsFAAnXaBrO5/rUdx2r
 j1+aerJoBn++eWn4hAYV4wwGmhX6FjWeNXUw4+9RO+nFfVNVb6/EcF69HwB1VlO3v4/tL7/o7lC
 U/cwsE+Cjro/e1luH2t+WN1YkxKGQcFXub+IW32yUsBCpItHCbA9wAIfPgkCaiqQ8rPN8eV2VDS
 kgxXUGcuzbARBWBgi2skbb2O1muqXhO9Jd5JsmtjZpz0jZ8Liwv4OefuBb78f6kmJguRhsj8tR2
 oJ4Gx4Xo2+XeaWIWvssiM8/QwTTUr9e/b9LR8s+hg/2hVQTeblMRAICXqtTPOy5Vk5Ii79AiBGl
 lH8ITCpAQRBF209CszjzI/gMZflbRbkv7ao+jZEWsnpIFtwEJGK3Lh2GmwvKsj15Fp/Nn88SpkQ
 3fepI+EBOkEakWXshTVfWFJl0fuZm4Qjkc2fEscpyktYSIsQUEdMdIQ5ye+NC5X1SqRzY36jgop
 IxEO1Pplb/FsMNrDT8rhhyzrXQN+cLzVx2PRfCs9g8H5HQE7rzP5XyGd6pXSBSY+WQ3O9vmP/vl
 aX9ToFNCbiObtgw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'signal' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the address entry from the
list to cover this case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2e94f2a9f2a6..d44d318dce03 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1394,6 +1394,11 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
+		__set_bit(entry->addr.id ? : msk->mpc_endpoint_id,
+			  msk->pm.id_avail_bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+
 		list_del(&entry->list);
 		kfree(entry);
 		return true;

-- 
2.45.2

