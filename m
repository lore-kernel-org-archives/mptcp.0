Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBF1FA4
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977514; x=1676513514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2nXdu5nNJkPcDV95CNUS45peiEoulnhateBofGFB04=;
  b=nbcU1QC/OJD1d14DZPpJFTTdZ9jWYGL1ohaVwcd7AYVgSBRZ+8qj2yMF
   NTCVu0SGIdjYkQpM2lyY/Z1sQowx9B4LwHzvrMzg58EiKGG+SBBeUO+yT
   iVdhXWC33YOaDgpfmf+YH8jYjdbsJ+x5AuNQew596bQaLnmjOrB7VTKTK
   LpVcF8ZHZ89XDhm4LPvtxof2r43bu6V+YI1fjq7U6f85YpY/zHB1Y6LZc
   d19MrPD3YVOaniV4F0PjaOYgZvF7yrP02waRiOCOvOur7jIgTo/hqoXDR
   hPbkaFYtpATzfOLTDOpJGKeKVLPmKF5dmbp3AxWBSCLPFrS9jUPDWHF0p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778523"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088827"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 8/8] mptcp: don't save tcp data_ready and write space callbacks
Date: Tue, 15 Feb 2022 18:11:30 -0800
Message-Id: <20220216021130.171786-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Assign the helpers directly rather than save/restore in the context
structure.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.h | 6 ++----
 net/mptcp/subflow.c  | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 86910f20486a..9d0ee6cee07f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -468,9 +468,7 @@ struct mptcp_subflow_context {
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
-	void	(*tcp_data_ready)(struct sock *sk);
 	void	(*tcp_state_change)(struct sock *sk);
-	void	(*tcp_write_space)(struct sock *sk);
 	void	(*tcp_error_report)(struct sock *sk);
 
 	struct	rcu_head rcu;
@@ -614,9 +612,9 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
-	sk->sk_data_ready = ctx->tcp_data_ready;
+	sk->sk_data_ready = sock_def_readable;
 	sk->sk_state_change = ctx->tcp_state_change;
-	sk->sk_write_space = ctx->tcp_write_space;
+	sk->sk_write_space = sk_stream_write_space;
 	sk->sk_error_report = ctx->tcp_error_report;
 
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 740cb4763461..45c004f87f5a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1654,10 +1654,12 @@ static int subflow_ulp_init(struct sock *sk)
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
-	ctx->tcp_data_ready = sk->sk_data_ready;
 	ctx->tcp_state_change = sk->sk_state_change;
-	ctx->tcp_write_space = sk->sk_write_space;
 	ctx->tcp_error_report = sk->sk_error_report;
+
+	WARN_ON_ONCE(sk->sk_data_ready != sock_def_readable);
+	WARN_ON_ONCE(sk->sk_write_space != sk_stream_write_space);
+
 	sk->sk_data_ready = subflow_data_ready;
 	sk->sk_write_space = subflow_write_space;
 	sk->sk_state_change = subflow_state_change;
@@ -1712,9 +1714,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 
 	new_ctx->conn_finished = 1;
 	new_ctx->icsk_af_ops = old_ctx->icsk_af_ops;
-	new_ctx->tcp_data_ready = old_ctx->tcp_data_ready;
 	new_ctx->tcp_state_change = old_ctx->tcp_state_change;
-	new_ctx->tcp_write_space = old_ctx->tcp_write_space;
 	new_ctx->tcp_error_report = old_ctx->tcp_error_report;
 	new_ctx->rel_write_seq = 1;
 	new_ctx->tcp_sock = newsk;
-- 
2.35.1

