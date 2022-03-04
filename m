Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AE42B7
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422607; x=1677958607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4H1NNFEPEPtaUDrXkY9mhWAswryRgKMsLlxBfLPh78=;
  b=Gcez1kAF7Vj5545ci8pg4fS3eh9Yd6456VQgS8yeGZnuzVoyHrsIbhV0
   +m242Hh6eZyEazkAu78d/RA1zNaxzIWMCvk7NMGxwnzxvVi8SrjEJxPel
   g0PM0BF3LEdThGwvCj4hCSFITDG8LnVF1A4EeAxU/NmcUMxT29RRgMr4D
   RKF+tGAQbr8iAf2I4Uu24qncDgVgGppvSw5Lpx0rrVJWz5dJfs3eUzER8
   dQatjTIA00/UlgVO9bwtgWcNo3IvpduNKpvE2ZNDoP5Wt5FS07YyyTwQc
   AbUBlMYi9I4GQ3Z55KXlyXDmXFTcQuwWxoczbgeT/uxsnI7It9+x0bjn9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739506"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340787"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 05/11] selftests: mptcp: add the MP_RST mibs check
Date: Fri,  4 Mar 2022 11:36:30 -0800
Message-Id: <20220304193636.219315-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
References: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 10339a796325..12008640d9f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -824,6 +824,50 @@ chk_fclose_nr()
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
+chk_rst_nr()
+{
+	local rst_tx=$1
+	local rst_rx=$2
+	local ns_invert=${3:-""}
+	local count
+	local dump_stats
+	local ns_tx=$ns1
+	local ns_rx=$ns2
+	local extra_msg=""
+
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns2
+		ns_rx=$ns1
+		extra_msg="   invert"
+	fi
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
+}
+
 chk_join_nr()
 {
 	local msg="$1"
@@ -878,6 +922,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 	fi
 }
 
-- 
2.35.1

