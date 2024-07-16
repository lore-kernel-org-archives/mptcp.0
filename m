Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A54F95
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163208; cv=none; b=ZpBpHqTwI/HLB0khbMdDZjxGKW6aVHnZ2MhudTqbq2mYva4rpmco0l9NIdP5ux7eGsrDNUDQh9P7t1Ma0pF5xFP4AD6owL19jI2+fIXa/RVdSj5MaJRKUJMLnU1ZPreUa8QiBY6Yiib3wQ7deTc/68vlBqrbEJQtrKrVAJeGihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163208; c=relaxed/simple;
	bh=y+9lvgnvtgDRX5f09qLB3GnotikWJoKiqrQbcHj7jI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ES59fREmQwH1kvS295mVWxpq01xUS9tU4+eS7l5OOEIZzLs4oKaj34dfZ5MBoR1CA/F8aEVXu+ycFl9mJRBRz16mWgjuJu5ZCWFBXL+Tc20RQvgcLDZiDbMVZwNHF+Wx+S3LTPJ2yAvDXh1D1qQ63v30sx+sruuSeUvkheLD/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdeHd9x/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdeHd9x/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81EDC116B1;
	Tue, 16 Jul 2024 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163208;
	bh=y+9lvgnvtgDRX5f09qLB3GnotikWJoKiqrQbcHj7jI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QdeHd9x/kyjBbslr+qVQW9PnOa2ouUsegJPN8KswdueK1xpHIpR29rAdIT1wM2PW5
	 Pn1FOgWwbnEbM6NMh4IKuAFt+pxMCQYIwueNbz2fqKRwIykquiuYrXLuyeRIFhfEbU
	 Lg2slANkV9sz9a56WANbrSJwg0nvlOA5wY0epWMzzphbuBVpWO/eqqkUsO8V0Rqz7u
	 mZlSty8zeaUNsItl6iNirbhqGhf0f+xmWCegOmgBgTC29uNcYYS401YH5YCxKMwbTP
	 XR02/9p1I/6AWVUoB+AIWQjnqUBYIIawkYVOKh0AFBMGtI+wytAmkI3OJmj49SSz/A
	 LZuYXY6MbN9Ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:17 +0200
Subject: [PATCH mptcp-net v2 5/9] selftests: mptcp: join: validate backup
 in MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-5-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4145; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y+9lvgnvtgDRX5f09qLB3GnotikWJoKiqrQbcHj7jI0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BXTz7xAsW8qIvWi4/9qXWkYB83YPQ2z1yJ
 NXoqKmjwzeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 c8PrD/0fs4N3byEv6+QnTmcTZE4M8QD1TW6YuBi+xBATrUqsfVU9jlb4nsmsI0SPvbcqjv/ljNh
 XEGktOD+UTqXlq7+Mup+OWZY0y0avBn8OLdfHsT5bTllCb+wCmhjNdMdxVPlAkpKRgkWSsY11bI
 NvqOV7qkEseTFrOXPsnczRlNt3EDTkh5oIRKbNikcahSsSTHbtWwXVH7mH+g7to++fsfENLYgmC
 +JQRzLtWNWRXz5+wWDj7ajg6a5nv1tf9x97jM1fwFJMt2BL3h3fyIlf4XpYCZVWukYI2LwaKpG8
 vb6dvODq5z2XjLbyCraM+6j4D/MqCDYj256bJis5dB6q8Gv2kl+XvJIX4vNhKvz4ViLz0s68MMq
 f8rVHhJ/ClbCHpW6OIUdG6I9jRcL4GelKI5BfTuFzEy39mLLnCyM59Te/owYgrIc+1dBpthW165
 XdGPDYCj05DRg2kxnnDgB4tbMFptoGJHsyFOxoA2uqBBjbWUmFTljLinS37i4YVSIvIdvl4wYAj
 Gz1SrczWewuKjHljflmIY7f/+C5NY0ErzERCSr8pIQE3oeWdeehPnoQSiVuA7/gxh7iQ/pf+EXg
 zxhbbNvdgf1+h3ObBc6v9x2nGCtQqQSP2HPnTXCqdcYm9B3MQuLMeS6p6qIgS/JkTe7khhY7EIM
 UIlKQ9qMwOVJSfA==
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
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 42 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55d84a1bde15..175127a9c00c 100755
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
+		fail_test "got $count MPJ SYN[s] with Backup expected $mpj_syn"
+	else
+		print_ok
+	fi
+
+	print_check "synack backup"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		fail_test "got $count MPJ SYNACK[s] with Backup expected $mpj_syn_ack"
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

