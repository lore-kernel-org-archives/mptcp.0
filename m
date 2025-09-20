Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16D1DD525
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758339938; cv=none; b=WRG+KRHrbgnc4osN/ghXK1ZCJwWTBkjtg3kcexgPuiGX5BqmFGmGxHNi7zJbBIO/sL2Udwsw+W06C2JMieMpQ7Tg8yQttU+mOXGe1+2vcEK1X4zg67Sn8bYTK8H8fbL3OvZc5BtdkF4lyVg7bDi7iERkY20Bu8Kqnmj0d3FzMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758339938; c=relaxed/simple;
	bh=xIwHED0VxqxQjZEoY4VoTX3tm9ykruKcqoHIBdE39lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR0n1QDViHdL2wY39y5vBNa5wTskzC5ClKDZiXoxJKSrQ61/4/g17lHU8B5y4EsSL/54Y5iqrocg8BBoAPLRKDdgPj+1nobAcnsJguSD372L4IAIAZCtpg+RQ4noyJBsGW4g3MFIDfNhD0ey2YHj6fIjmZoanKXpfj14ajcLTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSCHYqHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSCHYqHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB20C4CEEB;
	Sat, 20 Sep 2025 03:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758339938;
	bh=xIwHED0VxqxQjZEoY4VoTX3tm9ykruKcqoHIBdE39lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSCHYqHSe7E8flTQRUefzs8WP2yKig77dC1KkUEMG3kMlH8CZ7if5eo47jlhpgT7L
	 UPELkKflphnuNfOVER21Vdu4cBwPGsp88MAh3oQxOutZ7bC1R6+6KqBjULYOfa5DWS
	 27srzvu97PyZUKUTpDN//eDiKNMmRubgy51J50aFl9kar0sCKr9dm87GcJAYrBntC3
	 fve9umVe9eFMU57kZbmYdtQOSyyfas+WD7xndpVDLQLDrAvdA8D7BU4cq4ZEaLk0HB
	 1IzgNvZ7eNCPeGvwShmKWMlGgA5M9cFmzbKNzG/ySAx8HRtOduCCViNvOaW/r4b6OO
	 PC6RgTKvm27MA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: leverage the sk backlog for RX packet processing."
Date: Sat, 20 Sep 2025 11:44:26 +0800
Message-ID: <4dcb72484826d96e772cdd6565f4ffe1b6bf2681.1758339666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758339666.git.tanggeliang@kylinos.cn>
References: <cover.1758339666.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use new __mptcp_try_coalesce.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d114ed1bd61a..85dce66e12a3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -377,8 +377,7 @@ static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
 	int delta;
 
 	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq) {
-		delta = __mptcp_try_coalesce(sk, tail, skb, &fragstolen);
-		if (delta) {
+		if (__mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 			sk->sk_backlog.len += delta;
 			kfree_skb_partial(skb, fragstolen);
 			return;
-- 
2.48.1

