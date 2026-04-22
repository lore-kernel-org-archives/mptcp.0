Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266E299929
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876043; cv=none; b=IBZBe+fVpM6XVMvZUBdBnkPRDjlqF/N0c+6ido2jqlTndVsBe0grcm+s/4rjhCG1iAPl2jAlb1R4wrkM9ZtguhCT2EcXm2dZJJhZUcT5MwoD2xoViJs1x0pvXYK2TjRxGLVXS46mlQJwBkrM52W4qCugVd4RoU4+3OH7EtWXwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876043; c=relaxed/simple;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4lIjbm+FAtMuQGIExrGrcZSVGCiJFiFF094DZg2+DCgvDKdmp2tp0AsWQgEwUeFr+vJ8hMC3GGxL65EHoACX+hJRhPCE91jEP5IRmD/yQPe94a0Mbl4s65G96Tw91jgj77Jtpb4CbKKTG2cEZOc027f60llDbfAslI/LzSeWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLFZK+Z0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLFZK+Z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD10C2BCB4;
	Wed, 22 Apr 2026 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876043;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DLFZK+Z0bsvnbkz7VtTyuo7ckttBNCEKcsq56gNVwecl7jVDnLcTMQbPywojiT/af
	 UGtEu4Bc5DcvFLJYH3CqCiURZXwWjoxK56yGUSV+H3XOdQi+3sdiuBIhc2DDa4crP5
	 QLqfUIDdupN+yY8gt2aFz4C1Whj0FSgEprl2gTY7lNBm3OkoQHxCsqFFrB2Y8bC4wR
	 CzsaSM2rpMrwGrNSuPW8vW1w/QCcjegdZWOp9DIMgM143hrXpd7TTY4WNdOh/9cZo6
	 ek7rA6BXZQyN1pSRF1TMyY2TQhuimuGMnDxW2tbmdgHbWq3/HF2yVCrSL36iGcTRZY
	 h2K4tAyLLkS1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:16 +0200
Subject: [PATCH mptcp-net v6 02/19] mptcp: pm: ADD_ADDR rtx: fix potential
 data-race
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-2-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/Pz9qoyzZ5/c8hMxZ4R+Trlt9j2lLe/Za/V00Zo9g
 VO3SR542VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRlcYM/0yEmowOMm6KY77S
 G/lVwZizQNaGsUVPr3/trZa5s2afUmb4HxGaIezXfe9pruzMRZbnbA4f4qqLe7ZFquRvK+tUVr9
 qbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fdadd0e8f77c..43a11b65235f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -340,6 +340,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -368,6 +375,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 

-- 
2.53.0

