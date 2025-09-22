Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04526F46F
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579848; cv=none; b=uyrhPaF7Cwap6JNDKkLjMjGAZ6RTBEEVVDMO6naIk3hh3IaTbpdKHXP20neTPW+q+DRjfhgMHBA3ChQHLpjcGV6Qj8VqdQeRwW2hma1YuxSP4VPEq0I2aZ8s6fhKnzpMFZbvBhSpX3cdZIF3czugdMDVBS27RKJKJj91txALDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579848; c=relaxed/simple;
	bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0EuJtXxsPmuB5hkfc+z2q32ZHIKhCiAERbos0JE+KA597jDXqzv6q0poCqobW4ZLgRhMPr2aaqyul/eUtsEEl2BgOhfgtntRjE1Zh2G+8dWL8LfaV+LrHSnAcqIlZN8uUdE5ekv4b/AIKiD5gyaQJDuVOYrptXNH0STwCfu2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Hv6VQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Hv6VQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9008CC4CEF7;
	Mon, 22 Sep 2025 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579848;
	bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g6Hv6VQQF5Tw2YrO4+7Etx/nZXHZrwW/Rqf1GjFzADuzGZkVFKTpMWwqLwRehU85q
	 IanoUVorrucpCh9TOgTynN1Ad/JpELKqgw4Cy2McOibw+hpLBD5U2HeYCdFdjFK2lE
	 Fu7wDElOjSKv7z0mPFBHKfKuWKjguK37wSsmFhbyHlYw4hF1JyfdiVDEAwRDgJIA35
	 Y5ZhddFfWcdTR2gLQbR9WkhKiyXv+PiOILi42yywDwZeaIHuxwmJkVbEWQs7szBIct
	 JFZ0l3gHr4OhLlezAA3NIozE8j1XUB9OzI9N94O27b3UPVpfNE+0Zc+K94u94twmMG
	 UbVLe3q2J8HnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 00:23:52 +0200
Subject: [PATCH mptcp-next 1/6] mptcp: pm: in-kernel: remove stale_loss_cnt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-1-60e3a8968f45@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunqlnyJp3sWbDqpuCO37c/sa3Z2vg2Yak05umZwkkT
 plyibFrSkcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmcCGcHEKwETcvzEyND/jiGTeHKsdv9h3
 p87rG+bOvy6u+WjuPLc2R49lVlZkFSPDJ3V1ay8+94IbF08Jbw93EZj4QurQLjuudeeCGk9MudL
 FAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is currently not used.

It was in fact never used since its introduction in commit ff5a0b421cb2
("mptcp: faster active backup recovery"). It was probably initially
added to struct pm_nl_pernet during the development of this commit,
before being added to struct mptcp_pernet in ctrl.c, but not removed
from the first place.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e84c381aa3a4e2ad8a05e4b0daa7a5e8daf2c35b..52ae6304b311189ab927857ab74a9ee44ac6d76a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -19,7 +19,6 @@ struct pm_nl_pernet {
 	spinlock_t		lock;
 	struct list_head	endp_list;
 	unsigned int		endpoints;
-	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
 	unsigned int		limit_add_addr_accepted;
@@ -1461,7 +1460,6 @@ static int __net_init pm_nl_init_net(struct net *net)
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
 	pernet->next_id = 1;
-	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at

-- 
2.51.0

