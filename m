Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933313B290
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248334; cv=none; b=LFUxt0eekQV0xUV7gTBSUZ1ezmmAP2W9FrXqzZianE1DmuSq0zsInTRgpLyZmgLl/+HVizpZx8lJKLpjQx+fDBuUxg7toDam/t7acWoS0aiVe/KxZu/ktEbtEYwd62yjpU0X8Bgm26A1N9viKxHPz4aaz5Zt20oSwjxcrH1GO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248334; c=relaxed/simple;
	bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXVIT8csvoUiVInPSj17BVaEB1KjD4BUCC00e4ELN7FBHnBBWC6NJ9KyPHQLeAXGvPdQ15IDRydA6HfwkayA7wrJzT1HDPt0mBKW38Hnqp4/R5vnmszWg4URP2aZYbKTfyyrBGqmMrUUMNbcm7pTqWXrA66FYzKvPBdAsATeAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYDuA4am; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYDuA4am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF47DC4AF0E;
	Mon, 29 Jul 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722248334;
	bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QYDuA4amwClKWAkZhb9YQn+ZxIUGszIMy/sFXt87Tpk3h/MQ3fpfY6DuGBKT/rwR8
	 m/b8b73KSIYl5rhiUs29J/buFcfUV89BL6XpCe8PPhUqppCuse0Si0HQFsCW1MxejE
	 tcR1MitSEWi9GaoiYHw6NWHHqI8kQ/jSG01bK6CaDBR6smEDAm7GUOgUD28vhkWh+r
	 8uKAFtjgeWzcvQjf0Xwk2PCFIWCy4H9pDowvKzZZgXd7YH9DiJ9QA2UpTPEEI1WO59
	 vgR5aFz5654xqjdy1jZhv/IDCnNYxuLlN5By7NTcnqJmpf4g9HO4GttJ/jgl1Xt/Hf
	 cWPjAp7mLuQqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 29 Jul 2024 12:18:44 +0200
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: validate MPJ SYN
 TX MIB counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
In-Reply-To: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmp2yLUCG2f//86FNiuz5jwB4J2B/13Y/GjdBDZ
 ssMPguYUIaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqdsiwAKCRD2t4JPQmmg
 c+bCEACWX7SLVzHUrkGAP4DzbhNZx3bg67RuNg0tLcb/UVHqESi/SRofpukumy01oM3o6WrA1NC
 CMsb864oiqu9axF5PHH7ZMXlfbRT4BtUubKRnsfxNDJg+mmMEirKW7fSRTKga4LiEUiTCGJAEpl
 1cgGNf6Eo4USfqEfgHrWfKxzr7eZ4QYFleUmzIpyhpDam782mFEyJ6Tz5Q6WkFuLneXymaEGvmH
 IcvH/MzCrkrrlZ8MEeiUF1YC8n6PHsFyzKmHCM3u+8bkcDk5vPjpz9AyYuIeUv2oPaEg/5Zv8rx
 qKtXC+0w00H+XFrWIggucDQ3QbSkf4yc71a5r0/aV0flB3q/WogO3g0wCWcJgFxCcEeob2+AQr3
 NhpY5RyVm8VYxeZAQa9Fcea0IqqJuvUBKdeT/tZ2+iHOTDTwQMyqcPgmUMMddRTqRjM+07zvwWC
 YcoK4V8zLW8FqrUjfDbLK9oD+1Ep4KozKiXm4/Bj4tsK50UeyR2LvShn9vlE9qNa1UbtaWPKZWS
 vKTipTcvbITota19FUgCNL+0KW36rQ+JGZirgjrHKILIr7S5Kd+j/+fND0DiUivuaPP3yHQAg7B
 Seer7wDKNFrFj4Nw82d+9HiCkMyAl8HuuAEboC2FQ2aq4olgN3DiNRgN8ONIVTKV6StV+r2I6k2
 zWEKtbtW5+IYXAg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few new MIB counters have been added. They are being validated here.

Most of the time, there are no errors, but sometimes, more MPJ SYN are
queued compared to the numbers that are received.

Only one test has an error, the one to connect to a broadcast IP address.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fbb0174145ad..c1f1ebd2340c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1372,6 +1372,66 @@ chk_join_nr()
 	fi
 }
 
+chk_join_tx_nr()
+{
+	local syn_nr=$1
+	local festab=$2
+	local create=$3
+	local bind=$4
+	local connect=$5
+	local count
+
+	print_check "syn TX"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$syn_nr" ]; then
+		fail_test "got $count JOIN[s] syn TX expected $syn_nr"
+	else
+		print_ok
+	fi
+
+	print_check "syn TX Fully Estab Error"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxFEstabErr")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$festab" ]; then
+		fail_test "got $count JOIN[s] syn TX Fully Estab Error expected $festab"
+	else
+		print_ok
+	fi
+
+	print_check "syn TX Create Socket Error"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxCreatSkErr")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$create" ]; then
+		fail_test "got $count JOIN[s] syn TX Create Socket Error expected $create"
+	else
+		print_ok
+	fi
+
+	print_check "syn TX Bind Error"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxBindErr")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$bind" ]; then
+		fail_test "got $count JOIN[s] syn TX Bind Error expected $bind"
+	else
+		print_ok
+	fi
+
+	print_check "syn TX Connect Error"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxConnectErr")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$connect" ]; then
+		fail_test "got $count JOIN[s] syn TX Connect Error expected $connect"
+	else
+		print_ok
+	fi
+}
+
 # a negative value for 'stale_max' means no upper bound:
 # for bidirectional transfer, if one peer sleep for a while
 # - as these tests do - we can have a quite high number of
@@ -1907,6 +1967,7 @@ subflows_error_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
+		chk_join_tx_nr 0 0 0 0 0
 	fi
 
 	# multiple subflows, with subflow creation error
@@ -1919,6 +1980,7 @@ subflows_error_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_join_tx_nr 2 0 0 0 0
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
@@ -2306,6 +2368,7 @@ remove_tests()
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_join_tx_nr 2 0 0 0 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0

-- 
2.45.2

