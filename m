Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4622CA8
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 23:29:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227493935"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="227493935"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:21 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="597124827"
Received: from jdweinst-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.54.246])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/4] tcp: define macros for a couple reclaim thresholds
Date: Tue, 26 Oct 2021 16:29:13 -0700
Message-Id: <20211026232916.179450-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211026232916.179450-1-mathew.j.martineau@linux.intel.com>
References: <20211026232916.179450-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

A following patch is going to implement a similar reclaim schema
for the MPTCP protocol, with different locking.

Let's define a couple of macros for the used thresholds, so
that the latter code will be more easily maintainable.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/sock.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ff4e62aa62e5..df0e0efb1882 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1573,6 +1573,11 @@ static inline void sk_mem_charge(struct sock *sk, int size)
 	sk->sk_forward_alloc -= size;
 }
 
+/* the following macros control memory reclaiming in sk_mem_uncharge()
+ */
+#define SK_RECLAIM_THRESHOLD	(1 << 21)
+#define SK_RECLAIM_CHUNK	(1 << 20)
+
 static inline void sk_mem_uncharge(struct sock *sk, int size)
 {
 	int reclaimable;
@@ -1589,8 +1594,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	 * If we reach 2 MBytes, reclaim 1 MBytes right now, there is
 	 * no need to hold that much forward allocation anyway.
 	 */
-	if (unlikely(reclaimable >= 1 << 21))
-		__sk_mem_reclaim(sk, 1 << 20);
+	if (unlikely(reclaimable >= SK_RECLAIM_THRESHOLD))
+		__sk_mem_reclaim(sk, SK_RECLAIM_CHUNK);
 }
 
 static inline void sk_wmem_free_skb(struct sock *sk, struct sk_buff *skb)
-- 
2.33.1

