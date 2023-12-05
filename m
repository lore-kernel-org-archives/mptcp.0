Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1214F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRf5bCBb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF+VA+ZcS+SqGL38NaBYnD2qC3xK3bpP/oFN6TX8Mkg=;
	b=qRf5bCBbpqiITw3ehC89zNaVactSQ9VmaPzW4bn1/1M8HDGqYoGegS3lsYGrroAUzIhTeD
	WsR8BNuyR+eiomsmhyB6rCEts2AC7MYMRc0WtqDAcbiKjiPriPJ+4Nvm0/b8UMpTgqSSUz
	xuYNXwdSOZ+IozhbevlFPYfj/rAURkg=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 15/33] selftests: mptcp: sockopt: print colored output
Date: Tue,  5 Dec 2023 15:01:02 +0800
Message-Id: <2a9e85785954222d64cf9f30ff3e8d8f5db50ad1.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use mptcp_lib_print_info(), _warn() and _err() helpers in script
mptcp_sockopt.sh to print test results with colors.

Having colors helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8cee8bc6d6e5..338d48c248c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -209,7 +209,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_print_warn "INFO: MPTCP sockopt not supported: SKIP"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -219,7 +219,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_print_err "[ FAIL ] SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -232,7 +232,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_print_err "[ FAIL] SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -265,13 +265,13 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $@" 1>&2
+		mptcp_lib_print_err "[ FAIL ] mptcp_inq $@"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -281,7 +281,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_print_warn "INFO: TCP_INQ not supported: SKIP"
 		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
@@ -318,12 +318,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
-- 
2.35.3

