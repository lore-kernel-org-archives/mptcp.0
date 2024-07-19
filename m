Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AC83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391881; cv=none; b=OdWwFGLHl3yMyHheEHSEEq5mEGsTIJ3kBPLNp62IYXmIkwIteT5hCY/8d1WugkDEtJbEzAVCnY6bNarHIPiE6RIwRRYSybYoDhW+6ZM07Od/j58Ll/w0BmlQTQwQSDxFC+2Fdz2HbMKRYwEG4ESDeD6iKPF8bl3RFnOpZv+7L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391881; c=relaxed/simple;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPepj3SDNf6LnQRhd5tPE6iNS3JIrLqvGt49XbIlgVfDPhProUfiLoEiD2OyS3uSWd0JkD/JViaUPXCNw10+xuKYnO2jjoezKSbKtvhMZ7Y7dYAezq+z4mON3ITtwxFnBFTy2zCDvceTV5HYp0P2V6XH29UUMlGVOBOFadAK638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+m1ynu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+m1ynu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD71C32782;
	Fri, 19 Jul 2024 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391880;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k+m1ynu6Pht5j1iXLc/ajvHp0d0hKaYWzQMSLnnDYEWXZPJs0LtU5rFevvwMhWT1J
	 He8LFG5Xg7FWtZzP+P43QXgYJibsXpbnEr7y86kjAwC1ULxbd+GvPT6E8TGy+PBvGj
	 iFwFG4jkHIAeIkcSFJlpfSXD7ux/x8upbVFw0Aj2LI3J09Uie9dA/ThcLwYFEEZZoR
	 XrVMDSTENAvwnWmwICWf/TjMQkXz6zIG9F7Ae6p0E5z5RCg/17Q9JCl3FOreM5y63Z
	 fRLZX4gyy2/n5QBq5Y80KUCzcDYTRaJn8ENmIuScwrJxVZjs551IC0MfkiZJkIqNXb
	 UgghpZkZkMt1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:17 +0200
Subject: [PATCH mptcp-net v3 06/20] selftests: mptcp: join: ability to
 invert ADD_ADDR check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-6-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/HmZwdrxp545HnECmitolTzDbJNnrHYCVI
 bEnd9QeUAOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c2J3EADLIDs58rCLSzyukFJy8X8v1B+NOlKS/SMs7envjLRC1BttUGcFHS9vDKY9IK6MTb5ffhn
 aISFY1O6yUbTrnnpXmTlhX/MFieV5wPytVTxtVXBAN/En79vNj7qEueyekwLlZmbQQA8pskxCV2
 Uo/YMVrpOWsSYUi3LAbEG6Jdv7l1jJA2to9QX3RbPu0AOTO7UuUMJtQQifGHqr+3vXbByyZHzZ3
 bwIZeg9soYcDkhY4UkSH1eJeqKWdGPYSKCoz+5KQR5f9x9yWNM6NkJc3rRRmoMJiqHxn6nY+cup
 RC79inf5EnlqV6YslVHFoEYumbuR3XqCWTa4JZIzz1glAtXIt7dKYgtw9+u+2TP5s1sOOUK27zw
 8ModBKpDKA25l4Yexm06utDDJUK7UdBpFmZuh20py02QSuqAfneV8AddUbnlfcwLS3f40tDI/JI
 Al5iU07vC6gP7/tZd27Cf3+4U5CL8u0P6EVLWTXA5STNcWcutyJdHG3MMAA5EYH38ThtCz3RFfo
 47ev71Mn9L/Fi/vSe2nYe0m0096WTwe2h28hwqe/UFPkgYJ/8Z2qegPMIy952K0r9zLuJmL0vXy
 rGKFHJGmdg5Cri+vGDEOYSdb41ME+LJYmamCp3mZ2saNra+JwuAHK5zgAzebq0GO4nvV59QrQAd
 J8I8dXiJ9L/FblQ==
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

