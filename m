Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77145358381;
	Thu, 21 May 2026 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334130; cv=none; b=ZVT+RLpdvxwN0kmcVgyvOb1OYwEmsmYzR+zgw2tX06fXBfSa4fLMTExhuBNZ/arfrdtk0ulfpxt6d7eRyN2hPpgvSB8k/91scQjTywvYI7X8vwXAaNrsxBSGlFMXfraA2EJVFRz9doQebpFsNRMNXYFBO4/qjavTfdqmdFT+jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334130; c=relaxed/simple;
	bh=dedVbwFEs6+83NrjuCtR/O9WvWYy5d0Fs9aM3EiTf1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrRYkuuRpwp3sz5z6Vw4AsvBI+7A0J/n71tl/3xVo3nDAWGJTwBF+lUd8ZnOC0TdTHv2eJOAWgi7aHy7ovihfdvgUnlUx6zBxbcI3MYzX3ecui3VS/95fAIvj875Y187+nOpdXcKBYGbNlwcfIBg2sh088Kx/LziCDsYB/TbYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQiC+2xR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQiC+2xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7251F00A3B;
	Thu, 21 May 2026 03:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779334129;
	bh=6tpKhbl7/XP4g0sNUV4dMb7sk1SW+jcxNTcYkt/07i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQiC+2xRgk40ytP2JM/ufg2/GN1+jRLHhiNJ0KyLhzI0hKTC0lYeqCyc8ubfcy7CS
	 FDEOElKmZeNVxO/vI+Mwk+t8Wfs9Ao122+bfCmKRp/yL6C5zPN4KDu0xDasqjIZoPB
	 eDhXFG1jF5XjitYDkA3xmdubIFaT8RluoOwnztZGj6CRvaunOlaSGQMv0sYVikcoQN
	 /JajP5KHNXpEI7mIyYrK2d+u9iThQjbcvQlXheWVxcqGmChP4CDaTF1GF6pArW07s+
	 gIJlI1w7Mbo9HlrnOO+z46IAqO9rtJWndxs9tLCNx15yPp5Tok9vcrPPVLrx7rFDCJ
	 FLVfdZgzDbmsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/4] mptcp: pm: ADD_ADDR rtx: allow ID 0
Date: Thu, 21 May 2026 05:19:09 +0200
Message-ID: <20260521031906.740857-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521031906.740857-6-matttbe@kernel.org>
References: <20260521031906.740857-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=matttbe@kernel.org; h=from:subject; bh=dedVbwFEs6+83NrjuCtR/O9WvWYy5d0Fs9aM3EiTf1A=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4Kk9c8Re54bn2muGVlNA/Xpwl7s3P/FvVf/ktir129 F/WXf2sjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm8+8TI0KPN//T1I4lJq4Vn /r9sWRzy+lbiwqJ/q+s+pofl+i/TZ2L4p9uqv+bMomfVscXihTG6uUfWsTOfecObtqgzvDXf+3w eDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 03f324f3f1f7619a47b9c91282cb12775ab0a2f1 upstream.

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-2-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied to net/mptcp/pm_netlink.c instead of upstream's pm_kernel.c ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4a5802126c8e..23aef214f30d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -305,9 +305,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-- 
2.53.0

