Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A73CCFB6
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089529; cv=none; b=hbKEC7qmmvcIE5LEmpX6Rb4gVp+oiUPpCw7iGinS3e3kTxAutbdrYIQ+S3O7Pb3H+c69DZWLZl1cP/+Pn8YIz4wB3p0NSs/tOcLmyZ1B176zK2Fjma2tHDe0ywUDMExZF5s9wvouOcNUcC52fO54amUc7iOxWC+uE763QfHoERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089529; c=relaxed/simple;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+FFKRkrog+y+e1nzBS7gXzZs9Nnc2+Xd0fw0Ds3bZLOmlJdyRI17RITBWmr42QH4+MhlMuXapSaOqlsNuCuu2wHHxpUioQjwDMhbIPQlA1uWWgPlRwTpnah3P/zcIyOjMKLsdoJMM2On966C8sz/WdZPmknOfQ83azaD1KFF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFQc6kqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFQc6kqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E2C2BCB4;
	Mon, 13 Apr 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089529;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NFQc6kqKlIqrnp5///TurAeX3gv+ohG6gqhYgaEl7R2seJMJo1bmm9Udfo1GwKU4x
	 vIQUjZDfWZD+3ywQqV8JKJIeOCFqy4x0m/HW/zq7y7qSFU0ZuexrXLsOgnwNL9lJFo
	 WMk3jokfZfl42Wlb2v9vvMeV+L8XbLiswIPxlepJxpAcvaXmbYCsrwB6/LeP4jDLpV
	 CNpA0FiTspmwnxtjUCGyWjuIQpirlkBfYgE6OdDSorC/XYkxERw9nr9h7KppNJtuQ1
	 E2GIxCogB+0Da2FSHAiOuIk1G6z/cUgOchn9tMUDU0rxUb3Mder3tilgHzSxvUDty7
	 rRptxYK1siWyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:50 +0200
Subject: [PATCH mptcp-net v3 04/19] mptcp: pm: ADD_ADDR rtx: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-4-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/FyV+bZL8IRN52W9wrylF98I340/HLTY56Le5j4hs
 29V8VfjOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy/DQjw9zdCyelyGo3zc50
 sH95au1yPv8tUxUl7lrWP2OYs3qSw0KG/3WHVvB8y/mUtO6r97ZPSZ8f8xRY5+g38e3b/clsxZP
 MNjYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to the 'out' label to fix this
potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: remove '!msk' check: cannot be true.
---
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6a75470dcf5e..d3fcf441b208 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -373,6 +370,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 

-- 
2.53.0

