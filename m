Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67572FAE
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 21:12:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="246639637"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="246639637"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="704320285"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.52.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:45 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/5] mptcp: use lockdep_assert_held_once() instead of open-coding it
Date: Fri, 24 Sep 2021 14:12:36 -0700
Message-Id: <20210924211238.162509-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
References: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

We have a few more places where the mptcp code duplicates
lockdep_assert_held_once(). Let's use the existing macro and
avoid a bunch of compiler's conditional.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d1757b8ef69..87ee409d68ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -956,9 +956,7 @@ static void __mptcp_update_wmem(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
+	lockdep_assert_held_once(&sk->sk_lock.slock);
 
 	if (!msk->wmem_reserved)
 		return;
@@ -1117,9 +1115,8 @@ static void __mptcp_clean_una(struct sock *sk)
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
+	lockdep_assert_held_once(&sk->sk_lock.slock);
+
 	__mptcp_clean_una(sk);
 	mptcp_write_space(sk);
 }
-- 
2.33.0

