Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5B7B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651099815; x=1682635815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmrL8d5kVZoi9GKjFaD/PhxeoocjNdjMMVWgnhRg444=;
  b=YP9EIMWZjNF6x4GKFqTt39fR26U+w6IO7fY8feazpgbL1ddORqeWrOhD
   2ssv8tsV/tNDdWNy6I1VrB6n4/i+mgeSlVVPCbkPVoEQHSWpqWA+x3nR9
   cxiQrrMqjMp1HRi0RrvOO1d7grMW1hQUptMuWQelhpV6vVTI0TTIJWDPT
   0N6lQgY/bzIKxfx5UMYq7l22u2m3vrv85G9dee+hjqHyHApALpXShk3Y+
   xs4Y3FA7MqnqkA4Mwxe2v5GmcQ48QBGijUM1EsoTe5zato+ZwUsx2u2yR
   Pf4fZyywQZ5wi7fzvMQTfuUxf7LxtQFTwe6rttpYUqQloiSkryPlGLSQz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291252896"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="291252896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731049123"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.233.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH net-next 6/6] selftests: mptcp: Add tests for userspace PM type
Date: Wed, 27 Apr 2022 15:50:02 -0700
Message-Id: <20220427225002.231996-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
References: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests ensure that the in-kernel path manager is bypassed when
the userspace path manager is configured. Kernel code is still
responsible for ADD_ADDR echo, so also make sure that's working.

Tested-by: Geliang Tang <geliang.tang@suse.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e5c8fc2816fb..b27854f976f7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -70,6 +70,7 @@ init_partial()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -1611,6 +1612,13 @@ wait_attempt_fail()
 	return 1
 }
 
+set_userspace_pm()
+{
+	local ns=$1
+
+	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
+}
+
 subflows_tests()
 {
 	if reset "no JOIN"; then
@@ -2698,6 +2706,63 @@ fail_tests()
 	fi
 }
 
+userspace_tests()
+{
+	# userspace pm type prevents add_addr
+	if reset "userspace pm type prevents add_addr"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 0 0 0
+		chk_add_nr 0 0
+	fi
+
+	# userspace pm type rejects join
+	if reset "userspace pm type rejects join"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 0
+	fi
+
+	# userspace pm type does not send join
+	if reset "userspace pm type does not send join"; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 0 0 0
+	fi
+
+	# userspace pm type prevents mp_prio
+	if reset "userspace pm type prevents mp_prio"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		chk_join_nr 1 1 0
+		chk_prio_nr 0 0
+	fi
+
+	# userspace pm type prevents rm_addr
+	if reset "userspace pm type prevents rm_addr"; then
+		set_userspace_pm $ns1
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 0 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		chk_join_nr 0 0 0
+		chk_rm_nr 0 0
+	fi
+}
+
 implicit_tests()
 {
 	# userspace pm type prevents add_addr
@@ -2767,6 +2832,7 @@ all_tests_sorted=(
 	m@fullmesh_tests
 	z@fastclose_tests
 	F@fail_tests
+	u@userspace_tests
 	I@implicit_tests
 )
 
-- 
2.36.0

