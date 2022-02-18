Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E004C9B
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645222705; x=1676758705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V8BE8auzhPjcsNv55FjAz+I3qbU9pXHfmig7YP34otQ=;
  b=iBSJjEy2RaD0exsTMdiGLR3hLcmXqdQYg3YsG9KmCMEG5shhK3mmY3Uc
   CdRQgqbammhUW2C2nzIlJjVA/Fh5q2YHBZedn69unf8niyj4+VscVeScJ
   mhuHcjt9JsR9eEpnr3jPCeJ8TChj5TycYrCvufbDRsR6nn9rqm1FOwLKm
   FMgnLi2sHBODPSyRRwFgwbF0kdYghj2Yst2hT0CIvv+zUiTU4zQKQtWrK
   vdFzpqRd2rF82LyGTAbCY8MfyyAWZNL2sPEjoYskVPp/wXL55nzg+G5T+
   zXk75YSmXmmUFoCRXeX21DNn2sMZnwl0YsDhy+3Hv7gcNt01eZDnluCOm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231857989"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231857989"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="542032039"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: Rename wait function
Date: Fri, 18 Feb 2022 14:18:14 -0800
Message-Id: <20220218221814.72026-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "selftests: mptcp: improve 'fair usage on close' stability" commit
changed that self test to check the TcpAttemptFails MIB instead of
looking for TW sockets. The associated bash function wasn't renamed in
that commit because of the merge conflicts it would cause, so this
commit updates the function name as Paolo originally intended.

Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 491934c3c489..71b2ad5adefc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1152,7 +1152,7 @@ chk_link_usage()
 	fi
 }
 
-wait_for_tw()
+wait_attempt_fail()
 {
 	local timeout_ms=$((timeout_poll * 1000))
 	local time=0
@@ -1271,7 +1271,7 @@ subflows_error_tests()
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	# mpj subflow will be in TW after the reset
-	wait_for_tw $ns2
+	wait_attempt_fail $ns2
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
 
-- 
2.35.1

