Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD1270ECE
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686947; cv=none; b=aDf2Ds/LeplKGvZa+lpk0aTbCBuSui4BOMoA/uthTiLjvrRff8P+LgHJkXBMmQqIWi7EIfRpABwk7WNdIG7XTimOb3BC7HQI4twptwVhDregXa7d5vfmfxf8q7iX5BquVTMHafFW13UmVNVH+j5yMdCRI6pzoNijz/1i7ZxKAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686947; c=relaxed/simple;
	bh=7GEZFMzYrOJ+55D8d7JQ1WpQFAIF6W4yweWIp4RoQMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDrDUgUnUkNXeLBenBF8y9F7v/Rgcag1XuFXHxJ4fXArq6ht+P0Lqaedfo6eRK0bNld9hGSBRi/O0xi/V9NqqRbTBtlel3EvvO9n+l9muBHuhW1pM1swd9Vsol3Oe8bTZ7GddC9iP+JGMCUjQOCgbPVn8hX3UyWSAWTKkHpm3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBy/JsJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBy/JsJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13CAC4CEE5;
	Thu, 27 Feb 2025 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686947;
	bh=7GEZFMzYrOJ+55D8d7JQ1WpQFAIF6W4yweWIp4RoQMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mBy/JsJ62fIP9QUuEleJTCgklSLVhvct2TFPdcpwi5DQDJMX0aZNghuPJvv0eucJz
	 rMLRoRETwzUghLSfo1scWXaatNpGGkUTitnMeq634XjC8v9QtLgCHMacn53dVi+VVj
	 sKSv+aRzHzhjw4ENPdk3scl0adF5e31430QxCZWs3babNyPTJfu8DLLtIM4q9hjL4S
	 QroeKZBmSi5KmeusAH/jgD4JTSpuKtUYnf0NqeInxiW45YrPJlEdSz4pyJfSmjyd0j
	 dJpyjuzzgb9OnDi1plUVsrhfyhFkE1XORlTjBamsQnLBk1Yttx2Zbk5VVrEHZxQgM+
	 Wn0Ywd6FPfPbg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:54 +0100
Subject: [PATCH mptcp-next 7/7] mptcp: pm: code reorganisation
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=125994; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7GEZFMzYrOJ+55D8d7JQ1WpQFAIF6W4yweWIp4RoQMk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZZAJfVwuucV89AdS6JghfmhImPsUc6KYYA5
 ncZJMtefwSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWQAKCRD2t4JPQmmg
 c4Y+EACaXtWdjlLwfcMKTnNuCyAuqjpbWhQnfEG13nkVWssE0LOo70iwi+V3qDMRLdwCmUoxs/y
 DkFhiMP0/ugrIFtrx0GEJeYPvoJcgLUr0o3QfewYitMAmZ1oea73rqJvX0RvndPOBYVGTg1ryW9
 ToZ9ubCgqAWhuSKhqW2h3fmuWCro9/fYqxzeSIMxooEcWP/83PBj3yqDm2u7ARbad0swUueTeHT
 lNRSdH3JE2KF6rDUkyuFSZML6zg0X6oDqpjNp4pbWRc+VNtrOfdc63U7UW0fLFbwOX16Dim+SEF
 RL7FnAFNUh+bVCfaYo1KzRBwfWeOtGtAS8Bym+h+O/niTSkfzntzQ0QAwV3crdhATKuyncgjzIw
 5I5YTYFy7KIvCxtdi1yxYQq77qJ6/WwXNTUXtLnFlgfNYPa6crZ41xarWPp5hdEt6DBO5FArXaz
 YBAbosjnQl/Pffyb4u4MGrbFuY7cutSKLho8ZX7YUQrme4iOlKHXP5RZqwKHwzQxENCPlisgmpj
 SZVjXPGAxCHzmB2VUDqvKAkQWLOoG3v1UvRGDwSQpmJ/BeEg8U9sLIRBIT/XmZXoWYbYczi7PKU
 r36GcmZD+eXHjBDEzM2PEeNWODxHXPvhDy7oTtkuYf4IsKpcIi6BTkqzA2Gy7dVQDqpOusET/ZN
 A00Np4CkCRW5n2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the PM code was dispersed in different places:

- pm.c had common code for all PMs

- pm_netlink.c was supposed to be about the in-kernel PM, but also had
  exported common helpers, callbacks used by the different PMs, NL
  events for PM userspace daemon, etc. quite confusing.

- pm_userspace.c had userspace PM only code, but using specific
  in-kernel PM helpers

To clarify the code, a reorganisation is suggested here, only by moving
code around, and small helper renaming to avoid confusions:

- pm_netlink.c now only contains common PM Netlink code:
  - PM events: this code was already there
  - shared helpers around Netlink code that were already there as well
  - shared Netlink commands code from pm.c

- pm_kernel.c now contains only code that is specific to the in-kernel
  PM. Now all functions are either called from:
  - pm.c: events coming from the core, when this PM is being used
  - pm_netlink.c: for shared Netlink commands
  - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
  - sockopt.c: for the exported counters per netns
  - (while at it, two checkpatch warnings have been fixed: remove
     unneeded return, and the duplicated condition before a kfree())

- pm.c got many code from pm_netlink.c:
  - helpers used from both PMs and not linked to Netlink
  - callbacks used by different PMs, e.g. ADD_ADDR management
  - some helpers have been renamed to remove the '_nl' prefix, and they
    have been marked as 'static'.

- protocol.h has been updated accordingly:
  - some helpers no longer need to be exported
  - new ones needed to be exported: they have been prefixed if needed.

The code around the PM is now less confusing, which should help for the
maintenance in the long term.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/Makefile     |    2 +-
 net/mptcp/pm.c         |  664 +++++++++++++----
 net/mptcp/pm_kernel.c  | 1410 +++++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 1917 +++---------------------------------------------
 net/mptcp/protocol.h   |   21 +-
 5 files changed, 2009 insertions(+), 2005 deletions(-)

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 5dbc37d38d7a4b0779c71e7b291ef83a49e46648..bd72b300a0f68fa862bcae5aa1e1e913f595f315 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
 	   mib.o pm_netlink.o sockopt.o pm_userspace.o fastopen.o sched.o \
-	   mptcp_pm_gen.o
+	   mptcp_pm_gen.o pm_kernel.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c17828981dd6400b2ed74dd28a95e21f76ed37b9..8b9117abbe7cd22e8770810e9d5aeb9ee0e001e6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -5,12 +5,399 @@
  */
 #define pr_fmt(fmt) "MPTCP: " fmt
 
-#include <linux/kernel.h>
-#include <net/mptcp.h>
 #include "protocol.h"
-
 #include "mib.h"
