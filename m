Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFB13777F
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969969; cv=none; b=WTNk9fabWoz1c6Zw59tOSlgmjG3w/0DsQvbDElPGMQBRHRkn/ThuNT+zu572PfHi3wGNiWgKuWKMW+SjT5jCxy9N5yqbw7lvlWL+soLZ1DpIJma8muvboa7X0vllemWl9iX7MFa6vHjRH6RDaxaT8sl89AX56deY6WqOF1UEpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969969; c=relaxed/simple;
	bh=bxESA9RyE6Q2GVZhl2l+RPRIRfX3gqlM6Uy/yG+YhP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX0CHidksFSoN/ft/gynu8BTLuMgiFB3Aw2Kbo1fwnz+fCSyz0/NOsCMOTNN+atNDwKdeG9sXaDHEKgvJs95mWk3exhecY172gVen4GbphL80I0Qh1Zn5V2yIuT6gksXWYG91Z+iaVk/JQrD8GbE34nhK3+lroMoA0h5LwDYEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDzG9Du3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDzG9Du3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A40C4AF08;
	Fri, 21 Jun 2024 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969969;
	bh=bxESA9RyE6Q2GVZhl2l+RPRIRfX3gqlM6Uy/yG+YhP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rDzG9Du36kvxGYU5jjDCXGluoceNUTkL247NFMPn9P3AruezZcEEPVyqwZrU8IgVo
	 F5bFXv2eYtmc6cvyIFsKFqeQ7deUWfV93F8Hk5rG5MfG50M3ncg6puc74DwCMUYThq
	 b74C2t/PXGAF24GIOJuZE0p82Wwjm8gHZ6Na/ITwGGAO0irGQ/EFTXYVso0+cJ0LsO
	 zCFDF5LHa9iV1eXnPOy07FDzAV+eBiF5rlWYMBXNhQog7vYN3NtRhU3my2c2eGm68R
	 y+7QAnnoIu5FwxTpm3ER8BEhvPGuKo2KcURViDJCuDkkbqABORg44gmgvyEcFDNBzR
	 Xo9KEALX8YOMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Jun 2024 13:39:09 +0200
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: join: ability to invert
 ADD_ADDR check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-mptcp-pm-avail-v1-3-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bxESA9RyE6Q2GVZhl2l+RPRIRfX3gqlM6Uy/yG+YhP4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmdWZsUk4jyDc+BC9suK5cCyIWtQ/tK3mujwWxE
 8r0UnEaWkqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnVmbAAKCRD2t4JPQmmg
 czS7EADe30JNmsSyN+wp6pqmDYYHEErlu/Hi7Ya7UCWUKcge6UH05XKOFKT5uKp84UOYYRq1jTI
 y1CiHfd2ydyYFR26+xfLQlGdkMfKqDQGZsCgg0t/ni7BfK3q0fIZzK3wXwTPVUsbcdmrhHH0Vnn
 TeOd6ePp4E9VDzCC8/6Ogw1C9FRu0DYjF9glMCPWjWc9Z0lLzwZn6ra7C4nggP/3wwDjcF8WQy3
 cxyuKa40SQVIYJ+YCAH1ZSqjhXHDJ2tfETEvXiGvkouvZKnSYNOPz0bRLNdnriq1Hv9mPaj/tDo
 7MXkosgluZnip4zuqIIhsF9YBfpoZm/OebiR5MNrXSzibPFQEGNlIHPVp33Jp2tc8Y6+9mKQUdw
 7MRifurddvdcu2fWGZYWDHQ6ncS5cy/TU67ZDWbAzk6vPwaO0oT+u3yqdRlvIsDPOKC00RJ/34a
 LRPDVkswKi/aN3EG0KFZS2Gwb0T8F5mzlD3RSzr8t4psy1dmfq28+/LfnAoDOM/ZWS8I3zUpa5n
 vy/K8Bkad8efa1jBUgWRo36qz4K93Wd/MvJufUwRdr3YgapyaIdkNvuB3KmvvSfkUSzsuUwTWpN
 eAHD6aIJ71Qey1qd/p0VhP1N16xpiO56JpYIbsFcKFclBHhJwNsHxob89B8UKVkJn1oWNq5GHto
 kW915PyzETLeFfA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the following commit, the client will initiate the ADD_ADDR, instead
of the server. We need to way to verify the ADD_ADDR have been correctly
sent.

Note: the default expected counters for when the port number is given
are never changed by the caller, no need to accept them as parameter
then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 108aeeb84ef1..5f5e498bbb75 100755
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
2.43.0

