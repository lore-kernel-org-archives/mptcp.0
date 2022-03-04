Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC57C
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422608; x=1677958608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROvep7kyVqc+GmBw/uIi6w1KfX09rcAB6oWAZ89yNz0=;
  b=mhQFeGN5AIBJoMSyQ+7DuW0+8zcZbS/q7bHZBaE3tsvxZXLqK5zZFQ6q
   2SH0iHAbU8PfeojZ//w1jZY/mm4UHppIvXOSayE8mulJUU4or6gsWzIUU
   1Xw+69+5VxL5PIn66x36uIqDfv6Ky8t4CDGjvvQZpbj6NruaatI0bgwzC
   4q36oN/aoS+Eg0vodXVmeaXPYPbOtmuzVgi+NIUXtfetV4Lc4/IdwdEHo
   Npjo6m0iqPXmASAl87BqFq7p/iCiu3hpGQUMapCrTfqTrRjbiylw8hAek
   SZ8VtSlYLzO08v5Do9ByM3e7evGPzaVzd7K85PD2880J78VxJCIBS/DVH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739511"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340792"
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
Subject: [PATCH net-next 09/11] selftests: mptcp: add invert check in check_transfer
Date: Fri,  4 Mar 2022 11:36:34 -0800
Message-Id: <20220304193636.219315-10-mathew.j.martineau@linux.intel.com>
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

This patch added the invert bytes check for the output data in
check_transfer().

Instead of the file mismatch error:

  [ FAIL ] file received by server does not match (in, out):
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER

Print out the inverted bytes like this:

  file received by server has inverted byte at 7454789
  file received by server has inverted byte at 7454790
  file received by server has inverted byte at 7454791
  file received by server has inverted byte at 7454792

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4604dd13a87e..f4812e820acf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 capture=0
 checksum=0
 ip_mptcp=0
+check_invert=0
 do_all_tests=1
 init=0
 
@@ -59,6 +60,8 @@ init_partial()
 		fi
 	done
 
+	check_invert=0
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -216,15 +219,21 @@ check_transfer()
 	out=$2
 	what=$3
 
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=1
+	cmp -l "$in" "$out" | while read line; do
+		local arr=($line)
 
-		return 1
-	fi
+		let sum=0${arr[1]}+0${arr[2]}
+		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
+			echo "[ FAIL ] $what does not match (in, out):"
+			print_file_err "$in"
+			print_file_err "$out"
+			ret=1
+
+			return 1
+		else
+			echo "$what has inverted byte at ${arr[0]}"
+		fi
+	done
 
 	return 0
 }
-- 
2.35.1

