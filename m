Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FA13B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943148; cv=none; b=iHpg7b3cISP3nFP/Qsq64vgabHJamyyrLy38H24evbVs/6WHKgPTjXCRIOfovWiN6JU7jin2M+1NU8npHcoj+VlXTZS5ncewQ3REg1sgBGc34N+5djTeAO8rLda380jZxtW6EjcVUKks07i94Mxbe35NJSnABsA+nEKe9eyPlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943148; c=relaxed/simple;
	bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piMl7Ie3p1ClhFhraCLpzO5gEUc6YgYg8q8ZVhpAgICp7ejBTiSAgiyt6EzjD1AAc2CEPJOdohA6+3d3kne9j8k5FkmJ9Bx9LW4fc9Cp5ULx6kFrUOnHaA/J5h+Hc8jaG5ALwk33+FqmmovO0CMV5/4JKpIObpi9E5MKwhBc1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEG0ART7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEG0ART7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDB6C32786;
	Tue,  6 Aug 2024 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943148;
	bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LEG0ART7L4HegIx7rM6WkTM8oDEhjXpiPgaoviM+Iw9HyP92PBluMl9WMur7uKXiK
	 o9jmBzTcyAkoerwG2pB6T3hn5cXti4AIUJqTKGausZ+4Yo0aSNNt/koaRdZHHq4PTV
	 8GV6etSv2kC23QoOvLDLXNbIIRke8xbrauZrPi4sjMwHWF1MIFDd8MWba/CBYWikgJ
	 EdSdhVnPcJ+9cyapc5vt0uuA98CRaAk60+sPIDos1S1tvT/I8Dmism4pQ+UCQbSgfK
	 faDiZcCpfxxI2ehRKfDufUjkYDyoLfNMs+8sAJYStuNBZA061iSz7wYLXsmkzpMxj2
	 JMZJNJps761NA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:51 +0200
Subject: [PATCH mptcp-next v3 3/8] selftests: mptcp: join: reduce join_nr
 params
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-3-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4qOuC2MTCctuAx75QWVtBN5+Usgkze7z+2y087lwyDI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaoT1nYl1nDiXHZMmFN5qQqMeuMIOpqwbK7K
 BXBr/RBRy6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 cwC0D/46r0rIkT6tCWNcyBHAMDcIqnBRUUGj0AGG1pSM3smu7g8r+9rNTOGshScIMUbnwrA/r7c
 TFGetnvEX+9FCgUMcu5DOT+WmLxhqDdvCd1cexHo4OIKwS0UQPWva7cUqnAD2brjtzfJxiuhEnw
 05YAKvf4M5VEh4crnHzjrlnV7hbjQNQQnmZ47w12kJe7TQ3u5SqtFK7X/JO8DVTciomFVltrpQv
 SEvl04as8o/4VjJEGTnmmk1AxFMp2XljEplrzfOm5J455vSeXKlKd5R2age9mnAZc1FNjT+iDV8
 xYjE6s+raFdeGrN0/msf7XsqatAVr84BPi0htvbYfsw9xt8WF6APvUgi+Q6CkVuUmYCaBOhIhXF
 vDKJxcbBiGi8+vAuFbJJfQ1W+oaGcrzFymxK0iPuRO7GOUinYSvqYSMANt+u5LlwkLURzV6MvA/
 blD0ydsln9iDrJAaV094uY8iy/5SweGuTczZrL3Qwa/lshNSQNb3o2IiF5hd82CQJMrc1e8HbUk
 tW/G06/3yZQzDYMT3Pojgba4LJJpUTgJwh6hIpGFBypqOrdyd3ITy7aWHGFGBrlQB8VmKNJym6J
 D8Syf1gc3NwP0uk6r+WZGRPZzpddDV3zsztKAQpPBKOHr/SJwzLjqqBonAMW36BjmZmv9uOU+Oc
 6nG+HX0pLJfSXmg==
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

