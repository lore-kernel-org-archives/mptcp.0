Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D96D0F
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:31:49 +0000 (UTC)
IronPort-SDR: NUlfEI/4cy+0wPtM/WmJzbBAU7Ou/YUqtkl5aAorv/5m8Wqck0S82IFwWCaaWnsvC62wghNqci
 kKUeuTKMM6ZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202623693"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202623693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
IronPort-SDR: mab1Qem+WKbXV9Qcq1Ffq23iPa8bfYct/siRzKEEEyHIdJtmkQTW5uLc5HyBuTHfip52a9cgC9
 QdsGsb94mxQA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477700335"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 4/4] mptcp: update selftest for fallback due to OoO
Date: Thu, 27 May 2021 16:31:40 -0700
Message-Id: <20210527233140.182728-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527233140.182728-1-mathew.j.martineau@linux.intel.com>
References: <20210527233140.182728-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The previous commit noted that we can have fallback
scenario due to OoO (or packet drop). Update the self-tests
accordingly

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3c4cb72ed8a4..9ca5f1ba461e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -501,6 +501,7 @@ do_transfer()
 	local stat_ackrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -518,10 +519,14 @@ do_transfer()
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
-		printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-			"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
-		rets=1
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} -a ${stat_ooo_now} -eq 0 ]; then
+		if [ ${stat_ooo_now} -eq 0 ]; then
+			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+			rets=1
+		else
+			printf "[ Note ] fallback due to TCP OoO"
+		fi
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-- 
2.31.1

