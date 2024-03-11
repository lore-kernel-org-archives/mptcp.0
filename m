Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEEA35
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121737; cv=none; b=G767b59Jwpn31sMiHNlCs7NDd8glIZBZulyD5VuSVP6GW8Dl86+9qeDKyGBwPdJRF1+hUyN4wT9gl0+IUqEgGjUmgLEFDDYhikyu4tsf1K8yB0Pm+R/ihTJuHRB4H+NtoyemetYV3qTsx+gA2x7rvOArk5nn8Etb5OVByOW3Sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121737; c=relaxed/simple;
	bh=t0PjEkHGrF3beQen3geQkEdYiBkumvUszEWKhEn2UGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syxijrq1caQgBYct6GZh/afHmF0UFaSzOZAsCRsGxldvkuN+CeHpLjVtwIpU/Kji+qfhoSzMzqehqUB8+mvlKa0GYKrxJkhmdgDPF5i0zshOAxWU0BFcKsGT3EFs2JWk/sY1kYDAZz4dxRm1QSIYzuXic3TJlk1e9/3/M+Ap7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS1/4SA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS1/4SA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4B2C433C7;
	Mon, 11 Mar 2024 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121736;
	bh=t0PjEkHGrF3beQen3geQkEdYiBkumvUszEWKhEn2UGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VS1/4SA1YPSIwsjStecMaja/NkK2mHVsZvURYJbjwdk9ogN7y8P6TwGKnjiRH0Ivk
	 Dl816LG9nzis0dc4Tr9xe2FnApjugikPIUwvF1YRtBr4roImGMyqgNcd38cdxVRl/f
	 P4vcwPXb5cXxrFuwLR23S6WsYKS3CWr6q7pyTvzbmi1mY27zXTKEyPcXY83/gMLuor
	 bLD/u5CH6/DiW2dBBJxjuVEShfI7XAysOc7BHwHxbQPiWPAs/OGIXOpwGAJJegIZch
	 arYB5EGL2pJF7C8/+ECrZwsmYBPZZAZnGPLdXkdte9illCYl9KvDPHAWTQjD/czcgE
	 b8F/MpUbbgu0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 02/10] selftests: mptcp: get support for limits
Date: Mon, 11 Mar 2024 09:48:39 +0800
Message-Id: <fe6ee65c22c22e0b2da067841a4226cf8093948a.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There's only 'set limits' ability in pm_nl_set_limits(), this patch adds
'get limits' support for it as well to show the limits, and rename it as
pm_nl_limits(). Then pm_nl_set_limits() can be a wrapper of it. Also add
another wrapper pm_nl_get_limits() to get limits.

Usage:
        Set limits - pm_nl_set_limits $ns $addrs $subflows
        Get limits - pm_nl_get_limits $ns

A test for 'get limits' is added in endpoint_tests().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7fd32f645650..8eb5cf54ea42 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -603,19 +603,34 @@ kill_events_pids()
 	evts_ns2_pid=0
 }
 
-pm_nl_set_limits()
+pm_nl_limits()
 {
 	local ns=$1
 	local addrs=$2
 	local subflows=$3
 
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
+		local limits="limits"
+
+		if [ -n "$addrs" ] && [ -n "$subflows" ]; then
+			limits+=" set add_addr_accepted $addrs subflows $subflows"
+		fi
+		ip -n $ns mptcp $limits
 	else
 		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
 	fi
 }
 
+pm_nl_set_limits()
+{
+	pm_nl_limits "${@}"
+}
+
+pm_nl_get_limits()
+{
+	pm_nl_limits "${@}"
+}
+
 pm_nl_add_endpoint()
 {
 	local ns=$1
@@ -3578,6 +3593,10 @@ endpoint_tests()
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
+		print_check "get limits"
+		local output=$'accept 2\nsubflows 2'
+		mptcp_lib_is_ip_mptcp && output="add_addr_accepted 2 subflows 2 "
+		check_output "pm_nl_get_limits ${ns1}" "${output}"
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 &
-- 
2.40.1

