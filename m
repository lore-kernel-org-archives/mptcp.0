Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737182CA1
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 00:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019429; x=1675555429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rfbmUcVWCl5wd94io4ujwqYMesa9mKGmoOG+bRtuJgU=;
  b=hYZaImEV2lhykdri/Bo/MARVviMpEx6FUXJQJC3Rkce2ZTCTMJRDgpRG
   PU+g13VIHlr+R1k5jBRMp0/obO8H7kU+xzK366FXy3InEEI66Q3xSmX3v
   UegnFZYsa3boAvQWuLer87Y/FAVYcmGCXQPB/Dwk9MnLZmwEnJ9b0+3TR
   ZXGFqFAO9VyyK+fikUt1PuRM2OtucAtBB8lpuT5J3qDECexJpukOZG/vf
   G6qQP4IAlpJ6AEdUBgRlEAG294pW9eQ2fLLtDGVT6CjYPw2vu1TQbw73i
   2yuicwiRoIpFOatNqnUjFfH749k0EiN7unRXxBvM0rEWvRLBUbfCyYyKM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248678313"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248678313"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="770097535"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 9/9] selftests: mptcp: set ip_mptcp in command line
Date: Fri,  4 Feb 2022 16:03:37 -0800
Message-Id: <20220205000337.187292-10-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
References: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 757f26674c62..4a565fb84137 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2117,6 +2117,7 @@ usage()
 	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
 
@@ -2138,9 +2139,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=1
 	fi
+	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=1
+	fi
 
-	# exception for the capture/checksum options, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
+	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
 		do_all_tests=0
 	fi
 done
@@ -2150,7 +2154,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fesltra64bpkdmchCS' opt; do
+while getopts 'fesltra64bpkdmchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2201,6 +2205,8 @@ while getopts 'fesltra64bpkdmchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
-- 
2.35.1

