Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC17C
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 11:35:38 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nZA8O-0004uM-RL; Tue, 29 Mar 2022 13:35:36 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 2/4] mptcp: remove locking in mptcp_diag_fill_info
Date: Tue, 29 Mar 2022 13:35:21 +0200
Message-Id: <20220329113523.19793-3-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329113523.19793-1-fw@strlen.de>
References: <20220329113523.19793-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem is that listener iteration would call this from atomic context
so this locking is not allowed.

One way is to drop locks before calling the helper, but afaics the lock
isn't really needed, all values are fetched via READ_ONCE().

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 no change.
 net/mptcp/sockopt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f949d22f52bd..826b0c1dae98 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -853,15 +853,11 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
-	struct sock *sk = &msk->sk.icsk_inet.sk;
 	u32 flags = 0;
-	bool slow;
 	u8 val;
 
 	memset(info, 0, sizeof(*info));
 
-	slow = lock_sock_fast(sk);
-
 	info->mptcpi_subflows = READ_ONCE(msk->pm.subflows);
 	info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
@@ -882,8 +878,6 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
 	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
-
-	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
-- 
2.35.1

