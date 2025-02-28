Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607BA14A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749504; cv=none; b=fPd80pXg4IXmduznrGZa8SlqiQ2zUF8S83VhGj1DhWzVO2blHC7ClBje/ot3YmfZ5EqJVD/+vCpIlF3TJqZ9HLU037uRQxyiVhHx/868e/e8qJ+eeC4PFL2xX51LCwO8ILSHG/NW5xO6wPlFev0YWCUzqmIccPsWOI5BDkg5054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749504; c=relaxed/simple;
	bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+ix8eMr+mD5WZytb6I1PG9eJ7XaDFlEBDEGVAUjOmWG6SmVXkjSmDfzqdCQLlBM6uoA7zKO1rLSLFa+FkRQcFc9lTiz8il82zNmkigmSqyjoNLYnJD3E21+RMP76Rxz3nRZVumyxcxIk2+bv1lKWj3fWmWneEghnGQ/sewGV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp7emdw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp7emdw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D59FC4CEE2;
	Fri, 28 Feb 2025 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749504;
	bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dp7emdw+/bYnsMZ3xlpNzTeBOHcmX0EUlgnuTzUPB03GtqoYLW+sEMMBCZKbwffI9
	 uapsLuiWTKxattkyzZUnAdOZxny3f4RN5+BkhOjexDQKFzHdjaN/PwlKU2PXEw38zj
	 UH1pTwchyeFWpP5PPfQDw/aBMcWcHLVMa/0uemYR5mn17uMOKD5/Wh0pYN/3HbpYcC
	 8/IzcWkfRcd7bvA9Nry3gXUjK+xEgFxChDAEJzFkU/sxmHcx8zp78H1a78bLjXcwQf
	 d9TVBX0CJ9BUZlkmlCOtkZZjXl11VBdqMF2544bm3Lz3Bp9c51V2rdXoLcq5ETtqCZ
	 NfGCGGLZAn2yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:23 +0100
Subject: [PATCH mptcp-next v2 03/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_work
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-3-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2W5IOWEd4fCHUHdDsL6jaxM47+9aB5RZX3pzpD4s46g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5xnjOYCYZak8vxxtXIh0M2BJn2dEuP5Wl2
 0EBjzp5KlWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 c/CbEAC6QYVVp6/BiP8bCY+bU6CoOE0mrROYVXC5XZN8BnsypaDEn0sBUMKWd5kSYl/vHofEZEk
 t48AH4EDfs6P1ln5XDU47YG9UPwLCsrs5L1AvUZXpi3MFN8pAyq1qY6Z0Cvg7o9pE5C6J2xXng3
 cQeXo93TAslpF0fNitKHxMyAatMlMQFKRjp8C9d7v6Cf7A9nCMzDIg8gXSQnxMXZuGhWXoYMB9B
 HJV8D3SzWvKAjlu+pzS9BF6RDOOUvJTqkzza1lKx9TMIYu8LcU7bMAJf+5EP7AGrECUD7G3zNe7
 tQnnHCxTz5/6ZYG0SxXL6IlMvWd5IhClBGcWzxHJbVz6c8V6hatPOlvAt8zwh458IoAkhpxBPys
 QeVgiR37uE+C25z4IRCNd4RhH9/EOEtiWzmoDy6qCZPDnOxXsB5yolRCDClBY2yhQVfL+b/kgtV
 kBG4MHz/3izd+9y4OmNiTQObfZAUUPebnG5NzzTkSLhR+MdLvk9Y7HFAm3OakUggc24Wo1V8otu
 NeEV/lQYDxNE//1aBSaJZvc+6TLEJOR6DUWm2g1whYhjkWy7S2b5ymo6MFtBwd3RyCDWq003/p/
 mdj0FcwxC2V5QdHWoJGxIjpOQgHakvCN/2DVL8ZO7nfF9Ju210zQ61RMNw7aVrwuo5L3utMwRjk
 yQ7iz06179fFWPA==
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

