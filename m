Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712804359
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153411; x=1676689411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1szUR6pqUI2yP1NLV6igd+jmVjkx9CEqyJEDcke89k=;
  b=fXD2a8jZjaKL8dl8fjEfTTTRfLDrWCFscBiIvDl59Y5pWoaFQniY8EiU
   askjTu6ABpEypXJkZHRAHQd5GvvRF3zlv+qQptAz2MumAsBB6CyI5OZWR
   p9oQx8ZrW7kMMfH1L90Th41yyOnz53RHMh4fd5KkJ1nU1ltjEOR3o4rWc
   vsGxx3niBsb1l4LHg2jKGafl52SX916KsjOvm2MPOw3p74OhcbDi/Lqun
   o+Ccs02mOXWfKxaDG6PBDtINSs+DbLsipDfJpaPY+T06/wTWF7E2VGSFS
   HHQpjl9mYcWfR8ukxZGpaogRNPZDTKkgbzt3r+mERfYuI+lFJYDeXmAl7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021642"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431917"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:18 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/7] selftests: mptcp: join: remove unused vars
Date: Thu, 17 Feb 2022 19:03:08 -0800
Message-Id: <20220218030311.367536-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Shellcheck found that these variables were set but never used.

Note that rndh is no longer prefixed with '0-' but it doesn't change
anything.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1a881a21e7ef..c6379093f38a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -42,7 +42,7 @@ init()
 {
 	capout=$(mktemp)
 
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+	rndh=$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
@@ -665,8 +665,6 @@ run_tests()
 	addr_nr_ns2="${6:-0}"
 	speed="${7:-fast}"
 	sflags="${8:-""}"
-	lret=0
-	oldin=""
 
 	# create the input file for the failure test when
 	# the first failure test run
@@ -694,7 +692,6 @@ run_tests()
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
 		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
-	lret=$?
 }
 
 dump_stats()
-- 
2.35.1

