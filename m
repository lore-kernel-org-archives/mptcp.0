Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7032D5936
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083023; cv=none; b=GA74e6kWt05JHJKrNhCeLop5ipG2pF8YdUjE+/PvLrP+lAfIBOkOBAjK8v5svuVuW2sBUkOBrAX8+jB9spUJrK7SIQImi0kMZ2LE1dE9qJhgbxT55zoM2LHOGLtPvU7K2TerVMei7AoG9vWa75J0BKt0m65lfBS9sIOsS8V9FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083023; c=relaxed/simple;
	bh=glEMJ7NhArT1aQG4urKiW3p8ogCxkHbTuTgMGKWEQ98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSBFJJNjiv26K2P/wy80ltGmTZ74MTpZpU7Sdl+kGGOu+llO1gRKDpRlAraNb20CLXAGYdd0x4SIzzUeA7Q8sWVYMGaWaUsjXEaHIyf+361/2mJNk3bM6ZYbTCLZ3hGlQqpNweu2kQvNPooOdEbTqchdtfAe96j0FH2BQCN7IBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeMD4knF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeMD4knF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A4EC4CEF7;
	Sun,  2 Nov 2025 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083023;
	bh=glEMJ7NhArT1aQG4urKiW3p8ogCxkHbTuTgMGKWEQ98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IeMD4knFGZVuYfJyHbD1FP0dsc9Rd3NPJOBFN2Fhpw0Nd5eaF1VBY1KYb5Y3jNje1
	 fAuZzjOTzZsKfnKKLtfzUtaOT8azFj/jvfdeiQCm2WR/SGyhJs7ZN1ulUdainPtf5D
	 KreIbjBou1rIpk5/1j6jXzSbZpVy3IeZMp4krFE55dbcssHUaWqR1YmxQkDOfM09sF
	 4de4hzo/fL4dAXHZEj3263i/KzuT/Xgj0ARUbAMGFHb+OHXQrDa+XHZpDrNmbZRAEg
	 9ZBX6h4YpXEIlDJeymW1s6K0GqPEanzI0vgj8/ftI7rR7kJ2HJOGqTEzPH3GjySo70
	 TDo+WdARjgJIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:04 +0100
Subject: [PATCH mptcp-net v2 2/6] selftests: mptcp: join: rm: set backup
 flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6701; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=glEMJ7NhArT1aQG4urKiW3p8ogCxkHbTuTgMGKWEQ98=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHY6HV1jn/gp8L3a/5p5hCtMn45PpSjvM3kT93vPuh
 etlGbZbHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpfMTwP1Z47t2UuF0M3j6X
 qnQqJ3wtmfnj1b53pzfmFL86lBijY8jwz4Q94uWlh/UB3xhW6IY833WhWKN0ws9M3fuluy6mHpQ
 vYwAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some of these 'remove' tests rarely fail because a subflow has been
reset instead of cleanly removed. This can happen when one extra subflow
which has never carried data is being closed (FIN) on one side, while
the other is sending data for the first time.

To avoid such subflows to be used right at the end, the backup flag has
been added. With that, data will be only carried on the initial subflow.

Fixes: d2c4333a801c ("selftests: mptcp: add testcases for removing addrs")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++++++++-------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e0cdb9c662aa..399805812197 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2552,7 +2552,7 @@ remove_tests()
 	if reset "remove single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns2=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
@@ -2565,8 +2565,8 @@ remove_tests()
 	if reset "remove multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns2=-2 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
@@ -2577,7 +2577,7 @@ remove_tests()
 	# single address, remove
 	if reset "remove single address"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 1
 		addr_nr_ns1=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2590,9 +2590,9 @@ remove_tests()
 	# subflow and signal, remove
 	if reset "remove subflow and signal"; then
 		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
@@ -2604,10 +2604,10 @@ remove_tests()
 	# subflows and signal, remove
 	if reset "remove subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-1 addr_nr_ns2=-2 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2619,9 +2619,9 @@ remove_tests()
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup id 250
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2634,10 +2634,10 @@ remove_tests()
 	# invalid addresses remove
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal,backup
 		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2651,10 +2651,10 @@ remove_tests()
 	# subflows and signal, flush
 	if reset "flush subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2667,9 +2667,9 @@ remove_tests()
 	if reset "flush subflows"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup id 150
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2686,9 +2686,9 @@ remove_tests()
 	# addresses flush
 	if reset "flush addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup id 250
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2701,9 +2701,9 @@ remove_tests()
 	# invalid addresses flush
 	if reset "flush invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1

-- 
2.51.0

