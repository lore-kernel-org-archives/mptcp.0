Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC130FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831530; cv=none; b=GviZqmU8KLX4WgUaa2EHTfrDh7eIA2Pk9Ic9NVCYVDRamPW7JOq3UXGXGnjPwqfq7XXTDbsSE071ARPSdjfv2w+SDtQolBcCbZ/8PqvghuZipxvhWApoJIq4HH6jK//bfO0vDFrbd9Wc56T2CxfOU20zQXKjkThqUj9Z5mEspKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831530; c=relaxed/simple;
	bh=HZY2XN+a4Z9RhOVR+DImgT8aD+2/AsJyuNyLoXK01ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UW12ky6joSd2N8XMme+j+bNFaMtXNPv54bgVdjQblyoQNibRDFSLgUmc8Idf4xQaZOMri9K0ChyWeYgy4eykg0QaVPRUWkP/VPHIF8pmNFK52EKqbNhsurlsjvsp/+ZjHrygCHyLIJwym5PYEjKpj2H0OfPUGSWigd8lucMdjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJX/tEdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJX/tEdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A71C19421;
	Fri, 10 Apr 2026 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831529;
	bh=HZY2XN+a4Z9RhOVR+DImgT8aD+2/AsJyuNyLoXK01ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JJX/tEdw8rZhQ59Lj2jMG9Hy49DWZwHgK7CAzzXEaM4ToVppmmJ2SKzpQaWaTpPVc
	 3jfLSQGD+vrGeZ4+47HUTDdwfQvCEbEdzQU7/wfx2kw/pofeHKvr//aR/wkPLr39mg
	 M6D6X8Ve0H1sYBKQhDasMHX1KyqYNUhw7U8Mq2/2GsAuzvt/gr7JjnLu2N/Nw/dfGz
	 mdXQIJ9y8RuntiKXEAG+Qh3nIujPfROJSJTSrt4sRXDI1B9fDWny1yFbRkMQXaq82g
	 fpMawqxxJigeZ9VIre5f4vM6yv8u5uj/KIvgAukg1Y6hZCDAmRkh1b2rMmhK3KY7yD
	 Ljo5Fp7AmIdBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:42 +0200
Subject: [PATCH mptcp-next v2 04/17] mptcp: pm: ADD_ADDR rtx: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-4-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HZY2XN+a4Z9RhOVR+DImgT8aD+2/AsJyuNyLoXK01ZM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct5edmjPrKbDbz9kbb0dJjrxtebbiYuXztu/UurAJ
 KmIP5wlvzpKWRjEuBhkxRRZpNsi82c+r+It8fKzgJnDygQyhIGLUwAuUsnI8OTszgzBA4bBnOkL
 H6y3aHglnXZSkHv5ZM5c01+vt9w1/MrwP9lcWkbiU7+V6qtZecv+id16W13N/+yuU4J/4nVG/Wh
 HdgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to the 'out' label to fix this
potential leak.

While at it, regroup the conditions, and explicitly mark them as
"unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0f35ea0e4f66..cb709c1edf81 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(!msk || inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -373,6 +370,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	sock_put(sk);
 }
 

-- 
2.53.0

