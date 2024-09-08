Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AF3224;
	Sun,  8 Sep 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800809; cv=none; b=TKvPIgHCLvManm8xf2UAgsTP/Sd0vky3s2iUIc1bw739VQlyTMnxE+i4WrPoj0baUQF7giLG46TB5Gxhtm7NQvaDJpPLouR4U72Wk4l6Zb7v+bp+LmGsC4S+jATnG2NXOVmQprM9kZ83GundMg+rLnikOab7MB5plvt8VbfY988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800809; c=relaxed/simple;
	bh=m1vLFVS2fF2lvb7frbAKl+bmvp7/ygsGiv38NGxoJgo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=PGmQULIrSA+Oi9vp2SWjRBBejm3uOo0hUpDCWlR83MGYKuLYmjC/Jvrf0kqmm5/nib9+9Cgf8XYuxXgCnOG1FI+9f6//1a9vnLNMHgBXIEkCPo7jHyFx6GKyVwiGloo/TFe4jSXitcHgF5B6ymYhzSrsIZD0cI8IAAPR3ij/UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ovq/EVAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ovq/EVAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD0C4CEC3;
	Sun,  8 Sep 2024 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800809;
	bh=m1vLFVS2fF2lvb7frbAKl+bmvp7/ygsGiv38NGxoJgo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Ovq/EVAevrx8iB4UHOIySE+z0UOqMpVH85n7SgcvEqW5FsAonWREq7fjvrRJJHCe0
	 zU2o6n6q5EnnffqlFpQ6MVW4Uy7QIA+T2U7DudcNqYGblnecgkvtv4pYgGmuPxSTTL
	 ajf8+JpMO1l6+1ufoXKNEP7zaOvwnJpcxW3A/lLc=
Subject: Patch "mptcp: constify a bunch of of helpers" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:42 +0200
In-Reply-To: <20240906083151.1768557-3-matttbe@kernel.org>
Message-ID: <2024090842-ethically-padding-192d@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    mptcp: constify a bunch of of helpers

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-constify-a-bunch-of-of-helpers.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73734-greg=kroah.com@vger.kernel.org Fri Sep  6 10:32:23 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:31:52 +0200
Subject: mptcp: constify a bunch of of helpers
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240906083151.1768557-3-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 90d930882139f166ed2551205d6f6d8c50b656fb upstream.

A few pm-related helpers don't touch arguments which lacking
the const modifier, let's constify them.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 48e50dcbcbaa ("mptcp: pm: avoid possible UaF when selecting endp")
[ Conflicts because a few modified helpers from the original patch are
  not present in this version. We don't need to do anything with them. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c         |    4 ++--
 net/mptcp/pm_netlink.c |   36 ++++++++++++++++++------------------
 net/mptcp/protocol.h   |   18 +++++++++---------
 3 files changed, 29 insertions(+), 29 deletions(-)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -202,7 +202,7 @@ void mptcp_pm_add_addr_received(struct m
 }
 
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -260,7 +260,7 @@ void mptcp_pm_mp_fail_received(struct so
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -60,7 +60,7 @@ struct pm_nl_pernet {
 #define ADD_ADDR_RETRANS_MAX	3
 
 static bool addresses_equal(const struct mptcp_addr_info *a,
-			    struct mptcp_addr_info *b, bool use_port)
+			    const struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
@@ -123,7 +123,7 @@ static void remote_address(const struct
 }
 
 static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    struct mptcp_addr_info *saddr)
+				    const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -141,7 +141,7 @@ static bool lookup_subflow_by_saddr(cons
 }
 
 static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    struct mptcp_addr_info *daddr)
+				    const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -162,8 +162,8 @@ static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
 {
+	const struct sock *sk = (const struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
-	struct sock *sk = (struct sock *)msk;
 
 	msk_owned_by_me(msk);
 
@@ -219,16 +219,16 @@ select_signal_address(struct pm_nl_perne
 	return ret;
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	const struct pm_nl_pernet *pernet;
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
 
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -237,7 +237,7 @@ unsigned int mptcp_pm_get_add_addr_accep
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -246,7 +246,7 @@ unsigned int mptcp_pm_get_subflows_max(s
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
 
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -264,8 +264,8 @@ static void check_work_pending(struct mp
 }
 
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr)
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -346,7 +346,7 @@ out:
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id)
+		       const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -364,7 +364,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     const struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -410,8 +410,8 @@ void mptcp_pm_free_anno_list(struct mptc
 	}
 }
 
-static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
-				  struct mptcp_addr_info *addr)
+static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
+				  const struct mptcp_addr_info *addr)
 {
 	int i;
 
@@ -1329,7 +1329,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id
 }
 
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr)
+				      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1344,7 +1344,7 @@ static bool remove_anno_list_by_saddr(st
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr,
+				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -738,7 +738,7 @@ void mptcp_pm_subflow_closed(struct mptc
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
@@ -752,10 +752,10 @@ void mptcp_pm_free_anno_list(struct mptc
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id);
+		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr);
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 					 u8 *flags, int *ifindex);
 
@@ -814,7 +814,7 @@ static inline int mptcp_rm_addr_len(cons
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
@@ -830,10 +830,10 @@ void mptcp_pm_nl_rm_subflow_received(str
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-5.15/mptcp-pm-only-decrement-add_addr_accepted-for-mpj-req.patch
queue-5.15/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-5.15/mptcp-pm-skip-connecting-to-already-established-sf.patch
queue-5.15/mptcp-pm-re-using-id-of-unused-flushed-subflows.patch
queue-5.15/mptcp-pm-add_addr-0-is-not-a-new-address.patch
queue-5.15/mptcp-constify-a-bunch-of-of-helpers.patch
queue-5.15/mptcp-pm-do-not-remove-already-closed-subflows.patch
queue-5.15/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-5.15/mptcp-pm-check-add_addr_accept_max-before-accepting-new-add_addr.patch
queue-5.15/mptcp-close-subflow-when-receiving-tcp-fin.patch
queue-5.15/mptcp-avoid-duplicated-sub_closed-events.patch
queue-5.15/mptcp-pm-send-ack-on-an-active-subflow.patch
