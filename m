Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0F365A0F
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876046; cv=none; b=b16r9W9K73mpkTHB6e363E3SeQf2grTN4Q5i8gYayxn/p5x0SiDROyLR+J7KJSCsEqVfuHmOfuW9L+SNEAh6+ZYueWB3WGOrfoiZZW+ac7bD/Ai9fApRfGYiNk2ToI79aa2biYCpNdh+R+LlPMU+tUszVpWB005uRrmlIw/3aGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876046; c=relaxed/simple;
	bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTykUOY7EILX60JWIqtRFXRKNQynQL+SZCyukaq6Vc6z2L+aff1JdeQtn4s+ftH4lgUNF0oXIp8panGGHiRxIVMcwS9oEbsJerCP+jFqJXFROw1TOaj4GoKaIX+oktUgXPW+nc0VuB4KRAipXTybRFP5ryfFUKfuMnDBKnMBCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVaQMk9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVaQMk9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D9C2BCB2;
	Wed, 22 Apr 2026 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876046;
	bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVaQMk9tHZN42egnQOq+2EXHPnE8+GL0TJpbWeZf5DBSjMv9YInvGkfHnSidEyoKo
	 aDpJxzT4COo/WQMy6ALLPwb2qhe5g5C1ciZ8KYuNzQOfZeLmVSwrcS3Uhw5GoXua27
	 43zrHtFHuOkqIU9GBKNkWppjX7SJPAPduFXJrntzsvU9WDoVjbXoeuX8d0qr8O1o+x
	 Cub5afAf4sEim6ruh4ArPltZOj7xVJH+x1S41vKQwpwKahhNanLlTNdLrJXNrCLIb4
	 55f+Aq3QOHvLItlPUX1850vgO3GnoQJngT9TH1VB/WXnwPua+Ww5gV/LYsJVrf8g8E
	 g/cObhq8CiszQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:20 +0200
Subject: [PATCH mptcp-net v6 06/19] mptcp: pm: ADD_ADDR rtx: resched
 blocked ADD_ADDR quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-6-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/Py3dm37T3637q//5L1ltnakywQ4lLNPNb/JXRyx0
 zvMMSmpo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL7FjH8ZuWRfHI+7PVyE1/h
 pCoh0VRVB8nPnw3+JF3ZrTp9DlPQHEaGDXUOU3yllyVrPfKJ230qw0G3bRfTRtujq5RKGkN3Ljz
 FAwA=
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
 net/mptcp/pm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0ff35f49d451..bc5168831085 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -342,13 +342,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		timeout = TCP_RTO_MAX / 8;
-		goto out;
-	}
-
 	timeout = mptcp_adjust_add_addr_timeout(msk);
-	if (!timeout)
+	if (!timeout || mptcp_pm_should_add_signal_addr(msk))
 		goto out;
 
 	spin_lock_bh(&msk->pm.lock);

-- 
2.53.0

