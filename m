Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8565A66
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664553632; x=1696089632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zbjAqgfLY8M6/uhSJ6CwvuwEPeEkk88HC/IYtTMmiWM=;
  b=NJmnqhnzrH4SjsO7rJdIc15cT9oRUM3ioR6X7tOMvzIpb0TZNds+v0H2
   fu+O+O2JbkU7ks6I7+4SxO4jgy+FePoICqKJfU4oHCQ+PwDvLsGXKuuC4
   Z5g8hUD0Hkm8mpV2aKEAWTLUNGCXe1gxdiut6Sn0E5ggyDjFDct+3IEKh
   ssBV4Yp65nSBmlB/4H4Js+o/wjQdMHdZ29gWH1TUFHA+7iA5B6vLLO/S6
   IH6wVbPw7HoOpxv1NI6dqN+4lGNhJNfl3tnHoQ9aYFDo9vbglsch03RHU
   69vK4jb0uubqVOlepGoQ2F4uGWuyylDjAFQukqGqsZMDqsjBu99/C2znI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289383898"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289383898"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="655996111"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655996111"
Received: from cmforest-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.22.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:28 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/4] mptcp: update misleading comments.
Date: Fri, 30 Sep 2022 08:59:34 -0700
Message-Id: <20220930155934.404466-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930155934.404466-1-mathew.j.martineau@linux.intel.com>
References: <20220930155934.404466-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP data path is quite complex and hard to understend even
without some foggy comments referring to modified code and/or
completely misleading from the beginning.

Update a few of them to more accurately describing the current
status.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index acf44075ba40..f599ad44ed24 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -662,9 +662,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		skb = skb_peek(&ssk->sk_receive_queue);
 		if (!skb) {
-			/* if no data is found, a racing workqueue/recvmsg
-			 * already processed the new data, stop here or we
-			 * can enter an infinite loop
+			/* With racing move_skbs_to_msk() and __mptcp_move_skbs(),
+			 * a different CPU can have already processed the pending
+			 * data, stop here or we can enter an infinite loop
 			 */
 			if (!moved)
 				done = true;
@@ -672,9 +672,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 
 		if (__mptcp_check_fallback(msk)) {
-			/* if we are running under the workqueue, TCP could have
-			 * collapsed skbs between dummy map creation and now
-			 * be sure to adjust the size
+			/* Under fallback skbs have no MPTCP extension and TCP could
+			 * collapse them between the dummy map creation and the
+			 * current dequeue. Be sure to adjust the map size.
 			 */
 			map_remaining = skb->len;
 			subflow->map_data_len = skb->len;
@@ -3768,7 +3768,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
-	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
 	if (sk->sk_err)
 		mask |= EPOLLERR;
-- 
2.37.3

