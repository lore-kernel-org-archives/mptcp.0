Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CC139590
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806142; cv=none; b=uiNPbh9ruCPLfAG/xG7ysBD/2wB8mj8JsNqejiRjvsd7KLGBOWDWVqHonXCp3btE++CYXoYfcxe4UGW9wf+C7ncnXmHWjt9QEa0O4HCwgJEybEGnNXwVivD4BqjKPRtmiEhRLyG206kNsncG7XdlZu0/sReSGFDsOgdNFMC0xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806142; c=relaxed/simple;
	bh=WoQt0OoDMjBs9YCEmJSyNcYnt+UpLxo5EXOKjoZ6ygo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrYmstfoCwl9qWvyX39Vtw1XvW7h8h6kJ6VjQToPxT/mVZ+E258/0qbzulh1peUmvnAv/lNMzrEpUfUmh5r+kVXMEC++fn9ZFJFar9Gkfb9zyw+Ar+EUuTwVlYGHBDh/2LU040YyLaxi4YLnxLfR4X5jLov4t5AH9m73/QgKtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT+eIcOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT+eIcOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2028CC4AF09;
	Fri, 16 Aug 2024 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806141;
	bh=WoQt0OoDMjBs9YCEmJSyNcYnt+UpLxo5EXOKjoZ6ygo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HT+eIcOv6N0psTfoMN0EV7vnA1rKlLAVWp9gmypEJuC9l3dxWvCcEMVp3/PY9kCIo
	 e8f9zSGiyF6tkma5WJQw1PJsKs9ONCEE+BUGIbW21QlYyL4lNNqTfiFn956LbW2D7G
	 jqZoOsEJvQ+7SviT+n3Kma0N4aWWcdRrYRYTsiMqgl4UY2MFPBz9SlutRO71aTx+jF
	 2jZoz7El6SatzREjouv9n8/BXPr2PPVTToudr8OvS7Grm3JgItdDvTMVI+JpbnrQcS
	 cURBPoV7IdHaOzlo1b3Fd/vofwfXmYst+ac/0Rnml+YbIt2MeOl3lGYpH6TOVXuaNM
	 Erd7p3OYPTNuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:06 +0200
Subject: [PATCH mptcp-net v2 12/12] selftests: mptcp: join: check
 re-re-adding ID 0 signal
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-12-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WoQt0OoDMjBs9YCEmJSyNcYnt+UpLxo5EXOKjoZ6ygo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGutNZ+CSzVQhjl9sahIDU5PBbEhCZnC9trJ
 JPYxNUdN/CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c0E+EACdzQpQ+gxrjoRG1oZ+2OXA14KC+Yjml2DRU7d8kMNyMrBGobEz08+lv+FLI1a2TXbm71u
 Y4PZClDmEckMIONscSP/KB0x7CkgNTyfYFdwL0b/6vo2rc4e4oH4lwSIteSqvOjEduhvyDF430u
 8LhhhkQs90BznTXi+W/Q8i5EgsmkEW1smkNgbqBq7G5weoERX1Q7j+5iNQSRVJQTcU4wI/TbY+m
 MtX3Wqz+4P5xXWC0weOnokNGvvElrO8JHbbYiFpCqceofLtmVAwV5Y+kHuXZ7fl50k96p3GFDky
 mvtKjNq62zJd2VvK+e89GbdVUm6qV9qRBMOqBqwhM5uTefewNi3ONHu/PXtm8Cp1Qnx0Fybl1ah
 84pYqOlxoSO1iuNgWL8F15vFfHno1nH8tq2RACGeAv+USR7g/OrueZL7+W15lSPRdYgqHbzwktO
 Huho0qmdLN4OQSWZMYf3gKQLP1A8/MpLYAytk381IL8gZXV7PcTRwhukFlUMc850XDXw+upUarI
 w6BFkhb6PAGW4iDF68Ohn0a/WMVtXrgKcWsiVG+uUHaByMsqsEftMOtT5+9oLO2jB2adg8Q6a5I
 ZPDcmRJrMZkorP6djNbSkRU3oArU5GuqXw+TaInrqoZMYOKf2gcaZjUAh+S5J9yRMr4UMmSRlmk
 LUYPd+QthDjBv/g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 56557a7e488a..037fb790f155 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3794,7 +3794,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3804,20 +3814,20 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		join_connect_err=1 \
-			chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+			chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2

