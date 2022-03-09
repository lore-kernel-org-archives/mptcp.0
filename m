Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE080511B
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853416; x=1678389416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwZxpPcrUIlnY/t31Q/cysFYWVpWE5E6d7htLTusAhA=;
  b=giLggFajy1mr/20Jhw9t6Le+kaExPrNyhzTG5jfRXk2SjUqahRLQL7in
   UuMzUw4vgYx0Thu0TNyyCpJS+HH8f2C+jPBsbfWInjkct9g1ZoyPNtfyW
   Yt724HyMWm6GH4c7qvpIrcev5bGvof3Fx+pJM/vqK+WraqYkiMxkg1vsX
   GLvV0O1WtNBIYDuuPlL8GC6EaSpY9JMpbt/LpypEns0w9XFGJAvHkRB8S
   SI1uSsjJbyiphXU4eW3n7kdcCoGlZdD6/HkWwYXLDiZkWDcexCO7Powc/
   SzjSQhyWhyTuUy2tkCRNnoH+t4rOH3kEW16WegqnF+OiEGXZoHjM7a2sP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011987"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011987"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957062"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 07/10] selftests: mptcp: join: helper to filter TCP
Date: Wed,  9 Mar 2022 11:16:33 -0800
Message-Id: <20220309191636.258232-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
References: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

This is more readable and reduces duplicated commands.

This might also be useful to add v6 support and switch to nftables.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d3038922a0d2..5223f2a752b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -561,6 +561,15 @@ pm_nl_check_endpoint()
 	fi
 }
 
+filter_tcp_from()
+{
+	local ns="${1}"
+	local src="${2}"
+	local target="${3}"
+
+	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -1519,7 +1528,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1530,7 +1539,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1542,7 +1551,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
-- 
2.35.1

