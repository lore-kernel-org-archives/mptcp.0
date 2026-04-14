Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC9271A94
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173658; cv=none; b=YPp52gwOjHyLzUHowS//Kqzfkt9aRxt7/3B3h0vCZSPC37GPQzgPiUszo2n5Mauynt51yRDF2Q4TW5n7Hg6nXu8mvp6OMY880GF2hIGGI+TgieKOz5E/RrrCCrA+f6rdEyk3K6aquJPUKH571nQftesJikJgX6qZYNlJWQCVE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173658; c=relaxed/simple;
	bh=hsYD0jMLJGmnh+est9GL0ngNzWUhY9f3/6jRBWsnSWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/M5tUmv+Lg6SD4D1m1lBvhWlZDaNoszVoO5y4HNhbnv9yWsjjfoYy4WX8GQZokhHBbqJs7gcbzoASPi3L4t9lFA7k1GgwtvPPNNrijlvBmRY+5Pb6hTCzqiA7pRea360vJiY9iCwV3OlG3wnPWt9NnxRNyCpYQTqN259UyXwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbukaZe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbukaZe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1CDC2BCB0;
	Tue, 14 Apr 2026 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173657;
	bh=hsYD0jMLJGmnh+est9GL0ngNzWUhY9f3/6jRBWsnSWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RbukaZe9kHqbGGOxeDesS5V+0tEgmEdkDrKofvGQfvhpSHhmpMuehOMrOPemLk/mA
	 Z7oK1mVn99TXZ+8rEH7Rb1PrlL/YJkQxjRbXiqJkbiY0BLyHJjjTxWnJXsOaU96KYp
	 ZuryW0+yO5VruwASIbV7l2jDowh+FGBwDmuOofvE69tvw8Jkzq5IptE7D9/DaIg+kk
	 ttyIYEl/mMJGv8YFatr2ec+6od5fXrtwtoZNT/zIrc9ndQ6VUvHt/GsxLhKi05DHYs
	 iJmS5QYwFppGyEYZyRUYqIcJvVIbXtVin2CsX2UmEo9SP3h3Uf+nP6rjZmFPQgcxlU
	 R78hQnChQVoCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:01 +0200
Subject: [PATCH mptcp-net v4 08/20] mptcp: pm: retrans ADD_ADDR: return
 early if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-8-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hsYD0jMLJGmnh+est9GL0ngNzWUhY9f3/6jRBWsnSWM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOfnaX1Swe3gzeXr3ls2uHSppJZNOLPgUv/DLUputv
 junrzk0oaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAisdMYGX6sKIz+ecT7oPfb
 6cc7WlbO7eT7xV+u32DKdnf70mVillWMDIskm5acu/WxXuZRqaD09G2zvA6GPpXhvtS3UuHGqxd
 ty1gA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 89a9790e50bb..f32015d4fb87 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