-#include "mptcp_pm_gen.h"
+
+#define ADD_ADDR_RETRANS_MAX	3
+
+struct mptcp_pm_add_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			retrans_times;
+	struct timer_list	add_timer;
+	struct mptcp_sock	*sock;
+};
+
+/* path manager helpers */
+
+bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
+			   const struct mptcp_addr_info *b, bool use_port)
+{
+	bool addr_equals = false;
+
+	if (a->family == b->family) {
+		if (a->family == AF_INET)
+			addr_equals = a->addr.s_addr == b->addr.s_addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		else
+			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
+	} else if (a->family == AF_INET) {
+		if (ipv6_addr_v4mapped(&b->addr6))
+			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];
+	} else if (b->family == AF_INET) {
+		if (ipv6_addr_v4mapped(&a->addr6))
+			addr_equals = a->addr6.s6_addr32[3] == b->addr.s_addr;
+#endif
+	}
+
+	if (!addr_equals)
+		return false;
+	if (!use_port)
+		return true;
+
+	return a->port == b->port;
+}
+
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr)
+{
+	addr->family = skc->skc_family;
+	addr->port = skc->skc_dport;
+	if (addr->family == AF_INET)
+		addr->addr.s_addr = skc->skc_daddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family == AF_INET6)
+		addr->addr6 = skc->skc_v6_daddr;
+#endif
+}
+
+void mptcp_local_address(const struct sock_common *skc,
+			 struct mptcp_addr_info *addr)
+{
+	addr->family = skc->skc_family;
+	addr->port = htons(skc->skc_num);
+	if (addr->family == AF_INET)
+		addr->addr.s_addr = skc->skc_rcv_saddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family == AF_INET6)
+		addr->addr6 = skc->skc_v6_rcv_saddr;
+#endif
+}
+
+/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
+ * otherwise allow any matching local/remote pair
+ */
+bool mptcp_pm_addr_families_match(const struct sock *sk,
+				  const struct mptcp_addr_info *loc,
+				  const struct mptcp_addr_info *rem)
+{
+	bool mptcp_is_v4 = sk->sk_family == AF_INET;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
+	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
+
+	if (mptcp_is_v4)
+		return loc_is_v4 && rem_is_v4;
+
+	if (ipv6_only_sock(sk))
+		return !loc_is_v4 && !rem_is_v4;
+
+	return loc_is_v4 == rem_is_v4;
+#else
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
+#endif
+}
+
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info cur;
+	struct sock_common *skc;
+
+	list_for_each_entry(subflow, list, node) {
+		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+
+		mptcp_local_address(skc, &cur);
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+			return true;
+	}
+
+	return false;
+}
+
+static struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, true))
+			return entry;
+	}
+
+	return NULL;
+}
+
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	kfree(entry);
+	return entry;
+}
+
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+{
+	struct mptcp_pm_add_entry *entry;
+	struct mptcp_addr_info saddr;
+	bool ret = false;
+
+	mptcp_local_address((struct sock_common *)sk, &saddr);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+			ret = true;
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
+/* return true if the new status bit is currently cleared, that is, this event
+ * can be server, eventually by an already scheduled work
+ */
+static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
+				   enum mptcp_pm_status new_status)
+{
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
+		 BIT(new_status));
+	if (msk->pm.status & BIT(new_status))
+		return false;
+
+	msk->pm.status |= BIT(new_status);
+	mptcp_schedule_work((struct sock *)msk);
+	return true;
+}
+
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+{
+	if (!mptcp_pm_should_add_signal(msk))
+		return;
+
+	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
+}
+
+static void __mptcp_pm_send_ack(struct mptcp_sock *msk,
+				struct mptcp_subflow_context *subflow,
+				bool prio, bool backup)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool slow;
+
+	pr_debug("send ack for %s\n",
+		 prio ? "mp_prio" :
+		 (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
+
+	slow = lock_sock_fast(ssk);
+	if (prio) {
+		subflow->send_mp_prio = 1;
+		subflow->request_bkup = backup;
+	}
+
+	__mptcp_subflow_send_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+}
+
+void mptcp_pm_send_ack(struct mptcp_sock *msk,
+		       struct mptcp_subflow_context *subflow,
+		       bool prio, bool backup)
+{
+	spin_unlock_bh(&msk->pm.lock);
+	__mptcp_pm_send_ack(msk, subflow, prio, backup);
+	spin_lock_bh(&msk->pm.lock);
+}
+
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *alt = NULL;
+
+	msk_owned_by_me(msk);
+	lockdep_assert_held(&msk->pm.lock);
+
+	if (!mptcp_pm_should_add_signal(msk) &&
+	    !mptcp_pm_should_rm_signal(msk))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			if (!subflow->stale) {
+				mptcp_pm_send_ack(msk, subflow, false, false);
+				return;
+			}
+
+			if (!alt)
+				alt = subflow;
+		}
+	}
+
+	if (alt)
+		mptcp_pm_send_ack(msk, alt, false, false);
+}
+
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup)
+{
+	struct mptcp_subflow_context *subflow;
+
+	pr_debug("bkup=%d\n", bkup);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct mptcp_addr_info local, remote;
+
+		mptcp_local_address((struct sock_common *)ssk, &local);
+		if (!mptcp_addresses_equal(&local, addr, addr->port))
+			continue;
+
+		if (rem && rem->family != AF_UNSPEC) {
+			mptcp_remote_address((struct sock_common *)ssk, &remote);
+			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+				continue;
+		}
+
+		__mptcp_pm_send_ack(msk, subflow, true, bkup);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void mptcp_pm_add_timer(struct timer_list *timer)
+{
+	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_sock *msk = entry->sock;
+	struct sock *sk = (struct sock *)msk;
+
+	pr_debug("msk=%p\n", msk);
+
+	if (!msk)
+		return;
+
+	if (inet_sk_state_load(sk) == TCP_CLOSE)
+		return;
+
+	if (!entry->addr.id)
+		return;
+
+	if (mptcp_pm_should_add_signal_addr(msk)) {
+		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		goto out;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (!mptcp_pm_should_add_signal_addr(msk)) {
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
+		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		mptcp_pm_add_addr_send_ack(msk);
+		entry->retrans_times++;
+	}
+
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+		sk_reset_timer(sk, timer,
+			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+		mptcp_pm_subflow_established(msk);
+
+out:
+	__sock_put(sk);
+}
+
+struct mptcp_pm_add_entry *
+mptcp_pm_del_add_timer(struct mptcp_sock *msk,
+		       const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct mptcp_pm_add_entry *entry;
+	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
+
+	return entry;
+}
+
+bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+
+	if (add_entry) {
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
+			return false;
+
+		sk_reset_timer(sk, &add_entry->add_timer,
+			       jiffies + mptcp_get_add_addr_timeout(net));
+		return true;
+	}
+
+	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
+	if (!add_entry)
+		return false;
+
+	list_add(&add_entry->list, &msk->pm.anno_list);
+
+	add_entry->addr = *addr;
+	add_entry->sock = msk;
+	add_entry->retrans_times = 0;
+
+	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	sk_reset_timer(sk, &add_entry->add_timer,
+		       jiffies + mptcp_get_add_addr_timeout(net));
+
+	return true;
+}
+
+static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_add_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	LIST_HEAD(free_list);
+
+	pr_debug("msk=%p\n", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_splice_init(&msk->pm.anno_list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		sk_stop_timer_sync(sk, &entry->add_timer);
+		kfree(entry);
+	}
+}
 
 /* path manager command handlers */
 
@@ -109,22 +496,6 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	return ret;
 }
 
-/* return true if the new status bit is currently cleared, that is, this event
- * can be server, eventually by an already scheduled work
- */
-static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
-				   enum mptcp_pm_status new_status)
-{
-	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
-		 BIT(new_status));
-	if (msk->pm.status & BIT(new_status))
-		return false;
-
-	msk->pm.status |= BIT(new_status);
-	mptcp_schedule_work((struct sock *)msk);
-	return true;
-}
-
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
@@ -209,6 +580,15 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+					 const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	mptcp_remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -231,7 +611,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
 	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
@@ -262,12 +642,81 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
+					const struct mptcp_rm_list *rm_list,
+					enum linux_mptcp_mib_field rm_type)
 {
-	if (!mptcp_pm_should_add_signal(msk))
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	u8 i;
+
+	pr_debug("%s rm_list_nr %d\n",
+		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
 		return;
 
-	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
+	if (!rm_list->nr)
+		return;
+
+	if (list_empty(&msk->conn_list))
+		return;
+
+	for (i = 0; i < rm_list->nr; i++) {
+		u8 rm_id = rm_list->ids[i];
+		bool removed = false;
+
+		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			u8 remote_id = READ_ONCE(subflow->remote_id);
+			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
+			u8 id = subflow_get_local_id(subflow);
+
+			if ((1 << inet_sk_state_load(ssk)) &
+			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
+				continue;
+			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
+				continue;
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
+				continue;
+
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
+				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
+				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
+			spin_unlock_bh(&msk->pm.lock);
+			mptcp_subflow_shutdown(sk, ssk, how);
+			removed |= subflow->request_join;
+
+			/* the following takes care of updating the subflows counter */
+			mptcp_close_ssk(sk, ssk, subflow);
+			spin_lock_bh(&msk->pm.lock);
+
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
+		}
+
+		if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+
+		if (!removed)
+			continue;
+
+		if (mptcp_pm_is_kernel(msk) && rm_type == MPTCP_MIB_RMADDR)
+			mptcp_pm_nl_rm_addr(msk, rm_id);
+	}
+}
+
+static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
+{
+	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+}
+
+void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+			 const struct mptcp_rm_list *rm_list)
+{
+	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
@@ -325,8 +774,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
-/* path manager helpers */
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
@@ -440,119 +887,41 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, addr, info);
-	return mptcp_pm_nl_get_addr(id, addr, info);
-}
+	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+	unsigned int active_max_loss_cnt;
+	struct net *net = sock_net(sk);
+	unsigned int stale_loss_cnt;
+	bool slow;
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry addr;
-	struct nlattr *attr;
-	struct sk_buff *msg;
-	void *reply;
-	int ret;
+	stale_loss_cnt = mptcp_stale_loss_cnt(net);
+	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
+		return;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
+	/* look for another available subflow not in loss state */
+	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
+	mptcp_for_each_subflow(msk, iter) {
+		if (iter != subflow && mptcp_subflow_active(iter) &&
+		    iter->stale_count < active_max_loss_cnt) {
+			/* we have some alternatives, try to mark this subflow as idle ...*/
+			slow = lock_sock_fast(ssk);
+			if (!tcp_rtx_and_write_queues_empty(ssk)) {
+				subflow->stale = 1;
+				__mptcp_retransmit_pending_data(sk);
+				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
+			}
+			unlock_sock_fast(ssk, slow);
 
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
+			/* always try to push the pending data regardless of re-injections:
+			 * we can possibly use backup subflows now, and subflow selection
+			 * is cheap under the msk socket lock
+			 */
+			__mptcp_push_pending(sk, 0);
+			return;
+		}
 	}
-
-	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
-	if (ret) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, &addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
-	return ret;
-}
-
-int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
-			    struct netlink_callback *cb,
-			    struct mptcp_pm_addr_entry *entry)
-{
-	void *hdr;
-
-	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-	if (!hdr)
-		return -EINVAL;
-
-	if (mptcp_nl_fill_addr(msg, entry) < 0) {
-		genlmsg_cancel(msg, hdr);
-		return -EINVAL;
-	}
-
-	genlmsg_end(msg, hdr);
-	return 0;
-}
-
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
-}
-
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
-static int mptcp_pm_set_flags(struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_loc;
-	int ret = -EINVAL;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return ret;
-
-	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
-	if (ret < 0)
-		return ret;
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(&loc, info);
-	return mptcp_pm_nl_set_flags(&loc, info);
-}
-
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -567,38 +936,13 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
 		if (subflow->stale_count < U8_MAX)
 			subflow->stale_count++;
-		mptcp_pm_nl_subflow_chk_stale(msk, ssk);
+		mptcp_pm_subflows_chk_stale(msk, ssk);
 	} else {
 		subflow->stale_count = 0;
 		mptcp_subflow_set_active(subflow);
 	}
 }
 
