Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D28F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558335; cv=none; b=YN5Dz3k/emLZCK+tVvp+OWH1UUZcq9fsx9vYtXfo37iezFhnDJCGu0XEiWfT4pA5yq1Pg+WpIQeR2KnPVBZxNBhk4Ig4wHcHtqUsk50K2ooUlgju5NLCB5aKsC5/9NUB5FjKBKVHQS8YC+cqnz0He+p35x6VDvCqVcMdvfngUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558335; c=relaxed/simple;
	bh=/OB0qIt3eBzgYQ7vAdDyvyp4bI2k1bL58iTq644CVZ4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=BVmpIpxcJRtat9/7WF+B4KgppNn8EMqtKHjvnfbFEQ5Z9M11ixa9Qu3dWvoADE6DuT2B3drlOxm+CMQXok0gQHhLS0JhkDSCZ5Bh9quwp+qGzO70fRc6M9KI0h4h0JLEcvo4oLPnpNlCcdAYYJ5U5Rd0X/s4Cr+c34dCjFxL2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF4dPNit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF4dPNit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40FBC433F1;
	Thu, 18 Jan 2024 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558335;
	bh=/OB0qIt3eBzgYQ7vAdDyvyp4bI2k1bL58iTq644CVZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cF4dPNitYydLvs9nzZkuVNWD5vyle9V1VIyKBT4TIIkm2uHrLbFhjDQpy5CSBEXFa
	 P4ewHNfuA55e51FguUm8zRl/ez564hFTqhn2/AZv5/ksTs7UIys8WpL43gl0BHzlWG
	 NVxE8MngTyjzOLLT0P/3CseC/D4bbxjV7cyJdFOBbfEod31eJXkLP2ZkKUX0Ovfnde
	 8EOWDBy8uFMr3GSIrDBU4CZWs43cqAJ9bVcDPcb7PyhfFswbRPiXV54Evtpa8lNfhj
	 WR6DKNESrhG6SqS9VfNio9pwm7eGHySiLr6Kt2Zufq2Roc6OGpOAebZYWgcj0RRII5
	 PsxWhvuYKw/Lg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 05/23] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Thu, 18 Jan 2024 14:11:45 +0800
Message-Id: <4fb4501fdec6f950e7fece31b78b645235c10917.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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
index 3a5b63026191..915ec79f5030 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3340,12 +3340,13 @@ userspace_pm_rm_sf()
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
@@ -3448,7 +3449,11 @@ userspace_tests()
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

