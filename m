Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474C4D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318051; cv=none; b=hNpK6cPu6SGjxp3+jerdpExRDJF0xIA/w2t3Osq9BIJJW7e/I4RJnsw2bKnMZWzbakUXUUr8yHcSbiizJaiDmZPRVtB26Ngj7zcCfWLEzm4WuJkzREdMt5OOP3zGw5USV/O38C+7MxrdgICuFEYk6BYeYmk7HAjQETJofUmrjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318051; c=relaxed/simple;
	bh=8JLLnKMqljQzI6JGwmBICIuuJvxiD6KinxFxILNjiWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAyIDIN7iCc1y+yE3lf7L/Bhsy5P/d/xoWcQlIrzDT6ae/cXhHyMRBnh+xFUc1otKOXlvepH7IHGgh8bJnj5DANXtF98am/uGU9Np20EjiVPNwDIVRgzwkQVxXSzh0DhC7CRnQIaqQiZaHgZMei1k5FgRHMMNnWFwARTK81i1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi21LgIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi21LgIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE14C4AF0A;
	Thu, 18 Jul 2024 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318051;
	bh=8JLLnKMqljQzI6JGwmBICIuuJvxiD6KinxFxILNjiWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gi21LgIoNd/j00IF8USmselgX6dNNaWkMP3mAra7KvXsoQ/o697ZnGcBtVMCAoRQd
	 NLZRj+8nCa+OtCWAcDWhBNOIa4fmTYnbGQ4OYAQ1zh7Xcwc6mWgK8Licsna3QQelJd
	 X7Iz4MHsguSDi2UZsoGTQfP4exOAOftKi4lag4efdtA84QcMHh12Z0c+i/sBo/qrcf
	 NSBgEgTD9t6RyCzud2Fmjuprcs8AtN8eaXwDzL+2/eB624F0/0hFcPeyu8V9Qodwvu
	 uvnb/EFGciSDcfh7DvZh/yWzrgLVKhU0XEtbLmYj0kd37qsfG8j9+pR4Ve05+Eabhl
	 MHX6KXpqy3fHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:04 +0200
Subject: [PATCH mptcp-net v3 7/9] selftests: mptcp: join: check backup
 support in signal endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-7-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3753; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8JLLnKMqljQzI6JGwmBICIuuJvxiD6KinxFxILNjiWs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbs+1Wf9RaI70zemVWSmdiquB/2gxH3dxQG
 MazFNVCBnaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c4QNEADIO1Yn9S/kneodeT+U3+QgcU8LrXILqJ9lhLBo24OX7L0tVAgnBm+eQnux6zkQvmCQAO/
 3oXPF+7fx1s/aHYBiyhqovcKQvKtPgkpfJ7mD2BjQLNLUmkVrul2Ny9aAa6m7Ptwkr3dpi+oqph
 O5WHvA0kumGqnM8Dn26ySZzS8Ch7rhSJPyn8il/HuXQcFMHSJf7jtjGnMwGEP6AjWUoZ5loBCZW
 ZOCEkIInBY1ZAnD/FP2iVaWS2P9A9vHh+5i1re4SCvPtvQfFVvPMLE2TpgC4cLYmyyCesIaIwlp
 3lSQ5LiyuTSiACn7iyaAzYhFUeNhSQ7tskNwA6D0uWxqGi8+tAG7ZNL8c14SurzPNh7z+OIV/Kb
 7KqtF9cQ36p6hm411XwIFuSlupL7q94tVtS53q9oCU7tYk9eAfeaQu4N9zOQb9m+YDPdO+yDvgR
 D4S+d4zEor63ucObk1cSpwH4mNGL5oY08sz/o4ShhfXQXwAd6VEgJrYrKetuwYe7LF1fK+sAYNV
 T4ZyXXAkPshZir7fzK7TL1x0NPlFfdsdTrQyXVYmLd2uTjF+q3DboNAMVPJsh7fUQQU4asScVml
 hyPr0+CCQnqES/2GxPqJ5gfh47Z1JHmAb0KvH+pj7dOukc2gRsjVJmsM9thdx5hbxmdpcChznzc
 ryPQdqKqTUNlAjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before the previous commit, 'signal' endpoints with the 'backup' flag
were ignored when sending the MP_JOIN.

The MPTCP Join selftest has then been modified to validate this case:
the "single address, backup" test, is now validating the MP_JOIN with a
backup flag as it is what we expect it to do with such name. The
previous version has been kept, but renamed to "single address, switch
to backup" to avoid confusions.

The "single address with port, backup" test is also now validating the
MPJ with a backup flag, which makes more sense than checking the switch
to backup with an MP_PRIO.

The "mpc backup both sides" test is now validating that the backup flag
is also set in MP_JOIN from and to the addresses used in the initial
subflow, using the special ID 0.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Also validating MPJ to/from ID0 with backup
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c8d86017f3..4df48f1f14ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2639,6 +2639,19 @@ backup_tests()
 
 	# single address, backup
 	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
+		pm_nl_set_limits $ns2 1 1
+		sflags=nobackup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_prio_nr 1 0 0 1
+	fi
+
+	# single address, switch to backup
+	if reset "single address, switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2654,13 +2667,13 @@ backup_tests()
 	if reset "single address with port, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup speed=slow \
+		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1 0 0
+		chk_prio_nr 1 0 0 1
 	fi
 
 	if reset "mpc backup" &&
@@ -2674,12 +2687,21 @@ backup_tests()
 
 	if reset "mpc backup both sides" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
-		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+
+		# 10.0.2.2 (non-backup) -> 10.0.1.1 (backup)
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		# 10.0.1.2 (backup) -> 10.0.2.1 (non-backup)
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		ip -net "$ns2" route add 10.0.2.1 via 10.0.1.1 dev ns2eth1 # force this path
+
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-		chk_prio_nr 1 1 0 0
+		chk_join_nr 2 2 2
+		chk_prio_nr 1 1 1 1
 	fi
 
 	if reset "mpc switch to backup" &&

-- 
2.45.2

