Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6172
	for <mptcp@lists.linux.dev>; Mon, 11 Oct 2021 23:51:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="207114808"
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="207114808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 16:51:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="441616375"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.100.194])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 16:51:32 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Tim Gardner <tim.gardner@canonical.com>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: Avoid NULL dereference in mptcp_getsockopt_subflow_addrs()
Date: Mon, 11 Oct 2021 16:51:27 -0700
Message-Id: <20211011235127.78924-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Gardner <tim.gardner@canonical.com>

Coverity complains of a possible NULL dereference in
mptcp_getsockopt_subflow_addrs():

 861       } else if (sk->sk_family == AF_INET6) {
    	3. returned_null: inet6_sk returns NULL. [show details]
    	4. var_assigned: Assigning: np = NULL return value from inet6_sk.
 862                const struct ipv6_pinfo *np = inet6_sk(sk);

Fix this by checking for NULL.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/231
Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
[mjm: Added WARN_ON_ONCE() to the unexpected case]
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

This is a slight revision to Tim's patch submitted to netdev a few weeks ago:
https://lore.kernel.org/netdev/20210920154232.15494-1-tim.gardner@canonical.com/

I added the WARN_ON_ONCE() as Paolo suggested and added Closes:/Fixes:.

-Mat

---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..0f1e661c2032 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -861,6 +861,9 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
 	} else if (sk->sk_family == AF_INET6) {
 		const struct ipv6_pinfo *np = inet6_sk(sk);
 
+		if (WARN_ON_ONCE(!np))
+			return;
+
 		a->sin6_local.sin6_family = AF_INET6;
 		a->sin6_local.sin6_port = inet->inet_sport;
 
-- 
2.33.0

