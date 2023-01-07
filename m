Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7310E5
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673056004; x=1704592004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdUNtY26CU/G5cw+K8EYRXAPOyGgj13nrX+yMhWgTdE=;
  b=Jfl1dnvDpzgo2cbrdixxax173S9DYqGEsHZBg14ktA8RJHAqbJjpfvj5
   Qk9+heRQEwTckNUAFT0rm/CN+yV1kD2bhh7ujaogKz2I9QIGFSIwpiM6y
   1lWJSGIrQakbGVsthi6SlVbmpqucly2IPqVCNS5Ont53uJnVc9Eh6Or68
   cjWA8ljFqJx/8qi+lFKNv2ifVuU657Rh7Lg1aE28+z0KkPMpzyDEpWHhE
   ldw55dcZJMb7WvSm/BJJ0JlGrN7Sv7jH+rUONbmLGJAqnoEIvi6+75Cu+
   wFTOjaO6/iz5IVJfYQxQUMwOsRoT8k2y+VTa4IVfddA3TS8WDgGo7Bibz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310393552"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="310393552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="606066134"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="606066134"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 1/4] mptcp: mark ops structures as ro_after_init
Date: Fri,  6 Jan 2023 17:46:28 -0800
Message-Id: <20230107014631.449550-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
References: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

commit 51fa7f8ebf0e25c7a9039fa3988a623d5f3855aa upstream.

These structures are initialised from the init hooks, so we can't make
them 'const'.  But no writes occur afterwards, so we can use ro_after_init.

Also, remove bogus EXPORT_SYMBOL, the only access comes from ip
stack, not from kernel modules.

Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/subflow.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2e9238490924..61919e2499e7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -360,8 +360,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 }
 
 struct request_sock_ops mptcp_subflow_request_sock_ops;
-EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
-static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -382,9 +381,9 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
-static struct inet_connection_sock_af_ops subflow_v6_specific;
-static struct inet_connection_sock_af_ops subflow_v6m_specific;
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
 
 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -636,7 +635,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 }
 
-static struct inet_connection_sock_af_ops subflow_specific;
+static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
 
 enum mapping_status {
 	MAPPING_OK,
@@ -1017,7 +1016,7 @@ static void subflow_write_space(struct sock *sk)
 	}
 }
 
-static struct inet_connection_sock_af_ops *
+static const struct inet_connection_sock_af_ops *
 subflow_default_af_ops(struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1032,7 +1031,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct inet_connection_sock_af_ops *target;
+	const struct inet_connection_sock_af_ops *target;
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-- 
2.39.0

