Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF00322B8B
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247095; cv=none; b=CEnpdl1TWvQnPzQaSq/5I50gQJvi3kQh7sLRY2bCQCGSTueQuoA8loCWNj6TSGHBFcPhXhbA7lObofNlZm+rRAam0NwBjo8EQd/XptYnzkT3uIp4eBVlCIsNERacnCuXXuehrmuRK06SoGUAw9Dk/FCsI+vKo/YvPjfoq3njQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247095; c=relaxed/simple;
	bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9Ln4RaUQfJKg9T+kmJoUflOL0tX+0LcRMK61cpeuaEUEXOYcx4Ndsij+e8cSUE/WdGVDVfevMNSxTZm4NwNttYMkIElkxIKkgzVChNEJnXT7TKVUrFcs/YdNWJGXIyltRJESJqaZsgSu8IhFYETfhknjBu80cU/vc21TCdej8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAQU6Lhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAQU6Lhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64DCC19424;
	Wed, 15 Apr 2026 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247095;
	bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eAQU6LhbyrxBtXmIIr3TdKA902yMgbqyjYhffBdOjKE88qPPJvBGwK+pf2JsaLMKU
	 S8zcc9IH6Db1yTQq7SUyknqBczMhsAPOalnq3ex2wE4ZdGJ0Fx0O/iojnFneVK5jg+
	 wf05icqFFfT5CPmh7Yq5fjQujqdj50YKIx0IRaQTNxxuGddQByGYugyNLDS6Rwj5DC
	 pwMLeaKI2knu6SoAOA3hODfkRHH1I3LHvad61Hiiu8d2uidKhpBdGKWucTWc4gmKWU
	 HfkJT1RsT0BVlpmvzAVWQoL13Yr4hTYIvroI9Se2bRk3f90W26MODeUJKHvSHgmn8n
	 /QJ7qo4B2X1OA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:54 +0200
Subject: [PATCH mptcp-net v5 06/20] mptcp: pm: ADD_ADDR rtx: resched
 blocked ADD_ADDR quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-6-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lHgkh0RL7ozwznfonwI1qORd+8z2EfSEMnbedFbtXd8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ6q/3r1Z9o++5Qq5B3sNkl5zl/yJvyBXuPH1p6lxq
 vUVGmbVHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5s5fhn/7+k8FJNa7PC8Mf
 dgkHWMwV2JjgYJMnfapgRSDT8kOBHxkZrjG0XvBimPeg5867D2e+Rmglbpgx7d/aJ8dee73c3V3
 xmgEA
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

