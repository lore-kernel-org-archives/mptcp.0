Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAE2CA8
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447174; x=1680983174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NABinCF0LHq/aOKg0y7Mwz+78G28IHxmsB6Mx1C7my4=;
  b=XI8yZEzXUR2VM4ybKxs8aMFACg+4vSUWN9SVx33XC8newK9+SDo5prpr
   NNMfHQ2aIqIhXQ62VCReWLt19ocixo6HMzXjBWFgcUsiHVT7b9IURU5JW
   bWgrh92pnimB83JV/Q1+8Zm9+IeHvRW9FPGNAioGLfnDTOgXBKYfQDaHO
   QZfnlGJEmzdZbZrxMZm4w8YRO+FrJSHWLpIh9ICj6oiZzyU3HYXMVdzGz
   rR6lvDlkWlKG1hrgq1vqx9yj44bZxiVBW8o35zh3zAYrCLA9TcR+eCynD
   BpK+SoguU9dspG9ov5/q5OdJP49SMSU+ms6SC1/5N90oZYSrtqknbT8+C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365317"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602181"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:11 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 8/8] selftests/mptcp: add diag listen tests
Date: Fri,  8 Apr 2022 12:46:01 -0700
Message-Id: <20220408194601.305969-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Check dumping of mptcp listener sockets:
1. filter by dport should not return any results
2. filter by sport should return listen sk
3. filter by saddr+sport should return listen sk
4. no filter should return listen sk

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ff821025d309..9dd43d7d957b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -71,6 +71,43 @@ chk_msk_remote_key_nr()
 		__chk_nr "grep -c remote_key" $*
 }
 
+__chk_listen()
+{
+	local filter="$1"
+	local expected=$2
+
+	shift 2
+	msg=$*
+
+	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
+	printf "%-50s" "$msg"
+
+	if [ $nr != $expected ]; then
+		echo "[ fail ] expected $expected found $nr"
+		ret=$test_cnt
+	else
+		echo "[  ok  ]"
+	fi
+}
+
+chk_msk_listen()
+{
+	lport=$1
+	local msg="check for listen socket"
+
+	# destination port search should always return empty list
+	__chk_listen "dport $lport" 0 "listen match for dport $lport"
+
+	# should return 'our' mptcp listen socket
+	__chk_listen "sport $lport" 1 "listen match for sport $lport"
+
+	__chk_listen "src inet:0.0.0.0:$lport" 1 "listen match for saddr and sport"
+
+	__chk_listen "" 1 "all listen sockets"
+
+	nr=$(ss -Ml $filter | wc -l)
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -113,6 +150,7 @@ echo "a" | \
 				0.0.0.0 >/dev/null &
 wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
+chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-- 
2.35.1

