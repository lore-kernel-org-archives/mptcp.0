Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80513270EC7
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686945; cv=none; b=d96V3ivLCAWEKDejY4uCp6544tJf8tgCdTnKx4w9rOrCJ3byGrLEkipilL0ih4ir3sAW+Vai8rHE+zebbQtGa0rTqjAXilNf45EhOiTFy+yv5A5enVqzq4gsm+WzwlAF9fFaBhM1nyq8f9xIqwDoaMY3OzYB1OhVif2Rt/ddOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686945; c=relaxed/simple;
	bh=JGJIHfItjYZJLGn0QYpL7xscoKfPeO/X5ODetsRyego=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQQ/fMje8vI1zeOjtku3fQKQl6s4yHq6EWS2WxEVEj9Ab1DJI2djIH+ps7AgKOQ5AsWklG/b0cjb+2pmtD87pzWV/yCTHKi9+OaFxXtu1Om6QH/YdJa0uZDK98IF5Wzp5ClhaJExa7VhLRSC0hdTMbxkqEQXKDZEVciZlrTSA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGHV7BsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGHV7BsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7E1C4CEE5;
	Thu, 27 Feb 2025 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686945;
	bh=JGJIHfItjYZJLGn0QYpL7xscoKfPeO/X5ODetsRyego=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGHV7BsIkHwFonpuf+9yvlbRuRSBSHcYzuvvurKMypPDo47c90t5dzAao5EEYRs7K
	 6AXHzi+kShdgX9P37rx6dswfZPUUj8DMWyBqUvtOoreCqE0ZWyhNy2jjPjwc9D7qks
	 RRV9dZyOMwHRFjOdSpBrzgfnqeLfFzvhSfnVIstnJr4i+CC/EtyFbG/Pg6Yrnf9pp/
	 fEvRDF8FFjTQsLbMMo1l3MYq0NjR7JrevRHMhsXIjzR5XJHO70QP15Cml6xWAJWq3G
	 o5RuvxhQAW39dreahuJyME52U1SYIF060Mqd2BP6PdCszQW5smqBD4gXA7mD2GAJbs
	 puiPVQsZuzDUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:53 +0100
Subject: [PATCH mptcp-next 6/7] mptcp: pm: worker: split in-kernel and
 common tasks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-6-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3738; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JGJIHfItjYZJLGn0QYpL7xscoKfPeO/X5ODetsRyego=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZZXrPDekEVoGYdyVmNBw9nOTXFkEkfZf/jR
 zEfacWU8yiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWQAKCRD2t4JPQmmg
 c9f4D/9LSihmFzXNx0hVfDve/J0ykKjP6g7W3IGWCgGAPGqEQGps1FKbzrK5Ig3jwCjzB+CiWod
 F88M/K/kGgEwbsr/4gTQ/2yoWbEagUyYjmGR++v9UvBTWeB2+Orrrt35OVXjQni44iXnnML4Hts
 wmcpI13DPTC0DpjQVLgcM1ZL1uWTN+qG3UKiC2A1ECafXkGQ55nGr1dO+O67FHdXvbwO6wRES2j
 tjJ25F85tqM42wEgd6rk/uyf1gmIYrma/NMymNQ4Zib6laNk6e7t30uijLcMTMdYv9GBc9W1fIP
 3gem0eiL7dcQi/jx0BCQGz4xxmaFK6e8pdQN+zsGuV1HDgjbQdoLOIMfsEoCXaaWgKLOnMJ22T0
 zP3izedLS7BCZdE3yAWanJ77+ntYbpp2VAjLYOF2UhdZDjPr+pMgN01AlI3VIEd5FhSxo1ztAVU
 s7TZSNiNYjI6zpoc9AJBNmTX3funDMNw11GHv6pJndEaRxcjY4GDgj93ReoeOeEpY2Nhtr+pwk2
 MANU4NoHl57lPx4MYd/SwBjtUw8gvOzmflLBKFToGDu06DFKni3NMPQPSiSBullC4O0KiqIjPGJ
 YOfgcbe79IS+o5CEONqT6SS4M3UyMlwr7m7E57QxjiTS7ZHKluvcIYkfnOaziBbKceXM2KMvdtK
 b5jAezAsPurmzTw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To make it clear what actions are in-kernel PM specific and which ones
are not and done for all PMs, e.g. sending ADD_ADDR and close associated
subflows when a RM_ADDR is received.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 25 +++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 21 ++-------------------
 net/mptcp/protocol.h   |  1 +
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e1ca90701fd92abbf6d8b92d461ddb18d2652391..c17828981dd6400b2ed74dd28a95e21f76ed37b9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -599,6 +599,31 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 #endif
 }
 
+void mptcp_pm_worker(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	msk_owned_by_me(msk);
+
+	if (!(pm->status & MPTCP_PM_WORK_MASK))
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		mptcp_pm_addr_send_ack(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_rm_addr_recv(msk);
+	}
+	__mptcp_pm_kernel_worker(msk);
+
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
 	mptcp_pm_free_anno_list(msk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 44362b0f7ee4f131482705439eb96c0374177c1d..2a8652886fce6ba9743d0efba576ac57f35a0077 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -924,30 +924,15 @@ static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
-void mptcp_pm_worker(struct mptcp_sock *msk)
+/* Called under PM lock */
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	msk_owned_by_me(msk);
-
-	if (!(pm->status & MPTCP_PM_WORK_MASK))
-		return;
-
-	spin_lock_bh(&msk->pm.lock);
-
-	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_addr_send_ack(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_rm_addr_recv(msk);
-	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
@@ -956,8 +941,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
 	}
-
-	spin_unlock_bh(&msk->pm.lock);
 }
 
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93faf203d987100f22e507c7f443d937284881e4..8742527196887598eb242c82f06004107d29ef92 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1154,6 +1154,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.47.1

