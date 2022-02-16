Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A351FA1
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977511; x=1676513511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kYzMznrxDGLwKZFu0MSKfsyMG7hTzjLWAU+77WHCCUk=;
  b=lr+b7xDxaopcQUv6t058+xPqEBg+xMEcqfYRMEs0yi8OfcMfiVe4a5ZO
   wV20Q3iIgUZ5inCCLlw9bqcjISrNThm0E6d/HkOwJxBgUB3IIq+yTU5UD
   4Ck/GUTRrS8dqkZvv0/SojcJBNKAMpl9MRtNDtHiwaYXs8/SiGfma9Sou
   qVNUW8RucoH1PJBqXurl71+zKTuBll6lIhGg7sM0MvQHsayZCEY0Wapis
   9ZrREsts7f4i5O12XDI6QlfpH9rtivBqAy8uTlcK8Cn6G5uu4afO5rBUU
   qVdxiLE6Ko+gGVkRP0zB0WdOGm19piVd/9ZZfx7hJyeCQqO0W4yilRLmj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778515"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778515"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088821"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/8] mptcp: drop unneeded type casts for hmac
Date: Tue, 15 Feb 2022 18:11:26 -0800
Message-Id: <20220216021130.171786-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Drop the unneeded type casts to 'unsigned long long' for printing out the
hmac values in add_addr_hmac_valid() and subflow_thmac_valid().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 3 +--
 net/mptcp/subflow.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a10536d7c84b..5a14420b77c8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1085,8 +1085,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 				      &mp_opt->addr);
 
 	pr_debug("msk=%p, ahmac=%llu, mp_opt->ahmac=%llu\n",
-		 msk, (unsigned long long)hmac,
-		 (unsigned long long)mp_opt->ahmac);
+		 msk, hmac, mp_opt->ahmac);
 
 	return hmac == mp_opt->ahmac;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0d6a4109add1..8cf85684c88f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -344,9 +344,7 @@ static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 
 	thmac = get_unaligned_be64(hmac);
 	pr_debug("subflow=%p, token=%u, thmac=%llu, subflow->thmac=%llu\n",
-		 subflow, subflow->token,
-		 (unsigned long long)thmac,
-		 (unsigned long long)subflow->thmac);
+		 subflow, subflow->token, thmac, subflow->thmac);
 
 	return thmac == subflow->thmac;
 }
-- 
2.35.1