-/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
- * otherwise allow any matching local/remote pair
- */
-bool mptcp_pm_addr_families_match(const struct sock *sk,
-				  const struct mptcp_addr_info *loc,
-				  const struct mptcp_addr_info *rem)
-{
-	bool mptcp_is_v4 = sk->sk_family == AF_INET;
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
-	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
-
-	if (mptcp_is_v4)
-		return loc_is_v4 && rem_is_v4;
-
-	if (ipv6_only_sock(sk))
-		return !loc_is_v4 && !rem_is_v4;
-
-	return loc_is_v4 == rem_is_v4;
-#else
-	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
-#endif
-}
-
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
new file mode 100644
index 0000000000000000000000000000000000000000..daf8f98a316439a67c12f63f2388ef497dae08dd
--- /dev/null
+++ b/net/mptcp/pm_kernel.c
@@ -0,0 +1,1410 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2025, Matthieu Baerts.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <net/netns/generic.h>
+
+#include "protocol.h"
+#include "mib.h"
+#include "mptcp_pm_gen.h"
+
+static int pm_nl_pernet_id;
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+#define MPTCP_PM_ADDR_MAX	8
+
+static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
+{
+	return net_generic(net, pm_nl_pernet_id);
+}
+
+static struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
+{
+	return pm_nl_get_pernet(sock_net((struct sock *)msk));
+}
+
+static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
+{
+	return pm_nl_get_pernet(genl_info_net(info));
+}
+
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
+{
+	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->add_addr_signal_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
+
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->add_addr_accept_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
+
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->subflows_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
+
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->local_addr_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
+
+static bool lookup_subflow_by_daddr(const struct list_head *list,
+				    const struct mptcp_addr_info *daddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info cur;
+
+	list_for_each_entry(subflow, list, node) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		mptcp_remote_address((struct sock_common *)ssk, &cur);
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+			return true;
+	}
+
+	return false;
+}
+
+static bool
+select_local_address(const struct pm_nl_pernet *pernet,
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_local *new_local)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
+
+	msk_owned_by_me(msk);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+			continue;
+
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+			continue;
+
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
+		found = true;
+		break;
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_local *new_local)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
+
+	rcu_read_lock();
+	/* do not keep any additional per socket state, just signal
+	 * the address list in order.
+	 * Note: removal from the local address list during the msk life-cycle
+	 * can lead to additional addresses not being announced.
+	 */
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+			continue;
+
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+			continue;
+
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
+		found = true;
+		break;
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
+/* Fill all the remote addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
+					      struct mptcp_addr_info *local,
+					      bool fullmesh,
+					      struct mptcp_addr_info *addrs)
+{
+	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	struct sock *sk = (struct sock *)msk, *ssk;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info remote = { 0 };
+	unsigned int subflows_max;
+	int i = 0;
+
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+	mptcp_remote_address((struct sock_common *)sk, &remote);
+
+	/* Non-fullmesh endpoint, fill in the single entry
+	 * corresponding to the primary MPC subflow remote address
+	 */
+	if (!fullmesh) {
+		if (deny_id0)
+			return 0;
+
+		if (!mptcp_pm_addr_families_match(sk, local, &remote))
+			return 0;
+
+		msk->pm.subflows++;
+		addrs[i++] = remote;
+	} else {
+		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+
+		/* Forbid creation of new subflows matching existing
+		 * ones, possibly already created by incoming ADD_ADDR
+		 */
+		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		mptcp_for_each_subflow(msk, subflow)
+			if (READ_ONCE(subflow->local_id) == local->id)
+				__set_bit(subflow->remote_id, unavail_id);
+
+		mptcp_for_each_subflow(msk, subflow) {
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
+			addrs[i].id = READ_ONCE(subflow->remote_id);
+			if (deny_id0 && !addrs[i].id)
+				continue;
+
+			if (test_bit(addrs[i].id, unavail_id))
+				continue;
+
+			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
+				continue;
+
+			if (msk->pm.subflows < subflows_max) {
+				/* forbid creating multiple address towards
+				 * this id
+				 */
+				__set_bit(addrs[i].id, unavail_id);
+				msk->pm.subflows++;
+				i++;
+			}
+		}
+	}
+
+	return i;
+}
+
+static struct mptcp_pm_addr_entry *
+__lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
+static struct mptcp_pm_addr_entry *
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+			return entry;
+	}
+	return NULL;
+}
+
+static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
+	unsigned int local_addr_max;
+	struct pm_nl_pernet *pernet;
+	struct mptcp_pm_local local;
+	unsigned int subflows_max;
+
+	pernet = pm_nl_get_pernet(sock_net(sk));
+
+	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
+	local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	/* do lazy endpoint usage accounting for the MPC subflows */
+	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
+		struct mptcp_pm_addr_entry *entry;
+		struct mptcp_addr_info mpc_addr;
+		bool backup = false;
+
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+		rcu_read_lock();
+		entry = __lookup_addr(pernet, &mpc_addr);
+		if (entry) {
+			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			msk->mpc_endpoint_id = entry->addr.id;
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		}
+		rcu_read_unlock();
+
+		if (backup)
+			mptcp_pm_send_ack(msk, subflow, true, backup);
+
+		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
+	}
+
+	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
+		 msk->pm.local_addr_used, local_addr_max,
+		 msk->pm.add_addr_signaled, add_addr_signal_max,
+		 msk->pm.subflows, subflows_max);
+
+	/* check first for announce */
+	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
+		/* due to racing events on both ends we can reach here while
+		 * previous add address is still running: if we invoke now
+		 * mptcp_pm_announce_addr(), that will fail and the
+		 * corresponding id will be marked as used.
+		 * Instead let the PM machinery reschedule us when the
+		 * current address announce will be completed.
+		 */
+		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
+			return;
+
+		if (!select_signal_address(pernet, msk, &local))
+			goto subflow;
+
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+			return;
+
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
+		mptcp_pm_announce_addr(msk, &local.addr, false);
+		mptcp_pm_addr_send_ack(msk);
+
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
+	}
+
+subflow:
+	/* check if should create a new subflow */
+	while (msk->pm.local_addr_used < local_addr_max &&
+	       msk->pm.subflows < subflows_max) {
+		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+		bool fullmesh;
+		int i, nr;
+
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
+
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
+
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
+
+		spin_unlock_bh(&msk->pm.lock);
+		for (i = 0; i < nr; i++)
+			__mptcp_subflow_connect(sk, &local, &addrs[i]);
+		spin_lock_bh(&msk->pm.lock);
+	}
+	mptcp_pm_nl_check_work_pending(msk);
+}
+
+static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+/* Fill all the local addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
+					     struct mptcp_pm_local *locals)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
+	struct pm_nl_pernet *pernet;
+	unsigned int subflows_max;
+	int i = 0;
+
+	pernet = pm_nl_get_pernet_from_msk(msk);
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+			continue;
+
+		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
+			continue;
+
+		if (msk->pm.subflows < subflows_max) {
+			locals[i].addr = entry->addr;
+			locals[i].flags = entry->flags;
+			locals[i].ifindex = entry->ifindex;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+				locals[i].addr.id = 0;
+
+			msk->pm.subflows++;
+			i++;
+		}
+	}
+	rcu_read_unlock();
+
+	/* If the array is empty, fill in the single
+	 * 'IPADDRANY' local address
+	 */
+	if (!i) {
+		memset(&locals[i], 0, sizeof(locals[i]));
+		locals[i].addr.family =
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			       remote->family == AF_INET6 &&
+			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
+#endif
+			       remote->family;
+
+		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
+			return 0;
+
+		msk->pm.subflows++;
+		i++;
+	}
+
+	return i;
+}
+
+static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
+	struct sock *sk = (struct sock *)msk;
+	unsigned int add_addr_accept_max;
+	struct mptcp_addr_info remote;
+	unsigned int subflows_max;
+	bool sf_created = false;
+	int i, nr;
+
+	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	pr_debug("accepted %d:%d remote family %d\n",
+		 msk->pm.add_addr_accepted, add_addr_accept_max,
+		 msk->pm.remote.family);
+
+	remote = msk->pm.remote;
+	mptcp_pm_announce_addr(msk, &remote, true);
+	mptcp_pm_addr_send_ack(msk);
+
+	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
+		return;
+
+	/* pick id 0 port, if none is provided the remote address */
+	if (!remote.port)
+		remote.port = sk->sk_dport;
+
+	/* connect to the specified remote address, using whatever
+	 * local address the routing configuration will pick.
+	 */
+	nr = fill_local_addresses_vec(msk, &remote, locals);
+	if (nr == 0)
+		return;
+
+	spin_unlock_bh(&msk->pm.lock);
+	for (i = 0; i < nr; i++)
+		if (__mptcp_subflow_connect(sk, &locals[i], &remote) == 0)
+			sf_created = true;
+	spin_lock_bh(&msk->pm.lock);
+
+	if (sf_created) {
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
+}
+
+void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
+{
+	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+		/* Note: if the subflow has been closed before, this
+		 * add_addr_accepted counter will not be decremented.
+		 */
+		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+			WRITE_ONCE(msk->pm.accept_addr, true);
+	}
+}
+
+static bool address_use_port(struct mptcp_pm_addr_entry *entry)
+{
+	return (entry->flags &
+		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) ==
+		MPTCP_PM_ADDR_FLAG_SIGNAL;
+}
+
+/* caller must ensure the RCU grace period is already elapsed */
+static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
+{
+	if (entry->lsk)
+		sock_release(entry->lsk);
+	kfree(entry);
+}
+
+static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id, bool replace)
+{
+	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
+	unsigned int addr_max;
+	int ret = -EINVAL;
+
+	spin_lock_bh(&pernet->lock);
+	/* to keep the code simple, don't do IDR-like allocation for address ID,
+	 * just bail when we exceed limits
+	 */
+	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
+		pernet->next_id = 1;
+	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+		ret = -ERANGE;
+		goto out;
+	}
+	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* do not insert duplicate address, differentiate on port only
+	 * singled addresses
+	 */
+	if (!address_use_port(entry))
+		entry->addr.port = 0;
+	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
+					  cur->addr.port || entry->addr.port)) {
+			/* allow replacing the exiting endpoint only if such
+			 * endpoint is an implicit one and the user-space
+			 * did not provide an endpoint id
+			 */
+			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
+				ret = -EEXIST;
+				goto out;
+			}
+			if (entry->addr.id)
+				goto out;
+
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
+			pernet->addrs--;
+			entry->addr.id = cur->addr.id;
+			list_del_rcu(&cur->list);
+			del_entry = cur;
+			break;
+		}
+	}
+
+	if (!entry->addr.id && needs_id) {
+find_next:
+		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
+						    MPTCP_PM_MAX_ADDR_ID + 1,
+						    pernet->next_id);
+		if (!entry->addr.id && pernet->next_id != 1) {
+			pernet->next_id = 1;
+			goto find_next;
+		}
+	}
+
+	if (!entry->addr.id && needs_id)
+		goto out;
+
+	__set_bit(entry->addr.id, pernet->id_bitmap);
+	if (entry->addr.id > pernet->next_id)
+		pernet->next_id = entry->addr.id;
+
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max = pernet->add_addr_signal_max;
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max = pernet->local_addr_max;
+		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
+	}
+
+	pernet->addrs++;
+	if (!entry->addr.port)
+		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+	else
+		list_add_rcu(&entry->list, &pernet->local_addr_list);
+	ret = entry->addr.id;
+
+out:
+	spin_unlock_bh(&pernet->lock);
+
+	/* just replaced an existing entry, free it */
+	if (del_entry) {
+		synchronize_rcu();
+		__mptcp_pm_release_addr_entry(del_entry);
+	}
+	return ret;
+}
+
+static struct lock_class_key mptcp_slock_keys[2];
+static struct lock_class_key mptcp_keys[2];
+
+static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
+					    struct mptcp_pm_addr_entry *entry)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+	int addrlen = sizeof(struct sockaddr_in);
+	struct sockaddr_storage addr;
+	struct sock *newsk, *ssk;
+	int backlog = 1024;
+	int err;
+
+	err = sock_create_kern(sock_net(sk), entry->addr.family,
+			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+	if (err)
+		return err;
+
+	newsk = entry->lsk->sk;
+	if (!newsk)
+		return -EINVAL;
+
+	/* The subflow socket lock is acquired in a nested to the msk one
+	 * in several places, even by the TCP stack, and this msk is a kernel
+	 * socket: lockdep complains. Instead of propagating the _nested
+	 * modifiers in several places, re-init the lock class for the msk
+	 * socket to an mptcp specific one.
+	 */
+	sock_lock_init_class_and_name(newsk,
+				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+				      &mptcp_slock_keys[is_ipv6],
+				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
+				      &mptcp_keys[is_ipv6]);
+
+	lock_sock(newsk);
+	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
+	release_sock(newsk);
+	if (IS_ERR(ssk))
+		return PTR_ERR(ssk);
+
+	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (entry->addr.family == AF_INET6)
+		addrlen = sizeof(struct sockaddr_in6);
+#endif
+	if (ssk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#endif
+	if (err)
+		return err;
+
+	/* We don't use mptcp_set_state() here because it needs to be called
+	 * under the msk socket lock. For the moment, that will not bring
+	 * anything more than only calling inet_sk_state_store(), because the
+	 * old status is known (TCP_CLOSE).
+	 */
+	inet_sk_state_store(newsk, TCP_LISTEN);
+	lock_sock(ssk);
+	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
+	err = __inet_listen_sk(ssk, backlog);
+	if (!err)
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
+	release_sock(ssk);
+	return err;
+}
+
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	int ret;
+
+	pernet = pm_nl_get_pernet_from_msk(msk);
+
+	rcu_read_lock();
+	entry = __lookup_addr(pernet, &skc->addr);
+	ret = entry ? entry->addr.id : -1;
+	rcu_read_unlock();
+	if (ret >= 0)
+		return ret;
+
+	/* address not found, add to local list */
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	*entry = *skc;
+	entry->addr.port = 0;
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
+	if (ret < 0)
+		kfree(entry);
+
+	return ret;
+}
+
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_pm_addr_entry *entry;
+	bool backup;
+
+	rcu_read_lock();
+	entry = __lookup_addr(pernet, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	rcu_read_unlock();
+
+	return backup;
+}
+
+static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
+					       struct mptcp_addr_info *addr)
+{
+	struct mptcp_sock *msk;
+	long s_slot = 0, s_num = 0;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		struct mptcp_addr_info mpc_addr;
+
+		if (!READ_ONCE(msk->fully_established) ||
+		    mptcp_pm_is_userspace(msk))
+			goto next;
+
+		/* if the endp linked to the init sf is re-added with a != ID */
+		mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
+			msk->mpc_endpoint_id = addr->id;
+		mptcp_pm_create_subflow_or_signal_addr(msk);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_address_nl_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
+/* Add an MPTCP endpoint */
+int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry addr, *entry;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
+	if (ret < 0)
+		return ret;
+
+	if (addr.addr.port && !address_use_port(&addr)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags must have signal and not subflow when using port");
+		return -EINVAL;
+	}
+
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
+	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags mustn't have both signal and fullmesh");
+		return -EINVAL;
+	}
+
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "can't create IMPLICIT endpoint");
+		return -EINVAL;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
+	if (!entry) {
+		GENL_SET_ERR_MSG(info, "can't allocate addr");
+		return -ENOMEM;
+	}
+
+	*entry = addr;
+	if (entry->addr.port) {
+		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
+		if (ret) {
+			GENL_SET_ERR_MSG_FMT(info, "create listen socket error: %d", ret);
+			goto out_free;
+		}
+	}
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
+	if (ret < 0) {
+		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
+		goto out_free;
+	}
+
+	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk), &entry->addr);
+	return 0;
+
+out_free:
+	__mptcp_pm_release_addr_entry(entry);
+	return ret;
+}
+
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
+static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+				      const struct mptcp_addr_info *addr,
+				      bool force)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	bool ret;
+
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
+
+	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
+	if (ret || force) {
+		spin_lock_bh(&msk->pm.lock);
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
+		mptcp_pm_remove_addr(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+	return ret;
+}
+
+static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
+{
+	/* If it was marked as used, and not ID 0, decrement local_addr_used */
+	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
+	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
+		msk->pm.local_addr_used--;
+}
+
+static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
+						   const struct mptcp_pm_addr_entry *entry)
+{
+	const struct mptcp_addr_info *addr = &entry->addr;
+	struct mptcp_rm_list list = { .nr = 1 };
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	pr_debug("remove_id=%d\n", addr->id);
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		bool remove_subflow;
+
+		if (mptcp_pm_is_userspace(msk))
+			goto next;
+
+		lock_sock(sk);
+		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
+		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
+
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
+		if (remove_subflow) {
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_rm_subflow(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			spin_lock_bh(&msk->pm.lock);
+			__mark_subflow_endp_available(msk, list.ids[0]);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
+		if (msk->mpc_endpoint_id == entry->addr.id)
+			msk->mpc_endpoint_id = 0;
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int mptcp_nl_remove_id_zero_address(struct net *net,
+					   struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	list.ids[list.nr++] = 0;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		struct mptcp_addr_info msk_local;
+
+		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+			goto next;
+
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+			goto next;
+
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &list);
+		mptcp_pm_rm_subflow(msk, &list);
+		__mark_subflow_endp_available(msk, 0);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+/* Remove an MPTCP endpoint */
+int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry addr, *entry;
+	unsigned int addr_max;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	/* the zero id address is special: the first address used by the msk
+	 * always gets such an id, so different subflows can have different zero
+	 * id addresses. Additionally zero id is not accounted for in id_bitmap.
+	 * Let's use an 'mptcp_rm_list' instead of the common remove code.
+	 */
+	if (addr.addr.id == 0)
+		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk), &addr.addr);
+
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	if (!entry) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max = pernet->add_addr_signal_max;
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
+	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max = pernet->local_addr_max;
+		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
+	}
+
+	pernet->addrs--;
+	list_del_rcu(&entry->list);
+	__clear_bit(entry->addr.id, pernet->id_bitmap);
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
+	synchronize_rcu();
+	__mptcp_pm_release_addr_entry(entry);
+
+	return ret;
+}
+
+static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
+					      struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (slist.nr < MPTCP_RM_IDS_MAX &&
+		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
+
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	if (alist.nr) {
+		msk->pm.add_addr_signaled -= alist.nr;
+		mptcp_pm_remove_addr(msk, &alist);
+	}
+	if (slist.nr)
+		mptcp_pm_rm_subflow(msk, &slist);
+	/* Reset counters: maybe some subflows have been removed before */
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static void mptcp_nl_flush_addrs_list(struct net *net,
+				      struct list_head *rm_list)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	if (list_empty(rm_list))
+		return;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (!mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
+
+/* caller must ensure the RCU grace period is already elapsed */
+static void __flush_addrs(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct mptcp_pm_addr_entry *cur;
+
+		cur = list_entry(list->next,
+				 struct mptcp_pm_addr_entry, list);
+		list_del_rcu(&cur->list);
+		__mptcp_pm_release_addr_entry(cur);
+	}
+}
+
+static void __reset_counters(struct pm_nl_pernet *pernet)
+{
+	WRITE_ONCE(pernet->add_addr_signal_max, 0);
+	WRITE_ONCE(pernet->add_addr_accept_max, 0);
+	WRITE_ONCE(pernet->local_addr_max, 0);
+	pernet->addrs = 0;
+}
+
+int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	LIST_HEAD(free_list);
+
+	spin_lock_bh(&pernet->lock);
+	list_splice_init(&pernet->local_addr_list, &free_list);
+	__reset_counters(pernet);
+	pernet->next_id = 1;
+	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	spin_unlock_bh(&pernet->lock);
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
+	synchronize_rcu();
+	__flush_addrs(&free_list);
+	return 0;
+}
+
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry *entry;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+	entry = __lookup_addr_by_id(pernet, id);
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
+{
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	int id = cb->args[0];
+	int i;
+
+	pernet = pm_nl_get_pernet(net);
+
+	rcu_read_lock();
+	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
+		if (test_bit(i, pernet->id_bitmap)) {
+			entry = __lookup_addr_by_id(pernet, i);
+			if (!entry)
+				break;
+
+			if (entry->addr.id <= id)
+				continue;
+
+			if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
+				break;
+
+			id = entry->addr.id;
+		}
+	}
+	rcu_read_unlock();
+
+	cb->args[0] = id;
+	return msg->len;
+}
+
+static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
+{
+	struct nlattr *attr = info->attrs[id];
+
+	if (!attr)
+		return 0;
+
+	*limit = nla_get_u32(attr);
+	if (*limit > MPTCP_PM_ADDR_MAX) {
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	unsigned int rcv_addrs, subflows;
+	int ret;
+
+	spin_lock_bh(&pernet->lock);
+	rcv_addrs = pernet->add_addr_accept_max;
+	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
+	if (ret)
+		goto unlock;
+
+	subflows = pernet->subflows_max;
+	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
+	if (ret)
+		goto unlock;
+
+	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
+	WRITE_ONCE(pernet->subflows_max, subflows);
+
+unlock:
+	spin_unlock_bh(&pernet->lock);
+	return ret;
+}
+
+int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct sk_buff *msg;
+	void *reply;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  MPTCP_PM_CMD_GET_LIMITS);
+	if (!reply)
+		goto fail;
+
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
+			READ_ONCE(pernet->add_addr_accept_max)))
+		goto fail;
+
+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
+			READ_ONCE(pernet->subflows_max)))
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	return genlmsg_reply(msg, info);
+
+fail:
+	GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
+static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_rm_subflow(msk, &list);
+	__mark_subflow_endp_available(msk, list.ids[0]);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static void mptcp_pm_nl_set_flags_all(struct net *net,
+				      struct mptcp_pm_addr_entry *local,
+				      u8 changed)
+{
+	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
+		return;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+			goto next;
+
+		lock_sock(sk);
+		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
+			mptcp_pm_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
+		/* Subflows will only be recreated if the SUBFLOW flag is set */
+		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
+			mptcp_pm_nl_fullmesh(msk, &local->addr);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+}
+
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct net *net = genl_info_net(info);
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	u8 lookup_by_id = 0;
+
+	pernet = pm_nl_get_pernet(net);
+
+	if (local->addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!local->addr.id) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr,
+					    "missing address ID");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	spin_lock_bh(&pernet->lock);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
+			       __lookup_addr(pernet, &local->addr);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+		return -EINVAL;
+	}
+	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
+		spin_unlock_bh(&pernet->lock);
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
+		return -EINVAL;
+	}
+
+	changed = (local->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
+	*local = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_pm_nl_set_flags_all(net, local, changed);
+	return 0;
+}
+
+bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
+	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
+			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
+		WRITE_ONCE(msk->pm.work_pending, false);
+		return false;
+	}
+	return true;
+}
+
+/* Called under PM lock */
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+		mptcp_pm_nl_add_addr_received(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		mptcp_pm_nl_fully_established(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		mptcp_pm_nl_subflow_established(msk);
+	}
+}
+
+static int __net_init pm_nl_init_net(struct net *net)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+
+	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+
+	/* Cit. 2 subflows ought to be enough for anybody. */
+	pernet->subflows_max = 2;
+	pernet->next_id = 1;
+	pernet->stale_loss_cnt = 4;
+	spin_lock_init(&pernet->lock);
+
+	/* No need to initialize other pernet fields, the struct is zeroed at
+	 * allocation time.
+	 */
+
+	return 0;
+}
+
+static void __net_exit pm_nl_exit_net(struct list_head *net_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+
+		/* net is removed from namespace list, can't race with
+		 * other modifiers, also netns core already waited for a
+		 * RCU grace period.
+		 */
+		__flush_addrs(&pernet->local_addr_list);
+	}
+}
+
+static struct pernet_operations mptcp_pm_pernet_ops = {
+	.init = pm_nl_init_net,
+	.exit_batch = pm_nl_exit_net,
+	.id = &pm_nl_pernet_id,
+	.size = sizeof(struct pm_nl_pernet),
+};
+
+void __init mptcp_pm_nl_init(void)
+{
+	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
+		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	if (genl_register_family(&mptcp_genl_family))
+		panic("Failed to register MPTCP PM netlink family\n");
+}
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a8652886fce6ba9743d0efba576ac57f35a0077..2a9a87cad5b80787c683b0ee89e7ac3be31bfbf0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -6,1177 +6,9 @@
 
 #define pr_fmt(fmt) "MPTCP: " fmt
 
