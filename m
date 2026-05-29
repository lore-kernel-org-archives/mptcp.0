Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885036A36A
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024938; cv=none; b=uyFZwEMp5Sd2PJT56tlQiOgRAj3aF23eG+foA/opS0CyJ1okgba8XsMSB0JV/0JG1pAt6Lxo/rz8AkCzo1IH6JGXP4Vl7txj7lchEahown9xNb4CCuTS4X6hW+J9yLAaf+t7LE+QBD+O6Pt93G/Fct7oZkOQ4nz/6WxDRfhxJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024938; c=relaxed/simple;
	bh=0tAcJaJg7M+WY692YK0MRuA+nUvW5ayBe4Wvt8FSRUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxRYKjsWyxFplcaMNFg8hyZ84Nasf9XlHLXmyHN7QVnv1GA9hPImML7RjSGrqNlFRsHWnI5bxUVz+Cm/1IfT2jaODdG6Bdj5lGOnLY1DhTAmmYeCBD499bSLWVuHhctLyavoGPeCtaIQWQNg68eAUAzBg3znt7+TQIWceuLqF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKPIV+MQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKPIV+MQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6421F00A3A;
	Fri, 29 May 2026 03:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024937;
	bh=SYSlHs/PHrizoIPKvhzxLUIcZXJpbu9nlwn3/Sp1OBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TKPIV+MQZTFvJJT/DJtt2TrlmpFtNJ8Qia6HCRHNRSFAYm/anxuU2pUZ7Oel5Il8O
	 Akph9gZJGRX3ph5Qd4dcddClBqzCNtvcrYz9/c1idsvXphpxpZLRM26gpdEuqvIwCC
	 NyI1uZ1gpEEsvSeWPKHHPSbbnhvrbOk6LfY3Wg5mmMfUYLzFHHUSEWRRGs//QBS4Nr
	 UuFgq6EMQ6xFTarTg66bf9DKKy4k4EVy7yjQBkIfMuMsNCTN9J1j1T36IJqQsSUIxZ
	 dr/0jcbP4Hqd325/Ww86dLHV6+RuNUxYHLjHkTkLacKOdoOQoq1i9anVvcBiil82lQ
	 o90KLN0i6hGmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:51 +1000
Subject: [PATCH mptcp-next v4 13/15] mptcp: pm: remove add_ prefix from
 timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-13-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0tAcJaJg7M+WY692YK0MRuA+nUvW5ayBe4Wvt8FSRUI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZX4xN2v+IKQRdMbtKe7V/l5vvQ1HoPbkAHD
 /veeD8Cg7eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVwAKCRD2t4JPQmmg
 c8pyD/9G2dvf+7vucnvvmukiHOkum/yNr/P/SJMoIHeOzN01Rana0anA8WgWV2w6484dvqq7qu9
 ANPFxn6l4XeAIyWYhh7yyT2YnSJDzdVPsEQusTZJWi2m/wS6vDOGLpce/k8/1eyaA4Ra3FtBdIY
 QqYYpXbs8Czi/4H+14glwrBpWopd0tAt+jMNlzDm7V2SH6TRo7jTbPhArlDnV9of30atsj15rmd
 DHzQWX9VwGnd0q0gutxWjFijmwG/q+maTAhabtyX1a81Id9yD1grufZ1yF/wlButn9xY+AhEpRw
 EHmfdHft7RGUl2G6Q//TmpcLvPpm13a/0WJON9eDrvyorTpXuuFbMm2L2oQ7kLLLKsTZHEu5f+U
 79MUHXizDpqZeL4OX4G9EPPc63qi26KX4gUpyuttIBxtZNRP07ZuC81K9kq0J2YE+UEGggygqXm
 n+f+whVqgOkmeqMj4pTs7nXBBlgcR2QvyuzdPNy3T55dWSFTh5qwfUadthka0/zU4kJY15/VugW
 WKMRuGBSMPz5D8Y4GJFgJvHF5R6ZRA4rqJoIEcblm2LIPmLF7Ye4p8TSsZvuBroGFhFlFmA5SgM
 oBZZfgz0p/j3UiBMn3Bs3EdUlNZFjTy41uCJK3i8AfCuqQtG/Ap3Pq4LYjvSWWWVZxsls2SsPpW
 MeiNEFy/1TPDCnA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the two previous commits, using the 'add' prefix is
confusing, also confirmed by [1].

Now that the structure has been renamed to include 'add_addr' in its
name, easier to know the timer is linked to the ADD_ADDR, no need to
add the confusing prefix, or an unneeded longer one.

While at it, also update the ADD_ADDR timer helper to clearly specify it
is linked to ADD_ADDR, and it is not there to add a new timer.

Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0f05222ecda2..6c0468f1609b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -17,7 +17,7 @@ struct mptcp_pm_add_addr {
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
 	bool			timer_done;
-	struct timer_list	add_timer;
+	struct timer_list	timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
 };
@@ -338,10 +338,10 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	return rto;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
-							     add_timer);
+							     timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -411,7 +411,7 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->add_timer;
+		timer = &entry->timer;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
@@ -458,12 +458,12 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+		sk_reset_timer(sk, &add_entry->timer, jiffies + timeout);
 
 	return true;
 }
@@ -482,7 +482,7 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, &entry->timer);
 		kfree_rcu(entry, rcu);
 	}
 }

-- 
2.53.0

