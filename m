Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6B365A0F
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876044; cv=none; b=Fgpcyp2itll7KPa9JF+BYAY3kblP6RNaCqAUXBeybeO3wyDthmw5hxJEQ4YY01zYGcsD1+t3VZPGeswuRjkWsnr9W2wuSwJtj/575nijkN6QitWLhAIPiJP1aN8DRy2aQW9c4L6Z9GLCMwOyyOpfktekiFuzdGlvWGBpyQ2cMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876044; c=relaxed/simple;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7LKKyb/raLAsJWr87u7K4aq0+jKMK5vE8YlCZ8qPT49FQtjL2sMjmoCKSMYfwmXC6TC1jxfgFASjwWStJlW6RBIb3pL9YmgAcC5EkwTyd4HJJEq3QxuDKQ7coJUDmYCeVFyCImEVkfRTwieulwxM7gP+EvOWvyezrptLFho3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7lYvQUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7lYvQUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9390DC2BCB4;
	Wed, 22 Apr 2026 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876044;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F7lYvQUqBpdaL1ZCYn3mPO99mDDjtO60DFLvvzFfUENyhrLGlT1yB1qxOd8gWri3I
	 ysSrnutRLDR1/1ElBdIEn5OCNPdYDoboJuCLrxmJib++23r1y+inos7+xE6FNX9IhW
	 8UB2xeV3oEBTkhjL6oKtdAuebK4lKJwmbkKPOp0DSKbppv9EWtj9ygHpigZjhwkTSH
	 OyGCXDwGlGfLDNvGroSM8BgndRFUMQPyvLxPpIlyeLRO7aduQhZWCwc5NIFfQym0XB
	 nEUx0qg9nxtfTpWf/P7jfpEGZtsbWWiKsqvsiUDzsA/IMlzcAVZsjVtI5/kfC/aDGN
	 ZHbAIw9anZ4PQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:17 +0200
Subject: [PATCH mptcp-net v6 03/19] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-3-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/PzTmbzM4fmFxSu2/dsfUfKuu69uX/SKd2naFvVzD
 r/jOLj3TkcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEJEMZ/il7LWhq0onfVsjP
 phBy4UDu0pUJk/8ytLcGHjj9JzNRaz7D/2yvjnttcf0cN8499J3aYrZ/SqWLnqE/59ytEh3Tr/o
 mMgEA
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
index 43a11b65235f..6a75470dcf5e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,9 +337,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */

-- 
2.53.0

