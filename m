Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B983939C2
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173661; cv=none; b=aNjhvuUnsBJo7Zr/KaD/dnl8/AuU1vLY0U04EoEIVDcyY4JdLOzaAZE97qsenOvnOd+pGT4WFSyRt9S6g2IaFwGWe/Xr/pWYEezyNlr8aMdT65KKQAEkXcjCJzlJaqozFQiaBxOY5vhda2T2PzHfy2HKlxWtzZVh1H23dxieZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173661; c=relaxed/simple;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0hDRFv0Bc49O712jWzTRzTXcGTRZd6tchlFi1KFt9Uc95r7vImZNKPNfyXG9rWb5b1di5M4d0XuGLMKtYbMnWye+KDO3LKxcZ56akvqC4j9su30qOHPBhwKN/budg2sUwtr2mattw046qDaMiGRK8o7f9VKlDMEEXfkgIGiVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqVAZjx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqVAZjx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D07C2BCB7;
	Tue, 14 Apr 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173661;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LqVAZjx+P4/MaqvCBiK9YQp9QHvWxzBlrHg5ExnAJrtDQke6oopyQD17X6TJRcp5a
	 IVPqIrJ2HBOqi7M3ZWL8VAyCfe+aFXvwZ4f2w3rGpDfGlN8eRvuoq9n+glj5lJFgir
	 VKOCyaeGMoH10HyzoISWQvdwjPDJZLwtXmZxFX1b0utMAiPUypv2AEjdJLJBXQDp9G
	 vt7idcLuDMcAYgRWVk0Bz4lpbBNiiHyJFtj5QC5a+Tcb1SIvif0MJWyZAhkysPCqKO
	 hp3rgh4t5mmqSUi/Mb5mQrYDQcN/lVV6k+jEQ668/abKfEFJk+BXU2na9gLOYfOw/H
	 PvkiuxAnEPljA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:06 +0200
Subject: [PATCH mptcp-net v4 13/20] mptcp: pm: in-kernel: increase all
 limits to 64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-13-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOflLtGfWl20VX3b55l+h1wWnbfNW9JxPMl3D8MbB6
 5rp+0f7O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiycTI8JiZ44l6G89ay9Bz
 fWXieQ9vXvm35sd1zzbWE9ylfCu7wxgZHoivXvNALspwnvzr266RwteOXA46dXxWiyVLn/zDGOX
 lbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This means switching the maximum from 8 to 64 for the number of subflows
and accepted ADD_ADDR.

The previous limit of 8 subflows makes sense in most cases. Using more
subflows will very likely *not* improve the situation, and could even
decrease the performances. But there are no technical limitations nor
performance impact to raise this limit, so let's do it: this will allow
people with very specific use-cases, and researchers to easily create
more subflows, and measure the performance impact by themselves.

The theoretical limit is 255 -- the ID is written in a u8 on the wire --
but 64 is more than enough. With so many subflows, it will be costly to
iterate over all of them when operations are done in bottom half.

Note that the in-kernel PM will continue to create subflows in reply to
ADD_ADDR with a single batch of maximum 8 subflows. Same when adding new
"subflow" endpoints with the fullmesh flag. Increasing those batch
limits would have a memory impact, and it looks fine not to cover these
cases with larger batches for the moment. If more is needed later, the
position of the last subflow from the list could be remembered, and the
list iteration could continue later.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/434
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index a678b1c33f56..f163d40e7375 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -30,6 +30,7 @@ struct pm_nl_pernet {
 };
 
 #define MPTCP_PM_ADDR_MAX	8
+#define MPTCP_PM_SUBFLOWS_MAX	64
 
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
@@ -1381,10 +1382,10 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 		return 0;
 
 	*limit = nla_get_u32(attr);
-	if (*limit > MPTCP_PM_ADDR_MAX) {
+	if (*limit > MPTCP_PM_SUBFLOWS_MAX) {
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
 					"limit greater than maximum (%u)",
-					MPTCP_PM_ADDR_MAX);
+					MPTCP_PM_SUBFLOWS_MAX);
 		return -EINVAL;
 	}
 	return 0;

-- 
2.53.0

