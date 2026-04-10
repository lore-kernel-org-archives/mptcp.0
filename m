Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224630FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831535; cv=none; b=orrtPQMloK6X4YFpi2mJYFAq9h63KXgCukdxvSiO31twEJprKuggQ9ZPT1Bory3ShdIDQXl4BPSalIwnybCweZPhd3xXqi5sAV3Yhlgd+ZG6wod0PgtXm3OkvKOTUGCFLp3CpSuUuZmKA0Jmc91wIrT6NY6Z7Ysu0/CuUqmchYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831535; c=relaxed/simple;
	bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugGrdBRKOCn8PQGctO46j9H0LsccBlZO0bg7KG9UgAfEMEnnnjal6Q1RK1tm45fpn1X4sy4PzkJi+3Nedss7Dy7VpUB1Gjmh0R6zRQF9eBhxclyFxfVNPbH5AQrxusx8dQhIhLdnH/1ulGJijkAntZVD/Enu87DvD2Nl4rrW1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apSf5mI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apSf5mI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C77C2BCB1;
	Fri, 10 Apr 2026 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831535;
	bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=apSf5mI6d+I2N9hMLnxXDEX/2GG76fXR2Io0WzUPx+UFVcBfzXZxglV2GJ+dhqMMa
	 ZNFN5sIq9RN2JKO37AlTOFD7bGSBK47RJyp4PJdsr2gOSFRd46xGKJcZMU4MZtyoSk
	 kdNRzNKpaWjD1nMoGbVJGP8aXWBIuEIqDt6EXAol31G6M2In/5XXNz+JR1blW27juo
	 PDqqysrlYiAkl9diPfXb3Qcvtu/6UZmpplHy8h+kqsTerEusj+9h/Ep0PqAGYplleZ
	 2/rXN3asSYRvfIp08u//wNNzAyepZ4YOcVQR8vCM1svtP4RY64wjJkUoFoStprmtIn
	 83EgaSpyoPdKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:49 +0200
Subject: [PATCH mptcp-next v2 11/17] mptcp: pm: in-kernel: increase all
 limits to 64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-11-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcj7cWNb7aCtjv1jXV6Ed19veSj2et37fbu+gF+/P/
 XFc7DXtVUcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEvN8zMjy/3vPj+dndE5gf
 b1l2/Njbjniz6Z8dtRU8j8Wvk+veXxjP8D9hwQ2vP0b+NzY5HEx3L/b/2uWfKzQ/PInnta1tgU2
 DIQ8A
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
ADD_ADDR by batch of maximum 8 subflows. Same when adding new "subflow"
endpoints with the fullmesh flag. Increasing those batch limits would
have a memory impact.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/434
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e9102c0f92f4..685bf2b9f9c2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -30,6 +30,7 @@ struct pm_nl_pernet {
 };
 
 #define MPTCP_PM_ADDR_MAX	8
+#define MPTCP_PM_SUBFLOWS_MAX	64
 
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
@@ -1378,10 +1379,10 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
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

