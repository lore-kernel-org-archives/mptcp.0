Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEA14A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749511; cv=none; b=duCTYVwJlTBGmVWwQS4af2zruJgyAVuxn0j+Eu7afpndcUyI2WC6e6NIWd/uowxbuN+uOUEGwF37mCPCqLYA8rbKFuN1dKBoLGBlegtPlcd9QnUyUtWkepcZldYMjhzdv5R8cX78UEM+kFoOFRzcGzuLU3U717mSD6rdDQe3JRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749511; c=relaxed/simple;
	bh=qOo4qlm3Azzg2s2RwHoS9xknIB0n9IQNsCk/NTKJVsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7x/GGEOCqpDs6cyObLze3WpV8jeBoQRtii+TINP1d1rRl9qgGEz+hdPpslKhU1wE87h+k9/jZMH/FprvJlbpfjLyA0z/sAbK/QeNxN902vrugKyVOu138YGpLRQa3U6tqIZPKIxZaZ0cGaB4yQqyNvCYVzGkzLOLQHW9Xzrdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXWtfFvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWtfFvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F592C4CEE2;
	Fri, 28 Feb 2025 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749511;
	bh=qOo4qlm3Azzg2s2RwHoS9xknIB0n9IQNsCk/NTKJVsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aXWtfFvneL4uL69pIIPUmGPcmKtb+B2jp9DFdmtJVwnmr52wU0dEKyudJK8dcOqlK
	 YlxqU4C85lHE9TbcHr7qapw7gb5Pvgs/V1EV47cN1xsfeGvwIOq7ViIheE/CGGInSN
	 j4e0tfR4rGkpU3/5Qqt6pHyaMc8KISnlTZonDF0PW/i8/KJDcPPwH/KhlcLrTMJOK+
	 spcwljBxJegvtyDeMSrtuMJgW+1QpzGxpYjDitmV/JJbme+UJBciuTsYqf6WCNF/ZQ
	 jphzP0aFklquu01iEoFfhOa+nhE72wGJoIdWUevrvecs0Qza+zquDS0Cy9pp1v1nR7
	 yMxAFuOkt2AXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:29 +0100
Subject: [PATCH mptcp-next v2 09/14] mptcp: pm: worker: split in-kernel and
 common tasks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-9-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4486; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qOo4qlm3Azzg2s2RwHoS9xknIB0n9IQNsCk/NTKJVsA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6KyD5S04iteH7r0+eMQXWQqzexdaDeDwR9
 vDiwDSg0jGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 cxwXD/9PXcRA3AhpUFbCnDSLv0LthhGcocLTwJxMnnSaW54t7FWZ57Acsr/BYk+33B86UWty0br
 goqhpGW0hsCBbLl5iJalWb7BzmJoM369Fx3yLqsDLq/uj1sw7+xUmO0/kaQVWm7gZVq5SY0zBmU
 0unV7D17+pUaJ5zgMSMU9XdCLveZQF8m6Ip3NSiJWC9jp+quDh3kaJA7bvRsThJMOFoy7fC0x+W
 IsNnEbc54bV3T3MBkhPMqQxmviDeczPbsOMLIqDR6LlzkCCqPSDACvLQJXU1MyIEFTJKOKy3O1n
 plHqAGC0y9b+tin4PNVwNoDEBypeW7ID0X26q0AeY33I/ERGq3h2FAaEdOcavYeOZcI6ra5KOPY
 FhpwTgHPGVI8xDj6AogScrEqHMHKHmDjuKhdMM1bQ9KyYGfv/7BRBMnicP44yGq7vQAxvwfIc6j
 cbi4dLXHu/gH3/RScO3cz8QxIUqnzZQLVGPusTHxmU492VVgOjOVkCa/cPl8x5byqUbGrdcDWBJ
 1Qy455cFhmDKPplrPNJ3h8gCDn499JC4Ig/D4yZS1rxehpi2ysa0WbdSEGcSSW29gtx+JgUldMe
 uPMbUXs9VUBtzGE4NGi5KVkjym30qjuKQ3vr82dLE4YI5d5MyBKAqAfVNznfAd+2DeBSOwCf9br
 K2PgGJdkDWdNk7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To make it clear what actions are in-kernel PM specific and which ones
are not and done for all PMs, e.g. sending ADD_ADDR and close associated
subflows when a RM_ADDR is received.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 25 +++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 23 +++--------------------
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 17f99924dfa0ee307cd10beea90465daf7c84aed..ddf9d0dc6274535b7d061c0c3b3258ec7dc7576c 100644
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
index 781831c506918cf3c4b93549cefa1a54373935bf..37986208b9c0aac48d9a7b29fb37e11e947f0d66 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -912,7 +912,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 	}
 }
 
-static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
 	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
@@ -923,30 +923,15 @@ static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
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
@@ -955,8 +940,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
 	}
-
-	spin_unlock_bh(&msk->pm.lock);
 }
 
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a91e6abfd64f9da555052386dd267e1ad1c16f5f..83ac7ac08e7723d8aea62f9d2f03f2d01ebf01e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1015,6 +1015,7 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 				  const struct mptcp_addr_info *remote);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
@@ -1154,6 +1155,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.47.1