-#include <linux/inet.h>
-#include <linux/kernel.h>
-#include <net/inet_common.h>
-#include <net/netns/generic.h>
-#include <net/mptcp.h>
-
 #include "protocol.h"
-#include "mib.h"
 #include "mptcp_pm_gen.h"
 
-static int pm_nl_pernet_id;
-
-struct mptcp_pm_add_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			retrans_times;
-	struct timer_list	add_timer;
-	struct mptcp_sock	*sock;
-};
-
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
-#define MPTCP_PM_ADDR_MAX	8
-#define ADD_ADDR_RETRANS_MAX	3
-
-static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
-{
-	return net_generic(net, pm_nl_pernet_id);
-}
-
-static struct pm_nl_pernet *
-pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
-{
-	return pm_nl_get_pernet(sock_net((struct sock *)msk));
-}
-
-bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
-{
-	bool addr_equals = false;
-
-	if (a->family == b->family) {
-		if (a->family == AF_INET)
-			addr_equals = a->addr.s_addr == b->addr.s_addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else
-			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
-	} else if (a->family == AF_INET) {
-		if (ipv6_addr_v4mapped(&b->addr6))
-			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];
-	} else if (b->family == AF_INET) {
-		if (ipv6_addr_v4mapped(&a->addr6))
-			addr_equals = a->addr6.s6_addr32[3] == b->addr.s_addr;
-#endif
-	}
-
-	if (!addr_equals)
-		return false;
-	if (!use_port)
-		return true;
-
-	return a->port == b->port;
-}
-
-void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
-{
-	addr->family = skc->skc_family;
-	addr->port = htons(skc->skc_num);
-	if (addr->family == AF_INET)
-		addr->addr.s_addr = skc->skc_rcv_saddr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family == AF_INET6)
-		addr->addr6 = skc->skc_v6_rcv_saddr;
-#endif
-}
-
-static void remote_address(const struct sock_common *skc,
-			   struct mptcp_addr_info *addr)
-{
-	addr->family = skc->skc_family;
-	addr->port = skc->skc_dport;
-	if (addr->family == AF_INET)
-		addr->addr.s_addr = skc->skc_daddr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family == AF_INET6)
-		addr->addr6 = skc->skc_v6_daddr;
-#endif
-}
-
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info cur;
-	struct sock_common *skc;
-
-	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
-
-		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
-			return true;
-	}
-
-	return false;
-}
-
-static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    const struct mptcp_addr_info *daddr)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info cur;
-
-	list_for_each_entry(subflow, list, node) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-		if (!((1 << inet_sk_state_load(ssk)) &
-		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
-			continue;
-
-		remote_address((struct sock_common *)ssk, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
-			return true;
-	}
-
-	return false;
-}
-
-static bool
-select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
-{
-	struct mptcp_pm_addr_entry *entry;
-	bool found = false;
-
-	msk_owned_by_me(msk);
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
-			continue;
-
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
-			continue;
-
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
-		found = true;
-		break;
-	}
-	rcu_read_unlock();
-
-	return found;
-}
-
-static bool
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
-{
-	struct mptcp_pm_addr_entry *entry;
-	bool found = false;
-
-	rcu_read_lock();
-	/* do not keep any additional per socket state, just signal
-	 * the address list in order.
-	 * Note: removal from the local address list during the msk life-cycle
-	 * can lead to additional addresses not being announced.
-	 */
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
-			continue;
-
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
-			continue;
-
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
-		found = true;
-		break;
-	}
-	rcu_read_unlock();
-
-	return found;
-}
-
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
-{
-	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->add_addr_signal_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
-
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->add_addr_accept_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
-
-unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->subflows_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
-
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->local_addr_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
-
-bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
-	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
-			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
-		WRITE_ONCE(msk->pm.work_pending, false);
-		return false;
-	}
-	return true;
-}
-
-struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *entry;
-
-	lockdep_assert_held(&msk->pm.lock);
-
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
-			return entry;
-	}
-
-	return NULL;
-}
-
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
-{
-	struct mptcp_pm_add_entry *entry;
-	struct mptcp_addr_info saddr;
-	bool ret = false;
-
-	mptcp_local_address((struct sock_common *)sk, &saddr);
-
-	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
-			ret = true;
-			goto out;
-		}
-	}
-
-out:
-	spin_unlock_bh(&msk->pm.lock);
-	return ret;
-}
-
-static void mptcp_pm_add_timer(struct timer_list *timer)
-{
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
-	struct mptcp_sock *msk = entry->sock;
-	struct sock *sk = (struct sock *)msk;
-
-	pr_debug("msk=%p\n", msk);
-
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
-
-	if (!entry->addr.id)
-		return;
-
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
-		goto out;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false);
-		mptcp_pm_add_addr_send_ack(msk);
-		entry->retrans_times++;
-	}
-
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
-
-	spin_unlock_bh(&msk->pm.lock);
-
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
-		mptcp_pm_subflow_established(msk);
-
-out:
-	__sock_put(sk);
-}
-
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct mptcp_pm_add_entry *entry;
-	struct sock *sk = (struct sock *)msk;
-	struct timer_list *add_timer = NULL;
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		add_timer = &entry->add_timer;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
-	if (add_timer)
-		sk_stop_timer_sync(sk, add_timer);
-
-	return entry;
-}
-
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *add_entry = NULL;
-	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
-
-	lockdep_assert_held(&msk->pm.lock);
-
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-
-	if (add_entry) {
-		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
-			return false;
-
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
-	}
-
-	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
-	if (!add_entry)
-		return false;
-
-	list_add(&add_entry->list, &msk->pm.anno_list);
-
-	add_entry->addr = *addr;
-	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
-
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
-
-	return true;
-}
-
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_add_entry *entry, *tmp;
-	struct sock *sk = (struct sock *)msk;
-	LIST_HEAD(free_list);
-
-	pr_debug("msk=%p\n", msk);
-
-	spin_lock_bh(&msk->pm.lock);
-	list_splice_init(&msk->pm.anno_list, &free_list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
-		kfree(entry);
-	}
-}
-
-/* Fill all the remote addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
-					      struct mptcp_addr_info *local,
-					      bool fullmesh,
-					      struct mptcp_addr_info *addrs)
-{
-	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
-	struct sock *sk = (struct sock *)msk, *ssk;
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info remote = { 0 };
-	unsigned int subflows_max;
-	int i = 0;
-
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-	remote_address((struct sock_common *)sk, &remote);
-
-	/* Non-fullmesh endpoint, fill in the single entry
-	 * corresponding to the primary MPC subflow remote address
-	 */
-	if (!fullmesh) {
-		if (deny_id0)
-			return 0;
-
-		if (!mptcp_pm_addr_families_match(sk, local, &remote))
-			return 0;
-
-		msk->pm.subflows++;
-		addrs[i++] = remote;
-	} else {
-		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-
-		/* Forbid creation of new subflows matching existing
-		 * ones, possibly already created by incoming ADD_ADDR
-		 */
-		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-		mptcp_for_each_subflow(msk, subflow)
-			if (READ_ONCE(subflow->local_id) == local->id)
-				__set_bit(subflow->remote_id, unavail_id);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			ssk = mptcp_subflow_tcp_sock(subflow);
-			remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = READ_ONCE(subflow->remote_id);
-			if (deny_id0 && !addrs[i].id)
-				continue;
-
-			if (test_bit(addrs[i].id, unavail_id))
-				continue;
-
-			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
-				continue;
-
-			if (msk->pm.subflows < subflows_max) {
-				/* forbid creating multiple address towards
-				 * this id
-				 */
-				__set_bit(addrs[i].id, unavail_id);
-				msk->pm.subflows++;
-				i++;
-			}
-		}
-	}
-
-	return i;
-}
-
-static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				bool prio, bool backup)
-{
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-	bool slow;
-
-	pr_debug("send ack for %s\n",
-		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
-
-	slow = lock_sock_fast(ssk);
-	if (prio) {
-		subflow->send_mp_prio = 1;
-		subflow->request_bkup = backup;
-	}
-
-	__mptcp_subflow_send_ack(ssk);
-	unlock_sock_fast(ssk, slow);
-}
-
-static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-			      bool prio, bool backup)
-{
-	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_pm_send_ack(msk, subflow, prio, backup);
-	spin_lock_bh(&msk->pm.lock);
-}
-
-static struct mptcp_pm_addr_entry *
-__lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
-{
-	struct mptcp_pm_addr_entry *entry;
-
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
-				lockdep_is_held(&pernet->lock)) {
-		if (entry->addr.id == id)
-			return entry;
-	}
-	return NULL;
-}
-
-static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
-{
-	struct mptcp_pm_addr_entry *entry;
-
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
-				lockdep_is_held(&pernet->lock)) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
-			return entry;
-	}
-	return NULL;
-}
-
-static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
-	unsigned int add_addr_signal_max;
-	bool signal_and_subflow = false;
-	unsigned int local_addr_max;
-	struct pm_nl_pernet *pernet;
-	struct mptcp_pm_local local;
-	unsigned int subflows_max;
-
-	pernet = pm_nl_get_pernet(sock_net(sk));
-
-	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
-	local_addr_max = mptcp_pm_get_local_addr_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	/* do lazy endpoint usage accounting for the MPC subflows */
-	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
-		struct mptcp_pm_addr_entry *entry;
-		struct mptcp_addr_info mpc_addr;
-		bool backup = false;
-
-		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
-		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr);
-		if (entry) {
-			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
-			msk->mpc_endpoint_id = entry->addr.id;
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-		}
-		rcu_read_unlock();
-
-		if (backup)
-			mptcp_pm_send_ack(msk, subflow, true, backup);
-
-		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
-	}
-
-	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
-		 msk->pm.local_addr_used, local_addr_max,
-		 msk->pm.add_addr_signaled, add_addr_signal_max,
-		 msk->pm.subflows, subflows_max);
-
-	/* check first for announce */
-	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		/* due to racing events on both ends we can reach here while
-		 * previous add address is still running: if we invoke now
-		 * mptcp_pm_announce_addr(), that will fail and the
-		 * corresponding id will be marked as used.
-		 * Instead let the PM machinery reschedule us when the
-		 * current address announce will be completed.
-		 */
-		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
-			return;
-
-		if (!select_signal_address(pernet, msk, &local))
-			goto subflow;
-
-		/* If the alloc fails, we are on memory pressure, not worth
-		 * continuing, and trying to create subflows.
-		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
-			return;
-
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
-		msk->pm.add_addr_signaled++;
-
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-
-		mptcp_pm_announce_addr(msk, &local.addr, false);
-		mptcp_pm_addr_send_ack(msk);
-
-		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = true;
-	}
-
-subflow:
-	/* check if should create a new subflow */
-	while (msk->pm.local_addr_used < local_addr_max &&
-	       msk->pm.subflows < subflows_max) {
-		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
-		bool fullmesh;
-		int i, nr;
-
-		if (signal_and_subflow)
-			signal_and_subflow = false;
-		else if (!select_local_address(pernet, msk, &local))
-			break;
-
-		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
-
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
-
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-		else /* local_addr_used is not decr for ID 0 */
-			msk->pm.local_addr_used++;
-
-		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
-		if (nr == 0)
-			continue;
-
-		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local, &addrs[i]);
-		spin_lock_bh(&msk->pm.lock);
-	}
-	mptcp_pm_nl_check_work_pending(msk);
-}
-
-static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
-{
-	mptcp_pm_create_subflow_or_signal_addr(msk);
-}
-
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
-{
-	mptcp_pm_create_subflow_or_signal_addr(msk);
-}
-
-/* Fill all the local addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
-					     struct mptcp_addr_info *remote,
-					     struct mptcp_pm_local *locals)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info mpc_addr;
-	struct pm_nl_pernet *pernet;
-	unsigned int subflows_max;
-	int i = 0;
-
-	pernet = pm_nl_get_pernet_from_msk(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
-			continue;
-
-		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
-			continue;
-
-		if (msk->pm.subflows < subflows_max) {
-			locals[i].addr = entry->addr;
-			locals[i].flags = entry->flags;
-			locals[i].ifindex = entry->ifindex;
-
-			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
-				locals[i].addr.id = 0;
-
-			msk->pm.subflows++;
-			i++;
-		}
-	}
-	rcu_read_unlock();
-
-	/* If the array is empty, fill in the single
-	 * 'IPADDRANY' local address
-	 */
-	if (!i) {
-		memset(&locals[i], 0, sizeof(locals[i]));
-		locals[i].addr.family =
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			       remote->family == AF_INET6 &&
-			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
-#endif
-			       remote->family;
-
-		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
-			return 0;
-
-		msk->pm.subflows++;
-		i++;
-	}
-
-	return i;
-}
-
-static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
-	struct sock *sk = (struct sock *)msk;
-	unsigned int add_addr_accept_max;
-	struct mptcp_addr_info remote;
-	unsigned int subflows_max;
-	bool sf_created = false;
-	int i, nr;
-
-	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	pr_debug("accepted %d:%d remote family %d\n",
-		 msk->pm.add_addr_accepted, add_addr_accept_max,
-		 msk->pm.remote.family);
-
-	remote = msk->pm.remote;
-	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_addr_send_ack(msk);
-
-	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
-		return;
-
-	/* pick id 0 port, if none is provided the remote address */
-	if (!remote.port)
-		remote.port = sk->sk_dport;
-
-	/* connect to the specified remote address, using whatever
-	 * local address the routing configuration will pick.
-	 */
-	nr = fill_local_addresses_vec(msk, &remote, locals);
-	if (nr == 0)
-		return;
-
-	spin_unlock_bh(&msk->pm.lock);
-	for (i = 0; i < nr; i++)
-		if (__mptcp_subflow_connect(sk, &locals[i], &remote) == 0)
-			sf_created = true;
-	spin_lock_bh(&msk->pm.lock);
-
-	if (sf_created) {
-		/* add_addr_accepted is not decr for ID 0 */
-		if (remote.id)
-			msk->pm.add_addr_accepted++;
-		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-		    msk->pm.subflows >= subflows_max)
-			WRITE_ONCE(msk->pm.accept_addr, false);
-	}
-}
-
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote)
-{
-	struct mptcp_addr_info mpc_remote;
-
-	remote_address((struct sock_common *)msk, &mpc_remote);
-	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
-}
-
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow, *alt = NULL;
-
-	msk_owned_by_me(msk);
-	lockdep_assert_held(&msk->pm.lock);
-
-	if (!mptcp_pm_should_add_signal(msk) &&
-	    !mptcp_pm_should_rm_signal(msk))
-		return;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
-			}
-
-			if (!alt)
-				alt = subflow;
-		}
-	}
-
-	if (alt)
-		mptcp_pm_send_ack(msk, alt, false, false);
-}
-
-int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr,
-			      struct mptcp_addr_info *rem,
-			      u8 bkup)
-{
-	struct mptcp_subflow_context *subflow;
-
-	pr_debug("bkup=%d\n", bkup);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		struct mptcp_addr_info local, remote;
-
-		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
-			continue;
-
-		if (rem && rem->family != AF_UNSPEC) {
-			remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
-				continue;
-		}
-
-		__mptcp_pm_send_ack(msk, subflow, true, bkup);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
-					const struct mptcp_rm_list *rm_list,
-					enum linux_mptcp_mib_field rm_type)
-{
-	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = (struct sock *)msk;
-	u8 i;
-
-	pr_debug("%s rm_list_nr %d\n",
-		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
-
-	msk_owned_by_me(msk);
-
-	if (sk->sk_state == TCP_LISTEN)
-		return;
-
-	if (!rm_list->nr)
-		return;
-
-	if (list_empty(&msk->conn_list))
-		return;
-
-	for (i = 0; i < rm_list->nr; i++) {
-		u8 rm_id = rm_list->ids[i];
-		bool removed = false;
-
-		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-			u8 remote_id = READ_ONCE(subflow->remote_id);
-			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow_get_local_id(subflow);
-
-			if ((1 << inet_sk_state_load(ssk)) &
-			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
-				continue;
-			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
-				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
-				continue;
-
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
-				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
-			spin_unlock_bh(&msk->pm.lock);
-			mptcp_subflow_shutdown(sk, ssk, how);
-			removed |= subflow->request_join;
-
-			/* the following takes care of updating the subflows counter */
-			mptcp_close_ssk(sk, ssk, subflow);
-			spin_lock_bh(&msk->pm.lock);
-
-			if (rm_type == MPTCP_MIB_RMSUBFLOW)
-				__MPTCP_INC_STATS(sock_net(sk), rm_type);
-		}
-
-		if (rm_type == MPTCP_MIB_RMADDR)
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-
-		if (!removed)
-			continue;
-
-		if (!mptcp_pm_is_kernel(msk))
-			continue;
-
-		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
-		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-			/* Note: if the subflow has been closed before, this
-			 * add_addr_accepted counter will not be decremented.
-			 */
-			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
-				WRITE_ONCE(msk->pm.accept_addr, true);
-		}
-	}
-}
-
-static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
-{
-	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
-}
-
-static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-					    const struct mptcp_rm_list *rm_list)
-{
-	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
-}
-
-/* Called under PM lock */
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_data *pm = &msk->pm;
-
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
-		mptcp_pm_nl_add_addr_received(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
-		mptcp_pm_nl_fully_established(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
-}
-
-static bool address_use_port(struct mptcp_pm_addr_entry *entry)
-{
-	return (entry->flags &
-		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) ==
-		MPTCP_PM_ADDR_FLAG_SIGNAL;
-}
-
-/* caller must ensure the RCU grace period is already elapsed */
-static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
-{
-	if (entry->lsk)
-		sock_release(entry->lsk);
-	kfree(entry);
-}
-
-static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id, bool replace)
-{
-	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
-	unsigned int addr_max;
-	int ret = -EINVAL;
-
-	spin_lock_bh(&pernet->lock);
-	/* to keep the code simple, don't do IDR-like allocation for address ID,
-	 * just bail when we exceed limits
-	 */
-	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
-		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
-		ret = -ERANGE;
-		goto out;
-	}
-	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	/* do not insert duplicate address, differentiate on port only
-	 * singled addresses
-	 */
-	if (!address_use_port(entry))
-		entry->addr.port = 0;
-	list_for_each_entry(cur, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
-			/* allow replacing the exiting endpoint only if such
-			 * endpoint is an implicit one and the user-space
-			 * did not provide an endpoint id
-			 */
-			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
-				ret = -EEXIST;
-				goto out;
-			}
-			if (entry->addr.id)
-				goto out;
-
-			/* allow callers that only need to look up the local
-			 * addr's id to skip replacement. This allows them to
-			 * avoid calling synchronize_rcu in the packet recv
-			 * path.
-			 */
-			if (!replace) {
-				kfree(entry);
-				ret = cur->addr.id;
-				goto out;
-			}
-
-			pernet->addrs--;
-			entry->addr.id = cur->addr.id;
-			list_del_rcu(&cur->list);
-			del_entry = cur;
-			break;
-		}
-	}
-
-	if (!entry->addr.id && needs_id) {
-find_next:
-		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
-						    MPTCP_PM_MAX_ADDR_ID + 1,
-						    pernet->next_id);
-		if (!entry->addr.id && pernet->next_id != 1) {
-			pernet->next_id = 1;
-			goto find_next;
-		}
-	}
-
-	if (!entry->addr.id && needs_id)
-		goto out;
-
-	__set_bit(entry->addr.id, pernet->id_bitmap);
-	if (entry->addr.id > pernet->next_id)
-		pernet->next_id = entry->addr.id;
-
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
-	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
-	}
-
-	pernet->addrs++;
-	if (!entry->addr.port)
-		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
-	else
-		list_add_rcu(&entry->list, &pernet->local_addr_list);
-	ret = entry->addr.id;
-
-out:
-	spin_unlock_bh(&pernet->lock);
-
-	/* just replaced an existing entry, free it */
-	if (del_entry) {
-		synchronize_rcu();
-		__mptcp_pm_release_addr_entry(del_entry);
-	}
-	return ret;
-}
-
-static struct lock_class_key mptcp_slock_keys[2];
-static struct lock_class_key mptcp_keys[2];
-
-static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
-					    struct mptcp_pm_addr_entry *entry)
-{
-	bool is_ipv6 = sk->sk_family == AF_INET6;
-	int addrlen = sizeof(struct sockaddr_in);
-	struct sockaddr_storage addr;
-	struct sock *newsk, *ssk;
-	int backlog = 1024;
-	int err;
-
-	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
-	if (err)
-		return err;
-
-	newsk = entry->lsk->sk;
-	if (!newsk)
-		return -EINVAL;
-
-	/* The subflow socket lock is acquired in a nested to the msk one
-	 * in several places, even by the TCP stack, and this msk is a kernel
-	 * socket: lockdep complains. Instead of propagating the _nested
-	 * modifiers in several places, re-init the lock class for the msk
-	 * socket to an mptcp specific one.
-	 */
-	sock_lock_init_class_and_name(newsk,
-				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
-				      &mptcp_slock_keys[is_ipv6],
-				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
-				      &mptcp_keys[is_ipv6]);
-
-	lock_sock(newsk);
-	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
-	release_sock(newsk);
-	if (IS_ERR(ssk))
-		return PTR_ERR(ssk);
-
-	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (entry->addr.family == AF_INET6)
-		addrlen = sizeof(struct sockaddr_in6);
-#endif
-	if (ssk->sk_family == AF_INET)
-		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (ssk->sk_family == AF_INET6)
-		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
-#endif
-	if (err)
-		return err;
-
-	/* We don't use mptcp_set_state() here because it needs to be called
-	 * under the msk socket lock. For the moment, that will not bring
-	 * anything more than only calling inet_sk_state_store(), because the
-	 * old status is known (TCP_CLOSE).
-	 */
-	inet_sk_state_store(newsk, TCP_LISTEN);
-	lock_sock(ssk);
-	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
-	err = __inet_listen_sk(ssk, backlog);
-	if (!err)
-		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
-	release_sock(ssk);
-	return err;
-}
-
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc)
-{
-	struct mptcp_pm_addr_entry *entry;
-	struct pm_nl_pernet *pernet;
-	int ret;
-
-	pernet = pm_nl_get_pernet_from_msk(msk);
-
-	rcu_read_lock();
-	entry = __lookup_addr(pernet, &skc->addr);
-	ret = entry ? entry->addr.id : -1;
-	rcu_read_unlock();
-	if (ret >= 0)
-		return ret;
-
-	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
-	if (!entry)
-		return -ENOMEM;
-
-	*entry = *skc;
-	entry->addr.port = 0;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
-	if (ret < 0)
-		kfree(entry);
-
-	return ret;
-}
-
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-	struct mptcp_pm_addr_entry *entry;
-	bool backup;
-
-	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
-	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-	rcu_read_unlock();
-
-	return backup;
-}
-
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
@@ -1187,41 +19,10 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
-	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	unsigned int active_max_loss_cnt;
-	struct net *net = sock_net(sk);
-	unsigned int stale_loss_cnt;
-	bool slow;
-
-	stale_loss_cnt = mptcp_stale_loss_cnt(net);
-	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
-		return;
-
-	/* look for another available subflow not in loss state */
-	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
-	mptcp_for_each_subflow(msk, iter) {
-		if (iter != subflow && mptcp_subflow_active(iter) &&
-		    iter->stale_count < active_max_loss_cnt) {
-			/* we have some alternatives, try to mark this subflow as idle ...*/
-			slow = lock_sock_fast(ssk);
-			if (!tcp_rtx_and_write_queues_empty(ssk)) {
-				subflow->stale = 1;
-				__mptcp_retransmit_pending_data(sk);
-				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
-			}
-			unlock_sock_fast(ssk, slow);
-
-			/* always try to push the pending data regardless of re-injections:
-			 * we can possibly use backup subflows now, and subflow selection
-			 * is cheap under the msk socket lock
-			 */
-			__mptcp_push_pending(sk, 0);
-			return;
-		}
-	}
+	genlmsg_multicast_netns(&mptcp_genl_family, net,
+				nlskb, 0, MPTCP_PM_EV_GRP_OFFSET, gfp);
 }
 
 static int mptcp_pm_family_to_addr(int family)
