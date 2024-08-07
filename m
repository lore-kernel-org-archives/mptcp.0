Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26576F1B
	for <mptcp@lists.linux.dev>; Wed,  7 Aug 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041297; cv=none; b=frw3XuKUNAYdaVx22on4JM0Vy4hLHw/otx/c0xTWB+Tf3GIZcI9UUyBLvC5JrzXstuacUBTAqL82bstxhb9B/tt5vz96Ae1WUfEYHF5p/jaBYSJdvP8OdyXAf0aJWzKGKd8TnnRCCoHahAjoOZerbymey8LezTulOQ55OMDUWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041297; c=relaxed/simple;
	bh=NUKQxL3MJdJvIxCauaK9AV0G38rUZBQVs57o8ofdhSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dH35x+JV+tJctK6l1retk8nn2X//4eMd/T+svYHKTUuQ8KFPvJWGnA/kf7RRwz5Gq1lZmXygCOBftUDefUEMljyRN7e4iKxeHiImF4DxEH6IxUDU9fbQotr2PckjJ8w6NV8FSyXPqfRDNE+AJRVa9PbiC+KJKOnuU3qjHml/Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op9YTCIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op9YTCIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4AC4AF0B;
	Wed,  7 Aug 2024 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041296;
	bh=NUKQxL3MJdJvIxCauaK9AV0G38rUZBQVs57o8ofdhSI=;
	h=From:To:Cc:Subject:Date:From;
	b=Op9YTCIzBMNOGdR0/QtADxIwgN0UPYCLeP43a2Yqtz1lGgzVk4Ac/Z7JL4yvf9mcV
	 bV+whx9l92XfscShv+1SGc/A2J4M0hg8zUbTVXcHMZisdbSYkp9P0wRQKJNTifl9W+
	 lYAmVf5h+oC79d7pJsYu/r9RaTySnHdlgXeLtB1a90qDiOhb6SHWw5fh2rbt6G94Te
	 PIwRXOKJ+oqM4YgvXNjDVCg9VZY2wi1PTGFm6Cd/upEfTR4cTIM6GAE4kLROgUhGkr
	 LoiucvmYagiwQ+SYgGxR/DxojDGSMHqRMFG42T6eth4Z6b1cRVIN0/yX8VyIm2qpJS
	 rUfei/RCY3ayQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH] Squash to "mptcp: pm: send ACK on non stale subflows"
Date: Wed,  7 Aug 2024 16:34:39 +0200
Message-ID: <20240807143438.1471057-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=matttbe@kernel.org; h=from:subject; bh=NUKQxL3MJdJvIxCauaK9AV0G38rUZBQVs57o8ofdhSI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBms4X+cADBC7LdGH+u2UKk1Aj1aDpUBg4Bhi6YN 1XKH22HgPyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrOF/gAKCRD2t4JPQmmg cwROEACh5IzCiYeN77gonMyUhHA21IWMVL4w7ptuGGKvgHVgNYgbmV6HUf8gBw0oZuCx/RptAMH F5IMVrY4AUC6rUPiBUNWNY3vNxuXRyHWZehDDVT9CclDr57lEcCUWO5tWcv2yYeQJ1a7uQA4I/i p/rJkTLH2LZWWv745Ci+YUH1+LTdkk/MAwju75uh3KE4LQg3If/6+upS9xp9+MYVbACgiw2/TKA yVqrOhCsJFaFfQGiNbJnUYWnHIyhkopeyZgnRBcnEafmSx2HBi6qLdQ2mWRCpVQctq/4sPC72c4 GIos1nSKxWtZ3gu7DmoP1XI4meAC7ui0ens0DaROYmnx3Lfqw7BQCTQBh5AqAvYaP3wuLten3ew aZqpbKhf7NSd3bYvn5jnybAJGuccz9F8l1/wFGE98YhWBiylYAM+oN+7efNZ20HXEpm47OSshX+ urhqrlotxKxYZ5VK8bWRy3gCYeg9U7zHgujFkt8pQdpacDzqkJV2xy7U9KMDSwJYP27kzdxDSP1 nHiSettEuxGEscyxYlRNGkdzlTMyKAOQ8zj2gPf9wHN3JGt/I1ACdMnWmqCZLawJxfcsuQsI58W Ue5yNRlRPBDZbZvqwQIS1RzKzBqbeCOcPdIwNBGQVv2piwX1RsRbeFP2rWjrCmSj6I8AaQe6WGF CBfGiDzPsU6mvQA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

If there are only "staled" subflows, pick the first one we found (Mat).

Note that we could also check:

  !subflow>backup && !subflow->request_bkup

It's only a ACK, maybe OK to send that on the backup paths?

If we want this, should we have two alternatives?

  - First try on backup if any ; if not, on "staled" ones?

  - Or just on one of them?

We can also fill an issue, and wait for feedback.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Based-on: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cb8f7de7ed6c..3bdb0219188f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -762,7 +762,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *alt = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -772,11 +772,19 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (!subflow->stale && __mptcp_subflow_active(subflow)) {
-			mptcp_pm_send_ack(msk, subflow, false, false);
-			break;
+		if (__mptcp_subflow_active(subflow)) {
+			if (!subflow->stale) {
+				mptcp_pm_send_ack(msk, subflow, false, false);
+				return;
+			}
+
+			if (!alt)
+				alt = subflow;
 		}
 	}
+
+	if (alt)
+		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-- 
2.45.2

