Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8C4D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318049; cv=none; b=BrA5JU7hYFzOdRkM8CfWXPVQCtK2yCE/EM+jNSxA5q1T95S/nk96orT+ZPSYn7wz5rOKzExDqJpUkGMUKqHrrhXU9smL+dh98BlImzjBQIVm911aGcTym8k0JXZDLu+XOn7IzkUbB5TT6oEJL2E0atomaBqll0L/mhTWz/9lVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318049; c=relaxed/simple;
	bh=+4+H5hfHG7pX8V5vvNtS+y8btcJQ02UXCvlFX2Wpseo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpG8hyR+qOaSvT0Nl+4OIO1hVyq6UkL8SzhC9GtxvPifQ5bqqur4/fsVBVx5LXnpvA23vjQ6JwFiRqpuXIS+fYAW4qvEyMKl/r/49qrwiGnr7xONpueKwThGtXuVotPNwisyd2HQVBGbmKVJMQHEHO5M8fmS3xHDUq7t5ELt28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K12YSB8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K12YSB8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C83DC116B1;
	Thu, 18 Jul 2024 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318049;
	bh=+4+H5hfHG7pX8V5vvNtS+y8btcJQ02UXCvlFX2Wpseo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K12YSB8/DKyv8uhxYX9r0d6CKOfpHNQLpXS4WV6wd69aUjCT72XxlEaa8BTSN+lVV
	 mwxlDSq+ghUOqRh54MzIUpbaKzGW5MK5o52rV63SbweBfMGNbhTmhVVtpOCsODuj/E
	 mzQME6hFVClHK36Ly043NPWYarnWofOVUuUYY6NMBs5PDboPzlcDA1i4baZHvpxf26
	 q995/505z3XEaySDZ52NMR4ISeAVnZDnH1rJHfmzKlTQuckSH0eCUGy/V28NOPIddl
	 0Fll/ClgYOT0fyp7rxMWSOagl+tIYjahfd0D7Pn6u/E+9ezU5OLicklv8oEl82vlM3
	 5g05NiroAjQcw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:02 +0200
Subject: [PATCH mptcp-net v3 5/9] selftests: mptcp: join: validate backup
 in MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-5-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+4+H5hfHG7pX8V5vvNtS+y8btcJQ02UXCvlFX2Wpseo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbxjEMUeDX7LhfmB/eVRhZjPjz3WRK7Pvxf
 dbortchMM+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c2tBEACOqbIsK3QQw+755XnZzK8aVgUFyNOayyHOQzUcZLsGXly7JH33PYJqdcFRYOAiVepsFdZ
 X3KZi2kCkxrRixsILDQ4R6354oFEtQP4Tmdw1yDmQ7SLoaVDQ3TczG72+H3fj0w2MStU8nWvKrB
 sziQJ7Eoyx7UBP7VoiDmnn9KX4k/cNeoIwQn2M9Un5mv2wHzBfYGyXzUe7/Ej1v6fn3mAwivgM6
 OwVmnCPb94JhiNgMFLhrO+k8KbCto6qnqhshleJB5SM1III1JIsRQtZmCRw8KdjNfQP7k+HfhOi
 Cg41f7/Q994GUip6skAEmJp4tzIVkPt377ePLxC90fzxJlawMIPUHkDHrkb1fyRZev6mfHr2hL4
 9i4yXKX53AIS2NFStIiJOmdWKO02sqz6mIFCOSjzk2HQxMg2U0OfwtZG4rvr6wD4A+r4zjjS5Ka
 iWCQovhHf1oMyRQgRXiiNTsqMmp0afnzJzB2ZxYn9+qK55WOSXD0kens8SVeSo+Hr5MYO/1wdNK
 yT1lC56kM65tF9qa2TQvA2PiCpX65GUDXwMHJJ9mdPt/0UeSvbv0AIECyVex/r5hoWdEva9do3a
 7d+rgCbbUrIh1QeGlrRg/VYnciW724UdNIyauMIhF6SASLXmp/iHEI6ztaZ/p4FQu4zsay8SrBt
 uKVI6+U6UQZHThQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A peer can notify the other one that a subflow has to be treated as
"backup" by two different ways: either by sending a dedicated MP_PRIO
notification, or by setting the backup flag in the MP_JOIN handshake.

The selftests were previously monitoring the former, but not the latter.
This is what is now done here by looking at these new MIB counters when
validating the 'backup' cases:

  MPTcpExtMPJoinSynBackupRx
  MPTcpExtMPJoinSynAckBackupRx

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it will help to validate a new fix for an issue introduced by this
commit ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - Use error message similar to other JOIN tests (Geliang).
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 42 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55d84a1bde15..e6c8d86017f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1634,6 +1634,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 
 	print_check "ptx"
@@ -1655,6 +1657,26 @@ chk_prio_nr()
 	else
 		print_ok
 	fi
+
+	print_check "syn backup"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn" ]; then
+		fail_test "got $count JOIN[s] syn with Backup expected $mpj_syn"
+	else
+		print_ok
+	fi
+
+	print_check "synack backup"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		fail_test "got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+	else
+		print_ok
+	fi
 }
 
 chk_subflow_nr()
@@ -2612,7 +2634,7 @@ backup_tests()
 		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 	fi
 
 	# single address, backup
@@ -2625,7 +2647,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	# single address with port, backup
@@ -2638,7 +2660,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc backup" &&
@@ -2647,7 +2669,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc backup both sides" &&
@@ -2657,7 +2679,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc switch to backup" &&
@@ -2666,7 +2688,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc switch to backup both sides" &&
@@ -2676,7 +2698,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 }
 
@@ -3053,7 +3075,7 @@ fullmesh_tests()
 		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 
@@ -3066,7 +3088,7 @@ fullmesh_tests()
 		sflags=nobackup,nofullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 }
@@ -3318,7 +3340,7 @@ userspace_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
-		chk_prio_nr 0 0
+		chk_prio_nr 0 0 0 0
 	fi
 
 	# userspace pm type prevents rm_addr

-- 
2.45.2

