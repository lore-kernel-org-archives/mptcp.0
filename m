Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920E20EC
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 02:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649299370; x=1680835370;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=F5bEzE1YdN2UjunsOAw9AkKJ4FZzqySyiEln37ltG8Y=;
  b=OfmKplfnlpOqyUA9IwpCYVSdDJjpRtbBZG/vjtn6dGBWml6jl3RSVs2t
   FA5/wfU8Pax0mYRj3R1ykbXrHtFW39XR7gvYaNLn+YGfIkYqhRcVpNP+a
   CGS4JqFezU+QWpXvLl0VJILDgPObW925NwOh+1hgWky6Jf0Y1SK4TtclU
   0zzwXORQQEWYYkwtiWYzgockOv9Muh9efWEFZSDOhJcCipLuV2xGfQYab
   EdZ6q8fXCz37jy34jPlwiMoJRKX1OaDuYZ4wJSiRkZuV8ESjiHAbbI8sj
   TsbLhk7IheqbR/5N90uyEpcKCEX7EK1ldoTHrw593lofp5EdBDTYVGRVg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286189744"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="286189744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="658882190"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:46 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 03/14] mptcp: read attributes of addr entries managed by userspace PMs
Date: Wed,  6 Apr 2022 22:42:30 -0400
Message-Id: <20220407024241.1757334-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220407024241.1757334-1-kishen.maloor@intel.com>
References: <20220407024241.1757334-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces a parallel path in the kernel for retrieving
the local id, flags, if_index for an addr entry in the context of
an MPTCP connection that's being managed by a userspace PM. The
userspace and in-kernel PM modes deviate in their procedures for
obtaining this information.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v7:
-Move userspace PM specific handling into mptcp_userspace_pm_get_local_id()
and mptcp_userspace_pm_get_flags_and_ifindex_by_id().
---
 net/mptcp/pm_netlink.c   | 13 +++++++++++-
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  7 ++++++-
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 92d47e8e8983..ceb1c310d0c6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1041,6 +1041,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
+
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
@@ -1305,15 +1308,23 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
 
 	*flags = 0;
 	*ifindex = 0;
 
 	if (id) {
+		if (mptcp_pm_is_userspace(msk))
+			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
+									      id,
+									      flags,
+									      ifindex);
+
 		rcu_read_lock();
 		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index cb8321cdb4ea..871baee676bd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -72,3 +72,46 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
+
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex)
+{
+	struct mptcp_pm_addr_entry *entry, *match = NULL;
+
+	*flags = 0;
+	*ifindex = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (id == entry->addr.id) {
+			match = entry;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (match) {
+		*flags = match->flags;
+		*ifindex = match->ifindex;
+	}
+
+	return 0;
+}
+
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry new_entry;
+	__be16 msk_sport =  ((struct inet_sock *)
+			     inet_sk((struct sock *)msk))->inet_sport;
+
+	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
+	new_entry.addr = *skc;
+	new_entry.addr.id = 0;
+	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
+	if (new_entry.addr.port == msk_sport)
+		new_entry.addr.port = 0;
+
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 40dabf9462a8..a6ee811e5d02 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -775,8 +775,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -854,6 +858,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a0e7af33fb26..6d59336a8e1e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1468,7 +1468,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (local_id)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
-- 
2.31.1

