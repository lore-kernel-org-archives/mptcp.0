Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F974A04
	for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657908734; x=1689444734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfqvsGJ9MbosJZhWcxgM3E30ct/1oAqdmhbvhfOzG6o=;
  b=bAr9RK2nokHCczXQBxEBuIR3e0m68YpDBcyI6jpLAxL0PwgM5DoQMaVY
   gLQhT7eBjFUpUyURRIS9nY5PeZ3ss+VoUimj1ke+P+HqznXpRC9P9xCi+
   6+SqCv+AXyaxQK0FjszEIyIZMssEUWTuBcxjlOAXYPNedql0+Wm2bp5T1
   znlP0eJFoNEVnmjC0HN5k8b5esjFdnS6EkcfC4V8YCC86Ry44ZV4gjhgM
   /p3zDEWvXTdz+adgT9zFcRWWnJjE3ZczJ4j+ZZuXsoOEBmbqViPPKEKpv
   X/9nKbHYimAyyKPgpFNnwhC59byDEtsTDEbRF8BKKEBNRi8KmLSR1yTO+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372181841"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="372181841"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:12:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="623954453"
Received: from gtong-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.132.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:12:12 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net] mptcp: Do not return EINPROGRESS when subflow creation succeeds
Date: Fri, 15 Jul 2022 11:12:07 -0700
Message-Id: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New subflows are created within the kernel using O_NONBLOCK, so
EINPROGRESS is the expected return value from kernel_connect().
__mptcp_subflow_connect() has the correct logic to consider EINPROGRESS
to be a successful case, but it has also used that error code as its
return value.

Before v5.19 this was benign: all the callers ignored the return
value. Starting in v5.19 there is a MPTCP_PM_CMD_SUBFLOW_CREATE generic
netlink command that does use the return value, so the EINPROGRESS gets
propagated to userspace.

Make __mptcp_subflow_connect() always return 0 on success instead.

Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63e8892ec807..af28f3b60389 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1533,7 +1533,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
-	return err;
+	return 0;
 
 failed_unlink:
 	list_del(&subflow->node);
-- 
2.37.1

