Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66A33FE06
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767940; cv=none; b=bbE1daY6207UOSI/VhRwi1AQhm0w9as3f7wh+f/Mh6f5D9fjS3DgYkQUnJYrzLvFkNEQQwM8HQGOpSJTwcSZamlmbWLerRW/gwe4vV61GUNmfjoorTFsGK/pEPR8Ap++KcSQUA43TDZ9k3SSceQcxMkJOeocZGJjVQksvzwuMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767940; c=relaxed/simple;
	bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQWnjxOdUnH5zVcbBGZ+RuJ3HlDNPqKlhEx8v99vumB1mHonLyZvg3Ctom6GP6u7yPKgzO6uSckdIvDBNzE+EiNSwQUwk1VWEp6OJvgsCdvam+t3fAjrb+sa8P0jbHRgOcNDA5ddwbTfaqw5u4kPEQUAbZu7DYAkN0uXgknTkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIABYap+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIABYap+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C1C19424;
	Thu,  9 Apr 2026 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767940;
	bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vIABYap+HeCAnt4TosBpLHsrUtceqOLYrdH9PaYzEmMCSpT+8p8jjo/ky8VSlAY6B
	 90Rt2H2sNNCbf6ZXVw7UIpfjg/Fw5XocnOtScXCa7oWWBBcaEdVvRxNFk2nmUMpf1d
	 KrHlaxMD2sBkg6ziCCTsxCgu2uQ1T1Uu5lPyA+WSHdMoDOs2qUb1jGmGLO9A+PYjPq
	 jVvJkaGKRD3pdLVBblqEx+6+hItnWKf+uzGJ1bWQ/BdacLl63Ye0lDHyL0d0nVihVY
	 pK2Au3o5K8JQj1SBf/63z9VlQMtIHgw+6ee5ZOSNnG4BRD+Pa9xY70NHUrW7kyc6dx
	 N3r76AWjRJyEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:50 +0200
Subject: [PATCH mptcp-next 10/16] mptcp: pm: in-kernel: increase all limits
 to 64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-10-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yCVlhkZB2Vnmh/ppIw20AhzLny2aWqDy/QYYGuPF5mQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCJa1brm2vkNrlVm1C3/T7omJGWoVvHv3bV1r/IPxt
 DjjqzWfO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyyISRYevCg08iz/Z4btrN
 79LC9e47q05tyemN3I8tJ8y23CZaMJnhf+Hppsk7DjxY4KJduOWVWOmRyUWln7Ivr7T4dvaLQ5a
 SCy8A
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

