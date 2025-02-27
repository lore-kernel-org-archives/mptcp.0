Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30526FA77
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686944; cv=none; b=p3WHy5MKw1KJEDYM2aw8aw4n2N/TmMQUuG7z8mC1NQGUwaYkv+f7BduMVTloLagbGyqiUXO4z8Kihqc5s37xCbmyY+rpwUEerW8/oVKj+W1FQDTaFMbs4Ifs5YGq/lMyNvoRe/azQlzOTK/ue08QU4xQtiLii/ha0q27iW1CfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686944; c=relaxed/simple;
	bh=UIORiTavKw9Z3pg5YyTv7DaW/Riftj6MHRsOZoZovfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmDD5219Qqte0rRAZCtgUpwB7Iuvhn8Dis/IRAgib2JRTJe7aZl23YjDkSp2IkKgsGTUAfBbXIo+FQHG0QCMmvS0/9skAUlBODXXEn0v77PE7mQwoZcIkT/MWRcrQ2+P6+EAwZGDO0EjyH3pVrLPXb8a+J6xieDZbbM23ugin0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+D3JWAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+D3JWAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88045C4CEE4;
	Thu, 27 Feb 2025 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686944;
	bh=UIORiTavKw9Z3pg5YyTv7DaW/Riftj6MHRsOZoZovfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b+D3JWAwvBE0iqP8Y4FtJan7ghUNPdCpvTKR85FrwAzouHygM9PsXeNKIArSYMGCj
	 1IF2JGRuOIHJw1Ea1Gl/jgc57NNTyX7GLa/ry2+Cal72M/kmRg+g8jGUDlGem2LRa5
	 K4Mf15MWvYbyJxyMMkTx+GB5dFp755k/W+d4ZyoojZt4Is/H05H4t/oissPXUwwPFl
	 HluOZoROHnfeNfoPXjlb18RsuGf8zwYR978zvUhvwCwo3fAW9+ciyU6TRxLV8e0E8z
	 XmIqMQ3d5zzWvIRVqvBrYYgSR54cfTNyyXoZ73CgHF6XNO4FXNvN+3AtMoTJgTo7PF
	 MU2J4wilhUTrw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:52 +0100
Subject: [PATCH mptcp-next 5/7] mptcp: pm: avoid calling PM specific code
 from core
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-5-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UIORiTavKw9Z3pg5YyTv7DaW/Riftj6MHRsOZoZovfk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZYPPKWPUD/QmpRXzP+oB1qT7aFLBf+qjcug
 zc2oS3ukpWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 c7BAEADuYdpWH3P6Aua+38lO+9fBa2+EWZNw7w4oZFh9Wi+yqHqBIdn392aowAJ+ZKXr+NbcjcZ
 agNrG3rQkW3fSWp8RSSsaD2vbV2ufuvIr4ejyL5JX6P6dAN4oIAf0Ngtp6Z3JU+EAEPkYJy3tNu
 dmwUprivPBaLvjAoV3JrTzYuiDJiTzoWbl41x4nuq3lYWU4KY/TcjcbVHtkboQ1kMZOz4sc3Iiy
 8PmciN2t6zkR2jeLM3SnJQIO0RJarHOIbgYoLPPXQdRDmo8VgkJpjwjxmug78NUxTbpaD0xrb7M
 qX7iSW51xo6S752MADinWMgEilRwjXDjDtOV1T+fJSdNeuacoyl33ot5eH7ivUbvbBjbDqaYicV
 3PA9GimD24ttPnF/CMtspEvUKSerlFHCJ9nvyVSvy//fMTG6omoJr3IdcS16enPBNcpIzhawWqf
 ZRvJsSM4Ejr1KYbv0XHOnQe7OeamDDkpuZwCqWec//rwb4BNg3Tmv3NCPMIoLJ/wB04UFLyCMBW
 pTozljemgXAT+2MNDGb+iilIkxeHy2amYHAzGvoTlPMQbSyZJfC3TUs+i06Fwf1C2ratMkD0YWb
 YGAfUyaqM3lBaW9zCXnFe5qxH0fTcUPgHSDl6ts71FXXPqTiXVPWjM5k8dIXTQhuAMp+4Mt/ndC
 x6PQejh3vnd2ntA==
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
index ece706e8ed22bfd10249f6e655a0d790dcee34c1..e1ca90701fd92abbf6d8b92d461ddb18d2652391 100644
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
index be4d02b9510df06c2795ece6b999bee1c08aa981..93faf203d987100f22e507c7f443d937284881e4 100644
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

