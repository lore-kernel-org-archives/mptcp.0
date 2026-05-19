Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B434D910
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169887; cv=none; b=uspKFHsyOC9K+PYv/r8JtQAwQ8QwVjbvYvLn2+NWapYZy6uJZFyl6uP6XrpKrcGaUNzILnZbRBspoIT2lNFKZ2X/IJA0GbDd+1hOF/SevkgSPT7cCFUPBhFsP6BmC6c3tE994tJbcb9GxxQEiJZ3HGLXhNVVWLojeeid8Ndh67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169887; c=relaxed/simple;
	bh=uzwaf0vLhKEAxIslzA5V5Skg3N/Qi78ka8PTR3lRDEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKZVaFMvgyhSRyM3JicrEbpj3Hkx76cHh1piV1+eBnUTzUGMR+LCdqc6nUP4wpaXcL94jCt1CheHUXHpGEueWM8jAjPzfhHAzdqzWzaKlt2Z3J8BGuNBcMt/7gxFSm1N30IEo4UgbKzhHQdrPDssgcxSQ/CoNarmW7Q1hxJT3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwPb11d5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwPb11d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A1C2BCB3;
	Tue, 19 May 2026 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169887;
	bh=uzwaf0vLhKEAxIslzA5V5Skg3N/Qi78ka8PTR3lRDEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwPb11d5g8kEc6FRLYkPk3UYeUFzSy3J+/84+KHiyqfCEHuEl4wVqZUQw0qcOiCOf
	 jYHDqU6q3VNbtTOZ2E4LvPBo2gyRMeZAnntsYzZJJ36F9RfRFhcBevMnsmloFH3iKa
	 2KUq6QGTAR59CXATmJtD7vgS64ypcW+c/mZCP3f5MU+bVP6XHHdmcnmdysxS1KPha2
	 Lt1TSf/s3wdqWQAh2cFoL+Pi/uVm34udSPhZwzxyjCer00rWv1SSKxkgZcptcrFsKI
	 i5ikOUI7GcTwJifW+UOAEamyE6sqzwY6watekhxOHe/mT+R+Wnfk82hAn9f62qyv/i
	 TSCjTGfW/VF+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:19 +1000
Subject: [PATCH mptcp-next v2 10/15] mptcp: pm: rename add_entry structure
 to add_addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-10-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uzwaf0vLhKEAxIslzA5V5Skg3N/Qi78ka8PTR3lRDEo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS5Y8TTOWO/DKI+BzFHM8qjtj8t/1/r2gwU
 BO6aa82kGuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 czFjD/4uCuy4YAKSULiRDf5HnkrYMPbiFmAuY5FoFPVODSCcx6sX3NPjGo1kS/edhsy5z7SJ3iM
 JEo2oeF7p2ey/IGoPLUCkMtsS3BjnGqsm+rKEeCGLFsUQSuXJouFzAzOqBLtqyRtRHzh9NUhKO8
 0Tn1ZRdyaFxU8r+aHzp2bYRmyprTk3NPDxgGNVsgEjegPYfAM6GZy3iRe93P5cOKPM24mU5ZuVo
 5eCOUo++sky/0I67/I5ReiiBAFrwE8itPnYl/hvQ+XnsJdNFYgHL3W9HFF2sgjPmEj+5wf6Ixm5
 Ck+xM2rSsOEm2t37egclX+yS5SSm1FXnMM2tkxcgic3jcNfefBFBQwPsX4MTMWrBOHhbim6zvhH
 CtswbUjhjHYna85fyGAV46YDjzZm5FmVbkiBIhXy6YIt7zsEJTF6Btj/XrR3It86KTKVXmK6Fum
 Ty/iwRkikrQDLGKlg8GxBfsNuYMVQPc4uGa1samQCEm8IBU5n79qBtkl6oNtEx97kHY63VUlQgl
 SsL21l/67FJTe+UV30oUwh3Am7GBm6uX2ueycCe/nksl03eoc423zDdBwLZQab8DimummlD0kYq
 JilFD5x027Wspj3OOldSGqlnSst+JB5UePXeU/pi2lOReJBoFKCPE9lkHzB2WrriM2Ft1M1JFi9
 H5PnTLWOnF4KQJg==
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
index 5c4ff1dce1a3..8ced3c740dea 100644
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
@@ -435,7 +435,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
@@ -472,7 +472,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

