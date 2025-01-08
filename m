Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A4201264
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361651; cv=none; b=u3/bseTUr57jOo4FQGdce9MTC5qj2xhZF2pX+zfJTiNHllSsc46yNo+gQlhJVokyxYKEfDA9nMU4fgqej8TzkcnHiK1dZeQThHH9Lqz7jqYPQ34yfVkV+8IfSPvmfD7nT5H2K44fbcfkk8tO3bN9PG86rl9pbnt4ORqCE6d3IwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361651; c=relaxed/simple;
	bh=Ecko4f3i6j9yEeSjVkzAmdTOGM/LUREIPjpZDI4Qxzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbPJXQu0ha23E7Q2c04bQMZmQPw20qNmgBaogqtcBiKKp/aGYsBIjU6GNfnDU0Hd8DYmZKr1ACbd2K38VYl/PcqXesf3d+p+AvH6WSOIVN6tIgpiEQfPLhC8co49/pKYNFarD5PZyjhG4sai9a+QEiSxAMoVIND5Q2Ml23wtJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ/N2X04; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ/N2X04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7297C4CEE1;
	Wed,  8 Jan 2025 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361651;
	bh=Ecko4f3i6j9yEeSjVkzAmdTOGM/LUREIPjpZDI4Qxzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OJ/N2X04C3P4uVXQMja1FoSoQTg/7N9ehHS2KjASS8jMeJZUnuYhRLwldKzXnTEa7
	 1ADEZlOWfn6EBqZPOM1VJ4R0gzuyfBkOGCXZ5V72czUiO1cwEg/v1Edj6ljsHHUX9L
	 dRupez0w3gadBC8fJrsHGAOR9FE9p8B+nN7zEDfFy9MpGDEQ73LgRkbaZ5fbiVgXL/
	 jenH23Dou68sGl3crBO5TmdYgVWTHhaA1fwjCdygtdq+iOnJG6ufwlhdKwrmOl63aT
	 ZD0YVaMIbtYR9TSJGKA/A33gVNpVgGBAm7ZMXFlR6Zpl96ynEZY7oqdz5SSY7peS/o
	 Ibr4nmjUREcNw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 19:40:38 +0100
Subject: [PATCH mptcp-next 2/5] selftests: mptcp: move stats info in case
 of errors to lib.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-2-bdfbdba48a1f@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ecko4f3i6j9yEeSjVkzAmdTOGM/LUREIPjpZDI4Qxzc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsaw6fL/uTAvmLZdpHs+Rw5eZRbOZFbG9lGti
 MHOloGFALmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 c6JnEACQpaLyQGKr8IvZnEov+gGk7KtfxJPRywzHW2FWpYTb+jaSdNRWgORUWgdaMCZbjTvR7px
 GvGZfk7pRuCOV/jKOuL86CPpmNsGM4tdSl2qXDoe3TOW/Bd0fiPUJpQqFtu2Xjy0aLOwxCXmjWy
 aAD7fTHcpFRASAXsajuGWBVwRSCGA8FfFxussW+4bU84WbM30PcmIimEenn/KPKI1UYixm/zdal
 lIHQMYs0SE+08Og5iRGC8SnMC5ronoE5Vg7AIGilkQe5+HEcEGG+4gqATd4ovFZklyDlmPJz5Ke
 gfI212xFZD613Kozbl8QIHDyVrTNwo582Qn7anrkHlbQqfGmIYlZt3YKjEZFzQyTgIXPl5GSrGO
 suvoDC7cBC38n35CRXX5p7+xHVAwgkSJfQZIRQ+PsWiFNQ1SBF1AXL4MgFtyYCjX9qRdE6INEO7
 ozcKATBWpV/89fHey3NS41MC+lly5QoOSCjRgrkLZu6rFRXCuXTUOpKFyGZ+pnYfSyL/NP0uU1X
 i5+SJTleKtvimhVstXyXTmpmjvhumrjTKk1mXCoOF2Py9tftbAW5MS5aibCloXyFtz1l8iu2JCw
 78YOjn47BGRD355Wf7sdM74juulPRXsLR+EvH34GN1s/259n2KE+yDMVqE2zFGE+0dMD8Wd7lGH
 khKpwy/DF01bsfg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few MPTCP selftests are using the same code to print stats in case of
error. This code can then be moved to mptcp_lib.sh.

No behaviour changes intended, except to print the error in red and to
stderr, like most error messages.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 ++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++-------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  6 +-----
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  8 ++------
 5 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b48b4e56826a9cfdb3501242b707ae2ebe29b220..bfdaecd0a6a0564020530345daf91bed296bc15c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -445,12 +445,8 @@ do_transfer()
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-		cat /tmp/${listener_ns}.out
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
-		[ ${listener_ns} != ${connector_ns} ] && cat /tmp/${connector_ns}.out
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
+			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
 
 		echo
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07e2bd3a315aac9c422fed85c3196ec46e060f7..13a3b68181ee14eb628a858e5738094c3c936b74 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1039,13 +1039,8 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-		cat /tmp/${listener_ns}.out
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
-		cat /tmp/${connector_ns}.out
-
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
+			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
 		return 1
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 975d4d4c862afff2e685e86dc08a892dbd09d783..50ca64357053b14cd4989e6647d825337978fdba 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -107,6 +107,27 @@ mptcp_lib_pr_info() {
 	mptcp_lib_print_info "INFO: ${*}"
 }
 
+# $1-2: listener/connector ns ; $3 port ; [ $4-5 listener/connector stat file ]
+mptcp_lib_pr_err_stats() {
+	local lns="${1}"
+	local cns="${2}"
+	local port="${3}"
+	local lstat="${4:-}"
+	local cstat="${5:-}"
+
+	echo -en "${MPTCP_LIB_COLOR_RED}"
+	{
+		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
+		ip netns exec "${lns}" ss -Menita -o "sport = :${port}"
+		[ -s "${lstat}" ] && cat "${lstat}"
+
+		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
+		ip netns exec "${cns}" ss -Menita -o "dport = :${port}"
+		[ "${lstat}" != "${cstat}" ] && [ -s "${cstat}" ] && cat "${cstat}"
+	} 1>&2
+	echo -en "${MPTCP_LIB_COLOR_RESET}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5e8d5b83e2d092879efc179f1a450542be4e575e..6b366c604a9eeccdb759f260be4feafc380ccb0b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -192,11 +192,7 @@ do_transfer()
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e98e5907d52c2d0e9c0152efda82176861905cf1..9c2a415976cbf7a0b56cd4b2fbdd36c9e1ef3c8c 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -204,12 +204,8 @@ do_transfer()
 	fi
 
 	mptcp_lib_pr_fail "client exit code $retc, server $rets"
-	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
-	ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
-	cat /tmp/${ns3}.out
-	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
-	ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
-	cat /tmp/${ns1}.out
+	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
+		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.47.1

