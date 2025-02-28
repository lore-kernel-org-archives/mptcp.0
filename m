Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7814A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749510; cv=none; b=gA2ZKx6QVa/qQE5W1qc8a2ZQw+oCsAkqdAO56V2qgKXNXU97JvbqPWb/wYQmeLnLP//RXZoO7c8TwGOItASEaoCIE28t8LM+l+EOTHgPKT5XcvbmUu/6KSFyte/ilVvZUIMR26MXLDowGVJtG/U+6rkDEKfKCfJGsdtCsM1eFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749510; c=relaxed/simple;
	bh=SjUeXYJPBoM19MRCQZV2/3BwMNlkzuPip0SRKCO8QAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE1UIBfvkfqJQVfC6WUC8XrVpL0DtAZNqchRs6kHZAS/DVYBP2pLlXvWV70FzJ5Tbp+PfcdwZia9+b2AFgToVkJVLBirNZFwVbjt5UVhhrNQLnSNEtiXQ3+o56c80TtgJApGAXm3C3gOtbVT4giwBL/TK0u3RHhKuDI1grzKYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+SRqz82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+SRqz82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6432FC4CEE2;
	Fri, 28 Feb 2025 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749510;
	bh=SjUeXYJPBoM19MRCQZV2/3BwMNlkzuPip0SRKCO8QAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J+SRqz82WgGJyRlTZ8sdc7booY1QHyq5xOuvXT4xpisRVp3sX8lbonHSzProYboBW
	 0Yo3E5+3b4X46tJtW+TBDgxMbpDlQvpjICXsB+qAd1fWABGu5/nrBpQPfj0CpzZTRr
	 TEGXegcuaC6lGFwOI8cod7Dt7sGkPdQEK6dvJ2Od+YrMZrJKB8/ajlqlgp6fN2Er4r
	 r9WJKMabQSUeZVMjHeodspUhqgPzjFcOU/MPrRV+JTPFIwsWyynQqYd7oy7WoIjZ4+
	 ynNvROsx4gVSGRNKkG36VjTqnwTQI/lqTtnVLURDX3AfCYQEIOP3ohQ/32F8q4V5r2
	 xYjmg80ljxCdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:28 +0100
Subject: [PATCH mptcp-next v2 08/14] mptcp: pm: avoid calling PM specific
 code from core
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-8-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SjUeXYJPBoM19MRCQZV2/3BwMNlkzuPip0SRKCO8QAw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6kC5SRHjAUAkPxXKgc2T9O94LWYKHqRkGn
 YdlCe2sKXmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 c+weEACzA3sMmVBpZnl+pHGQsV5UOWxNkIcbFosXTVVqSsMKaxOrzhsBp8M1oxJ+trihf7+zXlT
 CdBte76WEi9mbuuwIVAfXv0Zb8osD1IeQf5gZiLZtLYPWf/bRb3y2c6kFfEkgMBLYGe6ufPuKq6
 5D0tlX6wobO2DU6nmA4ilScwUf3Qg9MSW2m3hrZvrdJhrv/btPqBg7q55L/kiZAlZ6SyByaOcEn
 oGr06yUQpdl7f5QDXyX6aL/miHXhADGOq3+uhzYPO/2a/+MxPBrV2qLtz4Eldy+6Nb9FpaHWViq
 PwWLKcTLxecNynSJdJSExNitzbwMuxg1gR5ChBR6uOP3YEwEeUry1uk/EOJCN2SrXBrDEbRfnmf
 2mn9zyjX5/bRqhynTX4PTXL9x/sBQdbJXQNpyHWSj3Lli+U/QvaWN5j6T7rI2BYcKKzkU7+N63e
 Kk/LgpPVI3N7c8LHMroNXLLUlv1PS5UwnRVjMm+MBiZURyf8zCr9iBsUOFTl84CVs3Y0Dha04pI
 UuRV3quqUrzp2yuX5FQB0DY5DS0DuR0uodpp9dmWiQ3SCNk4zr6+I0SvE1dr9yrDuXSop0vQ8bo
 1z6n0B428y+Z08MLtQmLEyZbQ6de0Jx8dtqDePXJSWo9/8k6NhTQUSVidT28LiWRMz7Rb4uwDq1
 0a0Hjlqy45OtjnQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When destroying an MPTCP socket, some userspace PM specific code was
called from mptcp_destroy_common() in protocol.c. That feels wrong, and
it is the only case.

Instead, the core now calls mptcp_pm_destroy() from pm.c which is now in
charge of cleaning the announced addresses list, and ask the different
PMs to do extra cleaning if needed, e.g. the userspace PM, if used, will
clean the local addresses list.

While at it, the userspace PM specific helper has been prefixed with
'mptcp_userspace_pm_' like the other ones.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 8 ++++++++
 net/mptcp/pm_userspace.c | 5 +----
 net/mptcp/protocol.c     | 3 +--
 net/mptcp/protocol.h     | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ab443b9f9c5f28e34791fa75ce42ee013ed70d78..17f99924dfa0ee307cd10beea90465daf7c84aed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -599,6 +599,14 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 #endif
 }
 
+void mptcp_pm_destroy(struct mptcp_sock *msk)
+{
+	mptcp_pm_free_anno_list(msk);
+
+	if (mptcp_pm_is_userspace(msk))
+		mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 434f59b793ef9a581ab37667fc904927c1600199..8f9e749e9b1aec9c5afeac6a6fcce9481d246948 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -12,15 +12,12 @@
 	list_for_each_entry(__entry,						\
 			    &((__msk)->pm.userspace_pm_local_addr_list), list)
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	if (!mptcp_pm_is_userspace(msk))
-		return;
-
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c8cbdcbea303c1f3be3518985b5bbb3be10a697..bf94aeeec667ff3159fa4a1a8daa3abcb495c82c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3305,8 +3305,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	 * inet_sock_destruct() will dispose it
 	 */
 	mptcp_token_destroy(msk);
-	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_pm_destroy(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5e9708e4416da6dd4dfa2269436a4943bdb1c903..a91e6abfd64f9da555052386dd267e1ad1c16f5f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -988,6 +988,7 @@ __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum su
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_data_reset(struct mptcp_sock *msk);
+void mptcp_pm_destroy(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
@@ -1047,7 +1048,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);

-- 
2.47.1

