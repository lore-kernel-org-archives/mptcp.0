Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3A482C1
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642918; cv=none; b=XbpJg7kyILXy/33d2mYuDXmPQqNRjqK2HbzPrhteyAK8m0EV4hSlpyRHGQUd6LpHStWVggTtFZfxCSa4czBKMuAJicJQ7iev+UwIhkSJtsGff04XCOBDd8+CMuneINz3Nc4uJ/9Xk7WRB3sMa3Y8AzrLXbZ28enXZmkZltuyGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642918; c=relaxed/simple;
	bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USuPKsZZmpiW/BIVQUhe5j7b8ndlTMwR7KLvWpS/+ghHVWmR4b6B1AISVR/7HRJkP5o1GWVeF6dm2SKDL2QmmwMqR1AchCcTE758K82xtwfeRVNORZq2pESR7Ua6njNyi6TS5qyooA7HHrjjDG32dKCa0PfpVdY5u4tvZK57prA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ9jEYL4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ9jEYL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E86C4CEC8;
	Fri,  6 Sep 2024 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725642917;
	bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IQ9jEYL45QkWEHSTTxziZacn7TBhgxYpdR0MXKcCRcBV2Jp2I8gxluRPvJZkxzIvE
	 jEl2rOen+SI9SfNX15ge3eG/oWm0NR+n2xXUpRAu8l5+ATDzmtQz4AY1fTJWFq9luh
	 fRAvcPtiquAVWR46vpKF1GDZnP6x94tWk78GPsNlkIuHhTkZ6UGJtxTepso5UBLAKa
	 Ga493cl3/nHq0Z66zdXM8jzOJ1zXtV+vI+B0mNV9kaXo/vkCiIP7/5jDP0AjMlpFRe
	 KV/9IkrERaFIziSWN0sJryfzurOoT6vhDqH47J2UnWC/wiVOED4zB6uRf4L9KMbNN6
	 hW2iVUOa4R6Vw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 19:15:08 +0200
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: connect: remove
 duplicated spaces in TAP output
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-selftests-mptcp-trailing-ws-v1-2-03421b02c48e@kernel.org>
References: <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
In-Reply-To: <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2ziisGYtJGpMAf50ntTjrMWW44LFSVNI9Vuzz
 oIQ8OtRliGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZts4ogAKCRD2t4JPQmmg
 c7SFEADB3pHUVPsC/2MTTBx1kfjnraMnKXN9WTxvCo+W9ZEzmlzsenALL77xYzlDJ/Rix44N570
 p10Y+go+ixMpRjbPfxFAniS2Nlcj3wc2s7zBILflcQvHv8wEtjkl1n16HZaPKXEzVFIWIOFMS3K
 /+150sWVT/hDzaCD+7WdCT0AJxy75dfO5nJ1JAdFCWjjxfS5rP/6qJjcaif53B5aNbm35UqS7D0
 ia+dhUgkM2Lea9Y0Wed5bV1TT4fI9ZFhmPqvcWMyE07jrXiySlAc7ZMeQoTy3bvgw2/wsOTy6Cd
 EvgQnfLethwCkqEbz0H9162uITBZq908lT5aXR7+SuhugURhvJlmIA4ahc5weAwMLZBGAq33++s
 DBiTsOIYQz81kZzgCxRJcMyIp5Iv0OWGifrUOOGHkPTeSJtXhJh9ka+EQkvrwsS3ZhUlNuS7BpD
 qbZtICtqxs3HkFZ9nI0IbvlOtTGQCALBKFfAlY0/sQwN9sKwR7ijk+WR/0aS1FePhedr584u+HC
 cJXB7/+2f1P9ljRfvaTDOO4YVK56lBOSyYEhlU0i62Ne4/70l+pxdUxAsqIAdmxsOYWTopFesEd
 8w6UXbgfhLTE+OtpIQlZkz8BYfqsoqz3ODNXMNZr2GPmoxTIk6+b9mAEWkBG08QdyUqgsrZPsk7
 mH0VM3NQ8PqXAyw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is nice to have a visual alignment in the test output to present the
different results, but it makes less sense in the TAP output that is
there for computers.

It sounds then better to remove the duplicated whitespaces in the TAP
output, also because it can cause some issues with TAP parsers expecting
only one space around the directive delimiter (#).

While at it, change the variable name (result_msg) to something more
explicit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 49d90c4dbc01..57325d57e4c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -345,9 +345,11 @@ do_transfer()
 
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
-	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	mptcp_lib_print_title "${result_msg}"
+	local pretty_title
+	pretty_title="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	mptcp_lib_print_title "${pretty_title}"
+
+	local tap_title="${connector_ns:0:3} ${cl_proto} -> ${listener_ns:0:3} (${addr_port}) ${srv_proto}"
 
 	if $capture; then
 		local capuser
@@ -443,7 +445,7 @@ do_transfer()
 
 		echo
 		cat "$capout"
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_fail "${TEST_GROUP}: ${tap_title}"
 		return 1
 	fi
 
@@ -543,12 +545,12 @@ do_transfer()
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		mptcp_lib_pr_ok "${extra:1}"
-		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${tap_title}"
 	else
 		if [ -n "${extra}" ]; then
 			mptcp_lib_print_warn "${extra:1}"
 		fi
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_fail "${TEST_GROUP}: ${tap_title}"
 	fi
 
 	cat "$capout"

-- 
2.45.2

