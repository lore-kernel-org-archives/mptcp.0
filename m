Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B5421F00;
	Mon, 27 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319694; cv=none; b=DJHd4StlDVQQO6//W9Nmx5EeuDSoeDw40C3dPD0y9K9lHfb36OWFRsqYUV3l2t05uZwG8aV82mgzOffLkVl53FrEpi55sFmEcnww4xpoW6+B/pkmr7ubUtU3eUcU5+ZeGfzWbwHs2zK35DUJzkp+RGJvHA8hz9dxnqPPX3FXuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319694; c=relaxed/simple;
	bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdSLmEIN81Lxi1UOubMdP3g0pEPjN/cFWrUy5F/9ukU0ffQPlJKgergz4649a0/L6zXguBUte3Lz7e7jzP3rDUtMF1Ii0SHxS7kBt8wX7e4dP2tq5MqMZqCvqwObpMZ5GCidE9TH/mYg929ztGrG1mjyG77QVzlr+WTsLG98Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phhMefp/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phhMefp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413EC2BCB7;
	Mon, 27 Apr 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319694;
	bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=phhMefp/bubG1wz7S69WSbqk2q9hthM4+xhqV8oyp/3VIXb+nsgE4CTpfO8I5nP01
	 YIAAIdWDfhSOeimUtGYHSQxDGKNl+efO60p/rDmDix2mFad5uAohHZlbQqrZdqgpq+
	 viiKxt8okhLVdGsthpCpBdoNy0XtePLbYQSmRbDRzEwKBphgPDoqKh+FDXw7AQYpU+
	 WJdwXsi+ESkkfcBZnhlmX/Q3k9Dw6EIy4Jksdr2+6Rvn9HrFAbUA6dBNWgj6E8Qwzl
	 qTbH9Ly2kysB5U3IiD/C+dtrA7/lZ7qsfnNzeKqvPeO6c5B+HHux308408BlGcDciP
	 Z3yuEivMMHWDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Apr 2026 21:54:36 +0200
Subject: [PATCH net 4/4] mptcp: pm: kernel: reset fullmesh counter after
 flush
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-4-7432b7f279fa@kernel.org>
References: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
In-Reply-To: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=przPaxcMyBQzUmg2GX2M3OT2M/7tS8ONkDW/LqeDsoE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLf72fgsAvJVZ6SxHpSN1d0RQ6vm0/JW54d66pP/jqg4
 S4vu/5xRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEREvjEybD1hnKrt+kp5v+e/
 jHcNRl9qFy0XNo5Je2jzsrd/tmzvBIZ/OjVrlLYEyDF4vVFxX3Bjq4LK56j8gviXEla/lZ78Wru
 PFQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This variable counts how many MPTCP endpoints have a 'fullmesh' flag
set. After having flushed all MPTCP endpoints, it is then needed to
reset this counter.

Without this reset, this counter exposed to the userspace is wrong, but
also non-fullmesh endpoints added after the flush will not be taken into
account to create subflows in reaction to ADD_ADDRs.

Fixes: f88191c7f361 ("mptcp: pm: in-kernel: record fullmesh endp nb")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260422-mptcp-inc-limits-v6-0-903181771530%40kernel.org?part=15
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0ebf43be9939..c9f1e5af3cd3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1278,6 +1278,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	WRITE_ONCE(pernet->endp_laminar_max, 0);
+	WRITE_ONCE(pernet->endp_fullmesh_max, 0);
 	pernet->endpoints = 0;
 }
 

-- 
2.53.0

