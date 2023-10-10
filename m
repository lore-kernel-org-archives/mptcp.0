Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D01DFF2
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skz5Dq0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C010CC433C9;
	Tue, 10 Oct 2023 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696945711;
	bh=RBFrQM1qQTXW0EqbrecY2Vzbv1s2b7ngE4Kqkd5EHpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=skz5Dq0sqTHxHiWQzZsLgRFMoNASCQ/5gK8NuFUvkiY/BWyz/X/tOqZyOxdPrRIZ7
	 cA9JsTId/1U95JRexBew4mWVJQOWx9EPTTUGkfqud2VidopLZJJFejzH5FqcmUw1B+
	 B9Ti6ZqnJv9HUQ9z4OCIr3+VVEkHr1uL3h68tQQdv/9tU3Q5aBSifon90YhKcks1Yl
	 95/27pdTuu2OJFiDbCeKbURfd4qdPiO9ZTJRoTjl5B6qD6bmDwC/nWFr1A6iJ/ga2q
	 ZvpviWAcWWCUKR7eEVK3THsqOOom+OleYDTnF0UFecBPbimb2FYCzaGInVMvHwlWHP
	 5l2T9+Iv4mV1g==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 10 Oct 2023 15:48:12 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: no RST when rm
 subflow/addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-mptcp-remove-id-0-rst-v1-2-5ce17026f748@kernel.org>
References: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org>
In-Reply-To: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RBFrQM1qQTXW0EqbrecY2Vzbv1s2b7ngE4Kqkd5EHpA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJVYrN6E7sRa+aqqddbjQaFKGSDZkugGaVSTu3
 +8LCLNRu/GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSVWKwAKCRD2t4JPQmmg
 c3EJD/9glW6p9cxvzCUlrD79rKSkidhLo3W73RwrsK/WBJbsyyic2cih4HZtWI00A/l3x6r1iH9
 FdP09gUr1DIiWayXoznmZO7batpc6sX6QOl2LmsXPpA4E055JPJ1uNHA32tRsYJs+zo/B9bCN8k
 IP33aO4KVWbs63kGj7Mp2+GJ8JJj8hIYpI0V38n7Ez1RKwJ09ysXUCAU9CR4oSn0G4srDraHdZL
 lUs66RhNrQF60M/jvsWsyRPm/xX66Nrs5bEyel90c1fv0dmAXeWyi6Jlu9AQ9RxipRAsEhycscN
 wschTi8NIaLF2j8voLGfURt+bdvqDNQqPowtGf8qtf8oCGrxGDPCnljJ4fShxtO46IbqrwA5Sgv
 +aBnUpp4xwA9IpX0J/eHyyunaUM1BQLVQbOcv89BhyGMqbq+P3UgfcxUzsooiHh/k0DzzVHrsc9
 uZhptSb/WysGhmKr5jpBQA18vZieTxAnjcI8wvgSAmJFUNi1z5nX+1AIUY6HZadxesCTY0od+Iz
 ljdDeyneZvWFho6ub4SNoL3c8Sa3Z3qALfcQND8oj5n2ILQDOqcIx+V57v6u/iCUpPIGHG2jzan
 WB3x8ASiApitRTnh/gBRS6CkvhHAYtnwmIhtvkG54LMsso5y+HmXqsrCUdX/tAS/9nvxl4vx8Vx
 soJpwWois4juy3A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, we noticed that some RST were wrongly generated when removing
the initial subflow.

This patch makes sure RST are not sent when removing any subflows or any
addresses.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Note:
  Please see the two TODOs in the code: two tests are expected to fail
  but Geliang is working on a fix.

  @Geliang: please include this commit (without the TODOs) in your
  series.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01480663c102..ab6908b7b143 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2343,6 +2343,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2355,6 +2356,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2367,6 +2369,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2380,6 +2383,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2394,6 +2398,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2408,6 +2413,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2422,6 +2428,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2436,6 +2443,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2455,6 +2463,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2469,6 +2478,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2483,6 +2493,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2494,6 +2505,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0 ## TODO: currently failing, Geliang is working on a fix
 	fi
 
 	# remove id 0 address
@@ -2506,6 +2518,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert ## TODO: currently failing, Geliang is working on a fix
 	fi
 }
 

-- 
2.40.1

