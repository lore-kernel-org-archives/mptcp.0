Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E5383BF
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016109; cv=none; b=OeE/GKpsVh4docFVF8UqW6ZxZ9PIUDEopFZVDnv4HXCip88fX+gaQsnyOShQOV5lyfS8iBV0fwPsE2SpgN6imp4SJbipj9cGS69DIsWEVOyHAu5DgKtgm0DFj0gmmvTl1HJ8LUYtr0f2ogCAGYuyJge1j1/T9rBPdKpXKe5jmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016109; c=relaxed/simple;
	bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwzHZs4GpIRnwOZ2Y1+yQfY96qezi8qCzXVG7rvycwjTaW01eru21WIl49lTvfMxyoMGh9TiP0GfqKYi2SstXTrCAliGsAVeDCQBpUG6slznCbQYreBlnkiov2b6WUFAkWfIcVVir0mS8z6kRZKmp2qk7jES49eKZtCYr8CYN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwQwGqX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwQwGqX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7411C32782;
	Fri, 26 Jul 2024 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016109;
	bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fwQwGqX9sgISldxYu1DCeDetF+iNS87ytbFmglPdQx/oGEJwix/czOdD1qU4ABGL2
	 gvSqfs9ohvKJp0N5sxF1CkT5HZMtnNyjjAHxFXKwVfz7iJHd3VNWlkqaEAu4459Iqb
	 VB6i9Pukc2WG6cswBI3gzo3XkozN8/D3XWyJ0dV2Bm/BL0CQHxfFTUmVdLxTNR9POJ
	 ROJyBE9DnMGy21phJRHBUud8ZLJxUozNrCMDxS1QVxRP/mhpaJ/7akg7eSTlhgG0IW
	 rCJlVxmmT8/Me2DKctdzj3m0LCq49sTKHE6/oZynDC3gdC9C1OavxHXJbbGKbCNt6O
	 EbRO0ohDjGhLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 19:48:22 +0200
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: join: validate MPJ SYN TX
 MIB counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-join-tx-mib-v1-2-7f2149ba0dcf@kernel.org>
References: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
In-Reply-To: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=txWGadEsrmhQCY+1OCs5bFpGkDlrfCce55DOhsaXkMI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo+Fqcpj6aJrEEMkU5kpvNmuFtK2LnG0jNkZef
 oNmy4uT1zWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqPhagAKCRD2t4JPQmmg
 c075EADsS1+zbKHCJ4VzPvr0f4V0dcL87g/6s50SabS2Tx/bBua+zU5mhZJoWLcE2tjx2xjUOGw
 B+hrx0MEqx0atVoBhlm5n79ny2NCpsmCod44V3oGtlFJPdbfhM/ugHTbagwHi0a2DXuNjXpv4qv
 Ji/mfLY7Z5N/TYxWMuV5jLI7AGQ4EPf+3cvJuijg34vxYLkmMhYHVBv7C+5bIUD2Z1BKeoEjygM
 +/W8fybqEvM5yMMOHa0BOEQzBTbFMfQ4QEvl91EOhos6dRnQo3Ny7wBcAAr/fSENHXnYXlN4H4E
 t4vrOYpjpJgxWCkLVzRP0XCA8EUYNNh9Myqv4Ge5qrGMxqTn15os07JfYeCNxOc2gr43FYzxJ7V
 uzFCvFraUO4oj1DyVD6CKyrvWAUrgoOg9qtP3Nx/VGqDpiuO+0EBEtWqKqRhJJDLA00Xp2u7cAr
 vp3t4J74xMNX2P2Y4zjzOQlUeIpthItQn2G+7TcURNpB0tacp9tKUe3voCEh75+oDuxg7IMp38e
 fXVVVGBDJJUK58EbhRQyY/Z1dhSA4+V2Dzx0tb3lhh+iUEawyj2JHFAFiZihs6VBMc4+XAO8c63
 wVnSOn3CSB922x+xKXJeNxmVyvXzg1r6f64l02hYwWBUNwiyZnPpa1HaQMp+Q48ujgic2R+s0Wq
 dCncCj3BmsNJBIQ==
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

