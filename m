Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8B3AC01
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759492; cv=none; b=MNIByBVxTuBAOeMAjRMlD7F3aSk60vIRm9SA6apRl0ORNqcY89U8Quub0BS5oyrhZsF+wDnUMFUSrhOeGezzKKCDvm0ZkfVs26h/22HrWz2MIGYhRdjOY17tJbw9yUoNeOWpVZc+KzzTSdamgUGftBL/ZMW6a5+4zHGkETDRHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759492; c=relaxed/simple;
	bh=z0jPnPHmTKper5VM3qALvmkItjdEIIa+tsBzgqe0eZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxQMwqnZW/r9OwmmSFD0MdgP8wqCyw+wg3EASQoAlykZ36qP0T5vgvcpeBR6/sPY3QBB0rTkpIlBJcUCrZpSSroJkXqD5si16NrzKMtLHoggSOuHzu6/oOUK8NXm4WN3b6mwJdmkgT5Argye6GsNjSSW1EZnm5ZEMghewmZ5+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUmPRRoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUmPRRoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B081C433F1;
	Thu,  1 Feb 2024 03:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706759491;
	bh=z0jPnPHmTKper5VM3qALvmkItjdEIIa+tsBzgqe0eZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUmPRRojTMLniLBpy+dh9AOzrdnsClIhJzA/oswngquAJcB5q2gERTBiWt4LOMZb0
	 WRiX2QIfMyF0xyhwMeW56lBvLmsCjWR+aPS4hOsys7RxEYFNB7HZ3KSH8/HIskWa0j
	 ExSEN6a++asUAplLMdkYSrzzTJ/foeKaOUsk540nefqgaog34goAO0PVZ/IkxNkMui
	 JRa+HrNOnrzO2Jn0WP+6IGLr09uAvs+HInTLePw10oYv6unOwKm6prW9VRGMWXs26y
	 7yLD0xuD8tzjLnfLji1trGwlVDkHRxt24uDP/g0hcy4zoiyJiIQBB278JEymzlosaz
	 9mV40dm4ZDBeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 4/4] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Thu,  1 Feb 2024 11:51:18 +0800
Message-Id: <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706759413.git.tanggeliang@kylinos.cn>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds random tests for both
addresses.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..a3bdbc896c6f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3333,12 +3333,13 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
@@ -3441,7 +3442,11 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 10.0.2.1 $SUB_ESTABLISHED
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.40.1

