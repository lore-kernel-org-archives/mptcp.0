Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D21C700C
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758339937; cv=none; b=ty/02evI5rC2ORlOM3yHr/iRhRIj95d4Hz/GtliZgWSwlqrXro1Ndm8Fk0RMOm9NmlL4xPHgUCQ+7XeUQlPa93kLU7aZ0kEHxBlwziNpbnCe4J2B6F364XQi9X4aHTyLorwf53zLlRXFwyK5h14BAy/FGuhWGYolkgsh925COCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758339937; c=relaxed/simple;
	bh=li81ymd/35vIybewR6QlHidBDMJX10f25+UofJS6Oks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2QHJyATNjjfYD9Y///MuIiSEj8aEt/1LTvJhoSBiJtWU0e8zlW8XMcwzb47b55uchVgnytIC7qAX/ifhJNMGR6ey/HuFluXKYZ8Jflv4PX4EKQawYrfhxxYqhioy+Dx8NAzoDJnmBf1NURfn8xTwei6vfq0hMw1qSjI5immp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnbsJYnl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnbsJYnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A4C4CEF9;
	Sat, 20 Sep 2025 03:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758339936;
	bh=li81ymd/35vIybewR6QlHidBDMJX10f25+UofJS6Oks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnbsJYnlEh/0k0i/18SDTvoEl9ddCeYcHUljEk5s9hepTsvJ4bdpBkR0IPmzpYXHQ
	 jjW8KUQFOz48iDfA79xlnv0VE+Dxx53IZ17jGblpoRrmYxikV1GxP+Ko/F7UJNw5Wx
	 +ffGhHNTaNALPnAbSRhTfpU1jOvn9tfAmeBXjBOIEYGYxD7kwGza7h4X06BOig53Vl
	 WdcTaKcBkzV1Oi5bODg79jr4mXW2cCCTLJZom1DQ7zFZpLDH3e4+XKSrFlndVg3PTF
	 FeaWaRhQZLJOd/FNwDMGk9mWTEVnTiMZkbhqnKyqC9NBV9Od+xavpUxLje1EPb1JOS
	 VGxwGvR/KrhEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: factor out a basic skb coalesce helper"
Date: Sat, 20 Sep 2025 11:44:25 +0800
Message-ID: <00348b325f283706e37009b3cc02c41b6077e4be.1758339666.git.tanggeliang@kylinos.cn>
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

Fix the return value of __mptcp_try_coalesce.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7db5adb43d41..d114ed1bd61a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -142,23 +142,23 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static int __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
-				struct sk_buff *from, bool *fragstolen)
+static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+				 struct sk_buff *from, bool *fragstolen,
+				 int *delta)
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
-	int delta;
 
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
-	    !skb_try_coalesce(to, from, fragstolen, &delta))
-		return 0;
+	    !skb_try_coalesce(to, from, fragstolen, delta))
+		return false;
 
 	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
-	return delta;
+	return true;
 }
 
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
@@ -167,8 +167,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	bool fragstolen;
 	int delta;
 
-	delta = __mptcp_try_coalesce(sk, to, from, &fragstolen);
-	if (!delta)
+	if (!__mptcp_try_coalesce(sk, to, from, &fragstolen, &delta))
 		return false;
 
 	/* note the fwd memory can reach a negative value after accounting
-- 
2.48.1

