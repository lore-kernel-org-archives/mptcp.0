Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1117A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204418; cv=none; b=GtmQDU6TCr1Dprp82BJH5JpIpwzdGoFuyU1vywbzOJGV+49XtqtQP0AKTnTUhQGx0k5c1F4HttxqBFs2wuwL7EYx0rkG2mFBcfzkR/mZEFN7OJ5TBQJmWgQexneZ2thnzyX+VYOiV9iO7c9qd8Iure/vT+PvTHvOT96zWOGdeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204418; c=relaxed/simple;
	bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZKTEuyCxI/4C0r6Ke7w9OajQ/Zbe5QmOjK/nArBOVQjD3DtRsNF/0//DI3w7hQ1LiZ7D3W15YcPoMCOg2qyhhP374XNukzjhvKxHJCeIW8T/fI3JYr7UuBjL0J/uzYTHHxxl1mByJodrceVbC5NPeRME9d2bIjjtGi9YDK58IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUYwKcFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUYwKcFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CAAC32786;
	Fri,  9 Aug 2024 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204417;
	bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OUYwKcFSb4EzQg3Q5KYJxMUZ0BbV0dfgI0oLH9+BNhSKGfMP/iIYKObLRrJ3CYAMD
	 +YEDDh+JuXtlWOxtMfU7s7Kl1wlsx/oM8wanN9nvs6n8hYoMeNTlIifCk0QOJXd2jp
	 68wTKmcvsxty9UQ9072C1F71jcPi8t0IZbrZzKkuy95ByUBcFzd5r3uqyqwDJBh7+m
	 KY4lcYwAPHxDky8ogCMYbXrF5rTOu3iveRK0hNKkVvabBNYbQzOTtaffJ0HS7tNm1k
	 CMMizZWPABb10+JlICmOFahiasZRl8bT+BX0AskQ94m4sVXNg7HqaRbeSAmhHPK51L
	 r9J6ZXOpEKdqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:19 +0200
Subject: [PATCH mptcp-next v4 1/8] selftests: mptcp: join: no extra msg if
 no counter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-1-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fmjxhC/ZoHiChWVetnjFuqjsv4acoJhHSK+S4Qit81c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/cUt0EwT2wuXpBn4+8m+ZL5awD71CUtI6t
 WpfeYM80eKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c+WlEACLb30l2nECRtVkRasQC+jpYB9xTYnY8l140SGyucaSK0n3MLN3CtCPTcPfPrs1Mpds4oC
 509DpSQJJdlCGuLQQBS7Co+HrnpFBXEtpWRXQGB3d5mbI9PD5kA5MP/weFi/kBQmPaUa3aIKimU
 S9zfQD8UO0fKup2h7eKhoVfuFGFruoNUaV1NQu/+uZb4ntp4V13EaHDKW0bt1VeTSfpcxnj6NoN
 m7eBoIDn3ypecW+dDBfxhxRO0DmJRAuzeN+SSNpmRdQySsru+A97pnugx4XD4lllDWY6QPfaQcC
 GknxxKCNLNGY5qdrRLrmP7W45Lbiu5zTI4vqPYZkQo0vFyKTeWHVEpFdTBpG5g2Es1tWNL5PD8O
 TJqh2U2/bOiSTJRDMGE9TXthuiNNmB1CJxLNT+RfzwaTJDn17F5ogq6bNiLH3YO5Nbvn6KQOJPK
 G72MtqufqXj7ZQ0R1ovCOrRd1lPuRCbKC9NS+Kf9tvow7Sd89BrWuCDODwT11aZbuJ08taVynF0
 Ohuuw8innTOOyZA8+ZIfwNGnd9Tp6d6MDkAkTau+kKh+I+o25raMahPXENG3x14qxFBMq+dmIJT
 OpNgWs6R5sEau60AdexGnVDLPixMs6BGPQsHaexhtwU+Q35M9e2XzOv0ZoQky7FPpBj5Enchsbj
 X7D+bWGAKsv+i4Q==
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

