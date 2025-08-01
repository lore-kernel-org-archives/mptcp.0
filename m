Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2F33987
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028457; cv=none; b=LYDv0/PKq+si/vhUvBSY1rn+ucTOjnS/lWo5MIKwufyvA4iu3dPQHfHUqmz2ao/6qEauZV2P3R2Jrc7d97KUAec+FPRcWjBIKJVMGZJpf8SVdrnCvSC1d0/vjxPfgdQ+2R3Ckl7wyMsZKNAZ4iZ5f1n/6B05Y+7ssJLjjHNBzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028457; c=relaxed/simple;
	bh=uyw1CugfhawkAkgYLc59ndnr8SziKHAORYD16ejuUb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPZ2CKCcZSm4LVoyt9+PHW5/Iw2e/OOpiKunWo+KYceDkKBb83ZdXqtWD1YiyInSXu0ooVGyL3YB8eQUxBpc9qBsg3G9hDsBLsebsT8y347qMRX7AjcMTo50iZKY87yp7Clasa9ji/fYnN4PnrKGo06vT8Y37VYLDvCLGHgnRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRRwokk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRRwokk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3233C4CEE7;
	Fri,  1 Aug 2025 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028456;
	bh=uyw1CugfhawkAkgYLc59ndnr8SziKHAORYD16ejuUb0=;
	h=From:To:Cc:Subject:Date:From;
	b=VRRwokk5/GQ6k5Wb/DmzHnOaqRGbjpXcJNliYTyfnspbRTYaej+hqmbTUzut2Jvct
	 cRIYcm1XxxDghp9ZHK721d2g9BTr2z3jPAtvHssSTt6kiZszYGitTiyw702X8it2TA
	 wMNlZ6pUgsP0ssyoBIOmSGXGQasj8TJjphIY7KxtajUs7CpqfNjAnBc6qV527c1K/P
	 KTZ2UO7FkpOihoOE+d3KUEdXDLukAe2qpmUGqCxHTbgIcUMtdgnUs22PW+W6agF5mk
	 O8VG9/r1EUUxpIIvuGnpYP1FB/bWAWZwlphxifH85oQ1D85K7+ZEKScPpnLrap/Pjz
	 IJb6wsCtrwsEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum subflow RTO
Date: Fri,  1 Aug 2025 14:07:32 +0800
Message-ID: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
patch makes the retransmission timeout adaptive by using the maximum RTO
among all the subflows, while still capping it at the configured maximum
value (add_addr_timeout_max). This improves responsiveness when
establishing new subflows.

Specifically:
1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
timeout.
2. Uses maximum subflow RTO (icsk_rto) when available.
3. Applies exponential backoff based on retransmission count.
4. Maintains fallback to configured max timeout when no RTO data exists.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - do not rename add_addr_timeout
 - use icsk->icsk_rto instead of tp->srtt_us
 - increase the time after each retransmission
v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.tanggeliang@kylinos.cn/
---
 net/mptcp/pm.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 687dbb59d084..22198609be2f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -268,6 +268,28 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk,
+						  const struct net *net,
+						  u8 retrans_times)
+{
+	unsigned int timeout = mptcp_get_add_addr_timeout(net);
+	struct mptcp_subflow_context *subflow;
+	unsigned int icsk_rto = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct inet_connection_sock *icsk = inet_csk(ssk);
+
+		if (icsk->icsk_rto > icsk_rto)
+			icsk_rto = icsk->icsk_rto;
+	}
+
+	if (icsk_rto && icsk_rto < timeout)
+		timeout = icsk_rto;
+
+	return timeout << retrans_times;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
@@ -302,7 +324,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + mptcp_adjust_add_addr_timeout(msk,
+								       sock_net(sk),
+								       entry->retrans_times));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -354,7 +378,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
+			       jiffies + mptcp_adjust_add_addr_timeout(msk,
+								       net,
+								       add_entry->retrans_times));
 		return true;
 	}
 
@@ -370,7 +396,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+		       jiffies + mptcp_adjust_add_addr_timeout(msk,
+							       net,
+							       add_entry->retrans_times));
 
 	return true;
 }
-- 
2.48.1

