Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F4A31
	for <mptcp@lists.linux.dev>; Sat, 10 Dec 2022 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670632101; x=1702168101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnTSysRNbAWtXozK6lTqUq/j/lCjWUE0xHsEdF/iWvg=;
  b=U/hktjv7n5Dh5+t6fLp96XLy7wuTRdCysq7/0/BFPa5sVhkprL5RoHI9
   nzCyqpLmZZLaBY4JFu+Bp2BihFOmfyYicCyZwPXlgDKOWn0EdtM9lDMfv
   6g8Ob0+pqpXQVTLizJoMjp5VlFoEq0DHZjtt3ph9QT70jGxzDwvkVPRD8
   cQOyViCWTs1mPd0fFVBDvUegyYIoJQTlAHMDqiskTT6uAnUa1QhmqtGd5
   QqD4Y3QYnxDQQWl0rgjvevz1dZ8Xzj60rhIy0826i0x6aa337QHg/OlVH
   IwC1HXUeOJyAobUY8T5qWGd/SNV79ChrR8mAM2vPA5IqytSAJDZgAqvXz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="381879143"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="381879143"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:28:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="649728883"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="649728883"
Received: from hthiagar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.121])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:28:18 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kishen.maloor@intel.com,
	dcaratti@redhat.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH net 4/4] mptcp: use proper req destructor for IPv6
Date: Fri,  9 Dec 2022 16:28:10 -0800
Message-Id: <20221210002810.289674-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210002810.289674-1-mathew.j.martineau@linux.intel.com>
References: <20221210002810.289674-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Before, only the destructor from TCP request sock in IPv4 was called
even if the subflow was IPv6.

It is important to use the right destructor to avoid memory leaks with
some advanced IPv6 features, e.g. when the request socks contain
specific IPv6 options.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Note: One original author of 79c0949e9a09 is not cc'd due to inactive
email address.

---
 net/mptcp/subflow.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30524dd7d0ec..613f515fedf0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -45,7 +45,6 @@ static void subflow_req_destructor(struct request_sock *req)
 		sock_put((struct sock *)subflow_req->msk);
 
 	mptcp_token_destroy_request(req);
-	tcp_request_sock_ops.destructor(req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -550,6 +549,12 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
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
@@ -581,6 +586,12 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
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
@@ -1929,8 +1940,6 @@ static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 	if (!subflow_ops->slab)
 		return -ENOMEM;
 
-	subflow_ops->destructor = subflow_req_destructor;
-
 	return 0;
 }
 
@@ -1938,6 +1947,8 @@ void __init mptcp_subflow_init(void)
 {
 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
+	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
 
@@ -1963,6 +1974,8 @@ void __init mptcp_subflow_init(void)
 
 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
+	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
 
-- 
2.38.1

