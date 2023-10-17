Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B948747B
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWT2Vrg0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697511770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D77JK1qlNbqzPSvYFGx3pucj8R9RSlkCdgwZC1mcg8M=;
	b=KWT2Vrg0EuZWPIBGt9nPvceZqvc+hZFvYjOjG5EufJPabRwu3esfOD7FPcBLmQDmo6APhj
	VGWp2uhup8nsSKSGnxj5dWSsFpu17bWPqA/+N8BmXw1LG0wZZiSZs+lVCwI2Zaodh7RJOs
	Q9VUSoaUeNw8yyDl6NzXU8KOdCY1+6Q=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 2/9] selftests: mptcp: fix wait_rm_addr/sf parameters
Date: Tue, 17 Oct 2023 11:00:21 +0800
Message-Id: <cbbcfa8b370507f89933331719ece20ce9a7117a.1697511436.git.geliang.tang@suse.com>
In-Reply-To: <cover.1697511436.git.geliang.tang@suse.com>
References: <cover.1697511436.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

The second input parameter of 'wait_rm_addr/sf $1 1' is misused. If it's
1, wait_rm_addr/sf will never break, and will loop ten times, then
'wait_rm_addr/sf' equals to 'sleep 1'. This delay time is too long,
which can sometimes make the tests failures.

A better way to use wait_rm_addr/sf is to use rm_addr/sf_count to obtain
the current value, and then pass into wait_rm_addr/sf.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2269dc986d78..186f5933a096 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3324,12 +3324,14 @@ userspace_pm_rm_addr()
 {
 	local evts=$evts_ns1
 	local tk
+	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
+	cnt=$(rm_addr_count ${1})
 	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
-	wait_rm_addr $1 1
+	wait_rm_addr $1 "${cnt}"
 }
 
 # $1: ns ; $2: addr ; $3: id
@@ -3355,6 +3357,7 @@ userspace_pm_rm_sf()
 	local t=${3:-1}
 	local ip=4
 	local tk da dp sp
+	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
 	if is_v6 $2; then ip=6; fi
@@ -3363,9 +3366,10 @@ userspace_pm_rm_sf()
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
 	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
 
+	cnt=$(rm_sf_count ${1})
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_sf $1 1
+	wait_rm_sf $1 "${cnt}"
 }
 
 userspace_tests()
-- 
2.35.3

