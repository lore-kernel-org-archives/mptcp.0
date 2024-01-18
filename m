Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C88F4F
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558349; cv=none; b=hLgejUqKDxkA2EzlbP7Bx9XgvG0soa+7xx2Sq1H1y/SumgtVt8Bjz4t01Qp9ydVhsqL7Wbsq3Z+crv9q418DYfO7b9R6BafvJ7bJa64NHSdDkNlJy64LUK5+8XVsoU+TjcQv6+AovZPb0Ph7rkbKljKDCHN76HY8dIa0jORuqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558349; c=relaxed/simple;
	bh=5k466pzbsTo7vHRUFh3719eMpMsDDPQyCTTC5vt4/Fw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=YMFLp0I9cfUtG44439YI4+T6w95P1rlCFX+a5/pX+x3cZ6rNdn1hjqQ0IkvJCz6sY0NJJ1FRL/WMYhfmiVwEzPkn9DZIakxYyeb+dT/TwrvbD+TqshI/ZNsQYrh9BZdVUEL89tj7OFTywtGPWM+NtnAW1xP5RI+Nx/iDEEc2pMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP0nRtlY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP0nRtlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BECC433A6;
	Thu, 18 Jan 2024 06:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558349;
	bh=5k466pzbsTo7vHRUFh3719eMpMsDDPQyCTTC5vt4/Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZP0nRtlY/n/Au3dT159aqpPLtOjYVOz7yr3ASv6PBO11KZ0+tvScxYDkvYFq1zyUi
	 68lXcpKU066qsd3E2eTciN8FqEeLsJPW/bgBN9U4OlOovb3umLFWYXG9m870icJVrl
	 qs9PbC+Az9aZXquIcAhAHmYvP6STDWosjlWbyrgQSU0u1Tan3nuLATNW0uy+W47WuN
	 379ojvDMOc6yCc7079/L275jayTERRU6XOdaMoU93lYgjP2ym4dbujBK7H+uhVsMGX
	 /FveO3swBYSyYa4fwOU8O+UTyhcjBCO+3slzdu5YTXhg5QFazZM0JwwQfdIclDMkxt
	 rDztILdKU3Cpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 15/23] selftests: mptcp: dump userspace addrs list
Date: Thu, 18 Jan 2024 14:11:55 +0800
Message-Id: <544973adc086c0fff7cd2896ff260434bb1231dc.1705558030.git.tanggeliang@kylinos.cn>
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

This patch adds two new tests for userspace pm dump address and subflow.
Use userspace_pm_add_addr() and userspace_pm_add_sf() to add an address
and a suflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a92fb5469621..cec4bfc5193b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3593,6 +3593,50 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_dump $ns1" \
+			     "$dump" "      dump addrs signal"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_dump $ns2" \
+			     "$dump" "      dump addrs subflow"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.40.1