@@ -1332,397 +133,16 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	return 0;
 }
 
-static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
 {
-	return pm_nl_get_pernet(genl_info_net(info));
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
 }
 
-static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
-					       struct mptcp_addr_info *addr)
-{
-	struct mptcp_sock *msk;
-	long s_slot = 0, s_num = 0;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-		struct mptcp_addr_info mpc_addr;
-
-		if (!READ_ONCE(msk->fully_established) ||
-		    mptcp_pm_is_userspace(msk))
-			goto next;
-
-		/* if the endp linked to the init sf is re-added with a != ID */
-		mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
-		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
-		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
-			msk->mpc_endpoint_id = addr->id;
-		mptcp_pm_create_subflow_or_signal_addr(msk);
-		spin_unlock_bh(&msk->pm.lock);
-		release_sock(sk);
-
-next:
-		sock_put(sk);
-		cond_resched();
-	}
-
-	return 0;
-}
-
-static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
-				      struct genl_info *info)
-{
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
-
-	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					 mptcp_pm_address_nl_policy, info->extack) &&
-	    tb[MPTCP_PM_ADDR_ATTR_ID])
-		return true;
-	return false;
-}
-
-int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
-	struct nlattr *attr;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.port && !address_use_port(&addr)) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "flags must have signal and not subflow when using port");
-		return -EINVAL;
-	}
-
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
-	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "flags mustn't have both signal and fullmesh");
-		return -EINVAL;
-	}
-
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "can't create IMPLICIT endpoint");
-		return -EINVAL;
-	}
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
-	if (!entry) {
-		GENL_SET_ERR_MSG(info, "can't allocate addr");
-		return -ENOMEM;
-	}
-
-	*entry = addr;
-	if (entry->addr.port) {
-		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
-		if (ret) {
-			GENL_SET_ERR_MSG_FMT(info, "create listen socket error: %d", ret);
-			goto out_free;
-		}
-	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info),
-						true);
-	if (ret < 0) {
-		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
-		goto out_free;
-	}
-
-	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk), &entry->addr);
-	return 0;
-
-out_free:
-	__mptcp_pm_release_addr_entry(entry);
-	return ret;
-}
-
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *entry;
-
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	if (entry) {
-		kfree(entry);
-		return true;
-	}
-
-	return false;
-}
-
-static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
-				  const struct mptcp_addr_info *addr)
-{
-	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
-}
-
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr,
-				      bool force)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	bool ret;
-
-	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
-
-	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
-	if (ret || force) {
-		spin_lock_bh(&msk->pm.lock);
-		if (ret) {
-			__set_bit(addr->id, msk->pm.id_avail_bitmap);
-			msk->pm.add_addr_signaled--;
-		}
-		mptcp_pm_remove_addr(msk, &list);
-		spin_unlock_bh(&msk->pm.lock);
-	}
-	return ret;
-}
-
-static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
-{
-	/* If it was marked as used, and not ID 0, decrement local_addr_used */
-	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
-	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
-		msk->pm.local_addr_used--;
-}
-
-static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
-						   const struct mptcp_pm_addr_entry *entry)
-{
-	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 1 };
-	long s_slot = 0, s_num = 0;
-	struct mptcp_sock *msk;
-
-	pr_debug("remove_id=%d\n", addr->id);
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-		bool remove_subflow;
-
-		if (mptcp_pm_is_userspace(msk))
-			goto next;
-
-		lock_sock(sk);
-		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
-					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-
-		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
-		if (remove_subflow) {
-			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
-			spin_unlock_bh(&msk->pm.lock);
-		}
-
-		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			spin_lock_bh(&msk->pm.lock);
-			__mark_subflow_endp_available(msk, list.ids[0]);
-			spin_unlock_bh(&msk->pm.lock);
-		}
-
-		if (msk->mpc_endpoint_id == entry->addr.id)
-			msk->mpc_endpoint_id = 0;
-		release_sock(sk);
-
-next:
-		sock_put(sk);
-		cond_resched();
-	}
-
-	return 0;
-}
-
-static int mptcp_nl_remove_id_zero_address(struct net *net,
-					   struct mptcp_addr_info *addr)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	long s_slot = 0, s_num = 0;
-	struct mptcp_sock *msk;
-
-	list.ids[list.nr++] = 0;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-		struct mptcp_addr_info msk_local;
-
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
-			goto next;
-
-		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
-			goto next;
-
-		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_nl_rm_subflow_received(msk, &list);
-		__mark_subflow_endp_available(msk, 0);
-		spin_unlock_bh(&msk->pm.lock);
-		release_sock(sk);
-
-next:
-		sock_put(sk);
-		cond_resched();
-	}
-
-	return 0;
-}
-
-int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
-	unsigned int addr_max;
-	struct nlattr *attr;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	/* the zero id address is special: the first address used by the msk
-	 * always gets such an id, so different subflows can have different zero
-	 * id addresses. Additionally zero id is not accounted for in id_bitmap.
-	 * Let's use an 'mptcp_rm_list' instead of the common remove code.
-	 */
-	if (addr.addr.id == 0)
-		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk), &addr.addr);
-
-	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
-	if (!entry) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
-	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
-	}
-
-	pernet->addrs--;
-	list_del_rcu(&entry->list);
-	__clear_bit(entry->addr.id, pernet->id_bitmap);
-	spin_unlock_bh(&pernet->lock);
-
-	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
-	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
-
-	return ret;
-}
-
-static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
-					      struct list_head *rm_list)
-{
-	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
-
-	list_for_each_entry(entry, rm_list, list) {
-		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
-
-		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-	if (alist.nr) {
-		msk->pm.add_addr_signaled -= alist.nr;
-		mptcp_pm_remove_addr(msk, &alist);
-	}
-	if (slist.nr)
-		mptcp_pm_nl_rm_subflow_received(msk, &slist);
-	/* Reset counters: maybe some subflows have been removed before */
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	msk->pm.local_addr_used = 0;
-	spin_unlock_bh(&msk->pm.lock);
-}
-
-static void mptcp_nl_flush_addrs_list(struct net *net,
-				      struct list_head *rm_list)
-{
-	long s_slot = 0, s_num = 0;
-	struct mptcp_sock *msk;
-
-	if (list_empty(rm_list))
-		return;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-
-		if (!mptcp_pm_is_userspace(msk)) {
-			lock_sock(sk);
-			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
-			release_sock(sk);
-		}
-
-		sock_put(sk);
-		cond_resched();
-	}
-}
-
-/* caller must ensure the RCU grace period is already elapsed */
-static void __flush_addrs(struct list_head *list)
-{
-	while (!list_empty(list)) {
-		struct mptcp_pm_addr_entry *cur;
-
-		cur = list_entry(list->next,
-				 struct mptcp_pm_addr_entry, list);
-		list_del_rcu(&cur->list);
-		__mptcp_pm_release_addr_entry(cur);
-	}
-}
-
-static void __reset_counters(struct pm_nl_pernet *pernet)
-{
-	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
-	WRITE_ONCE(pernet->local_addr_max, 0);
-	pernet->addrs = 0;
-}
-
-int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
-
-	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
-	__reset_counters(pernet);
-	pernet->next_id = 1;
-	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
-	synchronize_rcu();
-	__flush_addrs(&free_list);
-	return 0;
-}
-
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry)
+static int mptcp_nl_fill_addr(struct sk_buff *skb,
+			      struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -1760,230 +180,111 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			 struct genl_info *info)
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry *entry;
-	int ret = -EINVAL;
-
-	rcu_read_lock();
-	entry = __lookup_addr_by_id(pernet, id);
-	if (entry) {
-		*addr = *entry;
-		ret = 0;
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb)
-{
-	struct net *net = sock_net(msg->sk);
-	struct mptcp_pm_addr_entry *entry;
-	struct pm_nl_pernet *pernet;
-	int id = cb->args[0];
-	int i;
-
-	pernet = pm_nl_get_pernet(net);
-
-	rcu_read_lock();
-	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap)) {
-			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
-
-			if (entry->addr.id <= id)
-				continue;
-
-			if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
-				break;
-
-			id = entry->addr.id;
-		}
-	}
-	rcu_read_unlock();
-
-	cb->args[0] = id;
-	return msg->len;
-}
-
-static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
-{
-	struct nlattr *attr = info->attrs[id];
-
-	if (!attr)
-		return 0;
-
-	*limit = nla_get_u32(attr);
-	if (*limit > MPTCP_PM_ADDR_MAX) {
-		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
-					"limit greater than maximum (%u)",
-					MPTCP_PM_ADDR_MAX);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	unsigned int rcv_addrs, subflows;
-	int ret;
-
-	spin_lock_bh(&pernet->lock);
-	rcv_addrs = pernet->add_addr_accept_max;
-	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
-	if (ret)
-		goto unlock;
-
-	subflows = pernet->subflows_max;
-	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
-	if (ret)
-		goto unlock;
-
-	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
-	WRITE_ONCE(pernet->subflows_max, subflows);
-
-unlock:
-	spin_unlock_bh(&pernet->lock);
-	return ret;
-}
-
-int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry addr;
+	struct nlattr *attr;
 	struct sk_buff *msg;
 	void *reply;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
 	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  MPTCP_PM_CMD_GET_LIMITS);
