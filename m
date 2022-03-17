Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F94A9F
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647555011; x=1679091011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QpWbczOzLS4au3qRyyNQY/DJiO8OZbjCj8/kWLrheTM=;
  b=S5Wju0Gfln2zWw43LDG2Odo5NKpk1BVqi2VgxXDI8lmIEHSSAeyVlRpw
   Q47UM0i7xjUCzTposY92IydIaDRLVJ3LwG2FFbZDijRhdhwYGWVoRzcEp
   /iDFTCdALRCsUL27Yon9Kx23NlzTU7J0s2iELBez3bBH5dyUFPSYhTumn
   ejy5EXxKCjiGoNjvXexSWcARqaeI+EufyrZMUSljRxms9tTUB77hr6wr7
   8goPWIs5IdsXNwO3N3Fe22AxzVlRJINzhrO9bnxnPfa1b7iK5dKqPSo6o
   g4AGXytDw8i5EX9G7F4XozceHjsGnLIDjyfJiiItbWUTh+nZVzIki9RUy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="320207519"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="320207519"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:10:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="599259580"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.9.212])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:10:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net] mptcp: Fix crash due to tcp_tsorted_anchor was initialized before release skb
Date: Thu, 17 Mar 2022 15:09:53 -0700
Message-Id: <20220317220953.426024-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

Got crash when doing pressure test of mptcp:

===========================================================================
dst_release: dst:ffffa06ce6e5c058 refcnt:-1
kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle kernel paging request at ffffa06ce6e5c058
PGD 190a01067 P4D 190a01067 PUD 43fffb067 PMD 22e403063 PTE 8000000226e5c063
Oops: 0011 [#1] SMP PTI
CPU: 7 PID: 7823 Comm: kworker/7:0 Kdump: loaded Tainted: G            E
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.2.1 04/01/2014
Call Trace:
 ? skb_release_head_state+0x68/0x100
 ? skb_release_all+0xe/0x30
 ? kfree_skb+0x32/0xa0
 ? mptcp_sendmsg_frag+0x57e/0x750
 ? __mptcp_retrans+0x21b/0x3c0
 ? __switch_to_asm+0x35/0x70
 ? mptcp_worker+0x25e/0x320
 ? process_one_work+0x1a7/0x360
 ? worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 ? kthread+0x112/0x130
 ? kthread_flush_work_fn+0x10/0x10
 ? ret_from_fork+0x35/0x40
===========================================================================

In __mptcp_alloc_tx_skb skb was allocated and skb->tcp_tsorted_anchor will
be initialized, in under memory pressure situation sk_wmem_schedule will
return false and then kfree_skb. In this case skb->_skb_refdst is not null
because_skb_refdst and tcp_tsorted_anchor are stored in the same mem, and
kfree_skb will try to release dst and cause crash.

Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
Cc: stable@vger.kernel.org
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c72f25f083e..014c9d88f947 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1196,6 +1196,7 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
 		tcp_skb_entail(ssk, skb);
 		return skb;
 	}
+	tcp_skb_tsorted_anchor_cleanup(skb);
 	kfree_skb(skb);
 	return NULL;
 }

base-commit: 551acdc3c3d2b6bc97f11e31dcf960bc36343bfc
-- 
2.35.1

