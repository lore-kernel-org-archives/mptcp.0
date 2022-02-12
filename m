Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3820E8
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644627893; x=1676163893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GAmZYaR0P1bqh3KwvQo/X6/Itxs4eteqmJdYgJ1ryzU=;
  b=mQR/0MsG4WmE3y6feKrBiHRMCpwil3Lgi+4Hm6ukSGvcGSF8g7M4EiFq
   YTUPjiRlf7n6+Po4qbTKwjb3ZHbU8zqXgbWCEtboGkoNLR3Zz/0Opzpyx
   6U+lsJQ+TMLLk7Gk44gumbqWimHWnbMX0XmVnvUnyPGtA1r2n4Vag/J+4
   y5thZXQqwIHAiwOB+GHZf7NBwV9ZJ48up3XbIl9w73J/lAdghZoRI5L3W
   mAmfBSxnFJT88wQnjVGIfYZuaCb/NalxmNu3PN4QJv7YjRW19wh2D4MW1
   132OmTiHQTC0pq6onVk1edTugFtElqax/nKeGsNFSVLq/tRqKqibj5BID
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="274401050"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="274401050"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:04:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483773263"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.245.164])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:04:52 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net] mptcp: Correctly set DATA_FIN timeout when number of retransmits is large
Date: Fri, 11 Feb 2022 17:04:47 -0800
Message-Id: <20220212010447.119486-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3324e1c61576..a4171236091a 100644
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

base-commit: d53f81f7e645a73fae92f7d44076cdd6b7f8501c
-- 
2.35.1

