Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF68271A94
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173657; cv=none; b=UyjUq29/OY7quhzKb49asMD8JnQHPZ7o3mxM0op00dGxjIRuv/96rMr8bae9vn4QQriOpwE2rXJ2m9QcKyqcnXSEZoGLqsauP9HJKwGOxvpUU5Zjt0yge8qHEh2IDZU5Df03hq91w5r2nj1uc1Q3N39RTZ8gUN9LMW9eLki7d3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173657; c=relaxed/simple;
	bh=jXEpLOQ67t49RysWKZgvu3qP8jtz8NSTjoKZIw5ytXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FgExLMF/+tPBY+gi7r9UZk+MUwfBjXYw8kpImHbt6EA6kLgzP8i44bJbjMdfWhWUjaE5wnMwdgwUENgPWuiWVMJIsBFHKgDI3hGrS8IxYEDzr7/+2Jhf2b8fz0r1YaQTuKc0s6fbkjxM743LNM8hCjto0Ot6XycMpEk0a91QLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukAdYywD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukAdYywD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81D1C2BCB0;
	Tue, 14 Apr 2026 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173657;
	bh=jXEpLOQ67t49RysWKZgvu3qP8jtz8NSTjoKZIw5ytXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ukAdYywDQnkZDhnrxiBAR5DNCbb9r6vzYp6EDwRuVh3iiYkX/CZ55KROVEZL7sHLk
	 Qmya/OZKqUkSP0RfyvW7Rw/SLC7sAdrcmbgfSm0JFF3WUe0dyqOqIatE9hZaZnKa2g
	 lD4Yvb8b7T7yGmzYKwKPUSW+zzeXj40m+whS/u6VdKpgP5AeVYK8oyoG5QM8pFPEoY
	 nYKhFJH2savSOjbilbL5QEdn0l6tYHhToODw6uAba4FEKEOuc3Q2OUQL3MAyteumKj
	 9eTK3+J84/EDfA2pDAW5gtHCk6odjkgjuqY/VajynDEbNnibCY81WW1zpuywMAMAzI
	 4wE7Po+4PQ8Sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:00 +0200
Subject: [PATCH mptcp-net v4 07/20] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-7-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jXEpLOQ67t49RysWKZgvu3qP8jtz8NSTjoKZIw5ytXE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOfnUq9kcKO/TFWP56ujxp8TwSxBT7L/HVp3zNqtrn
 7I5vPdWRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER0NzIyTA77dL6+h2eTR6uj
 9sOmjoz+zZIbJ3TvfvRTTiFHdHfBNYZ/tu/Y5D4uniHHsMb0g/1tVpkVtlckH8jNzku3cvI92if
 PCgA=
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
index 4ea896c83b38..89a9790e50bb 100644
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

