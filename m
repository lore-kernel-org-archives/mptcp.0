Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315533E34C
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247101; cv=none; b=Nwq7Pe7ql0hravtKfLoOiXeLa85fpusrsV6kVzwBXpOCb070PUuFRjihym+48EwyvuXHuZ5BV7cOPGh5WJeyzrlbQHS1YE7PHuft9tzohK2IKOTwO0GayNqT1jDieYJFhSa6dmuDKeydn2PvwQB9uf+p5yD8ZsIE5nXqmQokQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247101; c=relaxed/simple;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTjN5R/wVsHZoTsg553pUx8acAMOxywL+kaZBdNKPgToSfUVdVTP0qB27gD3erf0JrjM3hKlGFpxnuFlcng97YBFIEAKb/ZYAvH1gu03cv7dKaNRlHRDMAJ1b+/4fSp6yn+vhCbUEXx2vZC/s2o3mEF8C2tMmw0z1p6+eix3xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYQVlKYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYQVlKYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A502C2BCB4;
	Wed, 15 Apr 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247100;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tYQVlKYHSydHO6ROEcMUGDb9foPjDfnFBuWn1P9Jx/DZDBHmtusP+Ppa0hMwoJ9BM
	 UHpA2LwfwUyohSUOvGDq87XLWfWi1ZWlG9EScB5g30t0yScsFWBCmaAAvD7oYzLrFq
	 o0TamkEMqqOyv2W7ZkMSJIDWPAnn5plDg4ZYH4k6bVeSHrhQLfYc4pF9xlEfaBmqAz
	 plxk+rUZxakiEwD6mZ7ZYzQ9CarRfh7KO2qmbX0lj6iXw6Y4FjQI4zBUe0VERalifr
	 IOLIKqyURac4h4RuqLJWhvZvlsKCK0g/+cz+NIrZltBXwNy9PvQ7LVbjontUXkCBLv
	 gkFMkYBgN6KvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:01 +0200
Subject: [PATCH mptcp-net v5 13/20] mptcp: pm: in-kernel: increase all
 limits to 64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-13-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ+pUSLqFS1slOByzdgycKmkaX/1Z+NX/yx82iBR0t
 W9s/1DVUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJH8Job/SZKmrMdyV51det+q
 3yJmsb5HtnnfjSzhLWFu3h1+c4sUGP6H9831UPy6+6+5/oW1yY2fqhczz1ss7ebFFP947j1mVWZ
 WAA==
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

