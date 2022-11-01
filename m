Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3B7B
	for <mptcp@lists.linux.dev>; Tue,  1 Nov 2022 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667336144; x=1698872144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Y+4lkdgIT8d7O2oSPzjOgREspHsAdPkiB0DPbtRlHc=;
  b=Y/MLhq1TJPCQtXnaB8afk4Y2EzDBVQf6JiINsVBQBgrU74NAgMMctfc6
   AVDr9Orp78hjdLVrQAhwfEbtdmjq40NrrLu0gOlnuo0M8ox5GAnSub3V1
   +OqfRTyZQXgYAFBVQOK3nEm5AJIWLiPoKNN9PVOSjmOlFSORR/GQIM/0G
   9BiSZSW0YIRfJgrTpqrTVSp7tq1rGLEo6WBWX2oIi5dKUASzt0Xuj89kP
   yocEuJFPKe7f70pRWlSudFlZKzlFRETT40OErir0zHEEaOm1k25INthHw
   QrDsU0No1Pi6bdx1cMNjTCfAemmWOUie5l/7Uj22FR111Cmn9bsk/s6tx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306857035"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="306857035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 13:55:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697542803"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697542803"
Received: from zfrench-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.31.189])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 13:55:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: Fix grammar in a comment
Date: Tue,  1 Nov 2022 13:55:38 -0700
Message-Id: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We kept getting initial patches from new contributors to remove a
duplicate 'the' (since grammar checking scripts flag it), but submitters
never followed up after code review.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f52ee7b26aed..65430f314a68 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -287,8 +287,8 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
  * This function returns the first mptcp connection structure found inside the
  * token container starting from the specified position, or NULL.
  *
- * On successful iteration, the iterator is move to the next position and the
- * the acquires a reference to the returned socket.
+ * On successful iteration, the iterator is moved to the next position and
+ * a reference to the returned socket is acquired.
  */
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num)
-- 
2.38.1

