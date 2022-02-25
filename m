Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1810EF
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750389; x=1677286389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqTt+niSLwVwwDItw0GZA8ZDW7BieBIv0e/LtMJlhfQ=;
  b=af/Tg2yiqnR0OdsELbXTlp5zNmyTsw6JBCirjZRh4WlpucC9gRsVTsss
   Acd0TnOjNO5nXkg+vVbuPc8+fffFAsDwYUwzV3Rk14tjnJJxYc8rFDM3i
   x/9YrOtYCoU7ggVMJd5LopMpKGxcWhItspogpFdUJ+E2uUyqzaMd51yZr
   AbWRyKj2c8X1rrwjxca1Egud7YSA2ae4BAB3X2GUhRNTbjH6c9dNoki6q
   96YBH5L/KRxAw/EBQPgmIkdmdILSTUm5/hjm0dF9h33SiJHEQNkWexD9R
   O7yjwxF8t4qMCraXeEOU1g8Hzh5ArGlovKL7Amd/FJVVsXW0waGz/OmMH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252117843"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252117843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="638050202"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:05 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 3/3] mptcp: Correctly set DATA_FIN timeout when number of retransmits is large
Date: Thu, 24 Feb 2022 16:52:59 -0800
Message-Id: <20220225005259.318898-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
References: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller with UBSAN uncovered a scenario where a large number of
DATA_FIN retransmits caused a shift-out-of-bounds in the DATA_FIN
timeout calculation:

================================================================================
UBSAN: shift-out-of-bounds in net/mptcp/protocol.c:470:29
shift exponent 32 is too large for 32-bit type 'unsigned int'
CPU: 1 PID: 13059 Comm: kworker/1:0 Not tainted 5.17.0-rc2-00630-g5fbf21c90c60 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events mptcp_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb2/0x20e lib/ubsan.c:330
 mptcp_set_datafin_timeout net/mptcp/protocol.c:470 [inline]
 __mptcp_retrans.cold+0x72/0x77 net/mptcp/protocol.c:2445
 mptcp_worker+0x58a/0xa70 net/mptcp/protocol.c:2528
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2307
 worker_thread+0x95/0xe10 kernel/workqueue.c:2454
 kthread+0x2f4/0x3b0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
================================================================================

This change limits the maximum timeout by limiting the size of the
shift, which keeps all intermediate values in-bounds.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/259
Fixes: 6477dd39e62c ("mptcp: Retransmit DATA_FIN")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 12bb28c5007e..1c72f25f083e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -466,9 +466,12 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 static void mptcp_set_datafin_timeout(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 retransmits;
 
-	mptcp_sk(sk)->timer_ival = min(TCP_RTO_MAX,
-				       TCP_RTO_MIN << icsk->icsk_retransmits);
+	retransmits = min_t(u32, icsk->icsk_retransmits,
+			    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
+
+	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
 static void __mptcp_set_timeout(struct sock *sk, long tout)
-- 
2.35.1

