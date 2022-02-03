Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78342F3F
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643850232; x=1675386232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7X+m5cdLWaZh4tYFJBJ/dkJI7qFZSYhYD4KmzoHQe1g=;
  b=lLFeVcdTLzJJYtDBbdK+2bV8F9xdE1ze1baVxYsC4JljRDFcuYbib+UN
   BwKNLFOit5qjB5AcuwuMbJjWAWHiHRWzjqfjT90CJNwuatvwoSYRWf2sB
   fK0pf9/qPTOwY80MNVA6vI0cGuWOZzbYkM/Kp8WylxqtSFlo7BAn+3Nyw
   UgBvYqp+q8hBzoLg0iugPJz3Xs+VgMD6W+yyeR2lv7zBHUUo/+0wjcCzz
   5n3HLMglEMBHaptF12puK4nlWtwFM3va9T3+DB0I5sgmaOAHUgBn0jpWd
   11rYSbIs8l1T8QbtYwyVhgEMX0/Xjej/5+CKMJFm7UCRO/nBZ7vG7A9n/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228023385"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228023385"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483070831"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.1.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:48 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/7] mptcp: print out reset infos of MP_RST
Date: Wed,  2 Feb 2022 17:03:40 -0800
Message-Id: <20220203010343.113421-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
References: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7345f28f3de1..3e82ac24d548 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		flags = *ptr++;
 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason = *ptr;
+		pr_debug("MP_RST: transient=%u reason=%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
 
 	case MPTCPOPT_MP_FAIL:
-- 
2.35.1

