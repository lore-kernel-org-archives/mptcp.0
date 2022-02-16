Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463351FA8
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977513; x=1676513513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gjydlaEKpBxwKt2pe7JF2Jr38ug0drglZmF5L56WW7k=;
  b=NWD9KZfuxanHa1RO+bpWqvnXQAk0BRWYU4UM96/IvCuYKIdslNhy/vAF
   1SQieuR9urCc0+34HBPwgASKWcc0OyxLIQpgxqAK5WI6kR964Qjdq8JsM
   v0qVJnY9bbxV7CsY3FxL3gvRBJo1jcqZfLktiMUZd+tRzxJhHACpgU1zP
   SuIJVI+oAY1rhMZoR2k6F2+IF05MrKqoneWGqc65Go3ruHvscmtmp5zO/
   2ykKHPmFn78Obv3JltS34NGiqgXr1CQfaL3mmFjxRWMawEUyMsIsmOogF
   SxK6lbCrAD8FWlijYmJ7fZoQHLywAe+P7m5C1jEsOtGm4iMULCy2PFGX1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778520"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778520"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088826"
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
Subject: [PATCH net-next 7/8] mptcp: mark ops structures as ro_after_init
Date: Tue, 15 Feb 2022 18:11:29 -0800
Message-Id: <20220216021130.171786-8-mathew.j.martineau@linux.intel.com>
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

These structures are initialised from the init hooks, so we can't make
them 'const'.  But no writes occur afterwards, so we can use ro_after_init.

Also, remove bogus EXPORT_SYMBOL, the only access comes from ip
stack, not from kernel modules.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8cf85684c88f..740cb4763461 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -482,8 +482,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 }
 
 struct request_sock_ops mptcp_subflow_request_sock_ops;
-EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
-static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -504,9 +503,9 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
-static struct inet_connection_sock_af_ops subflow_v6_specific;
-static struct inet_connection_sock_af_ops subflow_v6m_specific;
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
 static struct proto tcpv6_prot_override;
 
 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -788,7 +787,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 }
 
-static struct inet_connection_sock_af_ops subflow_specific;
+static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
 static struct proto tcp_prot_override;
 
 enum mapping_status {
@@ -1309,7 +1308,7 @@ static void subflow_write_space(struct sock *ssk)
 	mptcp_write_space(sk);
 }
 
-static struct inet_connection_sock_af_ops *
+static const struct inet_connection_sock_af_ops *
 subflow_default_af_ops(struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1324,7 +1323,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct inet_connection_sock_af_ops *target;
+	const struct inet_connection_sock_af_ops *target;
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-- 
2.35.1

