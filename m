Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8F320CD3
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767933; cv=none; b=ax6ComVHiuGEYC8CYyOtyr+bIwUmBzM6NmL4GWun6XSyxxtuDh1EXi+p2On6ymRwk+mTPxpw2xv+elq1nW845LkdXU6RAbDpiO6bXpiFHlLbfH9XbYPpiMagy8kLOHXRGcxFos9GVhafriOcyBugsYlwiCCfIHLOYiHXDgKOEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767933; c=relaxed/simple;
	bh=YyAzqPO4L4bAGDJnsHPD5sHlxlUcpaXTzz3DnuDzZWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAaQMYIC9uUagKnrlDmNnK25J0KNOl2/hXmX2dR9zZe3h0kVas4lCUeopR2xYzdOm3dek+rW5Uc3cBmh6zfKY3vWDBdXBOw2AK/DbrSrzXKMIqLFOFdGbK20q96SYOkqyXa0MZnEgDsgVVunXAotQP4Z3P36G7+Wavd2zFA7hYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbcR+8XP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbcR+8XP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5621C2BCAF;
	Thu,  9 Apr 2026 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767933;
	bh=YyAzqPO4L4bAGDJnsHPD5sHlxlUcpaXTzz3DnuDzZWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WbcR+8XPx0TbfhKeCrQxmseS5zphfV1H32uaCTGhJbn8a7C6j+V8Z+X5S4HuJSy7i
	 iqq89hDrj5GeSho2Ag0Yw/eQuIU6Rt+gN6pKRqtDVRXXzAUYaqk6piPJhLPJ9tOYOr
	 mGTkNSMlNu8GWsuZqbFXyKMFxWPtrr/YkwRc61tRGowaBTupblFNu5qZ7T5cqZFVEh
	 DKK2l9DyJlK1NCGpUn1Qo7j1/3/ceItYtvy4UyeCz8XBKnn7VxmEZG8WjUDfQP+6Hn
	 E5MrHHJtHjv1d8G0pdPHl4PEPnszB+UgxNjOOXiRiTe/ihuj8PhKacihfkgDWuZyqU
	 GDRa2DXUEGzVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:41 +0200
Subject: [PATCH mptcp-next 01/16] mptcp: pm: resched blocked ADD_ADDR
 quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-1-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YyAzqPO4L4bAGDJnsHPD5sHlxlUcpaXTzz3DnuDzZWM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCOaX1FUyFbin/L0zIyNPxnzfpxXrVGZuSA6d9odzq
 h7Pc2f9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl0uDEyPLnEvq+zyt7yutBZ
 hq93//58b/fl2oOtonn31bpW/jnhuZfhf/zCz4rc13R/NF///r3yrveELouLGVtS5TLl5jDYF27
 4ygQA
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
index fdadd0e8f77c..7d439d49c3af 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -340,15 +340,15 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
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

