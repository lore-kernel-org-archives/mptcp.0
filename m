Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A105107
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853408; x=1678389408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1t+Jz+5OGZSeGtd0kR9Wcxg+MZK1NVvBjKN3QGmv2w=;
  b=MnadPY3ZgiIm9PO+gh7eHV2otRJ5RG7TiWuHABkKlI5pr5EDIjGGMkUu
   suxbjZP2u4brN6ft5I0XSnZJCMckUjtJ6KKmMXyziKNBXHgDZg4CAwG63
   F1HOKKqt1qR5KOBhp+x6eWqXFSbt6mYG63G2wvh6VXP0qlhrxwq6EEvDJ
   NmBhWv8aPmh07fi0dF/qN5R/I2FEtVxgzZe/XvI9WmOZoY47h0uYZvwm8
   +0AMayvJH7PTii75EyeAfmr/8ueYB3WZxb3jQayl01/RBeovLO9LCjfv2
   X1QpPxJQLXcUWVfAGj+jsLWpPDjdb2DRqcs/aH6YXCJNI+HBzc9Qm6f5Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011974"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957053"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 02/10] selftests: mptcp: join: define tests groups once
Date: Wed,  9 Mar 2022 11:16:28 -0800
Message-Id: <20220309191636.258232-3-mathew.j.martineau@linux.intel.com>
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

When adding a new tests group, it has to be defined in multiple places:

- in the all_tests() function
- in the 'usage()' function
- in the getopts: short option + what to do when the option is used

Because it is easy to forget one of them, it is useful to have to define
them only once.

Note: only using an associative array would simplify the code but the
entries are stored in a hashtable and iterating over the different items
doesn't give the same order as the one used in the declaration of this
array. Because we want to run these tests in the same order as before, a
"simple" array is used first.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 141 ++++++------------
 1 file changed, 47 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 194c4420220e..8dc50b480152 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -19,6 +19,7 @@ check_invert=0
 validate_checksum=0
 init=0
 
+declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
@@ -2380,27 +2381,6 @@ implicit_tests()
 	wait
 }
 
-all_tests()
-{
-	subflows_tests
-	subflows_error_tests
-	signal_address_tests
-	link_failure_tests
-	add_addr_timeout_tests
-	remove_tests
-	add_tests
-	ipv6_tests
-	v4mapped_tests
-	backup_tests
-	add_addr_ports_tests
-	syncookies_tests
-	checksum_tests
-	deny_join_id0_tests
-	fullmesh_tests
-	fastclose_tests
-	implicit_tests
-}
-
 # [$1: error message]
 usage()
 {
@@ -2410,23 +2390,12 @@ usage()
 	fi
 
 	echo "mptcp_join usage:"
-	echo "  -f subflows_tests"
-	echo "  -e subflows_error_tests"
-	echo "  -s signal_address_tests"
-	echo "  -l link_failure_tests"
-	echo "  -t add_addr_timeout_tests"
-	echo "  -r remove_tests"
-	echo "  -a add_tests"
-	echo "  -6 ipv6_tests"
-	echo "  -4 v4mapped_tests"
-	echo "  -b backup_tests"
-	echo "  -p add_addr_ports_tests"
-	echo "  -k syncookies_tests"
-	echo "  -S checksum_tests"
-	echo "  -d deny_join_id0_tests"
-	echo "  -m fullmesh_tests"
-	echo "  -z fastclose_tests"
-	echo "  -I implicit_tests"
+
+	local key
+	for key in "${!all_tests[@]}"; do
+		echo "  -${key} ${all_tests[${key}]}"
+	done
+
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2436,59 +2405,43 @@ usage()
 }
 
 
+# Use a "simple" array to force an specific order we cannot have with an associative one
+all_tests_sorted=(
+	f@subflows_tests
+	e@subflows_error_tests
+	s@signal_address_tests
+	l@link_failure_tests
+	t@add_addr_timeout_tests
+	r@remove_tests
+	a@add_tests
+	6@ipv6_tests
+	4@v4mapped_tests
+	b@backup_tests
+	p@add_addr_ports_tests
+	k@syncookies_tests
+	S@checksum_tests
+	d@deny_join_id0_tests
+	m@fullmesh_tests
+	z@fastclose_tests
+	I@implicit_tests
+)
+
+all_tests_args=""
+all_tests_names=()
+for subtests in "${all_tests_sorted[@]}"; do
+	key="${subtests%@*}"
+	value="${subtests#*@}"
+
+	all_tests_args+="${key}"
+	all_tests_names+=("${value}")
+	all_tests[${key}]="${value}"
+done
+
 tests=()
-while getopts 'fesltra64bpkdmchzICSi' opt; do
+while getopts "${all_tests_args}cCih" opt; do
 	case $opt in
-		f)
-			tests+=(subflows_tests)
-			;;
-		e)
-			tests+=(subflows_error_tests)
-			;;
-		s)
-			tests+=(signal_address_tests)
-			;;
-		l)
-			tests+=(link_failure_tests)
-			;;
-		t)
-			tests+=(add_addr_timeout_tests)
-			;;
-		r)
-			tests+=(remove_tests)
-			;;
-		a)
-			tests+=(add_tests)
-			;;
-		6)
-			tests+=(ipv6_tests)
-			;;
-		4)
-			tests+=(v4mapped_tests)
-			;;
-		b)
-			tests+=(backup_tests)
-			;;
-		p)
-			tests+=(add_addr_ports_tests)
-			;;
-		k)
-			tests+=(syncookies_tests)
-			;;
-		S)
-			tests+=(checksum_tests)
-			;;
-		d)
-			tests+=(deny_join_id0_tests)
-			;;
-		m)
-			tests+=(fullmesh_tests)
-			;;
-		z)
-			tests+=(fastclose_tests)
-			;;
-		I)
-			tests+=(implicit_tests)
+		["${all_tests_args}"])
+			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
 			capture=1
@@ -2509,11 +2462,11 @@ while getopts 'fesltra64bpkdmchzICSi' opt; do
 done
 
 if [ ${#tests[@]} -eq 0 ]; then
-	all_tests
-else
-	for subtests in "${tests[@]}"; do
-		"${subtests}"
-	done
+	tests=("${all_tests_names[@]}")
 fi
 
+for subtests in "${tests[@]}"; do
+	"${subtests}"
+done
+
 exit $ret
-- 
2.35.1