-	if (!reply)
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
 		goto fail;
+	}
 
-	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
-			READ_ONCE(pernet->add_addr_accept_max)))
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		goto fail;
+	}
 
-	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
-			READ_ONCE(pernet->subflows_max)))
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
 		goto fail;
 
 	genlmsg_end(msg, reply);
-	return genlmsg_reply(msg, info);
+	ret = genlmsg_reply(msg, info);
+	return ret;
 
 fail:
-	GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
 	nlmsg_free(msg);
-	return -EMSGSIZE;
+	return ret;
 }
 
-static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr)
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_rm_list list = { .nr = 0 };
+	void *hdr;
 
-	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, &list);
-	__mark_subflow_endp_available(msk, list.ids[0]);
-	mptcp_pm_create_subflow_or_signal_addr(msk);
-	spin_unlock_bh(&msk->pm.lock);
-}
-
-static void mptcp_nl_set_flags(struct net *net,
-			       struct mptcp_pm_addr_entry *local,
-			       u8 changed)
-{
-	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
-	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-	long s_slot = 0, s_num = 0;
-	struct mptcp_sock *msk;
-
-	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
-		return;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
-			goto next;
-
-		lock_sock(sk);
-		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
-		/* Subflows will only be recreated if the SUBFLOW flag is set */
-		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
-			mptcp_pm_nl_fullmesh(msk, &local->addr);
-		release_sock(sk);
-
-next:
-		sock_put(sk);
-		cond_resched();
-	}
-
-	return;
-}
-
-int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
-			  struct genl_info *info)
-{
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
-			   MPTCP_PM_ADDR_FLAG_FULLMESH;
-	struct net *net = genl_info_net(info);
-	struct mptcp_pm_addr_entry *entry;
-	struct pm_nl_pernet *pernet;
-	u8 lookup_by_id = 0;
-
-	pernet = pm_nl_get_pernet(net);
-
-	if (local->addr.family == AF_UNSPEC) {
-		lookup_by_id = 1;
-		if (!local->addr.id) {
-			NL_SET_ERR_MSG_ATTR(info->extack, attr,
-					    "missing address ID");
-			return -EOPNOTSUPP;
-		}
-	}
-
-	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
-			       __lookup_addr(pernet, &local->addr);
-	if (!entry) {
-		spin_unlock_bh(&pernet->lock);
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
 		return -EINVAL;
-	}
-	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
-			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
-		spin_unlock_bh(&pernet->lock);
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
 		return -EINVAL;
 	}
 
