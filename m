Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2013B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943146; cv=none; b=OWaLf6lThMrwbGHVDVa7sTHnoYKMw/5wagthjBGMcLiC46JL24379YBrmOKNs05ghS/T8Q+TArGQqL1Tyjrtk/Ps4E1XQgPyCM2czx0b5vYY0KJUj32oF6MaMYmQYqSiSUITa7tdlHXgiHZyT8akS/wW924V7c672VdYjHyQlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943146; c=relaxed/simple;
	bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ri+3UDUxDufb9cQ3/IdNPKaGEMTggjIp6FO2qnxCoCkiPf00zadKq7ztAma/TmX5ItNujXlG9hq9uL9RyCee1wGQzWrKjXFk95N//UBzGRoVILAHnjrLemjrKWFwdrzNnqz01QauG6I5U2A+Sr31W2UN4E6AgbOFXR7kZltQIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJB7YVVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJB7YVVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE5C4AF09;
	Tue,  6 Aug 2024 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943146;
	bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJB7YVVN8mvheVaE6an3g7MItuZFbCaY204CDkh4yXXX1LgSOccW5SFJlZNWirEiB
	 eDI7RjLd/BTNTSep6KthZnIfk/OKF87+pnbeIYSqDoJzi3A7g2uKkxSMGEDvfoPY4W
	 yfzoWFzkk+/xMZJtzX4kuLpO/C0tBkBFjU/Duxy9WfvQNQ5NvUMPC8SWJmIq5xSOYP
	 nUxYGTkFyArynHhiJLId8oP63zWJEAwClINqQL9jCE/1yvjTL1yKBVwok6qRsjqdDB
	 IPuHtCAvUAPccyKPWq8OUOjnc2DashV0UeWhRfctzNOweWaKUBvbPiyvRQSiDfqi3p
	 cgYVMIVVKRqJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:49 +0200
Subject: [PATCH mptcp-next v3 1/8] selftests: mptcp: join: no extra msg if
 no counter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-1-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaorZtLVzfJC44ajt3cJHFTvyUFPhuQ/Yxnj
 CvLwr6ixaCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c8dAD/9BrjUCIqFj40YxcP3GP5oPsxvLrj1VMZ5+TuOiOs4mC9qqmJamLdbKyiA+3YWBZK414dG
 X07Lshzw9jZ3mtNEIgNAgyKZtUTIm4Y8E916OUl8IQynHGB/Am45jRNo5xRCT45atHrrYs9r++7
 D0LuUJkxBkmyiMW0LZuJ0jZST8auRQretvyRUe5MTQEmbvUyhqhcnsGAGr9rwzw4T9u1oo+wOcF
 UTQx6TrQS2nGF9ZaoBpdxDmVsfttHTSQjWX1M5P2qPYrNlZsJZDpRJdfUwrzoH3Hgf7kgoPmCx7
 XdqHLhEyXYQAluQEnodsagMscoP4MuSRvgfiMUj6mH4C8QspzB7vzrLDmm7Kpn3DqOIh13ih8N+
 op6A73wAeLmOywVfkaNUYHC/IfJCPoT4LV6MkiGVl96v76i9WTjNaqBjiikiNQALuq3dKBSmKBD
 SAxOZAydTQavAPG4F7dzknS7A266hDuro9PrlrjatCZQyzUIAVpD1Znt7hUTOWCRB92K9xjAEZO
 GGe3d+Eboo8KIr0BuUdyCNnTV3IWWfnMUVt2urLkbJUUdw2U7N5amhKpR6uFwpgewTOUaWgPVlj
 9mI5BhkygP8+4LUqbbNZcfKPwLgqVQOyYWxJHi7VvR4U5FsFvtNZ20fqtRuyM8mpJATImp1hzor
 gIElx+Mpr9+VmlA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01c1e0871aca..a1f80dac59a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1112,7 +1112,7 @@ chk_csum_nr()
 
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
@@ -1125,7 +1125,7 @@ chk_csum_nr()
 	fi
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
@@ -1169,13 +1169,13 @@ chk_fail_nr()
 
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] TX expected $fail_tx"
 	else
 		print_ok
@@ -1183,13 +1183,13 @@ chk_fail_nr()
 
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] RX expected $fail_rx"
 	else
 		print_ok

-- 
2.45.2

