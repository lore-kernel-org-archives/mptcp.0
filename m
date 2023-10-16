Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676515EBA
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VIpktDha"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697441027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKbra8FNzhZFX6d/ectQwvnFj0yJ/7rECU5VKdxro4I=;
	b=VIpktDhamewNfbgo0JcR7/xvfKaH7U6syYUsoioQdCLwVApszkE+kw7qyU27DKDVTjq5jF
	FerK4OyjkfI3IGrMrVzsAzQbaCqnByyw9Xt+2u+8OOHjF1QxyGp7hVnmzR8gwOFYlyzd92
	amZZdj0usZDyhfzu4OrsxY8eb5wW6MA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: fix wait_rm_addr/sf parameters
Date: Mon, 16 Oct 2023 15:21:23 +0800
Message-Id: <6b2e6b713d130a23e1c103acaba5aad3809e93ba.1697431973.git.geliang.tang@suse.com>
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
index 1fc33bb3aba1..b1386b07e312 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3311,12 +3311,14 @@ userspace_pm_rm_addr()
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
@@ -3342,6 +3344,7 @@ userspace_pm_rm_sf()
 	local t=${3:-1}
 	local ip=4
 	local tk da dp sp
+	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
 	if is_v6 $2; then ip=6; fi
@@ -3350,9 +3353,10 @@ userspace_pm_rm_sf()
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

