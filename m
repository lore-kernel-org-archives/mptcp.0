Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800019307E
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204419; cv=none; b=UNw1CC60Uz0Fv13KVCLZBm+ZF1RSwJc2f4wQqgiikXxEivJrAIxIPVbJVlR9tQtKmIlEM6SH/kLCIxjaNhAwlQzxOwXOXyrLfvzQ3BOyFTEqcOmb9ktxObxUkVrtQ6lfzXjyud9JXV2BHZhDQLnGRwwi6ZJfxK6n7oGSokvjSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204419; c=relaxed/simple;
	bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqAvukkVEKBp10fbSes9yo6TNBG8bAcF1Sc3SnofLVd9TAB6P8LTasqw7fG/91WP8khDIslKBLTt+C9L86BjxjLCIQmqy2mq/kGM0W0jYFNQUikGaHd/pJKPQZ8rqyuf8XUqM9XOvJ9rOcd5aSYSE2/s0X3qXufodLDpUjm9FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRZCIE01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRZCIE01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C55C4AF0D;
	Fri,  9 Aug 2024 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204419;
	bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iRZCIE01qgxI+/CME8WDFpj7IOk1ZenZnquDIfvDj7QUUnWn4UzmVuEKAFz5lvIuP
	 6YartWlJ6+HesvSqg5B2Ap3CFlUDcReTDlGurdI/qOMjZWoxIN2FFnoSk1+96crwU2
	 qaclQE1bxiL3HYf+kIv6sKcYUhDLL6mdk/x15Ji9qqeJEIeeuPQ3uSiH9eoC6J/tWh
	 UEgdYmf82e8oy3iN2bXfPucZwsJSlX/PoTg2uEAEnXG/6US4RiII15Q2n3+AjqAiNG
	 hcniMNcSjHQuOkoaZDp0ic7RzUuWYXVHKDJeJ3yL+rXGuoe+DDpmVzmbSGG8NrcLp4
	 FhFN1O/F1Fomg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:21 +0200
Subject: [PATCH mptcp-next v4 3/8] selftests: mptcp: join: reduce join_nr
 params
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-3-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/AXy1e8B5BcTOJ5Zs/Jl+E7u05nSoetv/T
 W8jZde3aZ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c+nGEADL0UH58vqKNt1OxiI/oi3sZCmIshollJCvqB9YS1ZgAy49Pe4z718sulNIvPbgR8Tj4Zj
 Y8a5t8QELPgyiH0BcArQ41Ge5JdaahquT4aK+mz0clTKk0Dcepc57Vl/s99Tagn+N0/JeQOJ11y
 P94mv55/UfMimNcFFTE0EVsXBhx7hKg63+iyKVskHpxUekya4AN2llRczJ3JhUUuoF9rsf06zIZ
 D0Xh2oTH7SYi1W/CCFYjGnGPDkAqeXBgN4dbpg+EyQGPMU1VrTV9lCe4XPx+Gs7ZtDkLqMjqdMl
 SwkdbVTvDYJH24yvbI9Sr/lQHqynOAuH8jrMQgWrrPFLtY1+wj2gdHcSmBZEAlXNeBDEd9XR8mx
 7R4pQS5KvkyB7Y2FJaOFlYYBXCRp3PXKSH2LsSqz6acnLV2mQe63K4+TlN0wAbl+a7HM7/T18ZP
 ABWm7N5N+q4QXLYgtqK7hpmjy+wRFAH9bRVuBsunMs+V4DhcdVQAevUERMjJj6j1F5YyA3mjVv5
 tMPlSYt73Wsu7FRd+UWV/w5TtpJjZpvjK2R6Iv5enNdrk6O7Qx4DksP3F6tFSV7e+ztPZBhC+NL
 riL2mh+zFpvGkFgb+xqzZCKbT+QZbr+T9iYDgWhjsbTQYiFLmCQJFsq2yqWRCjldycuEa8Da5Qv
 CcVAXw7ujXB9WJg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

chk_join_nr() currently takes 9 positional parameters, 6 of them are
optional. It makes it hard to read:

  chk_join_nr 1 1 1 1 0 1 1 0 4

Naming these vars helps to make it easier to read:

  join_csum_ns1=1 join_csum_ns2=0 \
    join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
    join_corrupted_pkts=4 \
    chk_join_nr 1 1 1

It will then be easier to add new optional parameters.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a1f80dac59a7..0401ba1aaf1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -61,6 +61,12 @@ unset sflags
 unset fastclose
 unset fullmesh
 unset speed
+unset join_csum_ns1
+unset join_csum_ns2
+unset join_fail_nr
+unset join_rst_nr
+unset join_infi_nr
+unset join_corrupted_pkts
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -1314,12 +1320,12 @@ chk_join_nr()
 	local syn_nr=$1
 	local syn_ack_nr=$2
 	local ack_nr=$3
-	local csum_ns1=${4:-0}
-	local csum_ns2=${5:-0}
-	local fail_nr=${6:-0}
-	local rst_nr=${7:-0}
-	local infi_nr=${8:-0}
-	local corrupted_pkts=${9:-0}
+	local csum_ns1=${join_csum_ns1:-0}
+	local csum_ns2=${join_csum_ns2:-0}
+	local fail_nr=${join_fail_nr:-0}
+	local rst_nr=${join_rst_nr:-0}
+	local infi_nr=${join_infi_nr:-0}
+	local corrupted_pkts=${join_corrupted_pkts:-0}
 	local count
 	local with_cookie
 
@@ -3138,7 +3144,8 @@ fastclose_tests()
 		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0 0 0 0 1
+		join_rst_nr=1 \
+			chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
 	fi
@@ -3157,7 +3164,10 @@ fail_tests()
 		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		join_csum_ns1=+1 join_csum_ns2=+0 \
+			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
+			join_corrupted_pkts="$(pedit_action_pkts)" \
+			chk_join_nr 0 0 0
 		chk_fail_nr 1 -1 invert
 	fi
 
@@ -3170,7 +3180,10 @@ fail_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		test_linkfail=1024 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
+		join_csum_ns1=1 join_csum_ns2=0 \
+			join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
+			join_corrupted_pkts="$(pedit_action_pkts)" \
+			chk_join_nr 1 1 1
 	fi
 }
 

-- 
2.45.2

