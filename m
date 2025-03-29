Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35B3987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265591; cv=none; b=OkPXiqgaCZT5QHw//OVgw36HUxxDELh6oQIf+VvD6sTjV/VN16CxH/XQitqIfygbji4PJKcURhkjouvOLgL5TlgtJTL9jRPEGt9NSJ1FaN5/cFHUa0L6Ke0El8hC9SJF+dZRc/eGxcooTnRJSqslA6oHwr+pJ+slblCBQJn2298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265591; c=relaxed/simple;
	bh=BP4qsoRF3UobaCULZhwLBej801ppnrA6ETy3pL7x/LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGT0mjPoZyO3En8OsrQFAdfMJj71M2mx/EytQ0fB2Whw9bO9mYRwFU8TobQdi5Tau1ZB9K0rMs+1vFsF6k8CRWninEMUX1MgSMakuphgiBMnYg3GMADUV3TYs3WS+L5M4h9Zq+gjOJasYv7QMdZJdurNd0PIzijDOXhPg0V1Pb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATRGlPmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATRGlPmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DC2C4CEEA;
	Sat, 29 Mar 2025 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265590;
	bh=BP4qsoRF3UobaCULZhwLBej801ppnrA6ETy3pL7x/LI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ATRGlPmYXayEI/lCTbmx+33jjARgtG92kzgvUOkpOgRzqXX3/hEg6BP5QW+DjMdH6
	 nLfV8jq+3M6mjkkPEpyM8oxxQBBws1Lx3JhVWEOqKueBm1NrbapOA3zgtrkWJN9g3A
	 HDoyjLsFHkALvNfI4ldy8ZhAvNT5I84MjhwXTrK2LtnkYYynhrG97NDLGYHNt9WTG1
	 wHS7pGmdV55iHtKZFeiwp7304UWtepjnWGd4wUjkI5ApBFXREHZSO3usr/qIOcvvqa
	 iezND1VPybGUVQ9dYPTtnY4QAbzdWqWb9AiuNqUHEahV9srbIzBk/z65q20Ln/7tu8
	 R5CnQYCW6wrcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Mar 2025 17:26:15 +0100
Subject: [PATCH mptcp-next 2/5] selftests: mptcp: validate MPJoin
 HMacFailure counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-mptcp-mpj-reject-v1-2-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BP4qsoRF3UobaCULZhwLBej801ppnrA6ETy3pL7x/LI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8zeN9C64I9AcWRN4Cx2TVmwauUJASNd5WXE
 ifdaz61kymJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 c3tgD/sGFV0A29EBqB8wPbv9V++cbzfgDh2rhvwP1HfkXYheu2pCDXEX6fXqe4b7BhTyFfgIQVR
 4fjc5+znPWa3LlOiOtXIDOmgq1GKdyPwV9PssRJpvnYwjuJfyDFxiQNtnfDkP1LN9kw8LyZL+J/
 Df3NPLstoZJjTPcfQGZ1B1ebr64rURa0IAANXd3TtiSYbyTkw1a5OrKJkuQBi7dUOxPWfpO8NIb
 DlgAJkoW8W/JEkoPU1aTho4Dap8Bq+TIpxqVKrGiwo09pqSUtxQtzwWuA6HgVslzPrIJtS3KVaO
 0Xki89WaZ5oQe5OiAxD7wTLDUasycarBC3iHaZqJT023aX01ws/ByQYuagKyR48r2ndCU64G0Uf
 AAvtVtSqyi0OUE6VctCp0aOTFiCeGymaTM9WVXbjvaF++nBjzECALLk1c7Hw5BDn6WdaMVX/m9/
 I7q/MtBQFt9/3Sl6FSb/DS8M37v/h+mD8UpyO6EgaMSj96XRha827l3ayM01d8Zw0JiVyc3npwl
 KR/+ZLwvGjVregF8kmrEYD8NncCyNNSp6XppOBi1hlmOS6QgJwd+s2+fr5RPE275CWZHoOTnqWK
 an+aps9GZKZzcbCo30mJJE3CWWN8iiqaNHhpcTH16yBEkUEPsfXKhnXUVGXYfZst1xr2IaBOjG9
 MR1XKNBG1pXXxiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The parent commit fixes an issue around these counters where one of them
-- MPJoinAckHMacFailure -- was wrongly incremented in some cases.

This makes sure the counter is always 0. It should be incremented only
in case of corruption, or a wrong implementation, which should not be
the case in these selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this can go to mptcp-net as well, with the parent patch.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee14eb628a858e5738094c3c936b74..5060b7e24f94550246c2b1f0465dcaf42b869313 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1441,6 +1441,15 @@ chk_join_nr()
 		fi
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckHMacFailure")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "0" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack HMAC"
+		fail_test "got $count JOIN[s] synack HMAC failure expected 0"
+	fi
+
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
 		rc=${KSFT_SKIP}
@@ -1450,6 +1459,15 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] ack rx expected $ack_nr"
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckHMacFailure")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "0" ]; then
+		rc=${KSFT_FAIL}
+		print_check "synack HMAC"
+		fail_test "got $count JOIN[s] ack HMAC failure expected 0"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \

-- 
2.48.1

