Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81058AD0
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550256; x=1700086256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h27g9PViRa+DdVfY8WqZPlUq8vMy1a58+HzU30dDaXY=;
  b=m+Gj3+lFkSKZO843eNM8Spr10ifQjttAtQUlId2EQfTwylY7kh/vcFX6
   xn/TJT7TXlCD+yR865KsIOi5zP3psC+neAdlEeCHeO/zBigddSDiZkyEj
   hJCOzhomMCV6nF1SbCBAODeiZyCLRVjflAKhMda7nu+OgFevNgsBdLrOC
   SMeZYIkUicTpe0ZTyiLChCWchJ7RMsTx9WN3KcII5+JLn5avEI83G0kCr
   wB+etsPA3JKlbl2DaG5F6aQGBDG5pjBH0BoRNt9q9Hkmu7WY5hyyurACI
   3N5vn7RNBoX0RdE7N69EgjLJVTJeJJSVDBsN9hhg7BDFwsn4t68CZ/kiK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292089840"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292089840"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616917997"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="616917997"
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
Subject: [PATCH net 3/3] selftests: mptcp: fix mibit vs mbit mix up
Date: Tue, 15 Nov 2022 14:10:46 -0800
Message-Id: <20221115221046.20370-4-mathew.j.martineau@linux.intel.com>
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

The estimated time was supposing the rate was expressed in mibit
(bit * 1024^2) but it is in mbit (bit * 1000^2).

This makes the threshold higher but in a more realistic way to avoid
false positives reported by CI instances.

Before this patch, the thresholds were at 7561/4005ms and now they are
at 7906/4178ms.

While at it, also fix a typo in the linked comment, spotted by Mat.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/310
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ffa13a957a36..40aeb5a71a2a 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -247,9 +247,10 @@ run_test()
 	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
 	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
 
-	# time is measured in ms, account for transfer size, affegated link speed
+	# time is measured in ms, account for transfer size, aggregated link speed
 	# and header overhead (10%)
-	local time=$((size * 8 * 1000 * 10 / (( $rate1 + $rate2) * 1024 *1024 * 9) ))
+	#              ms    byte -> bit   10%        mbit      -> kbit -> bit  10%
+	local time=$((1000 * size  *  8  * 10 / ((rate1 + rate2) * 1000 * 1000 * 9) ))
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
 	# completion (see mptcp_connect): 200ms on each side, add some slack
-- 
2.38.1

