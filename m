Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486847A
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664554; x=1682200554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3K/31va/RyyDkPboWS2IboZC2kBhh+5PAFP+cCkjibQ=;
  b=kHuaX0WoH3Gm3x+hvs89pvC5I/Ph+PF2pxNjoMzWe5IhNC6cHrrJHbyg
   N3JDJyBu3x1kYHeezMXBfq2+LFWEPmBSVdQxSDQ4QEzXyWtC+hXolqpSW
   OOCe0b+XmD+YeSLBH14u3FpJwQzFAXUMM8FD30wWxnKJ+iPtgTqyEJp/L
   Mr28blZYCh6hUeosbJ7CAcji9RD0eFWBA+TjZVsf/i2iXQoIDX/fymQxP
   2otW0VtRVmiLDsfcdfYUoHT+H/PSEc9Wmub9aON1ZnJmBfS8WJ3a+H82S
   rirZ0IDtVhlSSOoc1B5axPuYcSikBRKDo9PXOtd9iFQk4KkFcUtPFJdGm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720735"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720735"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119267"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 8/8] selftests: mptcp: add infinite map mibs check
Date: Fri, 22 Apr 2022 14:55:43 -0700
Message-Id: <20220422215543.545732-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
References: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a function chk_infi_nr() to check the mibs for the
infinite mapping. Invoke it in chk_join_nr() when validate_checksum
is set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7314257d248a..9eb4d889a24a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1106,6 +1106,38 @@ chk_rst_nr()
 	echo "$extra_msg"
 }
 
+chk_infi_nr()
+{
+	local infi_tx=$1
+	local infi_rx=$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "itx"
+	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - infirx"
+	count=$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
@@ -1115,7 +1147,8 @@ chk_join_nr()
 	local csum_ns2=${5:-0}
 	local fail_nr=${6:-0}
 	local rst_nr=${7:-0}
-	local corrupted_pkts=${8:-0}
+	local infi_nr=${8:-0}
+	local corrupted_pkts=${9:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -1170,6 +1203,7 @@ chk_join_nr()
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
 
-- 
2.36.0

