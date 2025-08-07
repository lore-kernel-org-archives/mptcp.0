Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5C1DB127
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534681; cv=none; b=Jv3ylK6VITzGOJRcY94MUFDc9d1A0n9Oy/TF43lGltEpIiDBtIGFXjjqagzqsG/RxTY3Dr3lDudVQUT/BLa0WQLtndM47xCkcy8ibi6sCZCscPw9V999L85ZPI3Luy0qug+xtcqoabqhkwxne0KyirY41+ktLmp3rShPiKkPe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534681; c=relaxed/simple;
	bh=1y9Knd42iXPORm8/kCFx2TJXDTLBjqb/jWGBKuXKuP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJVqwe9m9Akfg2gMrTwNrv1VuDO8Pishr80rqHyOJkND3S6IKJker3y85uEX8TbwU+PQxqC9U4CV+VUf9UYYDfuzXYjNQyt1Czk+T2mHd8j0wFm7yCC11rDpw/F9UjaLAVOUj9pZklQcyvsHExaEngTfks+ZTKlcMKS4eSyFWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUC/fFxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUC/fFxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929DDC4CEE7;
	Thu,  7 Aug 2025 02:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534681;
	bh=1y9Knd42iXPORm8/kCFx2TJXDTLBjqb/jWGBKuXKuP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUC/fFxLDe9VyyvVuZJho9doP81VKLibAgC9uUvQbApxAcFpThlQjo1jBaY2W2g+U
	 PxqkXMQVzb7vKwWeqwVzZOX+qzsnuyfy4VG4JcuD/oPiz8F73DxplZaWd7kwThsOXF
	 MV+PAMG4FIdueAMfmLkrg4UgyvvVx5fiQiqGFtgy+WWzNemI0Hn8AgSfr9tNsU4fPm
	 wuYUcrZLLXmKlgZEpFb2vCr/32KCJuOgQTvqsZYS6xA/dz5LZwN7cEFBNIZrylsT5k
	 To/PsK5ENuM/BUdasa+Ewifl7IyTyMnelvhgBmTYr+oGJEDEKwQheqTCt04kDozqRi
	 L+2SRccHTyN1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 2/3] mptcp: disable add_addr retransmission when timeout is 0
Date: Thu,  7 Aug 2025 10:44:24 +0800
Message-ID: <359dae075f9bbc7dc30b395e870b8919d771fd60.1754534416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754534416.git.tanggeliang@kylinos.cn>
References: <cover.1754534416.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm.c                            | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5bfab01eff5a..1683c139821e 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b66126692ac1..e6dcc5b62645 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -274,6 +274,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 							      add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -291,6 +292,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -302,7 +307,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -344,6 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -368,8 +374,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
-- 
2.48.1

