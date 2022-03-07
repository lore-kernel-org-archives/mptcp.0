Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D5434F
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685888; x=1678221888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAAcffiJOJsRQQTyOrz1x5kOdHFzms/WH96XqyL1xuE=;
  b=SZTl8U/2xX9tXp0F829OpZyQh+as+TFRPGoGou+057w5U8UBD8S6H6YQ
   ZO3b/mMLYs0AWKv4eugqz/JE2k7OMWzly3Kg/e1Hd2h41I5vcBYv18U6I
   GFinP+bWJzlxjQeFvAD9HufRGTf1fnmR01Tyg9x+n9z9b909pqmcNiM4G
   ifHIOtbmNyWfaSiZw5mobydUpU7hFc82BLK+cJu5zRZ38ALur5WYxzgdV
   XHlcdts/iOkRjNNSKggEYc3VbEwLztmBuFqj7XaXGLgbOlUQsw46H+ig6
   A6WUSzxnYIdEvl+Og/Y1df0n3zT2e0zmjzaJX9zgpO2F5FstnD4EUjUd/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731788"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320487"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/9] mptcp: more careful RM_ADDR generation
Date: Mon,  7 Mar 2022 12:44:35 -0800
Message-Id: <20220307204439.65164-6-mathew.j.martineau@linux.intel.com>
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

From: Paolo Abeni <pabeni@redhat.com>

The in-kernel MPTCP path manager, when processing the MPTCP_PM_CMD_FLUSH_ADDR
command, generates RM_ADDR events for each known local address. While that
is allowed by the RFC, it makes unpredictable the exact number of RM_ADDR
generated when both ends flush the PM addresses.

This change restricts the RM_ADDR generation to previously explicitly
announced addresses, and adjust the expected results in a bunch of related
self-tests.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c                        | 10 ++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 75a0a27547e6..91b77d1162cf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1466,14 +1466,12 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
-		    slist.nr < MPTCP_RM_IDS_MAX) {
-			alist.ids[alist.nr++] = entry->addr.id;
+		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
-		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-			 alist.nr < MPTCP_RM_IDS_MAX) {
+
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
-		}
 	}
 
 	if (alist.nr) {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d4769bc0d842..02bab8a2d5a5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1149,14 +1149,25 @@ chk_rm_nr()
 {
 	local rm_addr_nr=$1
 	local rm_subflow_nr=$2
-	local invert=${3:-""}
+	local invert
+	local simult
 	local count
 	local dump_stats
 	local addr_ns=$ns1
 	local subflow_ns=$ns2
 	local extra_msg=""
 
-	if [[ $invert = "invert" ]]; then
+	shift 2
+	while [ -n "$1" ]; do
+		[ "$1" = "invert" ] && invert=true
+		[ "$1" = "simult" ] && simult=true
+		shift
+	done
+
+	if [ -z $invert ]; then
+		addr_ns=$ns1
+		subflow_ns=$ns2
+	elif [ $invert = "true" ]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
 		extra_msg="   invert"
@@ -1176,6 +1187,25 @@ chk_rm_nr()
 	echo -n " - rmsf  "
 	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
 	[ -z "$count" ] && count=0
+	if [ -n "$simult" ]; then
+		local cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
+		local suffix
+
+		# in case of simult flush, the subflow removal count on each side is
+		# unreliable
+		[ -z "$cnt" ] && cnt=0
+		count=$((count + cnt))
+		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		if [ $count -ge "$rm_subflow_nr" ] && \
+		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
+			echo "[ ok ] $suffix"
+		else
+			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+			ret=1
+			dump_stats=1
+		fi
+		return
+	fi
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		ret=1
@@ -1666,7 +1696,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 1 3 invert simult
 
 	# subflows flush
 	reset
@@ -1677,7 +1707,7 @@ remove_tests()
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
-	chk_rm_nr 3 3
+	chk_rm_nr 0 3 simult
 
 	# addresses flush
 	reset
@@ -1689,7 +1719,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
-	chk_rm_nr 3 3 invert
+	chk_rm_nr 3 3 invert simult
 
 	# invalid addresses flush
 	reset
@@ -1973,7 +2003,7 @@ add_addr_ports_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 1 3 invert simult
 
 	# multiple addresses with port
 	reset
-- 
2.35.1

