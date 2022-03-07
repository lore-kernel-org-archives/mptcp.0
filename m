Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD854349
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685887; x=1678221887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4tIQUAOTRz1Si2gcqBM3+CXn/RCAkFxYB6IZ5aqlfw=;
  b=Gm3grsgEAKlUoRKCSh0lp6ubrmlqkwL6HoqFssxdEh6GEOeIgY2xbFOJ
   F6B7T98MuspqJX9FyoRDR05fk57P2WJ9gjv3uexhhItA6vN++h1VhadjL
   qklL/2BArWf48vvRc0nXa9HadxB4slM7Dr2yVhNukC8fd3wP5rX/2ZT0/
   Z14jffv3Km87iqAHbxinBkx4Ba/N6nU6FjNCe4B/LMru9jirb7UFsmpE3
   A3F6ZDMLSMvKKUUlkwzsfACyou7fy9hUzs/LfrvrU6w9w1kkEDJ1od0Yt
   1p1ufCGdnhQI/U2qGnfwkVZxeUT2bRL8pFHGpxGFjRSIAJEmB/ncvnZdI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731785"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320484"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/9] selftests: mptcp: join: allow running -cCi
Date: Mon,  7 Mar 2022 12:44:33 -0800
Message-Id: <20220307204439.65164-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
References: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Without this patch, no tests would be ran when launching:

  mptcp_join.sh -cCi

In any order or a combination with 2 of these letters.

The recommended way with getopt is first parse all options and then act.

This allows to do some actions in priority, e.g. display the help menu
and stop.

But also some global variables changing the behaviour of this selftests
 -- like the ones behind -cCi options -- can be set before running the
different tests. By doing that, we can also avoid long and unreadable
regex.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 67 ++++++++-----------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 45c6e5f06916..309d06781ae7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,7 +16,6 @@ capture=0
 checksum=0
 ip_mptcp=0
 check_invert=0
-do_all_tests=1
 init=0
 
 TEST_COUNT=0
@@ -2293,84 +2292,66 @@ usage()
 	exit ${ret}
 }
 
-for arg in "$@"; do
-	# check for "capture/checksum" args before launching tests
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
-		capture=1
-	fi
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
-		checksum=1
-	fi
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
-		ip_mptcp=1
-	fi
-
-	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
-		do_all_tests=0
-	fi
-done
-
-if [ $do_all_tests -eq 1 ]; then
-	all_tests
-	exit $ret
-fi
 
+tests=()
 while getopts 'fesltra64bpkdmchzCSi' opt; do
 	case $opt in
 		f)
-			subflows_tests
+			tests+=(subflows_tests)
 			;;
 		e)
-			subflows_error_tests
+			tests+=(subflows_error_tests)
 			;;
 		s)
-			signal_address_tests
+			tests+=(signal_address_tests)
 			;;
 		l)
-			link_failure_tests
+			tests+=(link_failure_tests)
 			;;
 		t)
-			add_addr_timeout_tests
+			tests+=(add_addr_timeout_tests)
 			;;
 		r)
-			remove_tests
+			tests+=(remove_tests)
 			;;
 		a)
-			add_tests
+			tests+=(add_tests)
 			;;
 		6)
-			ipv6_tests
+			tests+=(ipv6_tests)
 			;;
 		4)
-			v4mapped_tests
+			tests+=(v4mapped_tests)
 			;;
 		b)
-			backup_tests
+			tests+=(backup_tests)
 			;;
 		p)
-			add_addr_ports_tests
+			tests+=(add_addr_ports_tests)
 			;;
 		k)
-			syncookies_tests
+			tests+=(syncookies_tests)
 			;;
 		S)
-			checksum_tests
+			tests+=(checksum_tests)
 			;;
 		d)
-			deny_join_id0_tests
+			tests+=(deny_join_id0_tests)
 			;;
 		m)
-			fullmesh_tests
+			tests+=(fullmesh_tests)
 			;;
 		z)
-			fastclose_tests
+			tests+=(fastclose_tests)
 			;;
 		c)
+			capture=1
 			;;
 		C)
+			checksum=1
 			;;
 		i)
+			ip_mptcp=1
 			;;
 		h)
 			usage
@@ -2381,4 +2362,12 @@ while getopts 'fesltra64bpkdmchzCSi' opt; do
 	esac
 done
 
+if [ ${#tests[@]} -eq 0 ]; then
+	all_tests
+else
+	for subtests in "${tests[@]}"; do
+		"${subtests}"
+	done
+fi
+
 exit $ret
-- 
2.35.1

