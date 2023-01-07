Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7B10F7
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673056006; x=1704592006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRK4qVuzy0Id0xZgzO8hfEU1b1UXL/05oFAKMiQXlsU=;
  b=bRRSQZ7KscVn9iTNSdNfECggCe0mkOFW4cgGDWotDFKw8RxcnZk2S3Nu
   yd7TBcBBsA4RBzMUIljYnSx0mk/snSBkUtPa+tfmDiE97mnI5MWAc9PAw
   CBli7XEBLjH4c1YhSvuJdj17wc7W1wihLiL8Th5nOBTtGSJ40lUWUtAnr
   2cXw7Q83EOUoeRzLGyhyxSC0cZWD97NU3/F7vnV3FBCRSx3JfcSF5WXZi
   xGjmOJwVd5ksqCKMvVNesTNM13ZdgNHE2yW8ODt0MGUt63Yct7qfpg6hq
   7OTuRBzidJX2RIQtWQoB1DeBHrCNONyshrWzwUKRuff8JFjSeaqh1nJj8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310393571"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="310393571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="606066137"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="606066137"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	pabeni@redhat.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 4/4] mptcp: use proper req destructor for IPv6
Date: Fri,  6 Jan 2023 17:46:31 -0800
Message-Id: <20230107014631.449550-5-mathew.j.martineau@linux.intel.com>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit d3295fee3c756ece33ac0d935e172e68c0a4161b upstream.

Before, only the destructor from TCP request sock in IPv4 was called
even if the subflow was IPv6.

It is important to use the right destructor to avoid memory leaks with
some advanced IPv6 features, e.g. when the request socks contain
specific IPv6 options.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/subflow.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index aeb723b38ced..3b154ad4945c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -40,7 +40,6 @@ static void subflow_req_destructor(struct request_sock *req)
 		sock_put((struct sock *)subflow_req->msk);
 
 	mptcp_token_destroy_request(req);
-	tcp_request_sock_ops.destructor(req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -380,6 +379,12 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static void subflow_v4_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp_request_sock_ops.destructor(req);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
@@ -410,6 +415,12 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	tcp_listendrop(sk);
 	return 0; /* don't send reset */
 }
+
+static void subflow_v6_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp6_request_sock_ops.destructor(req);
+}
 #endif
 
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
@@ -1401,8 +1412,6 @@ static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 	if (!subflow_ops->slab)
 		return -ENOMEM;
 
-	subflow_ops->destructor = subflow_req_destructor;
-
 	return 0;
 }
 
@@ -1410,6 +1419,8 @@ void __init mptcp_subflow_init(void)
 {
 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
+	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
 
@@ -1431,6 +1442,8 @@ void __init mptcp_subflow_init(void)
 
 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
+	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
 
-- 
2.39.0

