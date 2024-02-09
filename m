Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617553398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499752; cv=none; b=i+FE/uSjfe25NFgDBsjziNuNyj7mDjDIGdKjemh6vJonoKi26Ju8Lq0bkqqKPXJ5X3hIbIhKqxQx1ScEQmm/hstA+bFqip66S2jW5unkVuHa5J0ufuxnPNzQjOQBV1JpiKSs3i9m2g1m6G7oFfKsp8W5v0kdc1Aon7/02H56RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499752; c=relaxed/simple;
	bh=Q/q/MpSotLJM7xtBsnAgFAbv8VGi7THdXvJwIQw8TTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrVUQouWPGGxKE/xK0dkbTnvGf28TTFPMg8+YnXnxmgpZHl1hzRG5Q0UrPocMGhplAkStt19ykvU/Pmpnz5hEyndUFtBXWWVoTPUZN8mAnEMiaFbsVZT3XeoRQ2iBQPqPTWdzecABiwuZKX3mmgzwGfETiaOyZkElhHgUgTCNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USh6Agr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USh6Agr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE8AC433F1;
	Fri,  9 Feb 2024 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499752;
	bh=Q/q/MpSotLJM7xtBsnAgFAbv8VGi7THdXvJwIQw8TTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=USh6Agr6HWaG7p3AsoXsJDt0Y91M+qA+J4g7banezrgoQJj6i1eim4nSZ2DJjea9i
	 E7csml0/iIuNXJO3YqlZRdSXR/dGu3iz2wGhtPtEmkRFwIQTdXOdTwtVp367wLEcBK
	 bzYSpeHVm8oi2j9Jm6I9hTMjYKJ+OZmNmG3zNwKreGSxPyR2pzUsMkD5pqERJF10Rb
	 X9nI9T7ssjrZtP6CFxviBqOWA0HkryyntN7kYNHIlhtkgGGGZYZPsCTvJMGb2ZVxG5
	 tJkB4b3tn76zAHJpXlyefgCZZocutejI0/XMlyKIxYi27Ap0U28MCpbEPoxDeostzY
	 VrEl3aPxZdq0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Feb 2024 18:28:42 +0100
Subject: [PATCH mptcp-net 4/5] selftests: mptcp: diag: unique 'cestab'
 subtest names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-4-e4fb3a3b5f66@kernel.org>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q/q/MpSotLJM7xtBsnAgFAbv8VGi7THdXvJwIQw8TTI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDj/M8+e3pSnbNBtgS7Gac2PT+VjKPncFasG
 A64grCOzeWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4wAKCRD2t4JPQmmg
 c99UD/9vHLmO7c1z7/Oy62oVeSOkjeWzNVo3jNWWC9iJG0l+3FVWNDMuI8jaRkzrVaruvBbRpwz
 uH6KlJPhZ+N7XPh413FOMjMxeKCzm+d1NRr+Jlf/2iANMwW5D4mUl9YArexksrlEt1YbfBqabGO
 9YlQspu0Xigkg8iMCa1FAi0UgnOjjSawf4WdjAGIEiCp69xCmpKSAne8HO934JNBa5A8wf3b5ry
 ExvgRA7Ptwt6Kt9nXurCn7qCf3/q1zjmu4ezEo+svD92s82sXPT4fAJa6hdBBjfMcOfGEP/T7ju
 GTG4tXNLQSXwoPZoAGmwbSRCLq0TYqM+JjF6BOtkZ0k3dfMhoG8sxyGuD83zvSO0AHjUByyB9+4
 krbqRQauE2N+c/yG7qodBAW1n2/raxNsKcFz0SARxLF3p7aJc80uXn/OR8SKKTNWCbe4fMb8xC+
 XgXT7Xjozmg3Zp5u/AopZfjV5yi+pMLDWMW1apcBixqQTXO7gsmFNCS/AqLgJDxtMUoX+3ar3fe
 czPaDCWq0DEMiZJnYlU7qRR9iPAudXpGvCOXaDX70tcKGbgqGvETayP33YVeIWNqmvA6mhX4J2y
 vRTnnnydSTE1vVTeX+SnxTxWf2fvBxDnWkedgsI60SSkj/fKOfWA5NNjWk2yGLvOsfVDobzC7VN
 qM9BjeVdfj23Rlw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Some 'cestab' subtests from the diag selftest had the same names, e.g.:

    ....chk 0 cestab

Now the previous value is taken, to have different names, e.g.:

    ....chk 2->0 cestab after flush

While at it, the 'after flush' info is added, similar to what is done
with the 'in use' subtests. Also inspired by these 'in use' subtests,
'many' is displayed instead of a large number:

    many msk socket present                           [  ok  ]
    ....chk many msk in use                           [  ok  ]
    ....chk many cestab                               [  ok  ]
    ....chk many->0 msk in use after flush            [  ok  ]
    ....chk many->0 cestab after flush                [  ok  ]

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7e7e40601c6b..2cffa85a0bb7 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -189,10 +189,15 @@ chk_msk_inuse()
 # $1: cestab nr
 chk_msk_cestab()
 {
-	local cestab=$1
+	local expected=$1
+	local msg="....chk ${2:-${expected}} cestab"
+
+	if [ "${expected}" -eq 0 ]; then
+		msg="${msg} after flush"
+	fi
 
 	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
-		 "${cestab}" "....chk ${cestab} cestab" ""
+		 "${expected}" "${msg}" ""
 }
 
 wait_connected()
@@ -236,7 +241,7 @@ chk_msk_cestab 2
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "2->0"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -256,7 +261,7 @@ chk_msk_cestab 1
 flush_pids
 
 chk_msk_inuse 0 "1->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "1->0"
 
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
@@ -278,11 +283,11 @@ done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "many"
-chk_msk_cestab $((NR_CLIENTS*2))
+chk_msk_cestab $((NR_CLIENTS*2)) "many"
 flush_pids
 
 chk_msk_inuse 0 "many->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "many->0"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0

