Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F52CA5
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447172; x=1680983172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rog/TReWZB7KzG+B5MlA9/Qw4RMiJg/AX7/ruffGZHM=;
  b=kqkh7fJvQU99FsPuDxG9+n2c1NjWC5hWtEuokQpEFQYVkeMTdLRq3oey
   AISDL4aq+5zpwIuBBh381U9r1rdTNsiwKI/mrCbzgnGjV7HMEXaLFzJUa
   C1Uhxery3hgspQdjfiIkR0jtD0a2+8RHTucLA/ewYysroLHCh7VyohJcM
   szMSkKj05T12eINUj0X6bHK+mLnQ7XVzHj2Rv/LekTGz7bW8Aa+pOoc1R
   +EALVadLJHY/hU8/AiuSoZggOvGhm1QP51UYIHs5Z+pdYg65zlz0qSMuW
   OkHBv2JlwPdioVpJ8U83Y8LDjhvgsDDfNaANDa2OScJ1VDK87cbiCXmfq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365299"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602155"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:08 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/8] mptcp: reset the packet scheduler on PRIO change
Date: Fri,  8 Apr 2022 12:45:56 -0700
Message-Id: <20220408194601.305969-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Similar to the previous patch, for priority changes
requested by the local PM.

Reported-and-suggested-by: Davide Caratti <dcaratti@redhat.com>
Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b5e8de6f7507..e3dcc5501579 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -727,6 +727,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		if (!addresses_equal(&local, addr, addr->port))
 			continue;
 
+		if (subflow->backup != bkup)
+			msk->last_snd = NULL;
 		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
-- 
2.35.1

