Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39F2F28
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652398026; x=1683934026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RHugB5Hjz9zdcLDqVwhGkff4wmFwxuJQu7+m1e3h1k=;
  b=BE0GWtVbb+W8a1RRGfb+8DoW7dhrWnH59QuJ4l0QB+Mq/LFPzEFcBpIZ
   Tip4yGprNc76gyHL+P9BVYliY8FiZm5hpw0louovkf+QKiVu3fiRZ/vi3
   WGn1pq77F6qRUBTNb5jfZmxNE3H+B+eiq7Ry2qMRO4ARh8F4wGIumOleR
   Or8t8m+k4TvZlkelIN8jmYQvFKw/WEvueDXU1Pov7k/2mS+HySEFzqLC5
   GAIS2Yy9BOVlor0bmTSJz+kmwGQI/3i1o/6ovdW2IrbvqWNrDNpz8IvUO
   sujtBZP+bMODrAHibF9gpP9FRHRjillNRAlCy82l814O63NH/L1ssh/eV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356590479"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="356590479"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739919554"
Received: from cmokhtar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:47 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/2] mptcp: fix subflow accounting on close
Date: Thu, 12 May 2022 16:26:41 -0700
Message-Id: <20220512232642.541301-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512232642.541301-1-mathew.j.martineau@linux.intel.com>
References: <20220512232642.541301-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

If the PM closes a fully established MPJ subflow or the subflow
creation errors out in it's early stage the subflows counter is
not bumped accordingly.

This change adds the missing accounting, additionally taking care
of updating accordingly the 'accept_subflow' flag.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       |  5 ++---
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 12 +++++++++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 01809eef29b4..aa51b100e033 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -178,14 +178,13 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join);
+	update_subflows = subflow->request_join || subflow->mp_join;
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
 	spin_lock_bh(&pm->lock);
 	if (update_subflows)
-		pm->subflows--;
+		__mptcp_pm_close_subflow(msk);
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c1a3036550f..f4ce28bb0fdc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,6 +833,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index aba260f547da..8c37087f0d84 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1422,20 +1422,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
 	int ifindex;
 	u8 flags;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1492,6 +1492,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 failed:
 	subflow->disposable = 1;
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be caught by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
-- 
2.36.1

