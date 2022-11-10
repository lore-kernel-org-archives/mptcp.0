Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFE1EA0C
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668122612; x=1699658612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvk3tuG4Q6CxP2j8xPqItoatn5Nmz7kyPpuaoZ8mcA8=;
  b=MP1fPmQjaeUiFTK3x7MCYCGHbsuDBQxCTU+G5tvTH3NdhEOCnqgnU905
   wgi0ied6Nz4dNbiQjS2vdEY90WHmjSA9MDenG1GnmRqGm6mGW+MtKN/Vc
   STHTbzZfbeFQvm2phejbWty6MiMn4mzPUqZgmEAMyNsjTTKqPhqGPUhJc
   N3fPw2ymJv5jJmFClnA7KJHauPiY4XX9Cl0hNgq8WSyLcMh3saILRykOy
   BeDPaa5LihrYvV3D8gdq3PX7vMCXa1NC2DDyXywdu29J92aA2lImZKi6q
   ZRSvot7yyCUcM/EQ1dSpz1AftWv0y4TtyvWS5js9ybzekPkrOjFMbCUkG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373594078"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373594078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637367376"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="637367376"
Received: from jsandova-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.81.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 5/5] mptcp: Fix grammar in a comment
Date: Thu, 10 Nov 2022 15:23:22 -0800
Message-Id: <20221110232322.125068-6-mathew.j.martineau@linux.intel.com>
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

We kept getting initial patches from new contributors to remove a
duplicate 'the' (since grammar checking scripts flag it), but submitters
never followed up after code review.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
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

