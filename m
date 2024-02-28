Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EC24B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106243; cv=none; b=L0GmQu9GEIhVAVzYE+uAE1fydFtZppEObouXDUUB+czr5eIQEJwOwfm4HDOz6WFn0M14wg5Nlpp1qCa/+s6At/Dn+QVyVxXDhH8gJdargDTLuivLiK15DWRaSVz4PDHvV+nxuJYyMowrpGzEu1dDGxDvVrwm9DL+CRukNg3inuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106243; c=relaxed/simple;
	bh=W1H8yVWw9eh/R3qnrPrQbj9dOYNB0GwWBTYOihO2iUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpOIYbOEHDmfAwD7m7S1YKNRV3Sd7nU8udSMJxurv3zGDtNzy8OhtnzZoIL4iAEl59WAgNXCvgP5OpgaSs7VhBZu5m62EMJC0Hc2C3s/tWLPfzOHbiV+0ZOG6/2vI5HMRxWlNNShFCllRaKADir6GLANKSFXtxOBEannTHCjvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpbY4HAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpbY4HAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD9EC43390;
	Wed, 28 Feb 2024 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106243;
	bh=W1H8yVWw9eh/R3qnrPrQbj9dOYNB0GwWBTYOihO2iUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpbY4HAOckKOthDOHOIsMq1feQ6bPB2ZyhJMU1FjcDhpogDzjJVWpoXmwDxH8AAdL
	 4/5ylNAip4mA8LME2PZY9JBd8BlSSYaoC4o6Y9thjUWHWJMuzqzls2juM3wRUOkXAu
	 uBVZ6o5hFIKOmtGQfMG9QofiQUCH+zvsjXY3mpr7gWeHzIcDI4KmGq9k+rZCKDQd4a
	 DQv0UisvF3/I75NPmzehY13h/DSd3hHXfwAnPkOLbtOb8l/Cr3cEqpQw8WYg1EFLfy
	 MsqYTn/651Zy8eV3OwibwPMO0BMv5DpcSKctkR9QupXpPN4lWBXD0ZbkiBQwTFl7K3
	 kBGumO7xxMIBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/9] selftests: mptcp: sockopt: print every test result
Date: Wed, 28 Feb 2024 15:43:43 +0800
Message-Id: <51944c2c405df17d101f0103a3640daaf5c3f885.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Only total test results are printed out in mptcp_sockopt.sh:

INFO: PASS: all packets had packet mark set
INFO: PASS: SOL_MPTCP getsockopt has expected information
INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

They mismatch with the test results:

ok 1 - mptcp_sockopt: mark ipv4
ok 2 - mptcp_sockopt: transfer ipv4
ok 3 - mptcp_sockopt: mark ipv6
ok 4 - mptcp_sockopt: transfer ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

This patch prints more info for every test result in each test
group to match with the test results:

Transfer ipv4                                     [ OK ]
Mark ipv4                                         [ OK ]
Transfer ipv6                                     [ OK ]
Mark ipv6                                         [ OK ]
INFO: PASS: all packets had packet mark set
SOL_MPTCP sockopt v4                              [ OK ]
SOL_MPTCP sockopt v6                              [ OK ]
INFO: PASS: SOL_MPTCP getsockopt has expected information
TCP_INQ: -t tcp                                   [ OK ]
INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
TCP_INQ: -6 -t tcp                                [ OK ]
INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
TCP_INQ: -r tcp                                   [ OK ]
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
TCP_INQ: -6 -r tcp                                [ OK ]
INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
TCP_INQ: -r tcp -t tcp                            [ OK ]
INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ccc941e1e7bb..c2aeb722a97e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -113,6 +113,11 @@ not 0 - not all expected packets marked" 1>&2
 	return 0
 }
 
+print_title()
+{
+	printf "%-50s" "${@}"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -162,6 +167,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	print_title "Transfer ${ip}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -175,7 +181,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	mptcp_lib_pr_ok
 
+	print_title "Mark ${ip}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -191,8 +199,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_pr_ok
 		return 0
 	fi
+	mptcp_lib_pr_fail "Mark ${ip}"
 
 	return 1
 }
@@ -221,23 +231,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_pr_fail "SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_pr_fail "SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -260,6 +274,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	print_title "TCP_INQ: $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -268,6 +283,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_pr_ok
 
 	mptcp_lib_pr_info "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.40.1

