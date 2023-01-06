Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC67E8
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673031457; x=1704567457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjuX8+She6FpFAaHIkqGpmDStsiekoH+YWi0nMZARFk=;
  b=Cr7Jxkso8DDQrsepGRQObeouJJByLOjZbU08294viROi9Ke303UyxU/z
   rRyddM67xl/gBj/oHdO4ZhiBZClMqS6VQtQlrioAN9c59gVzXYKqjIGkP
   5Lmq/gatsmGbp3W0LNzqViHjyyNNVO3wwvVPtmAlPhagotN0E0gbYPbYq
   ghnbs4pikpHQAVd5fQaPtoQ9VQSb1/ejCTNydlidM3RLn9sBjw8Jb6SpK
   ZHusKEnnls3jBnIBp1TKkGw/TTvMcjfJK+Noer+4inLB+n7hGqeVfqej1
   mZ3BzN/FFhfs6pGyxQQnPvevvq3j3/q8i2yveFzD+APOGk1ttT009Qn0b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322611216"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="322611216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="688383429"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="688383429"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:33 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/9] mptcp: use local variable ssk in write_options
Date: Fri,  6 Jan 2023 10:57:19 -0800
Message-Id: <20230106185725.299977-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
References: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The local variable 'ssk' has been defined at the beginning of the function
mptcp_write_options(), use it instead of getting 'ssk' again.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5ded85e2c374..b30cea2fbf3f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1594,8 +1594,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				      TCPOLEN_MPTCP_PRIO,
 				      opts->backup, TCPOPT_NOP);
 
-		MPTCP_INC_STATS(sock_net((const struct sock *)tp),
-				MPTCP_MIB_MPPRIOTX);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPPRIOTX);
 	}
 
 mp_capable_done:
-- 
2.39.0

