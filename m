Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102D4C89
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656366284; x=1687902284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BTBwV5VC3lAG5yT/2etvsEqtuuliwejn5Uws6ShVNO8=;
  b=HG4+g6g514qFhydJxrohiV+bP98mSCkCvmrUP/KcUh7bBYCPOd95sCXL
   LjWIbAvGuNu4Skx3Hrsx758YTVMCA0+2mMr9r5z6rl8R2lL/q84u7uOT6
   4TyoU4JQJy1MDDZYB8QFMpTpqZEMjrkjD9QHUindiRCI7VjkDyAIhDzEg
   6IuFXQEdVN5qXKuWXhtvc8mcVCPdUb0QKh8EhTJiSw9Kq4HQd6yFiirx+
   hl25/t4wCPccRzPloRcvs3v1BgknkU7/2f/4uuxQTR2Q6yVWVnojCvq2L
   Z3C+yUb100y+mpv/r52TZzwkOhdT+Urv8lwnT/9jj05dFkUnR5CeAIJhv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282660830"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282660830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:44:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="916901348"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:44:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com
Subject: [PATCH mptcp-next] Squash-to: "selftests: mptcp: tweak simult_flows for debug kernels"
Date: Mon, 27 Jun 2022 14:44:38 -0700
Message-Id: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
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

Adjust the debug detection to loosen the simult_flows timing constraints
if either kmemleak or lockdep are configured.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e266b26a4274..fa4f0bf55049 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -110,9 +110,10 @@ setup()
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
 	# maximum B/W usage.
-	# Use the kmemleak file presence as a rough estimate for this being
-	# a debug kernel and increase the maximum run-time accordingly
-	[ -f /sys/kernel/debug/kmemleak ] && slack=$((slack+200))
+	# Use the kmemleak or lockdep file presence as a rough estimate
+	# for this being a debug kernel and increase the maximum
+	# run-time accordingly
+	[ -f /sys/kernel/debug/kmemleak -o -f /proc/lockdep ] && slack=$((slack+200))
 }
 
 # $1: ns, $2: port
-- 
2.36.1

