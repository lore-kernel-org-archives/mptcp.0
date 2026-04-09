Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8433F591
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767934; cv=none; b=bJRwiSR5RbRqShpHqpx+qdYwfmScPluVlj/y/00+qT3cWOTLl6UhKH9rgwvsE2OYCj54FYzHWtjux/x0I0RX0+Y9voJRnPbvduIU2jmrggQymQyFFSrngyWdc3tMC8P+rD6rWfgEnuNXPk2ZNfBsdsh6CSdqv/m1LrmlmX1Z3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767934; c=relaxed/simple;
	bh=zcRKkBlw5AfB0X/461T8LUKk8JknfHT5u0FKTdrpPas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9BZd46qdbGYJA0HEToyCUzdfdmjLZr0XV5yOt7RQEae55tv5nEnCT7wa3800AL02tMRNaMDEFJTr1EwUFP5xkB7UyC4OW42mcsG4OuOFbaCh9BQO/j1W57CMd3Cxk/Mzm//yOHSMGnzPZkz8j+xcPjvE+DGWkgbpbaCKj5Dwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOlAK/ZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOlAK/ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1F4C2BC87;
	Thu,  9 Apr 2026 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767934;
	bh=zcRKkBlw5AfB0X/461T8LUKk8JknfHT5u0FKTdrpPas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FOlAK/ZIn4ECr+Y32dlPRhP7IkhDdXb0RHhBJ8FGUWQo9oIDx0HUqG1rQ+0S+zsJ4
	 nM3ZIj5T9wExzx2wPtcV++S5RKnaj/aRBM2u/ZVzay0QZndFPoriwzYbK+WZ4G+Wrc
	 K5oJJXCzXzHD4tBrFjz9dZC8bSIE7PWaHnn0Ef7q4hToR22rcdcEcQVkZh2N4aEZyM
	 pbmSnnjGERrnCpEKXeJlTBVCLNHj7iVf438E4U8y9i5jJiDfNq6N+74hBLT3eq8BfL
	 ldQ8f9IIv9WR/Wc29vk8cYc8uYQLTDcnec6qKwhlrXEq+pnbzY0kB1CTuN2Ikbcr18
	 xufxm/YLvDlng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:42 +0200
Subject: [PATCH mptcp-next 02/16] mptcp: pm: allow retransmitting ADD_ADDR
 with ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-2-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zcRKkBlw5AfB0X/461T8LUKk8JknfHT5u0FKTdrpPas=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCBbkOOjFF3EVbeX7J9qQqvbu9cbL//xnHjb7/PNG0
 Czpp1MCOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTAC7CyPC/Trd11YGT8lcV6ix1
 grawpCV7b3jV8bfkqXPoJQ6ZXTffMzLM3XjQ9mOaWMbdNoWPT/1ePOxvfiS98nLlaQ3di0Z5kpz
 8AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7d439d49c3af..f7c9a1f94d50 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,9 +337,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)
 		goto out;

-- 
2.53.0

