Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11652435A
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153410; x=1676689410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChdVtpx2FTn8UBnKC5Z+NGmbaMbZRte5dZCcVFncSNY=;
  b=d4vIbnDqJ6+XNYosXdc2AoOwKU+7LSDuGo3XYx3qrpCCKMtIJ56eV9lL
   SfexV+EevKwuhugQZ8BGdn4IEn1RcvBKooga14+8WEKClBXhWlomEw2RE
   V35gM3GZVOqgH8leB3Q6NtqKSbMsufkvZ8Qc9+ausfotSboGf8K4yyJW8
   DISbyuwYXDmREF/rFvTFZbN/3zWcQEOTU6nLEBR+9agc+2CZkSGrGHojU
   ZxfY1v3me4qCzyZ3tc7BrvGlaml9uHx0kknmcoE8nDBTnOZ4+T898eeu3
   L3rThqfY4bgExsZtqQ2D31XpP3rtX7uxR6cAqrNha29JIAq5jYhs0kLd2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021644"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431953"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/7] selftests: mptcp: join: check for tools only if needed
Date: Thu, 17 Feb 2022 19:03:10 -0800
Message-Id: <20220218030311.367536-7-mathew.j.martineau@linux.intel.com>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

To allow showing the 'help' menu even if these tools are not available.

While at it, also avoid launching the command then checking $?. Instead,
the check is directly done in the 'if'.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 63340bb76920..725924012b41 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -99,9 +99,29 @@ cleanup_partial()
 	done
 }
 
+check_tools()
+{
+	if ! ip -Version &> /dev/null; then
+		echo "SKIP: Could not run test without ip tool"
+		exit $ksft_skip
+	fi
+
+	if ! iptables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without iptables tool"
+		exit $ksft_skip
+	fi
+
+	if ! ip6tables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ip6tables tool"
+		exit $ksft_skip
+	fi
+}
+
 init() {
 	init=1
 
+	check_tools
+
 	sin=$(mktemp)
 	sout=$(mktemp)
 	cin=$(mktemp)
@@ -183,24 +203,6 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run all tests without iptables tool"
-	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run all tests without ip6tables tool"
-	exit $ksft_skip
-fi
-
 print_file_err()
 {
 	ls -l "$1" 1>&2
-- 
2.35.1

