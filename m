Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573643164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499633; cv=none; b=VVy6lwzOJ8eLSRyNwOxWxFfqaCEF778uxonWATaC+6quITfNIUjs2JhZMlaULu1H4TleHslMn0aNtiY9YKWyJgrRP9gyAmuC6wT8Mc8y2v0+k9tc1gRJM2PO/GQ5LZhdrrCQbv61dFB0MaX/XY60Ok8plV5nW+gk061877a2vnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499633; c=relaxed/simple;
	bh=NmqdA92ojYh5FV5PJu2c0LhMQQi6VjAx5mCmW8JwJcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pz54/iINWF22OJftg1jVykNquncMY48eY3FvhXrazjwrRIGwfVGEgxl4OABTeJdL08ELua4fYt9TQinb0qiaWRnWgM8q8s9xkqN4l5H1lOOO5JiJylogc/rQJFpjC9HBkCJB8HoBHM7MRjBMiu1IG7e0tgMc1M2u7+50ZhbCZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD8v5GdC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD8v5GdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEC0C4CEF6;
	Fri, 29 Aug 2025 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499632;
	bh=NmqdA92ojYh5FV5PJu2c0LhMQQi6VjAx5mCmW8JwJcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eD8v5GdCCtg+Z8IDfrS8G9oNUq0MrusIDnNnXOF9RKoahBdaVmRDJpJuUw/elGq1V
	 LrPclcsN+wGdK4xonHkQTuyhWFlreXr/6eD+AN21OVvLK9ri2r9p6Hhs05v/oXlEcP
	 wDWcpWw9H+z2SwTwOOstEgTnDmkG6qEBDmtTxefAxeBUJqdy3FGC/9/l31rMC8vc8g
	 KQJAd2qh/w2xctN6lc0ezay+9KXx4zAkj6huLM/2Usya9zuEadHZJu4+3RXmxnTcwY
	 dmyw+Vm09rRXyE2kUEaSfL0EbzCwm7sYWuPtUrmNL70fI4es1PtGg/dXbLo7N2H0V5
	 Pi5HGhva0wEIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:35 +0200
Subject: [PATCH mptcp-net 3/7] mptcp: tfo: record 'deny join id0' info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-3-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NmqdA92ojYh5FV5PJu2c0LhMQQi6VjAx5mCmW8JwJcI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a3cKtppcefp/aALMl98+3pnHtAVYDmtWdQimhkrl
 yPh+NK5o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKlXxgZeng+hDDWfHzx7V6O
 SILqMbGaZBmZyplMq38FXs5bMkPVjJGha8+699qiq//kWukzHu++2ZT6a2Fw5IR7FRwhhT/7pvp
 zAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When TFO is used, the check to see if the 'C' flag (deny join id0) was
set was bypassed.

This flag can be set when TFO is used, so the check should also be done
when TFO is used.

Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for passive fastopen")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1..cf531f2d815cdfbc772b837def6e7d558e64d558 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -985,14 +985,14 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
-	if (mp_opt->deny_join_id0)
-		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
-
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for MPTCP export */
 		WARN_ONCE(1, "bogus mpc option on established client sk");
 
 set_fully_established:
+	if (mp_opt->deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
+
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);

-- 
2.50.1