-	changed = (local->flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
-	*local = *entry;
-	spin_unlock_bh(&pernet->lock);
-
-	mptcp_nl_set_flags(net, local, changed);
+	genlmsg_end(msg, hdr);
 	return 0;
 }
 
-static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	genlmsg_multicast_netns(&mptcp_genl_family, net,
-				nlskb, 0, MPTCP_PM_EV_GRP_OFFSET, gfp);
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct genl_info *info)
+{
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc;
+	int ret = -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return ret;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
+}
+
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(info);
 }
 
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk)
@@ -2324,53 +625,3 @@ struct genl_family mptcp_genl_family __ro_after_init = {
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
 };
-
-static int __net_init pm_nl_init_net(struct net *net)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
-
-	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
-
-	/* Cit. 2 subflows ought to be enough for anybody. */
-	pernet->subflows_max = 2;
-	pernet->next_id = 1;
-	pernet->stale_loss_cnt = 4;
-	spin_lock_init(&pernet->lock);
-
-	/* No need to initialize other pernet fields, the struct is zeroed at
-	 * allocation time.
-	 */
-
-	return 0;
-}
-
-static void __net_exit pm_nl_exit_net(struct list_head *net_list)
-{
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
-
-		/* net is removed from namespace list, can't race with
-		 * other modifiers, also netns core already waited for a
-		 * RCU grace period.
-		 */
-		__flush_addrs(&pernet->local_addr_list);
-	}
-}
-
-static struct pernet_operations mptcp_pm_pernet_ops = {
-	.init = pm_nl_init_net,
-	.exit_batch = pm_nl_exit_net,
-	.id = &pm_nl_pernet_id,
-	.size = sizeof(struct pm_nl_pernet),
-};
-
-void __init mptcp_pm_nl_init(void)
-{
-	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
-		panic("Failed to register MPTCP PM pernet subsystem.\n");
-
-	if (genl_register_family(&mptcp_genl_family))
-		panic("Failed to register MPTCP PM netlink family\n");
-}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8742527196887598eb242c82f06004107d29ef92..380b61be4cf65bc42f791bf2254c8a2b4aa333fe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -729,7 +729,10 @@ void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr);
+void mptcp_local_address(const struct sock_common *skc,
+			 struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
@@ -998,7 +1001,6 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
@@ -1011,10 +1013,13 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote);
+void mptcp_pm_send_ack(struct mptcp_sock *msk,
+		       struct mptcp_subflow_context *subflow,
+		       bool prio, bool backup);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
@@ -1025,14 +1030,10 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
@@ -1060,8 +1061,6 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
 			    struct netlink_callback *cb,
 			    struct mptcp_pm_addr_entry *entry);

-- 
2.47.1

