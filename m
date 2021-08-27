Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718472
	for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 00:45:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="205007600"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="205007600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="599007132"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.68.199])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/5] mptcp: optimize the input options processing
Date: Thu, 26 Aug 2021 17:44:53 -0700
Message-Id: <20210827004455.286754-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827004455.286754-1-mathew.j.martineau@linux.intel.com>
References: <20210827004455.286754-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Most MPTCP packets carries a single MPTCP subption: the
DSS containing the mapping for the current packet.

Check explicitly for the above, so that is such scenario we
replace most conditional statements with a single likely() one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 71 +++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d33c020062f..f5fa8e7efd9c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1111,48 +1111,51 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return sk->sk_state != TCP_CLOSE;
 
-	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-	    msk->local_key == mp_opt.rcvr_key) {
-		WRITE_ONCE(msk->rcv_fastclose, true);
-		mptcp_schedule_work((struct sock *)msk);
-	}
+	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
+		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
+		    msk->local_key == mp_opt.rcvr_key) {
+			WRITE_ONCE(msk->rcv_fastclose, true);
+			mptcp_schedule_work((struct sock *)msk);
+		}
 
-	if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
-		if (!mp_opt.echo) {
-			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
-		} else {
-			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
+		    add_addr_hmac_valid(msk, &mp_opt)) {
+			if (!mp_opt.echo) {
+				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+			} else {
+				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
+				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+			}
+
+			if (mp_opt.addr.port)
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
 		}
 
-		if (mp_opt.addr.port)
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
+			mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
 
-	if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
-		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
+		if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
+			mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
-		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
+			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
-		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_RST) {
+			subflow->reset_seen = 1;
+			subflow->reset_reason = mp_opt.reset_reason;
+			subflow->reset_transient = mp_opt.reset_transient;
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_RST) {
-		subflow->reset_seen = 1;
-		subflow->reset_reason = mp_opt.reset_reason;
-		subflow->reset_transient = mp_opt.reset_transient;
+		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
+			return true;
 	}
 
-	if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
-		return true;
-
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
@@ -1179,7 +1182,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	memset(mpext, 0, sizeof(*mpext));
 
-	if (mp_opt.use_map) {
+	if (likely(mp_opt.use_map)) {
 		if (mp_opt.mpc_map) {
 			/* this is an MP_CAPABLE carrying MPTCP data
 			 * we know this map the first chunk of data
-- 
2.33.0

