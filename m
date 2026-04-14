Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAC146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173653; cv=none; b=l54jYY3UcDcCqlLhGuQYgESqyATqoM+Mmd6oh1yriCp3yC1NKi3i/WKZvtd9EZfR5kS39ufLFXF7UjAuFMjHUbmSUVEL6sEUqh/roTmT0JkFDmJA+/vYEvaPJqL1tdIzZhbBV4p44ektnSchKuENqCOW5lV1uaQ4vAIXrPoOZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173653; c=relaxed/simple;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEVx+H7XhpDxwsOaKysZ5bpQcFrx4xOBAQ8YWftM54jxHjwiNBpCA2RPuegFJ/xHMXrhwWmHLoQSk9UQP4vriHKAeX7BY5FzkaWCxcU/gLnI9JPKBiLuL6RTkZdQsEjbmMQoZtJPGYvkuYUh3lcTIGZZpZPXRXTXBqJwrB3pHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbuptivc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbuptivc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB0AC2BCB0;
	Tue, 14 Apr 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173653;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bbuptivc7NbL4Ll0vNeqegdHFPLu2hI4UMcxUd9DREbTIMKP2ipea+DwBuCKWK/ho
	 3u/JN2AoPD79w/MaJxIpOI9yNietWXP4v218XNjeJXASQL3f4otk4ONAa8tEOh6ZqF
	 Z5YPtAbH2STjYEtD8/14o7JA/dlRHUHFU5zo6z6pYtdSwQrJWkMj4yTarTBXqL8IkN
	 wFtGqD68rmpOJYAYlkqCdGC7SWS55q1u0zn9wb1bB2Yki/VJJ/ilBkr8L0zV1eVrV1
	 xYkCyp6vVnZvWeQprdF0HTtVj4B1nMcAp4x7aI5zRqTSXz5xcer0O615uIx3PfAETd
	 zmdwYqBu3GMtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:55 +0200
Subject: [PATCH mptcp-net v4 02/20] mptcp: pm: ADD_ADDR rtx: fix potential
 data-race
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-2-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXkqWqWcK2FPnXbe+fnOpbq1j6aXOURetu3a16n0r
 /Z1Rot0RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET82hkZvjxIVpgiYHie58F7
 acbieN6q+BdlFouErad0u+10LHL5zchweMsBjm67VpGgE8/b9ffO29J3431u5L1PrTN6vdJEF/9
 lBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fdadd0e8f77c..43a11b65235f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -340,6 +340,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -368,6 +375,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 

-- 
2.53.0

