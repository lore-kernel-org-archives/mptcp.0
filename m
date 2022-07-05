Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A52F2D
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657065110; x=1688601110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0DS/bgEX/ASK8qONgZPlYBLbKb8JLeh8BGr1BS7s1AM=;
  b=JYNGjVp0e713PVwuoj0nRRh4wqkBx5iommIDP+z8xaBZ1pfCnCJIXtcf
   sE1ufV0qfW/m3V8VP10bmK6cWO4N33hHnTerZAbEml9dZJHAb11CvZcmZ
   N46e7oAozJ6fuB+qXVgb6zSaOycyCE/9NNnzBmnetuAXCIZvUdsq+kfWQ
   YB4mzNknc9ZcRbT/LuydUoFHY0zlLQ0sTbtmL+pxF3mH/wa11eJZeM1Vc
   KR2MO7fPS5sRTh37gtwop9iOPxAfDcujr/swD1MoUjQebUVDre5ixku/K
   RR09Cs4QFTVwJnZ+4a12VYNqPXhRMOoEcIceF1ZwFoOZYOjdP9LPCSPqu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281131797"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="281131797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:51:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="735345345"
Received: from rcenter-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.17.169])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:51:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2] Squash-to: "selftests: mptcp: tweak simult_flows for debug kernels"
Date: Tue,  5 Jul 2022 16:51:44 -0700
Message-Id: <20220705235144.221591-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kbuild is still seeing intermittent failures in the simult_flows.sh
test. It uses a kernel config without kmemleak, but with other
performance-affecting debug options like lockdep and kasan.

Example failures:
kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_with_unbalanced_delay_transfer_slower_than_expected!_runtime_4339_ms_expected_4005_ms_max_4005.fail
kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4285_ms_expected_4005_ms_max_4005.fail
kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4346_ms_expected_4005_ms_max_4005.fail

Adjust the debug detection to look for more kernel debug features and
further loosen the simult_flows timing constraints if any of those
features are detected.

v2: Use kallsyms for debug feature detection, increase the debug timeout.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e266b26a4274..ffa13a957a36 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -110,9 +110,12 @@ setup()
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
 	# maximum B/W usage.
-	# Use the kmemleak file presence as a rough estimate for this being
-	# a debug kernel and increase the maximum run-time accordingly
-	[ -f /sys/kernel/debug/kmemleak ] && slack=$((slack+200))
+	# Use kmemleak/lockdep/kasan/prove_locking presence as a rough
+	# estimate for this being a debug kernel and increase the
+	# maximum run-time accordingly. Observed run times for CI builds
+	# running selftests, including kbuild, were used to determine the
+	# amount of time to add.
+	grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms && slack=$((slack+550))
 }
 
 # $1: ns, $2: port
-- 
2.37.0

