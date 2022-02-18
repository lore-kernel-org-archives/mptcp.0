Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FB3202
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645222704; x=1676758704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/B9Pj8yDuo/9UxBM/mK6bRm5hNBhdRh6Ev6v3wHfiU=;
  b=RLneeM1RpekDiW3Rp/nnLGUPXyh9E4l46td9qtedAeCoP2NqCPu8MK4C
   GUJjyGG8682/JXZ+4CigF7okVGIeUEfo6zquCJW3JxHqWtk/ZnnZQmycL
   wMWuEwoRBlm3FlrdGl1IO3gqE6v+6dFHAfk5fWQ2FEvhpA50d2jbpgRhG
   cPkqu+JNEcWKn4BYJCHIkdlLHc8I/pY9qcPdm9xB98xCPQNSbOSs5htOU
   O/tePWeQq0rKOtkxLEryoTbz8IiIkUtVNBhrGyEeDbdjAEfrecyaUWGZL
   qrgJFIRBkBZii+r8PD+q83FYO17OiqukW2LB4f25ZcaqLz4nj4iSbVbeM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231857988"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231857988"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="542032037"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 2/3] Squash to "selftests: mptcp: more robust signal race test"
Date: Fri, 18 Feb 2022 14:18:13 -0800
Message-Id: <20220218221814.72026-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes a whitespace change to match what I upstreamed for
-net. The patch will create a net/net-next merge conflict and removing
this extra change from the commit makes the conflict resolution more
obvious.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 788aab602d8f..491934c3c489 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1346,7 +1346,6 @@ signal_address_tests()
 
 	# signal addresses race test
 	reset
-
 	pm_nl_set_limits $ns1 4 4
 	pm_nl_set_limits $ns2 4 4
 	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-- 
2.35.1

