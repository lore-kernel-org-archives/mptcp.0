Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4C4C95
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220154; x=1676756154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPNBc17stRFe/AsFOoZDtyY+Pe1mPa0jEIXT/R6zQi4=;
  b=WBXtABcvaBl9TlhpU8S2JW7mERW+xYzBBIScujGwJt5kmOZZnqOrMzGB
   zziSonwepGIXeft2YLGHCMbUAGTj2QIfa6fahQLTkE8u4gbn3Lytalh2x
   PrP5g+pJqUzADPviq7mBS2LcjFHZUlZ+LqxjDEqq2R/6pnoI2wyDz40EH
   HHOcB6XfjUMbSKiUbTK7Of/6lrS4ZkLiS06buzyAv6YuoisqaA3Phi3q7
   eB9fkET0Sf6D9IiJj4fnZqjHNBoI/othIJ3PIjjeZYPy0s3v71ge0EroS
   JFLA2iEuMwEjAB3M8sofC0PidWa0N4c5+mS8lOfLF/mfNDJ6Hmwkq314O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238639225"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238639225"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605664083"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:53 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 6/7] selftests: mptcp: more robust signal race test
Date: Fri, 18 Feb 2022 13:35:43 -0800
Message-Id: <20220218213544.70285-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
References: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The in kernel MPTCP PM implementation can process a single
incoming add address option at any given time. In the
mentioned test the server can surpass such limit. Let the
setup cope with that allowing a faster add_addr retransmission.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254
Reported-and-tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 10b3bd805ac6..0d6a71e7bb59 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -752,11 +752,17 @@ chk_add_nr()
 	local mis_ack_nr=${8:-0}
 	local count
 	local dump_stats
+	local timeout
+
+	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$add_nr" ]; then
+
+	# if the test configured a short timeout tolerate greater then expected
+	# add addrs options, due to retransmissions
+	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		ret=1
 		dump_stats=1
@@ -1158,7 +1164,10 @@ signal_address_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
-	run_tests $ns1 $ns2 10.0.1.1
+
+	# the peer could possibly miss some addr notification, allow retransmission
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal addresses race test" 3 3 3
 
 	# the server will not signal the address terminating
-- 
2.35.1

