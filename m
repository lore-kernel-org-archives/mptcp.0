Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004A15ADD
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8tR1dTW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697441026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0e9royn391SyRFe03m2x7Ibz6JATDEQ+h6B3LRRtQg=;
	b=m8tR1dTW311lEDjT0OmjEMDB0NULM4oJmUeSFYyn+BqaTCep2fTiCeFQsJBf2OmhO0NjbW
	XdlirrmSyES07RYz0Mj+0XrZUIv097/ZEyJsh4A8t+USrm2z4+C5sKg49zDmyze2+QIrFW
	wHkfZ5vnbPvVPNWGPIKDVUoc6uAY3ns=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] selftests: mptcp: run userspace pm tests slower
Date: Mon, 16 Oct 2023 15:21:22 +0800
Message-Id: <be6f545d941e4b4c2adab547ec4235be163aee86.1697431973.git.geliang.tang@suse.com>
In-Reply-To: <cover.1697431973.git.geliang.tang@suse.com>
References: <cover.1697431973.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

Some userspace pm tests failed are reported by CI:

112 userspace pm add & remove address
      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      mptcp_info subflows=1:1             [ ok ]
      subflows_total 2:2                  [ ok ]
      mptcp_info add_addr_signal=1:1      [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert
      mptcp_info subflows=0:0             [ ok ]
      subflows_total 1:1                  [fail]
                         got subflows 0:0 expected 1:1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpInSegs                       118                0.0

This patch fixes them by change 'speed' to 5 to run the tests much more
slower.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01480663c102..1fc33bb3aba1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3435,7 +3435,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		speed=10 \
+		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3459,7 +3459,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=10 \
+		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-- 
2.35.3

