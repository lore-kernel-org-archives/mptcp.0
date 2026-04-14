Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714E2C21C7
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173656; cv=none; b=AsMDpzsTR5ary9mdZPZ0JXp5UH98MqlLW31qoPKkTEjCZUlVQ9g4OdYrXQgCpwQLK95zNvWs3k0QzjsCBRCM47Sq9grSaciEmnGnh7042DyCyyiPmIx761As3DK8M2/i4grNy8rDsDJzgPHbF0QK1BR2Hti/KK31gN0mbZTGbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173656; c=relaxed/simple;
	bh=L6POWmFKgcQjWjV+YPFwktx+/aPgcYJ8oOYMNleizKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU+jPws+5CC4r1jd0Mj0cmBIgZhwsTyiLWLB2u9h5CaroxXsXJDKCdT5WVDXUijk7QDakJYDE4eBNkD9UKIT4ruPr9mEw9tgeTKMDxOnavfeJA8St2Lmur20tjeQPxkLZbku3duh0mzJj4BEHCEZON/PErqGns4D3HpHRkdNnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY97o1Cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY97o1Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A75C2BCB5;
	Tue, 14 Apr 2026 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173656;
	bh=L6POWmFKgcQjWjV+YPFwktx+/aPgcYJ8oOYMNleizKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pY97o1CcMynHv3roJivee+P+Dv/g8EoJQvQ1HPpMhSm3BWhhoAnQTrkzmpYrc74O7
	 bWjpjOir8Z4d0ZOhkkKgVOgT3sfi+SCudhIMB9lG+Sn4Y+tGeP5xNQHNxMM8CVnfDZ
	 27onRPcQVACG4qEGSvTZYU6KV13mvrYzjzm9hEK33ZJSyOfBu81XD8oI7Jo/j91uy3
	 VLvXEKR7uKuez8z6LLVj85gMVIeK8weEsSpN7NgByEhns0RrFu7dbuGAmuEO3miwQx
	 1S8KNwEtgO3dtZdoH/lj94JQ+JgyuDrx7H+2y6clvGrTW62HxMf817B/VnE9iFgVH3
	 AfjyE52ZgcgJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:59 +0200
Subject: [PATCH mptcp-net v4 06/20] mptcp: pm: ADD_ADDR rtx: resched
 blocked ADD_ADDR quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-6-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L6POWmFKgcQjWjV+YPFwktx+/aPgcYJ8oOYMNleizKg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOfmEf+SI8xTVnP5xMnPMaqMbnN8P528JS5gt3uK7P
 rG1a/qejlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlUtTIyfOL7xFSozy1d2pr/
 78yh+1Wct87MNDpuem/ZA5+5oXyCggz/VFd2VcTwy+5PPSO1xW3dYb5jJ34YGmqXuBnvkxDZ9ug
 WLwA=
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
index e477f6a7a740..4ea896c83b38 100644
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

