Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7A1EA09
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668122612; x=1699658612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkHFHct5jmMR29HfWsBOmJdLyB9m7Wj7O5Y3w3dZj3Y=;
  b=Z1UGHSzEAQd1oI0SJOsY0UpSEF6Q+bx1XM0Bu3IYE4PldQUw8i9m7Tr5
   m/XhERsjtohaAHfKqNPri0X4oP9ANSYfrfMew5oe0f8liyerVx6E0B3dx
   Ov+bpRVvqehYQFMFXJOsbeXc17Zcm3nccx9ycLU1d4fLwCmv6DMuyt7h0
   LhJFrOe7EItXf/8zmHDYLmAAsluZK0fDkcIdXCf/DgM48+vl3Lm8aETMz
   T2mgROhvL0Pb/AFm2tNYdTJ0EZLMdJllSC3VcctLO32FhEXeM97Jh+W+N
   yvhJnQ8AT/8hfeU+j/79jc3snd3kenHTj6k+dSs3rrN/fc59cQWAT59ac
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373594074"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373594074"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637367373"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="637367373"
Received: from jsandova-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.81.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/5] mptcp: get sk from msk directly
Date: Thu, 10 Nov 2022 15:23:20 -0800
Message-Id: <20221110232322.125068-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110232322.125068-1-mathew.j.martineau@linux.intel.com>
References: <20221110232322.125068-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
instead of using '&msk->sk.icsk_inet.sk'.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.c     | 4 ++--
 net/mptcp/sockopt.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9e82250cbb70..5cb65f0928f4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -291,7 +291,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -403,7 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5a344788f843..3796d1bfef6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2454,7 +2454,7 @@ static bool mptcp_check_close_timeout(const struct sock *sk)
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 
 	if (likely(!READ_ONCE(msk->rcv_fastclose)))
 		return;
@@ -2616,7 +2616,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 	unsigned long fail_tout;
 	int state;
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f85e9bbfe86f..f62f6483ef77 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -987,7 +987,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 				    int __user *optlen)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct sock *sk = (struct sock *)msk;
 	unsigned int sfcount = 0, copied = 0;
 	struct mptcp_subflow_data sfd;
 	char __user *infoptr;
@@ -1078,8 +1078,8 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
 static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *optval,
 					  int __user *optlen)
 {
-	struct sock *sk = &msk->sk.icsk_inet.sk;
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 	unsigned int sfcount = 0, copied = 0;
 	struct mptcp_subflow_data sfd;
 	char __user *addrptr;
-- 
2.38.1

