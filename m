Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649AA50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689267; cv=none; b=Gw1Im0uEiy5zvqcXbHGI3Vswyn0fJl+GipEXgJp1bVN8Mr4T/jmP8nRCWwaxGbDKbtii0nvuCG5+AQu5c77KGworvR15Tej3UgeJkTrkqcAwpVWfaTBOD+gy+LZiqn5UACRq5B6appZBmcJ0/aGIfVzTOYHKLJcAqo0ONG9wtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689267; c=relaxed/simple;
	bh=9d8uvpRp5lhOrF8UXUVmQlu9GUzoSI6gHUtZ6xn1zvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mo/xJv4fSsBoaSwh7E0kn3sv270YuoYxmvFPwg81IH992Du+8Fl1lpSwB1XgVmeqDQNUirDFULmR6AQngdEw8pBgo1ytTETXc7UQDBrzKMvvOeifJl9qSLvtNxblzKxsfhCPujikM+uaU41YHK+3YbMLsTCSixoBGxUrHC0BYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQEuj028; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQEuj028"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9A5C43399;
	Wed,  6 Mar 2024 01:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689267;
	bh=9d8uvpRp5lhOrF8UXUVmQlu9GUzoSI6gHUtZ6xn1zvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQEuj028IoJqWp3OasYim7aS26ndyc0jnvSaMJ6zJfcHXu1D23bKdFanEcZMraBAK
	 loU6Gq0JRFzjY8ZJsHUZYeZhOYU9zxbQIukTnfgFgN8tIyyDbaQEM5j6mZkGx4hU1E
	 CnBoWKBoBLiy4Gh3sI1RVhgzx4foLknoMVflmRsdNUVO42BM8XFIjI+OaawhY3c/HM
	 y89iNAIBbNBT3gPYentAKX/3/rzLb5Ju/mtpq7WwgLkTaj+Ovd/B84/U8tFYSF9ajw
	 lKw/gJE77v9Od5uwO49pasOSZZQGSph2+3iQwYZRxw5LCC+V9PYAtCA7hLNq79EnfC
	 2x02mRxMHzm6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 1/9] selftests: mptcp: print all error messages to stdout
Date: Wed,  6 Mar 2024 09:40:51 +0800
Message-Id: <ea8d6b1bd2aeb7bc365cb0d04286a4e420c67a26.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709688778.git.tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some error messages are printed to stderr while the others are printed
to 'stdout'. As part of the unification, this patch drop "1>&2" to let
all errors messages are printed to 'stdout'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    Drop one more 1>&2, and update commit log

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 11 ++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..679e366c8f6b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -294,7 +294,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]"
 		ret=1
 
 		return 1
@@ -470,13 +470,13 @@ do_transfer()
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
 		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
-			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
+			"${stat_synrx_now_l}" "${expect_synrx}"
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+				"${stat_ackrx_now_l}" "${expect_ackrx}"
 			rets=1
 		else
 			printf "[ Note ] fallback due to TCP OoO"
@@ -721,7 +721,7 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		echo "FAIL: $msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
@@ -810,7 +810,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
+		echo "FAIL: ${msg}"
 
 		final_ret=${ret}
 		ret=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..7c70b52e63c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,7 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			echo "FAIL: got $tables $values in ns $ns," \
+			     "not 0 - not all expected packets marked"
 			ret=1
 			return 1
 		fi
@@ -162,7 +163,7 @@ do_transfer()
 	local rets=$?
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo " client exit code $retc, server $rets" 1>&2
+		echo " client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 
@@ -221,7 +222,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -232,7 +233,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -263,7 +264,7 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		echo "FAIL: mptcp_inq $*"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
-- 
2.40.1

