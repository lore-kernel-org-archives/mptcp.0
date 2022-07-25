Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5E4A38
	for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658782359; x=1690318359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tx6gJ865FBlGF8GXhCZ8lBxX17nODAgYp59Qf1QLR34=;
  b=c7Y7uJm5AWvuM2pbaO1rXUBvvGlu597gw/9tYypzn6lKRQftjiY1X/zo
   rd2ogkASFKB1W/6msab7A6WkGO446sbZkIOCLBdhpzycwf3YDXaRJ3UEM
   pXjnXSxanP31TYga41JnSodOWUw52UmWeJ0HRPVa3XcXp3qW+yYOgTaea
   pUmVYRF5woQnwjXt5Vf+uJlcqN97XSDuiVhvO1FpSf5WMniciCuttcceV
   wIX8dDJD420qraGYEgU0pjeoB8bp6l0C8BeXbtbfgdkh6oGNQu47nqShA
   nG8+wwto2TCE7fCNWjE0patb0/mVPQ4RsCDRpKU7IwhCAZreLAzOOhh5I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274659143"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274659143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:52:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="599741712"
Received: from dbpatel1-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.117.180])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:52:38 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	mptcp@lists.linux.dev
Subject: [PATCH net] mptcp: Do not return EINPROGRESS when subflow creation succeeds
Date: Mon, 25 Jul 2022 13:52:31 -0700
Message-Id: <20220725205231.87529-1-mathew.j.martineau@linux.intel.com>
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
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Note: The original author of ec3edaa7ca6c is no longer reachable at that
email address.

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

base-commit: 9af0620de1e118666881376f6497d1785758b04c
-- 
2.37.1

