Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F61321B
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524767; x=1683060767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8YE41PYOhNCiCTl5tdJDRpWVIfLdzB0W0L7IYHQ/tIA=;
  b=StjxulLZWa6ziHHVicVx26oEp5f8sDgWLTu9cAR+5X39ayZWQVIOtusj
   6i47DzsclsVy0Iu4ZkkMpnFYQAYPgeq9OE1zSeix+9IYK2+r7dHkLxfc9
   LsqhI2TyHk3an3j8OMMyxHYvPVIAOrP/ZdgCpvm+SB99GOn6r0aOU0BoH
   oVLFWMIa+roO0s3Rd7QaDWBe/wg9Kln6hiV8RognWjTHkLnFyJKk21NoY
   oJOKMqxk1dRK8cajpvycOFFdHxZNhIsLxUn/iKZs3EXd5bCbNMR7+9PPB
   V49ZCgfDFLT0VrR/ygXhXx4mZfXeuWwH/ZuNCuk3poQI1Z1WzrxY/puPL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247875190"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247875190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733619582"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/7] mptcp: establish subflows from either end of connection
Date: Mon,  2 May 2022 13:52:35 -0700
Message-Id: <20220502205237.129297-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
References: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change updates internal logic to permit subflows to be
established from either the client or server ends of MPTCP
connections. This symmetry and added flexibility may be
harnessed by PM implementations running on either end in
creating new subflows.

The essence of this change lies in not relying on the
"server_side" flag (which continues to be available if needed).

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 5 +----
 net/mptcp/protocol.h | 8 ++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9625fea3ef9..e05d9458a025 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -931,7 +931,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
-		    READ_ONCE(msk->pm.server_side))
+		    !subflow->request_join)
 			tcp_send_ack(ssk);
 		goto fully_established;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a5d466e6b538..5d529143ad77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,15 +3321,12 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	if (!msk->pm.server_side)
+	if (!list_empty(&subflow->node))
 		goto out;
 
 	if (!mptcp_pm_allow_new_subflow(msk))
 		goto err_prohibited;
 
-	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
-		goto err_prohibited;
-
 	/* active connections are already on conn_list.
 	 * If we can't acquire msk socket lock here, let the release callback
 	 * handle it
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a762b789f5ab..187c932deef0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -911,13 +911,17 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 	return false;
 }
 
+static inline bool is_active_ssk(struct mptcp_subflow_context *subflow)
+{
+	return (subflow->request_mptcp || subflow->request_join);
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct sock *parent = subflow->conn;
 
 	return sk->sk_state == TCP_ESTABLISHED &&
-	       !mptcp_sk(parent)->pm.server_side &&
+	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }
 
-- 
2.36.0

