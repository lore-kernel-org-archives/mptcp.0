Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FF5119
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853410; x=1678389410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HffHS+tgBcL14P63jBK+oadn/ULE2EtUEq4i5AhLI38=;
  b=V4aEO5UQ3nkamABJz8rgmSzoozMp0SmJrko42cyGzNwIcQ39UJua8wdC
   tKZYg2cYc+LdJ5KrIN1WKwC0ISFeMaunjZVRbrwFO2kCIF+EChoEsSKWC
   6DnPR1FOb1/k97yrX+G0qGLgpxYyjAdg4x+oto+acjHx8tFfSe5LWjjSC
   HrkYDyPdtFerwwI8HOaI3IXGkSztH8qwLv8dyzyyoUUKvVfv1shnM2ZHO
   9t7i0lxOZ053VwCQBIvzqqKlETjP15TehSZqdW0kUz62XqUdZZWxCoAYv
   Ea9u9sf/0BqhGbK8QwQvIZG0CThFNCuxcj1/G4qkEInm9k6/er/TO1Cck
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011977"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957056"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 03/10] selftests: mptcp: join: reset failing links
Date: Wed,  9 Mar 2022 11:16:29 -0800
Message-Id: <20220309191636.258232-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
References: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Best to always reset this env var before each test to avoid surprising
behaviour depending on the order tests are running.

Also clearly set it for the last failing links test is also needed when
only this test is executed.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8dc50b480152..65590f965e4d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,8 @@ declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
+export FAILING_LINKS=""
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -63,6 +65,7 @@ init_partial()
 
 	check_invert=0
 	validate_checksum=$checksum
+	FAILING_LINKS=""
 
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -1618,7 +1621,7 @@ link_failure_tests()
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	export FAILING_LINKS="1"
+	FAILING_LINKS="1"
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
@@ -1633,7 +1636,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-	export FAILING_LINKS="1 2"
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
 	chk_add_nr 1 1
@@ -1648,6 +1651,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
-- 
2.35.1

