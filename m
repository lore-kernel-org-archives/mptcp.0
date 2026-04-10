Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA030FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831530; cv=none; b=sP37hi7cU1gtA8HKTm0yBeXlO1Rhudob24GruY3wHGwo/VOClO333RXl7PeAeCSxNi9UFCv/sz87qBNq/VrvdsyWqwkumuNvSf8XMJYZvizSS+3ueea7eaDFDtDfmLahoEgqrySCAMAJzwP/hFM04H60gHyRCq6sZ2J3qCchKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831530; c=relaxed/simple;
	bh=jKWSTZKsuq/t6qoORPiArINB841k2CnSuCo9eJPMRDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDsXVOg35pXNLmMqXaSARREAaGDtuyT6CqZnY2XOMck8qJbcq9IORVOQnjNbWoP6r6SyCbFuWoiRCAPuLpEOsiCF9v6EfEk8E3ODErODV/CTeFCJ74UyoomdDVhNc4XYXqfqu2O8vtKDkd8MrlKEIYMZxRB9AHUw2O6ROu2jeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mknll7xf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mknll7xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505EAC2BC9E;
	Fri, 10 Apr 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831530;
	bh=jKWSTZKsuq/t6qoORPiArINB841k2CnSuCo9eJPMRDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mknll7xfLpK5cyYPFe+1DqMlp7ruFfzakXEwzXDVS7NOwyntcXCaZc/eef4kMa8Uj
	 29YLRztS5DDZOLQZEIN3VH9wUoEtepYRjFKcXImtgAhQlZI7n8yOq5OEpU8pjLvdA1
	 10o32zByl17KzcYf5Y6eL6EKwKxhXDI/nh4IHZEsVYELq5g8cO1gwq1+N6owIeDYp0
	 /vQ+8EFOj4uwegIuB14U4ll0wDfG8uBN1VV/osJouzwZepUrBHI95t3RrcuPEYiLay
	 mrBq2Kvp0vIB4vE+BFryZdvO70fL7npft/sosPcyV9yGYLRHQ8PLnt73MTXc80T9Zo
	 afP0dgreD9vuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:43 +0200
Subject: [PATCH mptcp-next v2 05/17] mptcp: pm: ADD_ADDR rtx: resched
 blocked ADD_ADDR quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-5-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jKWSTZKsuq/t6qoORPiArINB841k2CnSuCo9eJPMRDY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct5uXjDx2dldu5v/8h67JcfhPrniTWbAmS3vg3fPF
 Xqw5d8+7o5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJTPVjZOhtOlYZG7eMfc+V
 B0YvjVnl72et8ot24XnyhOv7WUM1zleMDBu231ssY2kl8dt2x3f9eW29devPXz4+yWgi+9Tb5h2
 sEfwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR needs to be retransmitted and another one has already
been prepared -- e.g. multiple ADD_ADDRs have been sent in a row and
need to be retransmitted later -- this additional retransmission will
need to wait.

In this case, the timer was reset to TCP_RTO_MAX / 8, which is ~15
seconds. This delay is unnecessary long: it should just be rescheduled
at the next opportunity, e.g. after the retransmission timeout.

Without this modification, some issues can be seen from time to time in
the selftests when multiple ADD_ADDRs are sent, and the host takes time
to process them, e.g. the "signal addresses, ADD_ADDR timeout" MPTCP
Join selftest, especially with a debug kernel config.

Note that on older kernels, 'timeout' is not available. It should be
enough to replace it by one second (HZ).

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cb709c1edf81..f296fa300efc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -341,15 +341,15 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
-		goto out;
-	}
-
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)
 		goto out;
 
+	if (mptcp_pm_should_add_signal_addr(msk)) {
+		sk_reset_timer(sk, timer, jiffies + timeout);
+		goto out;
+	}
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {

-- 
2.53.0

