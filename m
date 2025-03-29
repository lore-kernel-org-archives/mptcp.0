Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF23987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265594; cv=none; b=TcZ6RY5FhURIGH8cEsbnKufUF5S+MeR91zhQFxewcY2I/aTIXs/SbKwvvPB0FMBoTOh7D7MenunvWEXZozu60MNCg1kzE0sWiwLQAb/W+ZZ1ZZgucjck4a09ygF8uc3WyZo50WgFgdrqA1/dlRfeZ+2LrVjh6xWuN4UZ+lWbPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265594; c=relaxed/simple;
	bh=yeMaqJQBmjDpT0bgiEiAjJ9kHyXMiTOgWbynbyGyXjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goPdnqF/unNdt/gG3SGGVw1U5DVkEzsz+8sanHaDM8sGNFDoS4BkzIWlART74pf8z+NVRSm4ZHVpk2nXMxLt8x1z9dacGNIhA7VKYfoqihqcdvGfDpveoX2MJuqeoSc/fMvQjpOGiNtjquhfdiKlYyzji1VUVUoH3W8MfoiQ738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmfjmQcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmfjmQcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C7C4CEE9;
	Sat, 29 Mar 2025 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265593;
	bh=yeMaqJQBmjDpT0bgiEiAjJ9kHyXMiTOgWbynbyGyXjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qmfjmQcBEl9u7JVYofnQziwJLxfZtpZhhQPxH25ogBNA7f4WyAoPMzF8b6rkdlKC/
	 jPGK2pONIkxJcHXnO6v74f8NxJ1AZ+oipvcQuXZqbSuzjml4DYKsusW01IOJKZe5RV
	 s+5hSf3Dsa2ieq++pFKbWVLuGsN5e+CqBomzlzcReieZQJULiED9ZL9/VwCo6vDSc2
	 kNZWLBzAIdOslWp5xpt7pzKyqgr6ygqUYqoDey19AonLUSuN0Xv2HJXAUGRcmCKJ79
	 KD0JgZceUUM2f/vJ/nEJE/ngQgE75LuFWkSiEvltu7xs/GbGaOUWqZ3iyHSyNqrkoD
	 qZGRih8XQWNwQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Mar 2025 17:26:18 +0100
Subject: [PATCH mptcp-next 5/5] selftests: mptcp: validate MPJoinRejected
 counter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-mptcp-mpj-reject-v1-5-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yeMaqJQBmjDpT0bgiEiAjJ9kHyXMiTOgWbynbyGyXjk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8z7iGKhgw7WS/OQ+29Erf2Sg1/ZogHSHu+O
 yyGchsWEzaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 c/qAD/wJPum7gP6qbk7dAvoEgFGAS4Ba9y/AtLgX5/Q6wO5ta5Sl89pWvjn/sOfvF0dhdDMelc1
 5TGEMotCoZlvVkckt1VST2h1/tnhTieW87mFejyGzvHQrBYLMchtJDYKY2NJKHttyYG1s2s1s1n
 fvVMXIDfxK3JFt4I+f1LvxZqv3Nlv1T9XlhoD+cgq4ULLC9F9DRFNgknz/7N4FbxIUC/vhpR3Ty
 ChkKnc4FtQ1UOFCP/hi4cm3LzyIt0hwuACTYRxN+sRQfkDZXoXdXbVSaVR2+4AFM7q6EqhZgtG3
 JR5KMqDR4kaonR2XNEcBo+GtdWS5lP6UPVc43c3tGtK6ZDqCQNM/mgPdvfHUHbhbZgbCRLYZ9Vp
 xxvMpykxYl4TTz2fsZesQqdwlU/XcvWrpZjKHMbfUjOicWBWWU3T67r3WoKRpz3a5SVY3Yd77P1
 wAsrahBokROEooiV7tw8DlVr221lKIy2DzNmu2iatjaH3ZHvXuy7KesyfNfCRQvdjD0kJzRCUnc
 HNGqgXA9VC4MqaXJGuD2iCJckCThEXasMJIB195YDeSK3OS5DNuKqC84PGS88N1pMnrieGsgRJX
 TC7pekz0gCcx6q/DKp6pnPGlvcftqxKautCClZNZDZXHIYOFiOkf2tG/a5gGSnbsD5JIuovDYy3
 UZDmQOXzKU8RBlA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The parent commit adds this new counter, incremented when receiving a
connection request, if the PM didn't allow the creation of new subflows.

Most of the time, it is then kept at 0, except when the PM limits cause
the receiver side to reject new MPJoin connections. This is the case in
the following tests:

 - single subflow, limited by server
 - multiple subflows, limited by server
 - subflows limited by server w cookies
 - userspace pm type rejects join
 - userspace pm type prevents mp_prio

Simply set join_syn_rej=1 when checking the MPJoin counters for these
tests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5060b7e24f94550246c2b1f0465dcaf42b869313..7f868d68ab2867241aaad1c8739a662f232e625f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -62,6 +62,7 @@ unset sflags
 unset fastclose
 unset fullmesh
 unset speed
+unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
 unset join_fail_nr
@@ -1403,6 +1404,7 @@ chk_join_nr()
 	local syn_nr=$1
 	local syn_ack_nr=$2
 	local ack_nr=$3
+	local syn_rej=${join_syn_rej:-0}
 	local csum_ns1=${join_csum_ns1:-0}
 	local csum_ns2=${join_csum_ns2:-0}
 	local fail_nr=${join_fail_nr:-0}
@@ -1468,6 +1470,15 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] ack HMAC failure expected 0"
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinRejected")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$syn_rej" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn rejected"
+		fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
@@ -1963,7 +1974,8 @@ subflows_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 	fi
 
 	# subflow
@@ -1992,7 +2004,8 @@ subflows_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 2 1
+		join_syn_rej=1 \
+			chk_join_nr 2 2 1
 	fi
 
 	# single subflow, dev
@@ -3061,7 +3074,8 @@ syncookies_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 1 1
+		join_syn_rej=1 \
+			chk_join_nr 2 1 1
 	fi
 
 	# test signal address with cookies
@@ -3545,7 +3559,8 @@ userspace_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 	fi
 
 	# userspace pm type does not send join
@@ -3568,7 +3583,8 @@ userspace_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 		chk_prio_nr 0 0 0 0
 	fi
 

-- 
2.48.1

