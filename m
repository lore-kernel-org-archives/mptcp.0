Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE917108C
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676959; cv=none; b=YhJyHmMEnXO4yfANZEDam8LsbVi8odHHDKzZZav3cI3f/7FEoyeD6P0kABQjVsXZRNf54RJP9lVM0eJ6IbGdMj8gwks0q/TCI+PpEvmUsvF12r0OHhBih6M3OuwhDuoCsrtOKTOsXclz2Fb4M9fKIZy6+7oRAK6jnQV+mP6nvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676959; c=relaxed/simple;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWPlT3gtvKdJxceDeq6XqjRsy4V30BbVQgT8S9J+GifLeZxbUT1cEPTE30c+G44FlNhXxPQUWheltK5MkY2oi0CL/KEkUjWfIQ9Yx27SQewQU91mHM54itdokWk1y3QkBr+wZkmMJ/yl/EQmGQH26JV3hiKNSZbAPys/ns1Q/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYhYRrFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYhYRrFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131DC116B1;
	Mon, 22 Jul 2024 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676959;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NYhYRrFxsccEQqC75QNr5YKt73/PyM6amyJ/jcGEywBSDaF3chSx3N/ADWJYuNe6N
	 5A3YwZaHuf2EACjRb+MCPsRo/e3G6/lsAPFb+wKH3TlsAIBIMpzaXQfLhayUIN1fcf
	 ZA/4wPhW7O6zcNevFQIJXJ9+FKR5Mdmowl2UC4+m/RPsVU2odQWHho16njU4xOMRVW
	 RttznnyK2ou/58SRxpRMSOw2kKUZ2LHtHo3J3ggq3yvWmFpZUO5H/Uf1QF9kYSX0LD
	 TJlkPv02tojQtMM3hApDQH2xXCuOHSguo8grmlU//1B27+5aT2fmffyKJz0i+CvxN2
	 k14kwKKEqX9tA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:44 +0200
Subject: [PATCH mptcp-net v4 06/23] selftests: mptcp: join: ability to
 invert ADD_ADDR check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-6-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWQJaCzPBLmHQT98HKWxhIuoyGSq39Fvzcv
 MEzRPtJW2WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 cx3fEADIpoPPu7xdtdsCweGir/5NOQi1uC4fo4ID0U4X0FfvWJZGTBraNx69uHDcRc1VGsx6pn7
 evbnXIIoInx1LVLaMYWVGMEtiM+xHWyGn0LeZheqXbbOeY+ufmaTv7hUaUtbSzjBlY7i5GwY/hp
 n/zl3iVqfo64v8AfmOndfLaQBsP0iKGUjj/hC9zNF/xQy7NaRDAG+Kxco6qdKEu3G72cTMIfc7z
 uyPQQalwSCkpParXc+g4RWRgxKp4UbvmfMHJ3SBhvVXq0oHDWrRctyh1ANbpd56+EYoKOge1reb
 USZ1deRE5cVjUpbMauso2Wfk0HgFc8o51yCzYk5vUk6AzFY7fedYVGcO9E7nFl3UUVrdzz/Cchx
 b4PNtBNgBHD2Y1ELmxtwr21995dU/YForcPXuMfwOduzUKYZb0GqRAYxfnehCdrxAnUSOovy8Ql
 XNC4VaodmtebV04Gt8Ju6ojb8xBcgXkFS+YCBGJPnXKZ2/1sKfOr7Rf90i3T1RgUF4SNAtuJBYt
 7y8LhKC0HiKwsDVYHv7OPkqJk2MVZrF38SyIcdrTvmam7ue5IdxLTf+cy9liEOMwkYYFoOkCfVr
 4NKNQwsmq8uPXaAWQd1L+nNZcDcrOX60RbPp17Fmz1i7IZCN0gTsP/vy2rjgOBEULj87wFIPyo3
 r0rLmglHUHQgmEw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the following commit, the client will initiate the ADD_ADDR, instead
of the server. We need to way to verify the ADD_ADDR have been correctly
sent.

Note: the default expected counters for when the port number is given
are never changed by the caller, no need to accept them as parameter
then.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55d84a1bde15..55ccc4fdf18a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1415,18 +1415,28 @@ chk_add_nr()
 	local add_nr=$1
 	local echo_nr=$2
 	local port_nr=${3:-0}
-	local syn_nr=${4:-$port_nr}
-	local syn_ack_nr=${5:-$port_nr}
-	local ack_nr=${6:-$port_nr}
-	local mis_syn_nr=${7:-0}
-	local mis_ack_nr=${8:-0}
+	local ns_invert=${4:-""}
+	local syn_nr=$port_nr
+	local syn_ack_nr=$port_nr
+	local ack_nr=$port_nr
+	local mis_syn_nr=0
+	local mis_ack_nr=0
+	local ns_tx=$ns1
+	local ns_rx=$ns2
+	local extra_msg=""
 	local count
 	local timeout
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns2
+		ns_rx=$ns1
+		extra_msg="invert"
+	fi
+
+	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1438,7 +1448,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1449,7 +1459,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1459,7 +1469,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1470,7 +1480,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1481,7 +1491,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1492,7 +1502,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1503,7 +1513,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1513,6 +1523,8 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
+
+	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()

-- 
2.45.2

