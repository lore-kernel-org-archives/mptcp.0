Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3E18629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038209; cv=none; b=TgaHKOtu+TuzRaufviyhpDSg+H9RHo1dEAjrKq+QUfDRhjHHK02ZvD8UU4CqxZ4A9Ni7FxBx2fGT1hl2KIx724fgFCE2f7kEA3bmJ+aCy+/CqPZGeg5dkRT5IiJxL4j8SHsIxMl39icjlovvd/Hc94YY9UU3rFl2grLLceW2nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038209; c=relaxed/simple;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAndwRtpjCK4llhq+6YHgOLBPqv56e6vploR9rrX6YOymtdN+jkHiByfevWXhPAk4HuUClRgWMrvO3FuyvEXpPAmpAj6M4MDPw2cFnML+tjGpE2mhXOWOs910SH+trf47kH+JbAfkL/Qme63Wyz5RXXSKZMPHZmHq524p+AFa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt7OrSrn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt7OrSrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518F9C4AF0A;
	Mon, 15 Jul 2024 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038209;
	bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qt7OrSrntnqrU8zJzZw5GYQyIWus8OMUId3ghXHSbwkP4ByO84QX8xmyM1NSdJuBL
	 Mz09Q3EpMFt3AemzQ43/cUL1LQRxrEcqCCeg6sroFRyEHzxdtcijqaieA72sjiyZw4
	 epNQfrXNR8CI4lFVzXrTIm36MXT5IgOrhk0husCaDzAbjsSB6NCkaCihSzz5iZ0p43
	 Hfi7OVoC7w9COXz0joXcW42+lEYany9KyzD3J/oiw/l5JK1dsAFAe+JNB5PJlei3ay
	 hK0ifTMCa2FJxmd0MJz0s0BTUkOKj+OlTdg7drtbuGBSH3U3/R/eDHhxPfxlJA/spS
	 23lOojd6W/VSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:44 +0200
Subject: [PATCH mptcp-net v2 06/17] selftests: mptcp: join: ability to
 invert ADD_ADDR check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NAhjnJLuFDq3Qif5cnScKlPlgz1s2euUXNeowcShoi8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3r+yXGbH637dRiYDyhtiYKRX4kvO95kTCH
 Nbh/27jprWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 czgLD/wKQUdJpOoiIGOSdV9AUUC4s6SSuF+SRMHeCDudgAF6omrQonv0fZwTBGpGdl3f9Bj2AQ3
 riMlcKquxTnk1ipiq1Bshs2gR8w+W65JobRC5yEaFy4kgIMdOiZA77FdDRKv6dSf52Sl5GyzvR1
 8+IDD3v1ldxXQ5Ve6usvVXoty7GNnCNmeTEZgtdPZUIPYmN0Y0rNFWgsA/jnXNREv1+4bsTZY6t
 QFV53OXIh6nx5l1R1A2GYwYpXYMxTXrPWz7f1ggMrIyQzSN1N6X01vhCmMfzrckcGJHpaBuYKTf
 Nug0D8/igxDPycZsg3Y4UcZuXmJcdXQO9g28GG5DPf622vJTO0Xzc5MP6gaokpLFqWZcVpROebL
 mVoNtw2H3FxuAmaj5kVW173KzjdYvDACHrALkc9iLGXr56cCnKnXM2veYvyPWS3P4lxYBQHiwbd
 DvZAjC65g/2F95xg1Jv4LaSIq0JrJkxvYWnvPqL78o7kz4wOPy/ER5zUSmxpgZ/yGXLRAA4OkkZ
 T1iVi5fve5Y48Pwz4LwlrRNMcDY+YdUoSX0kn2pNYHUakeJNSpVEzXtfUFQ64/ww3prvbQojC56
 Zz92qMiVVfalRUmadJ3Ju2+vjkKD3+okzWXY2FETkR1ASnhzBEIq7ZvhYi8OuCUVcchgIH5gNaB
 +327QVQFb7pDXvw==
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

