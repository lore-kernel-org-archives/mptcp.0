Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D880435A
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153411; x=1676689411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATRa+uik1AsrOEVB2CM3pwo/U8VGumfyuTnhTNOouXM=;
  b=V8s+MD16YgKWRjvKw1lCf9BYajgEamg9rRpivPGaJHkunGL7Yq6kGncH
   cmTk9Le44QwikOvNG8/dUHubhHz+XoW+uPs9BYvNQqDWXwft+DZ2Rr2P7
   Yxuphrk3EdfOkvjKvb4MmWfgvEmQvKIpS+zgVIfSm1OIP8b6VWRlD2bNk
   ZiekJ05mAmEUgTfqKlvcYFs7apbCCme56d9j9mLD08pDBXb22OIOBP4E9
   tJzQYbLgsYuw5BAv88smmCsoclA7JGWT4dBQh++ZI6fuyZRjV1dST7v0/
   nZ6BOitaqL/oX9J8Yt3G+r4FVGKtIQMmxamNdKyJitnQBZM2004tKV9PS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021647"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431968"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/7] selftests: mptcp: add csum mib check for mptcp_connect
Date: Thu, 17 Feb 2022 19:03:11 -0800
Message-Id: <20220218030311.367536-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added the data checksum error mib counters check for the
script mptcp_connect.sh when the data checksum is enabled.

In do_transfer(), got the mib counters twice, before and after running
the mptcp_connect commands. The latter minus the former is the actual
number of the data checksum mib counter.

The output looks like this:

ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP   (duration    86ms) [ OK ]
ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP   (duration    66ms) [ FAIL ]
server got 1 data checksum error[s]

Fixes: 94d66ba1d8e48 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/255
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cb5809b89081..5b7a40d73253 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -432,6 +432,8 @@ do_transfer()
 	local stat_ackrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	local stat_cookietx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -524,6 +526,23 @@ do_transfer()
 		fi
 	fi
 
+	if $checksum; then
+		local csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+
+		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
+		if [ $csum_err_s_nr -gt 0 ]; then
+			printf "[ FAIL ]\nserver got $csum_err_s_nr data checksum error[s]"
+			rets=1
+		fi
+
+		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
+		if [ $csum_err_c_nr -gt 0 ]; then
+			printf "[ FAIL ]\nclient got $csum_err_c_nr data checksum error[s]"
+			retc=1
+		fi
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
-- 
2.35.1

