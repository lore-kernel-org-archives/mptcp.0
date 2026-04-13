Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75163D7D89
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089532; cv=none; b=nrfXKc+EhbRgLXrao3KHMpanLnTzn2G4M8R3n2MpBzl3aXOSrFq8bPD0EYGWE165RgapDiyFMGNNkpb2OSIkm2I1D7jKEH4qqDUYSsD7/Y4JpuaZ1tCTcijyS7DuU/ORv39oAUG9h7vhSNCSzYbUN0QlgUAlmyQERNsEl95wpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089532; c=relaxed/simple;
	bh=AeOXLUm6c8s934bcIBSU09kA/aUUlDw90GGi3QnQaLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8Zw59gxtJbYczaLD8NJqSUuHcRZL+0xEIqiVvRyUjHdbmVfUWLwmzSSKxwW5ujMUMU96JiKt6ljKeUnCJQTk4lDvkTUbNQTjPSdO1TxVcxkHo1F46bIFvgax+JGvUina7DSxDu0UEPzyfuxeFygu+OopTJWPETTgoLVHJzTAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPjJFTBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPjJFTBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC3C2BCAF;
	Mon, 13 Apr 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089531;
	bh=AeOXLUm6c8s934bcIBSU09kA/aUUlDw90GGi3QnQaLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MPjJFTBD3VgbwZ2cCZsmtTDOUECBTYFDoNboz+2rm4HGF5wYOk3YtmIg3/LYyAq2c
	 O1G82dBnkklqGwvWifYK0noOznKtLfnIEy0ziwOs29KH/TYbGEDHN1Krb8MtN1FDkt
	 +7RrDmAJMdQBGZW/4UsOe36sw4PD64MJSok43+itveqDozaB7KzgbeguwaO9OVTY5U
	 Kl6Am2A01LG+jPntUES8ltQ/8lOzr76C6y8csVFjbTGQ3/WfuEfmk8A9Q2DzElsT8W
	 ZNheFCeI09Ur+ErBjkJkZeYKXRWw8uzrTuRDY1Nbii45KM/IwjV1/jmjpg+7LEr6rM
	 eYJd8/Dvu+4og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:53 +0200
Subject: [PATCH mptcp-net v3 07/19] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-7-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AeOXLUm6c8s934bcIBSU09kA/aUUlDw90GGi3QnQaLw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/FxjWe+6Pu3uiZfN91iuOW8Uypy2bduCsDuXBCWaq
 xwbZ0Ts7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIhzZGhrNuU+Y/3jDfgDtw
 qbe49uf1Me77nl/cbvCzKObFpDweTXdGhvehvKW/Ha6pSq4Ie3Th6dO5Hw5uv9238ETPre4FgaJ
 dCtwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the maximum RTO amongst the subflows, inactive subflows
were taken into account: that includes stale ones, and the initial one
if it has been already been closed.

Unusable subflows are now simply skipped. Stale ones are used as an
alternative: if there are only stale ones, to take their maximum RTO and
avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
to 2 minutes by default.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: restore accidentally deleted icsk->icsk_rto > max check
---
 net/mptcp/pm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0830a4d2029e..e2d62131023c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -306,20 +306,27 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else if (icsk->icsk_rto > max) {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return max < rto ? max : rto;
 
-	return rto;
+	return max_stale && max_stale < rto ? max_stale : rto;
 }
 
 static void mptcp_pm_add_timer(struct timer_list *timer)

-- 
2.53.0

