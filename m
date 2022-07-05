Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9466028
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657056743; x=1688592743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zdPUfS8BpWFcbtpib3NKokn6LkmEHx7NP2q0cxq90Bk=;
  b=AvqVKdIpqyZoWCcFbH0MK18Mcy/s9mY92Q80MaBY/jlcwYl6+8Dw/zOa
   m9Fw5QDF8/rl+jRNLwniZLzSMJ/ueOaJrFjkvKQGIoHdB+LVWrbiIwdBF
   j1RabIVwVVICxwfokkCOP5HBimqcg8z96elBdeIqdgGSU5UHtibnT7YQH
   FwcZrs/Y5FD4YRKGVqFJrX5OwGlBnIMrpdBcIjTaQNLEC2vSMyR7Pgfr0
   p2K0u4sypzQpxhb4pQpGGMvheEIL7lA4RD+dMDYwje18+Ev3ApzzTy7Cp
   I3CecRRjZwn0MUlTzmetZk+QcUtVm/MmG2tIGjRVnEYlo3Jo52DvcNl2f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284250763"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284250763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="590558754"
Received: from rcenter-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.17.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 7/7] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
Date: Tue,  5 Jul 2022 14:32:17 -0700
Message-Id: <20220705213217.146898-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
destroy subflow function mptcp_nl_cmd_sf_destroy() when removing subflow.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 51e2f066d54f..9e82250cbb70 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -5,6 +5,7 @@
  */
 
 #include "protocol.h"
+#include "mib.h"
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
@@ -410,6 +411,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.37.0

