Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E6D11
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 23:19:56 +0000 (UTC)
IronPort-SDR: z8xaw+c27YHImknq89BHAoHDaiBsNCf8Q5QqRHs4BYCgbaqeNulcI0eM4UMNIm2ZZEEf0xQ2FT
 +caZjsVft37g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277537240"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="277537240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:55 -0700
IronPort-SDR: MIgANhYmd131RlHGxgbcmCb4dDVAI8DYE902JsIUn5Ybn9N9R5odb2rGPmqK8xtxeCwHyG0hzv
 nCZlCtc6Ti8g==
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="446269200"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.128.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:54 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/7] selftests: mptcp: dump more info on mpjoin errors
Date: Thu,  1 Apr 2021 16:19:47 -0700
Message-Id: <20210401231947.162836-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401231947.162836-1-mathew.j.martineau@linux.intel.com>
References: <20210401231947.162836-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Very occasionally, MPTCP selftests fail. Yeah, I saw that at least once!

Here we provide more details in case of errors with mptcp_join.sh script
like it was done with mptcp_connect.sh, see
commit 767389c8dd55 ("selftests: mptcp: dump more info on errors")

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 56ffdad01526..abeb24b7f8ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -78,6 +78,7 @@ cleanup_partial()
 
 	for netns in "$ns1" "$ns2"; do
 		ip netns del $netns
+		rm -f /tmp/$netns.{nstat,out}
 	done
 }
 
@@ -233,6 +234,11 @@ do_transfer()
 		sleep 1
 	fi
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat -n
+
 	if [ $speed = "fast" ]; then
 		mptcp_connect="./mptcp_connect -j"
 	elif [ $speed = "slow" ]; then
@@ -383,12 +389,19 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat | grep Tcp > /tmp/${connector_ns}.out
+
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport = :$port"
+		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
+		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport = :$port"
+		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
+		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
 		ret=1
-- 
2.31.1

