Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630C2C82
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 19:35:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="227700867"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="227700867"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:23:58 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="579878786"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.216.171])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:23:58 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-scripts] ci:virtme: Add 'mptcp_join.sh -C' coverage for checksum tests
Date: Wed, 27 Oct 2021 12:23:53 -0700
Message-Id: <20211027192353.253934-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Untested - I copied and modified the mptcp_connect_mmap bits.

 ci/virtme.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/virtme.sh b/ci/virtme.sh
index 94f5801b8dc9..1ddd16db280d 100755
--- a/ci/virtme.sh
+++ b/ci/virtme.sh
@@ -97,6 +97,7 @@ prepare() { local old_pwd mode
         local kunit_tap="${RESULTS_DIR}/kunit.tap"
         local selftests_tap="${RESULTS_DIR}/selftests.tap"
         local mptcp_connect_mmap_tap="${RESULTS_DIR}/mptcp_connect_mmap.tap"
+        local mptcp_join_csum_tap="${RESULTS_DIR}/mptcp_join_csum.tap"
         local dummy_tap="${RESULTS_DIR}/dummy.tap"
         local pktd_base="${RESULTS_DIR}/packetdrill"
 
@@ -217,6 +218,10 @@ run_mptcp_connect_mmap() {
         run_one_selftest_tap "${mptcp_connect_mmap_tap}" ./mptcp_connect.sh -m mmap
 }
 
+run_mptcp_join_csum() {
+        run_one_selftest_tap "${mptcp_join_csum_tap}" ./mptcp_join.sh -C
+}
+
 # \$1: pktd_dir (e.g. mptcp/dss)
 run_packetdrill_one() { local pktd_dir="\${1}" pktd
         pktd="\${pktd_dir:6}"
@@ -243,6 +248,7 @@ run_packetdrill_all() { local pktd_dir
 run_kunit
 run_selftests
 run_mptcp_connect_mmap
+run_mptcp_join_csum
 run_packetdrill_all
 
 # For "manual" tests only
-- 
2.33.1

