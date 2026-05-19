Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28D3BB68B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225939; cv=none; b=nG3oJ0jO9NFqdjaNoIH/OYSFdnq/NWwE1F5zjDYniW3N1GQExnrDwDh0GfiwPFzDNSCOreMad6NgcRnHuDVGud6KVbttiME+9eu1BBe5ltcx7ICFMyGpH5p87r1aggMGaW7lU8374EGdFMsFN4rkpzs5ujJZZmIqJtSGNaHmlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225939; c=relaxed/simple;
	bh=fkqrKx+PwCe1bbat+ZBAv2GdFwm7LUcqkZV58wWlSnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5Cx2jekNuTWSPwuOlcUyE9mqVVYOhHfqTa4vXNxfLZUFq7NQrgBS1md9yfU6jH+CE80rTnusfou4AzCsW2JcborNSsbmS+7YUDVqSEXicUp4z3EnAPnOVwxHq5iefjD4pUqu2fqXrh0NKfLWZusNao52RizZZdr8jO22bisAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI+XFPJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI+XFPJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606041F00893;
	Tue, 19 May 2026 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225938;
	bh=NilvR/TFPPN+XjLpPbz9qY3R/smhTLnFv8inJa/8UTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nI+XFPJWIsx8NS8l8jQ2JFLo7acLLkvxlrHAepoJIyA6g5WbzDaQ4UyV8cPhpuXt3
	 Q7dSn09aXal5yBZP7+dwg+5sgi0huJSVCZi2ypqKOtsTwJoRwr79NAJcC++N8LNvNY
	 h7FAIkpDT/UZyi8nXGAFeyWBxVxt64RsAknMD+CptCpueaKHelpsv6e07yQUAChDRd
	 T+eEQdhrgQqLsvwrK2Z/pN7YkY8KeDrIE3CXG5U7FyobfORJNHAmCZbXTEh5ncWAct
	 KY0tvL5w5d3ARggzMDz49VQv3Uvm1M09kzI8fYRNH3kWyUSEYzhHS2TUHQiGiyTYpG
	 4C6E6Y4I9iXXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:22 +1000
Subject: [PATCH mptcp-next v3 11/16] mptcp: pm: rename add_entry structure
 to add_addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-11-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fkqrKx+PwCe1bbat+ZBAv2GdFwm7LUcqkZV58wWlSnA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBObkoSwULUtrMEb5jNm5df6nJf0nvIoJl0
 pIhvPge5iyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 cxQWD/92C8yMdzLjHqAqkMZn5sJH60aXSks1yp6mAWizbPcn57GFhGOoCsz/WoywtweRbWIxL85
 v3cxVUOqMSHWmeLK7LZg+TBPKyB05Z3GnhPb8PJCU07qsIgLZwFG6OBk6fCiYQUATiKpXcMLF6i
 gTb6DjeDp+7Bcbrju5CA+Zd5m94FDF/fDkc44R10wvAmnqaXHEHcBiFM5ht/GnovAxiaNGFHIr6
 EyYZ8BL9SMHRCigUiupnng+MtAM9QsRff86Yp4A40VvkqVAosuBtjkTYNmmQbwJiRkMNqCyOXkN
 Gs72VpVjAGh4LAyrFtqgWaKo+MWFnC/JIgGZAgYUBuZMd3eX8BTs4Y2GOGqhCOdfwWnrlmXuE8e
 PGWZYFXg/L5BarDmdWn2bL32RfD4Kc/yZ06UG9EDPnDNo1oSKNXFPc0fRffoL5pwwn8Qgi/hJO8
 JTdeYxk7R+9kLw6/A2jhggITeEdEj/tYNI3I6i06W/Wnkn4uyq4gAxHGBszAqd8FkAVknm+Vrj+
 PAldIKQig8SMf/r6diBFTODP0SwsNcvpkREbX9//kPtdJs+Xp28NVSjRE/gduvoheX0Ie0an6Z/
 anpcizHmON6jAHCsu6p4wnuhqeeqB6SoBbB9m5xQMFTJFbDe4oMYF9/ILIpufkgKS+GBDXTCJUy
 0nf/I7B04qSr8jQ==
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
index f7d00be60ce5..e5d2d66193ed 100644
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
@@ -397,12 +397,12 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct timer_list *timer = NULL;
 
 	rcu_read_lock();
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
index 7a0f04e5b08a..59603bb1308e 100644
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

