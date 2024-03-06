Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7C2CA7
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689278; cv=none; b=GZoWEsQGDJDuf3N8NLLxJoS1guSfGn1/IBei6/PHMufLaN+dG5B4bRuPT4xOwn4RSkd5RoBxDCLsjOHEcWPJN92HyKXXhqdpKReIaAVKHu8gxJUuwkfmZARhBNjaM4qYn9bxm5b7wvrm8PzRSMfhAasI4uxIA0bTGNVI2WSiSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689278; c=relaxed/simple;
	bh=7+sKE/4BB0jXEdrey0Qt8KdrpmXIgZojwkQHjF7Inus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlzCqGJgSgW4bLbytu2OjonPNTo6MZhnV+ZisgVougysuzrbVNYaFJmjzx+Trw30XDsSfB55XXHAGRLmfQjHDXhxrHhoHdubSaS0fk9DiURL7CrRkQKSUDpZBJwuYwlhfD7zx4M0WZ9S0jYmAsCrconMtBP8syD4ge4as7uQzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyvBCcjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyvBCcjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883DFC43390;
	Wed,  6 Mar 2024 01:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689278;
	bh=7+sKE/4BB0jXEdrey0Qt8KdrpmXIgZojwkQHjF7Inus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyvBCcjXqEFR1JEYMMSicwXelWfMiYjRgXGQ07Ke44kzDssCJcFCC+pazUA91GbRB
	 B7N+CkUfdSzOAWUavivbwMJbCG8rb+ie0L2BLIr/8FwufU0ThzKXmpBc4Ml4J5DdH+
	 GOt86fN0YAPJs7zJxWzi3mM1Fj7q1oCothnwU+4z4NYOnFm0Cm1XmYjyIo3nhnlSKf
	 qsd0gSXBjQnfBI2hRT2vbFnFGCo2/6DC0n+Nmi1B+BCZIR+OxFDTOH/Wulh2qutxgV
	 DHt3pKI0XJ6Fgn5kqNRHKm7UJBZ3gojw7xq01OdgWVKrfsXEqka+WWRREWn7K/ogMV
	 CnClMSrVhnyDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 8/9] selftests: mptcp: connect: use += operator to append strings
Date: Wed,  6 Mar 2024 09:40:58 +0800
Message-Id: <137ba87c1e7e57ca849323586e4414ae000e5c89.1709688778.git.tanggeliang@kylinos.cn>
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

This patch uses addition assignment operator (+=) to append strings in
mptcp_connect.sh.

For extra_args, use += instead of open-coding to make the statements
shorter.

Add a local variable extra in do_transfer to save the various extra warning
logs, using += to append it. And add a new variable tc_info to save various
tc info, also using += to append it. This can make the code more readable
and prepare for the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    fix checkcheck error:
    
    	printf "[ OK ]${extra:1}\n"
    	->
    	printf "[ OK ]%s\n" "${extra:1}"

 .../selftests/net/mptcp/mptcp_connect.sh      | 50 ++++++++++---------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 684c24aba21a..d99e4ba96343 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -324,15 +324,15 @@ do_transfer()
 	port=$((port_base++))
 
 	if [ "$rcvbuf" -gt 0 ]; then
-		extra_args="$extra_args -R $rcvbuf"
+		extra_args+=" -R $rcvbuf"
 	fi
 
 	if [ "$sndbuf" -gt 0 ]; then
-		extra_args="$extra_args -S $sndbuf"
+		extra_args+=" -S $sndbuf"
 	fi
 
 	if [ -n "$testmode" ]; then
-		extra_args="$extra_args -m $testmode"
+		extra_args+=" -m $testmode"
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
@@ -508,39 +508,43 @@ do_transfer()
 		fi
 	fi
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
-		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
-	else
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
-	fi
+	local extra=""
 
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: did not advance"
+			extra+=" WARN: CookieSent: did not advance"
 		fi
 		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: did not advance"
+			extra+=" WARN: CookieRecv: did not advance"
 		fi
 	else
 		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: changed"
+			extra+=" WARN: CookieSent: changed"
 		fi
 		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: changed"
+			extra+=" WARN: CookieRecv: changed"
 		fi
 	fi
 
 	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
-		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_synrx}" "${stat_synrx_now_l}"
+		extra+=" WARN: SYNRX: expect ${expect_synrx},"
+		extra+=" got ${stat_synrx_now_l} (probably retransmissions)"
 	fi
 	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
-		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_ackrx}" "${stat_ackrx_now_l}"
+		extra+=" WARN: ACKRX: expect ${expect_ackrx},"
+		extra+=" got ${stat_ackrx_now_l} (probably retransmissions)"
+	fi
+
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
+		printf "[ OK ]%s\n" "${extra:1}"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+	else
+		if [ -n "${extra}" ]; then
+			printf "%s\n" "${extra:1}"
+		fi
+		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -866,8 +870,8 @@ stop_if_error "Could not even run ping tests"
 echo "[ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
-test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
+tc_info="loss of $tc_loss "
+test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
 
@@ -878,17 +882,17 @@ if [ -z "${tc_reorder}" ]; then
 
 	if [ $reorder_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
 		tc_reorder="reorder ${reorder1}% ${reorder2}%"
-		echo -n "$tc_reorder with delay ${reorder_delay}ms "
+		tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 	fi
 elif [ "$tc_reorder" = "0" ];then
 	tc_reorder=""
 elif [ "$reorder_delay" -gt 0 ];then
 	# reordering requires some delay
 	tc_reorder="reorder $tc_reorder"
-	echo -n "$tc_reorder with delay ${reorder_delay}ms "
+	tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 fi
 
-echo "on ns3eth4"
+echo "INFO: Using ${tc_info}on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
-- 
2.40.1

