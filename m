Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82718271290
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686942; cv=none; b=e0T8yVPL77APjP/uZvz4k2HFFslkdTYCTLCxBo8tciFLU68q0WHqFjvbcjmF8XBTLGB/GM9QfWXkq6BcPjZwi38ZEu/9Q9Sh4F3lMppmZ84TyQmTugqQ21TsO/jL1HgZvciELDKPGPTlnQ9OD2hgCHGdDQfK2sgyA2kNv5BIu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686942; c=relaxed/simple;
	bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xdv+HIik5kaau50wuzl1bOzbMz3ateXEqbStzfcvD7whLjQtsqDZ9hMAJ1g3EiExEbjhOks/BE0JmZFp2PP/WywZye7cwoaVvp61rid3FQ+fYWVAY00/AKrmn8vZfShxKxNujibgDKx0ZLMJsCjH2c5lycWKTkEpBrWfwQysW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA9BHx1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA9BHx1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE81C4CEDD;
	Thu, 27 Feb 2025 20:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686941;
	bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mA9BHx1hv9kRsATlf3yKpmMi8CbPXxvXvZm23GtGeD/1sVNgjLXk+W9NLG3lwaBVu
	 8C/qt8CuhBRqRR8+I0gACtmiGsu69cpcMy25WKMYPNVCvpZzEI9wwpy9gQFsRDnPIA
	 7U6f29B5gTLKcwcpDsJOCvxFFOGjsAYOTIDSoXvbawtr6hKuf2jZtz0x79g1j95v1K
	 LyqxRmSRjTc1m0MImWyn1YtDAFyAYhYc24Ek3cu5uoSh2fakZ3WQggxhLEro7KVg8F
	 s52dkjiWlyYoi3GUbc8xwUZRB5qEbuePzRP85crUToaeh6ER2NlCfVYzhYwz8/yMkD
	 kSqjXnR7ABKMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:50 +0100
Subject: [PATCH mptcp-next 3/7] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_work
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-3-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZY/YVy/oSfViZtzmDvKaLHviD0xxPudE3C1
 uxc46bXFR+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 c3PaEADuXf5kW5mp3rdRA+eRbGBypwefPEB/0m4MnkEmkLU0a+5QfZGM//4u+DKaAcaAIhRz/0e
 Re/THJnZUQ7RRwHAeRa5DeGl0ML06Ozvw9BIOd+PQxMQ1IT7SW2acQJGlhHcZTsHxrnufOhxLrm
 VCd2yGSyXh+JlorMaxlMswz0T3VNY3io8OvEICgT+VHfZK/EboraVI0kZSwHdH8Xf14gBdzUIqd
 IjabAWsYGDUabc4rFGmH/QXfkj9wvA2zo3elJX5qHTj869QD6PeWikj/sn4p2dqc/1HtxH3nigb
 qyOnpGl4THzENa54RS+wVRjgR7x6t2vh7gxlkeK9+WSerL0mqtVyYcONlKddb5K8tQxTX7Gsxqz
 jke1o+oU0ufeaXRmiFUhMJIRhGfMWiteeV+jDSH1i86EIy7psnrYxzP1As8m6yS3XcFezjNKypX
 /8DAJqtHCVa+gpSxj2bnlrmPShRZpupiKqj/LSS6surZGWDO/P4As8sQwLjhhceVZ6IyhoF+eQK
 7b3+ZBCa21nvGaW4NSrcRSpkL35muDyBtA2jWdly5/2cKoMEnR27QlTxPv4hwI1E5uObMEleDZ9
 XY0w2sPT+hQ20zEDXthU/2iOfTsOmI+TfIHC6SpktVirUSBqyh8M6F37lDQmnl3px9Kt6LJg4RI
 yGg3jhuEhCgAQNg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_work' is not specific to this PM:
it is called from the core to call helpers, some of them needed by both
the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

Also used 'worker' instead of 'work', similar to protocol.c's worker.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.c   | 2 +-
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5494b5b409dc478dc783844b9cfdef870688d17e..f6f7ea25640b7f0f71fc6cc3217ea278e15a4c13 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -924,7 +924,7 @@ static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
-void mptcp_pm_nl_work(struct mptcp_sock *msk)
+void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b48cf648346896ef4381ac3e541cfde5dddf1c3..0c8cbdcbea303c1f3be3518985b5bbb3be10a697 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2681,7 +2681,7 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_check_fastclose(msk);
 
-	mptcp_pm_nl_work(msk);
+	mptcp_pm_worker(msk);
 
 	mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin_ack(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 500c147cd4d4b4bf274b65fc9a181417fa90bc1a..be4d02b9510df06c2795ece6b999bee1c08aa981 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1152,7 +1152,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
-void mptcp_pm_nl_work(struct mptcp_sock *msk);
+void mptcp_pm_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.47.1

