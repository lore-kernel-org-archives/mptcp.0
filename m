Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092838D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449914; cv=none; b=LL0lux09+csgGAc1cwxYnhlPuEE5ThOadQF8Ptt6dYZwMMOefBe5rztdU59Vuu02oyg6oesoovzVV7gnjR3lghlLPvS9dNKP1ifIICC62dtRqTrl5+Zf14sYOBSo872aoDKnI4ebhyc5toU97CrybTV1UCJCoo8QFpacQdI/cW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449914; c=relaxed/simple;
	bh=Un1F47hDp6OCCwW4uU5crwtU5pYBcdCUp0tvnCcJcdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzUSHYT/GmKXM43GxRCCn5MvKbsH6cUhX/kdlnCgpvt69r5jmpXS6dBayEfeVfzqhihl80VYpCoLhChEpCXbekFOTh7fOaut8hlE4/S4WltdYeoJCZ1CgBhYMtUTVc59ahKhFgW1Q7H6XJ5Ht50h+NhZ1dQ+nJn8QCb9vGtf8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1w7utdd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1w7utdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3496EC4CEF0;
	Wed,  6 Aug 2025 03:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754449913;
	bh=Un1F47hDp6OCCwW4uU5crwtU5pYBcdCUp0tvnCcJcdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1w7utddSrU2u9eGXZi9Wgp7bL1E5GUf2ONA0nZppocIexdnQ3n3sQu9XnCyyTrFw
	 IYWHTO97bGFH3kpmV3RouUuk1/cLOJSxgCBVkEtLe9br3eOVEcutsYVtHFQNNeYv0b
	 8oQouz8bPoZ5em8n6vOOEHZJc74aQxhH7sf9WZQtIQBIUepsM/UdT6rSB13Z/2DuTw
	 BagjgQRL3BqfxX3s/GWxBVr3xA92IFzFOlIUxjN6ZC4XfpeOlpSDVP+HJVQ+VxyMTW
	 C5lzgcnQuKoqYOvS+Azn8ebEqelVBE2DMrrQ9PL+SIaQlJD7/ze2g5FqR5vfxb3klG
	 RteFak6xlVyIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net 1/2] mptcp: disable add_addr retransmission when timeout is 0
Date: Wed,  6 Aug 2025 11:11:43 +0800
Message-ID: <3e852490c11a12a42cb15712305be368372bd078.1754449726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754449726.git.tanggeliang@kylinos.cn>
References: <cover.1754449726.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When add_addr_timeout is set to 0, it indicates that ADD_ADDR
retransmissions should be disabled. This patch implements the logic to skip
retransmissions when the timeout value is zero.

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst | 2 ++
 net/mptcp/pm.c                            | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 687dbb59d084..5dec018fdda2 100644
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
 
-- 
2.48.1

