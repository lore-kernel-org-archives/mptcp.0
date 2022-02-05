Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF702C9C
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019427; x=1675555427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHxaD7+mSuBO6VwGpRSVDcFxi9YTf5ek/cd1ohC1TFk=;
  b=Ow2SqaRezYzOknEhpirWOHqFO8bn8/wdC1zpF21yhNtUTymYbhpB3tUq
   lpI1GGReYjchaQIidg3rKd6CutT98+G271yK5need/NS1cNT6LU4CUFn3
   bZ84fPnCwshyXSKy2/a3J9SPrQMEcqBGtuDl1/sJKef8fMDp8D1F+ZgaR
   Z/r4qj/V5mZyDPknCejubNq/IyCrpfeRbydy/y3PSRari4MmFvcnFUigS
   BBMPvL3T/qzmq5TKReCbXAhvjSxfSJs1dnu/SeNUGP5ZtYd4g2u4Eh+dY
   aE0G4rE8TRQnDMulujAlwY4HHeLBKw1dnW3kMSBG6oEhhdd3TB6EdvLPd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248678301"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248678301"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="770097524"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/9] selftests: mptcp: add wrapper for setting flags
Date: Fri,  4 Feb 2022 16:03:34 -0800
Message-Id: <20220205000337.187292-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
References: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch implemented a new function named pm_nl_set_endpoint(), wrapped
the PM netlink commands 'ip mptcp endpoint change flags' and 'pm_nl_ctl
set flags' in it, and used a new argument 'ip_mptcp' to choose which one
to use to set the flags of the PM endpoint.

'ip mptcp' used the ID number argument to find out the address to change
flags, while 'pm_nl_ctl' used the address and port number arguments. So
we need to parse the address ID from the PM dump output as well as the
address and port number.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 093eb27f5c6d..757f26674c62 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -376,6 +376,22 @@ pm_nl_show_endpoints()
 	fi
 }
 
+pm_nl_change_endpoint()
+{
+	local ns=$1
+	local flags=$2
+	local id=$3
+	local addr=$4
+	local port=""
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+	else
+		if [ $5 -ne 0 ]; then port="port $5"; fi
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -577,7 +593,7 @@ do_transfer()
 				local arr=($line)
 				local addr
 				local port=0
-				local _port=""
+				local id
 
 				for i in ${arr[@]}; do
 					if is_addr $i; then
@@ -586,11 +602,13 @@ do_transfer()
 						# The minimum expected port number is 10000
 						if [ $i -gt 10000 ]; then
 							port=$i
+						# The maximum id number is 255
+						elif [ $i -lt 255 ]; then
+							id=$i
 						fi
 					fi
 				done
-				if [ $port -ne 0 ]; then _port="port $port"; fi
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+				pm_nl_change_endpoint $netns $sflags $id $addr $port
 			done
 		done
 	fi
-- 
2.35.1

