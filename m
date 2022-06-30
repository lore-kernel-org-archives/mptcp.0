Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A387488
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 22:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656627484; x=1688163484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tF/Wq5emO17ur6n4i4kolET5/WZvdXynovD9SwfsTxM=;
  b=JvgDMj9E/icT2AUxD2HSeEqKrwWSG8pjX2123WZ8L7QVQRwrLQwcvRzg
   8ZDLKZ0TUuqxLVCypyJB3LzJCIypZuXXZ35oSxqQxOidooqmd8OFBb3Wn
   Lqwol0nlBBfXuC1E/gO96T4MvP2pdnlzmjEuTj8PRMn4XGCb/OHzB1VtQ
   wjUSL6i6PHkbDptMv05LVqDkfHL9sfihxetGzcJ/HWejc5HGeiDeb945y
   pqjdkm8tCpS5hRYz0lQSg7HEopBxX8qqW+5yASjoJZ01Rnf2TrLf0r1lE
   /ghQaZk77vYarFI+pp4nfmrqAJK4HJ9rjb0y5QI9cfeRHmtYJTz3xGlAf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368797906"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="368797906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="733804541"
Received: from mhtran-desk5.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.176.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:18:02 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/4] mptcp: refine memory scheduling
Date: Thu, 30 Jun 2022 15:17:56 -0700
Message-Id: <20220630221757.763751-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630221757.763751-1-mathew.j.martineau@linux.intel.com>
References: <20220630221757.763751-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Similar to commit 7c80b038d23e ("net: fix sk_wmem_schedule() and
sk_rmem_schedule() errors"), let the MPTCP receive path schedule
exactly the required amount of memory.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89a0124023f..91628dbe5a2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -323,9 +323,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int amt, amount;
 
-	if (size < msk->rmem_fwd_alloc)
+	if (size <= msk->rmem_fwd_alloc)
 		return true;
 
+	size -= msk->rmem_fwd_alloc;
 	amt = sk_mem_pages(size);
 	amount = amt << PAGE_SHIFT;
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-- 
2.37.0

