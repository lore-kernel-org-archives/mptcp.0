Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B52C83
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 23:06:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="291483045"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="291483045"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="528398899"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.195.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:22 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/3] mptcp: Avoid NULL dereference in mptcp_getsockopt_subflow_addrs()
Date: Fri, 15 Oct 2021 16:05:50 -0700
Message-Id: <20211015230552.24119-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211015230552.24119-1-mathew.j.martineau@linux.intel.com>
References: <20211015230552.24119-1-mathew.j.martineau@linux.intel.com>
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
2.33.1

