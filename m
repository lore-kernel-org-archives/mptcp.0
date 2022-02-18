Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A64C97
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220155; x=1676756155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2f5gKZYb+WbozvVkmuoQ5mgEVGSB54ZpJejDAL5YYw=;
  b=ghl1MYxx9+FGnUvlM/yog0pRrMzRt6k+q+I1iVH7mCiXK5PIgydaZlMC
   Ti3V/5LeO2l4rY93/BWfGl5HdeXZVwku4MNsrPHvLQYlRrl5eFazDhcpo
   fbM/m1OjtIeSFqchks6DhWkH+FjvgsPmJV3KSles6rAGyuVJACK2djRZv
   VbrV19Njl+3WywmGfYf5nQsNDMfTCdcyLtisFn+3MN1VIAONrqAAMka1N
   Nmh8v4GZEhkAuotub5fMCdFj4anpAr8nxXxTU9+UYDm82hjmhly2yFu8F
   I04yFjb4vhfo1akb00MYwS5RF756B5o2g/+177/tW/kVdVSiAvGq/vukO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238639226"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238639226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605664086"
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
Subject: [PATCH net 7/7] selftests: mptcp: be more conservative with cookie MPJ limits
Date: Fri, 18 Feb 2022 13:35:44 -0800
Message-Id: <20220218213544.70285-8-mathew.j.martineau@linux.intel.com>
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

Since commit 2843ff6f36db ("mptcp: remote addresses fullmesh"), an
MPTCP client can attempt creating multiple MPJ subflow simultaneusly.

In such scenario the server, when syncookies are enabled, could end-up
accepting incoming MPJ syn even above the configured subflow limit, as
the such limit can be enforced in a reliable way only after the subflow
creation. In case of syncookie, only after the 3rd ack reception.

As a consequence the related self-tests case sporadically fails, as it
verify that the server always accept the expected number of MPJ syn.

Address the issues relaxing the MPJ syn number constrain. Note that the
check on the accepted number of MPJ 3rd ack still remains intact.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0d6a71e7bb59..0c8a2a20b96c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -660,6 +660,7 @@ chk_join_nr()
 	local ack_nr=$4
 	local count
 	local dump_stats
+	local with_cookie
 
 	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
@@ -673,12 +674,20 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
+	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
-		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-		ret=1
-		dump_stats=1
+		# simult connections exceeding the limit with cookie enabled could go up to
+		# synack validation as the conn limit can be enforced reliably only after
+		# the subflow creation
+		if [ "$with_cookie" = 2 ] && [ "$count" -gt "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
+			echo -n "[ ok ]"
+		else
+			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
+			ret=1
+			dump_stats=1
+		fi
 	else
 		echo -n "[ ok ]"
 	fi
-- 
2.35.1

