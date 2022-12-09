Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861B652
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670546679; x=1702082679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQBp37x+YF6P+lJ16BGpex90f7Ktlcv6uncn05y46Wo=;
  b=PFgzqfqKwnF3tIwU3/kKHjppk8XiuEsMyO8l9as/zxkt62WpFpbqpudU
   tTHiGFaPdqIpRXcgqBITfcU+tBsXKrxh493tWKxJ8GnNJQ7A9xckalgbV
   CD5Rs/GEVIQwDhF9id9Dr1HqDw7LcDt6PnhuMQIGbthglqpvm3197gwJB
   +eqEXVpRoGJN8sn1fpOg5c3c0ZVv9eZdStIYfoeu9+P+anI+Jjt1zFVC6
   We+0qZ/Vmn+InCHVQm4yb1zGMMYXpvPCxBNIuIsfIPlsXG6MOP85jWI1u
   V5PJZ2xSMsnRjTSfoa4TDLOM6/mh1ZOi7mRKSownRpVUDEVY7epG5hlcl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="317367592"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="317367592"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="736027008"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="736027008"
Received: from mchombea-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.102.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	mptcp@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/2] mptcp: return 0 instead of 'err' var
Date: Thu,  8 Dec 2022 16:44:31 -0800
Message-Id: <20221209004431.143701-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209004431.143701-1-mathew.j.martineau@linux.intel.com>
References: <20221209004431.143701-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

When 'err' is 0, it looks clearer to return '0' instead of the variable
called 'err'.

The behaviour is then not modified, just a clearer code.

By doing this, we can also avoid false positive smatch warnings like
this one:

  net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn: missing error code? 'err'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/sockopt.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 08c65f3e70a3..2ea7eae43bdb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1190,7 +1190,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
 		if (!require_family)
-			return err;
+			return 0;
 
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "missing family");
@@ -1224,7 +1224,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
 
-	return err;
+	return 0;
 }
 
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a47423ebb33a..d4b1e6ec1b36 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -740,7 +740,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	}
 	release_sock(sk);
 
-	return err;
+	return 0;
 }
 
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
-- 
2.38.1

