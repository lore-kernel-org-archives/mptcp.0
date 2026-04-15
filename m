Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2833C536
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247096; cv=none; b=RF365jmrXeZTz8DQe/fFPVIyCsHp7T+9phDvu/Y36MprbYtD/tpu0uXeuf9bBu6/QATbt5ArCiI1vphwh+PqMc7EJCstp0i8Fp3Pa/WrQ+mY+06dCKzXko+bKhfWQPYCRzJmeh8lwftRVJm5T+rq1+/1b+ZuXyc2jqvg5drgEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247096; c=relaxed/simple;
	bh=Jzmk3liXGy9iPs++/Ns7j86iSPD8fR2e3vNAPGblgfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cy6KbYJYS/MTeq/Au7PgIEetqLo8Ur1dmdEG+k4sci29zUnOTIosUdempwIh5w/saA/udSjyMjW+m17huEm63ZvtkAcYHNT/qiuMf25HCz9NRSv4I2EbQ2CNB7Kzpwa4nYzqe16VK9Y5K4sFfU3o3HAtANrnzLoMyf3SB+0KkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN7vQ+fo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN7vQ+fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1C7C2BCB6;
	Wed, 15 Apr 2026 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247096;
	bh=Jzmk3liXGy9iPs++/Ns7j86iSPD8fR2e3vNAPGblgfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hN7vQ+foNxuChjC0U/bR1qxjDCriFJTmZBof4FQ6VmDmMYWVfa2yCExyKd/lUIhKG
	 egq9ahsRWw3yGCSswrlehBQQkN5+k4mZpLwbFemBpb8/WdHuqPYgKM8gbsNP1iit7o
	 cWc32oRO7fkQahZLr/JosWQurAnCbeqJ7QY+cShZeWoUulRhWP0nt2x19SBEFXxd3M
	 n6xMB+6FQJ8O9TcLfjq0+LYScsodxhfCcG9b86u+/byz963NA7MlDDt18vIGFiKZvT
	 KCDwWL5GHSxVIsSkMMPKGhNseRgkOQLUMUvNHOrHQ/RXIcUFNE/3EDWtt3gZsw76ho
	 LMuefeT8wePag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:55 +0200
Subject: [PATCH mptcp-net v5 07/20] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-7-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Jzmk3liXGy9iPs++/Ns7j86iSPD8fR2e3vNAPGblgfM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ2oUbQp/Mi+nQ2wZW8w2gZfvmZomrM7hFZ7j6fvkw
 s9P1TuYO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYy5yzDP9WNJ1sb/gfcN4nO
 KDmzo8NpZZF95fqpy7QtmT42L/V9KcXIMLFg+fnIX9vvPa746V2sOHnrqlNpt994/jtpWM6hZxp
 XxQEA
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
index bc5168831085..22ba75fa876c 100644
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

