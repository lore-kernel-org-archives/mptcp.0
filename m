Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9D2CA7
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447173; x=1680983173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Naww5WAF6j8utdrDnHxc3XOrwlWX7aHlT9VXi8XwnA4=;
  b=AJx4eG564ECJWTwn/xUlEmUdSCKum0lMfYK9aVVhpM2GOMfYvyxQDJnf
   0t8SXyc9E5TfuwFbxox6u6klL+yMuSofoXHYhGrva35QxpPFoLewTpL/q
   JN3Ca5ewpMz+GQ0tRsaJKhCkXJancaasC1MWobbC0/Sm4SKNxP+1Yy9fW
   uEHgnWiK+ND03fhd7jIfz7+BymNLokb+7wJw6MJGSd9e27UV9aNmMQiRe
   iwPbBZpnAkxMF8cUtQd19A1ne9zuFdbIlRRl6ObVsGoQZOWqQxOtcOyQi
   B5efgCDatpOsPvRW8fqgF8rE/KA5qWzuxYl7XF8A5s9EHk9Sh+dIkdlEs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365297"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365297"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602152"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:08 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/8] mptcp: reset the packet scheduler on incoming MP_PRIO
Date: Fri,  8 Apr 2022 12:45:55 -0700
Message-Id: <20220408194601.305969-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When an incoming MP_PRIO option changes the backup
status of any subflow, we need to reset the packet
scheduler status, or the next send could keep using
the previously selected subflow, without taking in account
the new priorities.

Reported-by: Davide Caratti <dcaratti@redhat.com>
Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 19 +++++++++++++++----
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 01809eef29b4..8aa0cdb7ad46 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -262,14 +262,25 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
+void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+	struct mptcp_sock *msk;
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
-	subflow->backup = bkup;
+	msk = mptcp_sk(sk);
+	if (subflow->backup != bkup) {
+		subflow->backup = bkup;
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			msk->last_snd = NULL;
+		else
+			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
+		mptcp_data_unlock(sk);
+	}
 
-	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
+	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a9335ce5df1..8f54293c1d88 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3102,6 +3102,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
+			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c1a3036550f..aca1fb56523f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
+#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- 
2.35.1

