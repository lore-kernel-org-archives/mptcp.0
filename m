Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F83264EF
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109165; cv=none; b=bOf2VV6gVM71yZMhr7EFB/4Td+iHbQTr4Y9tAAfCPLJmS0BQ/6pKGXXTTEVIMh1X3PA+Gbe44uRgCEBkh72o79vsXh9StRkoaVT1tTpJhrVqg9CFhTbXozToHn3ZsnrxmRId/UWo73/nJKDDzfcVLZNk0hgOQMdFlr7KLmJw2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109165; c=relaxed/simple;
	bh=/CBXg61tpkYkvn48k1RHmRfWg+W+ePf2UQAkqx1aSPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5IxsPWSKEE8OGhRLiPBfjhM/GNad/MVfT9RCDSpTQp3FUqG2FnIBCQP+Xq+O2fUmpofyko5ATNadZ3YAAa/FoqiCiXlj+/5DyIsxBddsB9iQkaWfUKQJis9h62FoIAh/D+oxEmGEz8bh3udEzsknaO/IgJ00WvNXX8HCmmldhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSc3098J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSc3098J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDA9C2BCB8;
	Mon, 18 May 2026 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109165;
	bh=/CBXg61tpkYkvn48k1RHmRfWg+W+ePf2UQAkqx1aSPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OSc3098JEowBl4l1Nqfm27A1hG62ebQxJGxj36imkN1lr3iRPEjeeHzVgwDDOvn0r
	 QmZdZomP5bBtIa782zmJZnKAUy/F9ftcALEcYm7JVqWlkMWkw3Le9Tljv4Cu4J+piz
	 vngq0J0f5NKmoY0ZSZPSXjYXt2qxG5+kcNzC0yM6ObGNTI8OlHC8zQGdOG+NnWmtRM
	 BjHMXFcIRqo5U8BYanbIjsIeaTM++ooinFHLPcF4z/8bmb5943jUqiJ+W6Scq01Kfj
	 i07DPvkhbiIKJZW9MdPAZ9ur35N1njUgSvonw3PODbFHd8ZZhV7LGqw0mpvF3hhG21
	 rG+VRfQEGFP1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:11 +1000
Subject: [PATCH mptcp-next 07/12] mptcp: pm: rename add_entry structure to
 add_addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-7-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/CBXg61tpkYkvn48k1RHmRfWg+W+ePf2UQAkqx1aSPk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0h6ftuK8SKkEo+g2OIJeusY0/q9Khjhf8DZ
 N/v4scJsUaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c9aXD/9Usw0uLg3XDpbyIBJJLu88rGlZdEwT4HvGJ8RSujLpCDEb+CpsDHDsYpr8LDTV3zPEOwg
 hGmz/oV+fIA+ek3vEYi3ZnrNp2ncK+kVyYgAwCHSCDrpDJKeTwNvrAfVo6KPTbQtOFQ5l7bAoOz
 pcUGP/nqnmJEsCy2pAZtJvf44CgGNtuSBl3I2BJ/+pKFduruqlEaU4HHSYJ/EbkdYWHgZws9fqR
 GFXjgEdUR2PAGZradb3FfYRUfsu+cH4PXERROd2/G79azcv0fZR4CbQlVs/bj9ezeSHUk2ytbaU
 g13KsIzLlX8b48nsdBntG8m04Hg+IGbKija6G20kROFmSwQCMvBr/ZbxtKmJc6pZOuvDKSuIsUl
 +jkj+bVQ8pGZt8SeXp9d2xRo3TGt0iDqe7jrDdaGH5xHIACd6ZCsuNdlDRX9etnU7tBbVsin592
 x6sWFTN51g6TQSTmU5Je4Uf9ZBao6UVt2XzgyUNKJtcnh1B88wGROYP06A7JvWxGVe0BRcqE2ux
 Pq/KAhkbYTo8qFzljejRvpfLSV/vSD6A0cETqgF+YU8r1yEy3zrnogawfZ34RCDhGHqhmvYPmhH
 vDTIeHTd2u45HW37ljEWyy1H2YMQFNYVE49FGwFwtwKuu6lorUznLpTyhxI69XxtvYuBHoCMruo
 pkLctxKJWJyTTCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using only the 'add' prefix is confusing: does it refer to a generic
added entry or address, or specifically to ADD_ADDRs. Using add_addr
removes this confusion.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 22 +++++++++++-----------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55d6427bab92..0a86b69ee214 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,7 +12,7 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -133,11 +133,11 @@ bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 	return false;
 }
 
-static struct mptcp_pm_add_entry *
+static struct mptcp_pm_add_addr *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -152,7 +152,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
@@ -164,7 +164,7 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -340,8 +340,8 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
-							      add_timer);
+	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
+							     add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -397,11 +397,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct sock *sk = (struct sock *)msk;
 	bool stop_timer = false;
 
@@ -434,7 +434,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
@@ -471,7 +471,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2987f88f465a..16424229fe15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1136,7 +1136,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,

-- 
2.53.0

