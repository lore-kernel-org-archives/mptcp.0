Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6634DCDB
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839709; cv=none; b=IB//pTEsh467j+xdL3r8NJ6zxBh6cKRZ5dRTOSymVK96Ed2Yu5wiY9X/RHOVsfFvsYjiDZ/wWEA+M1SovpHmavSV3WbQWn8RnARk+15WcsG3/0K/CS+B+6LSnVaFVydLPGpjUCba6nzRdvEUG470ZMv/0iYv+5/zmyIfhtfxZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839709; c=relaxed/simple;
	bh=sHKqM0o2iDFhGk4iddQv9GLLvlPoYl+gaS4DteXNi38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5g+wstxc5/L7llhYEze9KSRdIMI/duXZSZmks1xHeG/wTOLvBiuLELLWZhOZw9ohxQApvsGqAWxmkbJeyGtMbTul96wuEiagt/DQChBOD/s4j9J9EEU4YQO2vjp2IBslxNaZRpSFsLnmKxm8/Hr8fr1ywchSeLzdiAQyReGCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxIO/0eI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxIO/0eI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB2FC4CEED;
	Tue,  2 Sep 2025 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839709;
	bh=sHKqM0o2iDFhGk4iddQv9GLLvlPoYl+gaS4DteXNi38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AxIO/0eINN2oMHjPMfQcVEdBQ4sXQpGCRrlIUeK5+5BxCiVv4L4HB+g054BTKnPV3
	 yWKesnGH4bFLOOMiQeS56ZbzisqlOtxcvfyuyE9Du3V6ilAoL09jz0WDv8+bliDT/D
	 yi+V2/zJcbIpZEpiebfERym4GSJqVEXkulmZaZcmAJjpDkGczRz6i03pzCIiIYEZ58
	 XlS9Ow+uJl5basoeeQfiFxIYJVf1l4CJYkZxCDhM8cCOT4lc7A8vBnjPA8uZJUpEZE
	 catTs0W57vRWM1i5hi5M1sfjHPsSQEUeGd0Aqg7kdTRCpC2HPshjKFIv7uwVYPo/2b
	 e08KFlIhXyzUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 21:01:39 +0200
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-2-956a315d6a5a@kernel.org>
References: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sHKqM0o2iDFhGk4iddQv9GLLvlPoYl+gaS4DteXNi38=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK220ua3/0duU1V0fOieD53WHfhu9f3r80Wso35LRvyy
 2OruOf9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImoLGBkuHAiL64zwi7gdqp4
 7bsgb73LOdte786X0yrtfiubZOvOz8hwUOdI51OZnhVV6/zObmLf8pTpTz/bVEk71eYVaXFu25M
 5AQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ADD_ADDR can be retransmitted, and with, the parent commit, these
retransmissions can be sent quicker: from 2 minutes to less than one
second.

To avoid false positives where retransmitted ADD_ADDR causes higher
counters than expected, it is required to be more tolerant. Errors are
now only reported when fewer ADD_ADDRs have been sent/received.

An alternative could be to disable the ADD_ADDR retransmissions by
default, but that's changing the default kernel behaviour. Plus,
ADD_ADDR retransmissions can be required for some tests. To avoid adding
exceptions to a few tests, it seems better to increase the tolerance.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..1028f3f931612d98e828707a9f55caa69be4a6ca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -358,6 +358,7 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
+	# set a maximum, to avoid too long timeout with exponential backoff
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
@@ -1669,7 +1670,6 @@ chk_add_nr()
 	local tx=""
 	local rx=""
 	local count
-	local timeout
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
@@ -1678,16 +1678,13 @@ chk_add_nr()
 		rx=" server"
 	fi
 
-	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
-
 	print_check "add addr rx${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
-	# if the test configured a short timeout tolerate greater then expected
-	# add addrs options, due to retransmissions
-	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
-		fail_test "got $count ADD_ADDR[s] expected $add_nr"
+	# Tolerate more ADD_ADDR then expected, due to retransmissions
+	elif [ "$count" -lt "$add_nr" ]; then
+		fail_test "got $count ADD_ADDR[s] expected $add_nr or more"
 	else
 		print_ok
 	fi
@@ -1774,19 +1771,15 @@ chk_add_tx_nr()
 {
 	local add_tx_nr=$1
 	local echo_tx_nr=$2
-	local timeout
 	local count
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
-
 	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
-	# if the test configured a short timeout tolerate greater then expected
-	# add addrs options, due to retransmissions
-	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
-		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
+	# Tolerate more ADD_ADDR then expected, due to retransmissions
+	elif [ "$count" -lt "$add_tx_nr" ]; then
+		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr or more"
 	else
 		print_ok
 	fi

-- 
2.51.0

