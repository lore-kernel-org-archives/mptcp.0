Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB863204F6F
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070009; cv=none; b=luNb9kLPnN+rlKygR91fZ7u9KDDn2joAcZqig0/4yZJMRAvdUN2/raEV0O/aF89YaU6d7o/ScYDpAdHXnJVq3V35rLhdwTIGgqu4USBQmbNaITC27Le+D0p4DjDRxzrEkcZYqQjpvtEUec/X1f/FBhpbu6Qkt2GQdVKTDiRgDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070009; c=relaxed/simple;
	bh=wr5QJf611vpFPwPSZ9wJV0QzzUvva39TBierFt5EFS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6sILmgaC8qS3mijJbMzMP1f8QPzhYL4+UqXz2fhCOGGJOdGJxzcan2wZ7XhyFrep8sv/iCf9TumMZSfBCjkxPZwuGO8tanG5fBracOV8j+vbPNx4BLhkeTQ3BQPv9vfrPcg4CvLff4eDyhUvCjImAA7/nqRMq2+Bb2uvT/HWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpW7JdU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpW7JdU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54498C4CECE;
	Wed, 16 Oct 2024 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070008;
	bh=wr5QJf611vpFPwPSZ9wJV0QzzUvva39TBierFt5EFS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpW7JdU9z7Eg4E0Zr/ixikci5lvHorW+yOZGhvqGy97QARGwFr8GT2yxmQnweX9jJ
	 1pR3ifM6btdLRcDgHmQpD9cyZTTWFahQdgxYYQ6ksJ6OF0+Ly3FqOyXXkzaXmRPxA6
	 VAQ1XGoMweLvWmFsIkWR1sUrQgkF7Y0hTwkgO4pC4d2L8lQt8Ky5scjIvUBEguwrrV
	 i9VcrHwD/9efGbE3QDEA4ShKeraOJ1s3PTC6SOe024ljuV4HTsoWGfIqivYS26kuk2
	 ENDJK3hKU77zqltbCPk8x2c+LfbTctFmWjbgN2k2yIcgpfNMbIqO8EWHOrs/DobuT2
	 MepyoebgHjuow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 24/33] mptcp: drop struct mptcp_pm_add_entry
Date: Wed, 16 Oct 2024 17:12:28 +0800
Message-ID: <7c25953b40bcf0e686e5b6bc8cf8ec89222cecc3.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There is no need to add a dedicated address entry type "mptcp_pm_add_entry"
to represent ADD_ADDR addresses. Additional fields for ADD_ADDR addresses
can be added into struct mptcp_pm_addr_entry directly. This makes the path
manager code simpler.

Here "union" can be used to merge struct mptcp_pm_addr_entry and struct
mptcp_pm_add_entry into one. Then all mptcp_pm_add_entry can be replaced by
mptcp_pm_addr_entry.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 26 +++++++++-----------------
 net/mptcp/protocol.h   | 20 +++++++++++++++-----
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8f91fa2c398b..016ea8aba625 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,14 +18,6 @@
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_add_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			retrans_times;
-	struct timer_list	add_timer;
-	struct mptcp_sock	*sock;
-};
-
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -247,11 +239,11 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -265,7 +257,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -286,7 +278,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_pm_addr_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
@@ -328,11 +320,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	__sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 	struct timer_list *add_timer = NULL;
 
@@ -356,7 +348,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_addr_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
@@ -392,7 +384,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -1439,7 +1431,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 038b50c8e211..2423079662d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,9 +243,19 @@ struct mptcp_pm_data {
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-	struct socket		*lsk;
+	union {
+		struct {
+			u8			flags;
+			int			ifindex;
+			struct socket		*lsk;
+		};
+		/* mptcp_pm_add_entry */
+		struct {
+			u8			retrans_times;
+			struct timer_list	add_timer;
+			struct mptcp_sock	*sock;
+		};
+	};
 };
 
 struct mptcp_data_frag {
@@ -1026,10 +1036,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
-- 
2.43.0

