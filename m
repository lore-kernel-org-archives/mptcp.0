Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81A42B8
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422605; x=1677958605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kC064xb6BMbDim0pmnLeLvVczZMRtariLgOphzx/OI=;
  b=DGaQ/y+pytsj3vBs24ebbe5lUFVq0ofwtiUC3ImdngyswnKJTeSACLHW
   9bIctOkpgeskv9d/OxRFCsSRdxeatXWl0VPdPO74ogpLCWjovJrzUYWi5
   R4xjc36bOBxOZVUWVG2QQg4MdDTGj/0C3UqIn53UsnZ894et6t5uk+RGP
   z3NQ9TzVZgSV2h7CZaKg+HFPv+T+8fARGF6FP412OzCwxAkcZ4BFFjM7e
   mKqfT2xcYsDmWF1kqgOz0L74v/nU85557xaIK+Kwugs+9C+01GSHlUDTk
   kGjxKWQTVhnwQB+uFqmVZBD+jfAdOruohDm/BOiaSpDr3qqiSTQQHUYeP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="251622086"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="251622086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340794"
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
Subject: [PATCH net-next 11/11] selftests: mptcp: update output info of chk_rm_nr
Date: Fri,  4 Mar 2022 11:36:36 -0800
Message-Id: <20220304193636.219315-12-mathew.j.martineau@linux.intel.com>
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

This patch updated the output info of chk_rm_nr. Renamed 'sf' to 'rmsf',
which means 'remove subflow'. Added the display of whether the inverted
namespaces has been used to check the mib counters.

The new output looks like this:

 002 remove multiple subflows          syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - rmsf  [ ok ]
 003 remove single address             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ]
                                       rm [ ok ] - rmsf  [ ok ]   invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2912289d63f4..45c6e5f06916 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1153,15 +1153,14 @@ chk_rm_nr()
 	local invert=${3:-""}
 	local count
 	local dump_stats
-	local addr_ns
-	local subflow_ns
+	local addr_ns=$ns1
+	local subflow_ns=$ns2
+	local extra_msg=""
 
-	if [ -z $invert ]; then
-		addr_ns=$ns1
-		subflow_ns=$ns2
-	elif [ $invert = "invert" ]; then
+	if [[ $invert = "invert" ]]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
+		extra_msg="   invert"
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
@@ -1175,7 +1174,7 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
 
-	echo -n " - sf    "
+	echo -n " - rmsf  "
 	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_subflow_nr" ]; then
@@ -1183,10 +1182,12 @@ chk_rm_nr()
 		ret=1
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 
 	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
 
 chk_prio_nr()
-- 
2.35.1

