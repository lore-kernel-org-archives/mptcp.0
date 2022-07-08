Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A583229
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657300461; x=1688836461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQFTa2o7tX8z6E5Yqben/xtRbWyD1sotbqs9kP1vAWI=;
  b=EHJmphvdpFgq+EhL8tvIX8kBr4O1UaMFLHYEhn9PhaYVbZxXUSKnjVLC
   kRn89peFaT/UNXXmZI1BBgp6gy8gK4BpkhXpkKmDEG0g46hzbAFCXGk2O
   8YABVotzk2LziCcTkaA+A6DkvFK4dDI35Xz8M6hXO+iH1oPUWu8f8YaUe
   4GwV3x1siCVRKum0FzmNfMo04e9TBMuTuGVibcU4SXvad1vlfjVVt0zbC
   djjJi8hUvZzhgazDGxstT1qckCKTXbt4g29BIQQhKb4eUWx9+kzvAACkB
   w9+q1Lc4gJwQRz0EuHU8wo8riciOevRpoJuQ4eCquIhm1xJzq9X1+NqbR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285069096"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285069096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651641504"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:18 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/6] selftests: mptcp: userspace pm address tests
Date: Fri,  8 Jul 2022 10:14:10 -0700
Message-Id: <20220708171413.327112-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
References: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds userspace pm tests support for mptcp_join.sh script. Add
userspace pm add_addr and rm_addr test cases in userspace_tests().

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4406b7a8064..d889e7507cd9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -455,6 +455,12 @@ wait_mpj()
 	done
 }
 
+kill_wait()
+{
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -654,6 +660,9 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local userspace_pm=0
+	local evts_ns1
+	local evts_ns1_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -690,12 +699,24 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
+	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
+		userspace_pm=1
+		addr_nr_ns1=${addr_nr_ns1:10}
+	fi
+
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
 		addr_nr_ns2=0
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		evts_ns1=$(mktemp)
+		:> "$evts_ns1"
+		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+		evts_ns1_pid=$!
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -748,6 +769,8 @@ do_transfer()
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -755,9 +778,18 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
+			if [ $userspace_pm -eq 0 ]; then
+				pm_nl_add_endpoint $ns1 $addr flags signal
+			else
+				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				sleep 1
+				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+			fi
+
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		local rm_nr_ns1=$((-addr_nr_ns1))
@@ -890,6 +922,11 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		kill_wait $evts_ns1_pid
+		rm -rf $evts_ns1
+	fi
+
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2810,6 +2847,16 @@ userspace_tests()
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
+
+	# userspace pm add & remove address
+	if reset "userspace pm add & remove address"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_rm_nr 1 1 invert
+	fi
 }
 
 endpoint_tests()
-- 
2.37.0

