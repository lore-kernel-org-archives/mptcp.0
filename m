Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E802D322E
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985903; cv=none; b=lvWm3H4BmvY9X6lPGzwRCWTHSvkAWJS3HvJGA0S+NlA2eef4ppskUqfcf9/x+k6zRQKMXhn2ZS6Mp5+gJ83jMjJywBYhvQ+pEEKJE/PwaHV8mr+hPNIi541huzdxUayUbLajVACkyfaBN7W03+oC6e9FMKuoU5tjCpdO5ZKuzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985903; c=relaxed/simple;
	bh=4OL+gS891o5wWSLFOyQWCMLVfs+xcrUEezD/nJaHR1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNfc8GC3IhXOmWi+SvULR1Rw/LQgJl/fO5Y8VyhihqVqwY+ddiDrLGCLL6iGm5/4Mm3htLL5GyTdPahFQuyJcDBBQhNtlHnXNqKmjzGoXiKO733zPNl1qw/HAY4Yf1y3aAMAGVe/vtOwbt9YJfwADknXL+PSxRfafWhNuDfDGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u88/KjcI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u88/KjcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C6C4CEF4;
	Thu,  4 Sep 2025 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985902;
	bh=4OL+gS891o5wWSLFOyQWCMLVfs+xcrUEezD/nJaHR1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u88/KjcInIBsJ+u0g2tuSXDbZChR1qnqumJ5EXvZJ1MYKa4k1P79M79E8hI/gCPfb
	 im8WdyQnWKjc3zpiDhNUSmwQewkMds/MwUSmJCjEPcLxjRnOIwt5zsEOMlZRfaQCnn
	 SFnymAldS4+RREO9zfb7SgbBPOElsSlaX0yKdwoWRHKO1DDmpJuE7M/mvlaZUrKiWo
	 eeD2cJ+fU2CqKG4Zel+JX2e+PRMTYbmvxpbsXrgznGj3PFJZ7wtR5V9W1oinwy851f
	 uCg5EuabvDeLIamQaWY5y21wlWXY3WtvN6HBz1zNkGCuR9kNCH+5qo0E3grS/oFXHN
	 v/+1U1XKullcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 04 Sep 2025 13:38:06 +0200
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-2-a019e6678628@kernel.org>
References: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
In-Reply-To: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3614; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4OL+gS891o5wWSLFOyQWCMLVfs+xcrUEezD/nJaHR1U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2Vmna2O7R2Xrj7b+zSta7T9S89T8S+yyVu8lQ4Kjmu
 43xr++s6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI5wkM//NcRI4ZrxDcft1v
 w9tdB7j1EnbMdy09cN3tkGXnn1gJ9TRGhm2zsyR2u36Xnhmx9OnqvTHpe3uuKuxqe7RQ8k+Vipl
 5EScA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ADD_ADDR can be retransmitted, and with, the parent commit, these
retransmissions can be sent quicker: from 2 minutes to less than one
second.

To avoid false positives where retransmitted ADD_ADDR causes higher
counters than expected, it is required to be more tolerant. Errors are
now only reported when fewer ADD_ADDRs have been sent/received, except
if no ADD_ADDR are expected.

Before the parent commit, the tolerance was present for each tests where
the ADD_ADDR could be retransmitted in a reasonable time (1 sec). Now
that all tests can have retransmitted ADD_ADDR, it is normal to apply
the same tolerance for all tests.

An alternative could be to disable the ADD_ADDR retransmissions by
default, but that's changing the default kernel behaviour. Plus,
ADD_ADDR retransmissions can be required for some tests. To avoid adding
exceptions to many tests, it seems better to increase the tolerance.

Later, we could add a new MIB counter to identify the ADD_ADDR
retransmissions, and remove the tolerance when this counter is
available.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..be49712f91155a1f14f6cc21776764d65a897c27 100755
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
@@ -1678,15 +1678,13 @@ chk_add_nr()
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
+	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
+	elif [ "$count" -lt "$add_nr" ] ||
+	     { [ "$count" != "$add_nr" ] && [ "$add_nr" != 0 ]; }; then
 		fail_test "got $count ADD_ADDR[s] expected $add_nr"
 	else
 		print_ok
@@ -1774,18 +1772,15 @@ chk_add_tx_nr()
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
+	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
+	elif [ "$count" -lt "$add_tx_nr" ] ||
+	     { [ "$count" != "$add_tx_nr" ] && [ "$add_tx_nr" != 0 ]; }; then
 		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 	else
 		print_ok

-- 
2.51.0

