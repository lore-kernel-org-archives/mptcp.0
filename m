Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F618ADB
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550255; x=1700086255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMT0jvaM6rV0r/E+20oJeXxpjy/b/2beKHw5vQly4Kk=;
  b=fQSqlJyjIPapd6CZRVcdkw5gOomamPL/h8HJZjVsZUNJ87c7NVzifytQ
   idJVmbdYcHaXZaLoJkBIL+UKzmjqcvVIyowO3I7XjfnR4HNs1s8ecIOVf
   hXET8Mo6jmfrNYCgEA07YT2o/ZK8BJ7SOeAnMjUV1wagTLIomCMSzTISr
   AEOiO7vTFsLJ7Ah9J3JD9XD0SH62iptTEhwVNcUE0ap4j6FsaWR1O8aAM
   XSFZ2V1JakX3eQkedrY3Q8URyhJybfy2UiCayIE9JkS41eBjWYyIZw5D9
   pC/1V2EQXY+CI4SWrIIzxhmuasqKk2JzcRogI4dOYSZubFlkZm6YB/f8O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292089838"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292089838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616917994"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="616917994"
Received: from imunagan-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.21.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:52 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/3] selftests: mptcp: run mptcp_sockopt from a new netns
Date: Tue, 15 Nov 2022 14:10:45 -0800
Message-Id: <20221115221046.20370-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115221046.20370-1-mathew.j.martineau@linux.intel.com>
References: <20221115221046.20370-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Not running it from a new netns causes issues if some MPTCP settings are
modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
addresses are available and added to the MPTCP path-manager, etc.

In these cases, the created connection will not behave as expected, e.g.
unable to create an MPTCP socket, more than one subflow is seen, etc.

A new "sandbox" net namespace is now created and used to run
mptcp_sockopt from this controlled environment.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 0879da915014..80d36f7cfee8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -35,8 +35,9 @@ init()
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
+	ns_sbox="ns_sbox-$rndh"
 
-	for netns in "$ns1" "$ns2";do
+	for netns in "$ns1" "$ns2" "$ns_sbox";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -73,7 +74,7 @@ init()
 
 cleanup()
 {
-	for netns in "$ns1" "$ns2"; do
+	for netns in "$ns1" "$ns2" "$ns_sbox"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -243,7 +244,7 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
-	./mptcp_sockopt
+	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -252,7 +253,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	./mptcp_sockopt -6
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-- 
2.38.1

