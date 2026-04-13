Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7703D75C5
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089535; cv=none; b=p9MTQoQnDW/nNasPBHA9krWoJXMRdSQTxWJm18ZO5cO+ItupV7Kv7cjPc8VdxLsnyfB9YDDgwLuazYfbghDSrvkfO6kdQXYazGa3equwNZfe6u/fAYb4gBDc/ajPq6tv77+/PQ9No/jOrdHDkHY3O0bUdCNlAmOizYnN8M42poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089535; c=relaxed/simple;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsH7fpLTbomOxn5ap1jTdaAatW7MKc0gtpSlVFT/a1bbGVVaOS/iNiQsEvxTTrZywzVjTZWINo1Cgnf6pHpBhnFdOmJzBX8o8gGCFDGUkYO/6FCcaw7VqaI+7n53e1vl6KNlTVMEbzbYcGb5Gnrivsac+e0w5lXh5mrKdqjzhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vczmbyk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vczmbyk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406DFC2BCAF;
	Mon, 13 Apr 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089535;
	bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vczmbyk19VtJO/cXqVwQyFG0mSrRtZYsnkiTD8dFhK4ecpSNYZWf6eE+8yT5rFVTk
	 8tpKEBU2Jfg2gjbM4ncB4zmlnQ1WSCPrgQ4xI3i6Q8uscDP2BywjwWKen4t4ZlBEat
	 mxk0iN7yfiNzeCvuhviEXVgUabtAQJN1uB5vfpedLRgFC7h6QLezdvdBHbxpGJuEKd
	 3zOn5IruLHgdRSazrMVjwNPZa2meNBBm1OxqLq82EyHa7o8Qbw/E1kT+EH2hcyWwda
	 nVZyuJdnxUX/stRKdNtEeukzHJ/KorZB/YaI8lRD526JrK0BAOlnV3WhXQNeX2xJjM
	 SyeRceOwPpYEQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:58 +0200
Subject: [PATCH mptcp-net v3 12/19] mptcp: pm: in-kernel: increase all
 limits to 64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-12-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=geg3i+AZ83UdjmswHRjfvGyLJA3VdBH2mrx+q6p2fj4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Nzg8/DDu3DtzWukDwifuNDdbrHvmeiMk/suruNz4
 gq4MuXz/45SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJ6PYzMpyvOPIt6LUv943s
 K/u2pmk9kljFekH96LsrzMnvPrYLGjgz/LNcVJ3677pf8KvfAkHLTj7jFzp6ZMWjBK5FIp9K+VL
 avzEDAA==
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

