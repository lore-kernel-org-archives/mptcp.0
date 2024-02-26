Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151622EFB
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940613; cv=none; b=iMEz1ieGfrwIXvmz7LJeWgpiR6eIBxkEcMdQ6MCp/XR4KCDK5T9eDOngGsmwKj8D7CmV5FrMOiN0itts3uZ44o3DzTMSduIlI2Nnf44/HuzetmslSSL5w/1sP6o93hZge6pRRm67M75+S9QysrbFht8FPIWsxbYw0oh8pZZXMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940613; c=relaxed/simple;
	bh=LTtlVZgYotInA94KDfW/ER+WgCskEZLdprctLQWWxEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RS6AJ4utPu5JyxQbivjdBwkw9Zfqj1dAjxE5I6oMU13Cyjicf0MD3a60Aow8I4W43GwLv8xbUpqLmv9dejxz5hKxHry6eBLCVsm+zhaZNs3l/NpaH72+fOAA2i1eS8URkImQQw0W2vNE55S7edZ5Rmi761XdsUwNlO1B7U7kUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/SXTxE+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/SXTxE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80FC433C7;
	Mon, 26 Feb 2024 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940613;
	bh=LTtlVZgYotInA94KDfW/ER+WgCskEZLdprctLQWWxEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/SXTxE+IdZfBjTbNhaRwkCXeJRq/sRz6JYoFKNr3pswIBHecv0vtSSWOf5gxg8Qf
	 QVa4J5/Ws/smeYdn3QtL4QKYQ5rmQvvkdXxCj14cFpaOyfDnRdHhA3TGMUEuPuAbmt
	 iPxvxhYAnb0JCzbV6Ny8GEdU2vCFf4c0+bVFJMna3au2Qk1ohJa7kBYM1yAvUnYL0m
	 FG9zFw5UohuUf0S3C7zG9C7gmecYNp1A8erGCgy3V9KLAYdIwSwKtMBsZEMN+SoRki
	 X9UknsDZwUz/3Ym4WgkSgJ3CsreIJW4UdpZDZl/1NdarsI9LIqt8EahgX4tJlnPLXy
	 xToJ4/jdHgt6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 02/12] selftests: mptcp: sockopt: print every test result
Date: Mon, 26 Feb 2024 17:43:13 +0800
Message-Id: <1aa6a9af7ebd8690e595bfbbdde5f54f684f51e8.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Only total test results are printed out in mptcp_sockopt.sh:

 PASS: all packets had packet mark set
 PASS: SOL_MPTCP getsockopt has expected information
 PASS: TCP_INQ cmsg/ioctl -t tcp
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 PASS: TCP_INQ cmsg/ioctl -r tcp
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp

This patch prints more info for every test result in each test
group:

 transfer ipv4                                                [ OK ]
 mark ipv4                                                    [ OK ]
 transfer ipv6                                                [ OK ]
 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 sockopt v4                                                   [ OK ]
 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 TCP_INQ: -6 -r tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp
 TCP_INQ: -r tcp -t tcp                                       [ OK ]

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..f84185b5dc9f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,6 +161,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	printf "%-50s" "transfer ${ip}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -169,12 +170,15 @@ do_transfer()
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 
+		mptcp_lib_print_err "[FAIL]"
 		mptcp_lib_result_fail "transfer ${ip}"
 
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
+	printf "%-50s" "mark ${ip}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -190,8 +194,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ OK ]"
 		return 0
 	fi
+	mptcp_lib_print_err "[FAIL]"
 
 	return 1
 }
@@ -220,23 +226,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	printf "%-50s" "sockopt v4"
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
+	printf "%-50s" "sockopt v6"
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -259,6 +269,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	printf "%-50s" "TCP_INQ: $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -267,6 +278,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
 	echo "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.40.1

