Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439602E8B86;
	Wed,  3 Dec 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768727; cv=none; b=bn+ckH30E1xzqzzkUA262ShMUtgpB5+WrT0/K/7tXSm/Y7Liv4ZgEOyCiT9R0SCGMbOR6IcyHxL57ROOP2YwcydhTCeR6GRqRrqNxf0PDx7s6zf5GNPaV9mRd97xHSSe112oPyK9aQYLAXpUj1uGEsHUFLd1yaan5RUnO2HW2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768727; c=relaxed/simple;
	bh=u9gnSTJiAF2u/nBG7jQiy9HGLn3JSxSzKJjdgaOrWCo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GYxvutnmDDOXpnFtfXX4H7RCUIdJzQDl+FevMQ/6BVZTIDtM5ARvRmFTMSpLTzWn0dlA9baF+tKax+OiAMwpauoxN/mSxtD50QbWHXYnhwwzyno7j60HBEmpK0NhKV5gMma2bFJmvj8CVqqHGksgbe5iFAkgFOYPkp/HohvyCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=loy9Rnfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="loy9Rnfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3F8C4CEFB;
	Wed,  3 Dec 2025 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764768727;
	bh=u9gnSTJiAF2u/nBG7jQiy9HGLn3JSxSzKJjdgaOrWCo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=loy9Rnfm1X+0/hVxFAUrKoHlTk2KYf+rLVlfo+XtVkl6vDupzuFD6lF2O8mHhrBc5
	 f6nK/qyCyg0KBdGkUOKzFXlQPdcT1kpXtFMPd89T4PUiX1chiG0VZ1xPa7yPEpvDCM
	 ZT2Vq4Xp/3SS2wLzLLuZpU2I32eP2V5U+KGoJL+4=
Subject: Patch "selftests: mptcp: join: rm: set backup flag" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Dec 2025 14:31:37 +0100
In-Reply-To: <20251129165729.2127525-2-matttbe@kernel.org>
Message-ID: <2025120337-ditto-icon-3099@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: join: rm: set backup flag

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-rm-set-backup-flag.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197645-greg=kroah.com@vger.kernel.org Sat Nov 29 17:58:02 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Nov 2025 17:57:30 +0100
Subject: selftests: mptcp: join: rm: set backup flag
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251129165729.2127525-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit aea73bae662a0e184393d6d7d0feb18d2577b9b9 upstream.

Some of these 'remove' tests rarely fail because a subflow has been
reset instead of cleanly removed. This can happen when one extra subflow
which has never carried data is being closed (FIN) on one side, while
the other is sending data for the first time.

To avoid such subflows to be used right at the end, the backup flag has
been added. With that, data will be only carried on the initial subflow.

Fixes: d2c4333a801c ("selftests: mptcp: add testcases for removing addrs")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-2-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The subtests structure has changed quite a bit in newer versions, see
  commit c7d49c033de0 ("selftests: mptcp: join: alt. to exec specific
  tests") and commit ae7bd9ccecc3 ("selftests: mptcp: join: option to
  execute specific tests") for example.
  To resolve the conflicts, the same principle has been applied: adding
  ',backup' for each non-ID0 endpoint in remove_tests. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   54 ++++++++++++------------
 1 file changed, 27 insertions(+), 27 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1269,7 +1269,7 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1278,8 +1278,8 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
@@ -1287,7 +1287,7 @@ remove_tests()
 	# single address, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
@@ -1297,9 +1297,9 @@ remove_tests()
 	# subflow and signal, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1308,10 +1308,10 @@ remove_tests()
 	# subflows and signal, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1320,9 +1320,9 @@ remove_tests()
 	# addresses remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
@@ -1332,10 +1332,10 @@ remove_tests()
 	# invalid addresses remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal,backup
 	# broadcast IP: no packet for this address will be received on ns1
-	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
@@ -1345,10 +1345,10 @@ remove_tests()
 	# subflows and signal, flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1358,9 +1358,9 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup id 150
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
@@ -1368,9 +1368,9 @@ remove_tests()
 	# addresses flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
@@ -1380,9 +1380,9 @@ remove_tests()
 	# invalid addresses flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.15/mptcp-disallow-mptcp-subflows-from-sockmap.patch
queue-5.15/revert-docs-process-howto-replace-c89-with-c11.patch
queue-5.15/mptcp-fix-race-condition-in-mptcp_schedule_work.patch
queue-5.15/mptcp-restore-window-probe.patch
queue-5.15/mptcp-fix-proto-fallback-detection-with-bpf.patch
queue-5.15/mptcp-do-not-fallback-when-ooo-is-present.patch
queue-5.15/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.15/selftests-mptcp-join-rm-set-backup-flag.patch
queue-5.15/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-5.15/mptcp-fix-ack-generation-for-fallback-msk.patch
queue-5.15/mptcp-pm-in-kernel-c-flag-handle-late-add_addr.patch
queue-5.15/mptcp-fix-premature-close-in-case-of-fallback.patch
queue-5.15/mptcp-fix-a-race-in-mptcp_pm_del_add_timer.patch
queue-5.15/gcov-add-support-for-gcc-15.patch
queue-5.15/mptcp-avoid-unneeded-subflow-level-drops.patch
