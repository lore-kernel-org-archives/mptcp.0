Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4D186E2E;
	Tue,  2 Dec 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691392; cv=none; b=YU87ovALZyqVHGBJG/AOhNePs0tzlmTjlWeym02O1NPh/pIKhZ0I8eWcYOr08SqFbQElwoXNeo7V+/ZX81RDj4SjnmZ9oBg5kczDOTJTWLZZYqcX4HBb5zYIgTOminTIyXvgl3bgzR61PjulCBmYuLvVLjfbjrambT3Hjwk1l9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691392; c=relaxed/simple;
	bh=fYCDeDcj9pNv/mfsKKmk2uwvO7Y7Kxac6VTOaKZ1izs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=CtHysFYm3YRhZAW1dGfGX7X1itnEf7OWilC0K+TWO8ClINeihbeGCnEI7d9M/RwjkRQWdzcI7QanZMqC8lqLa/qYP63CVq/PPfsiC51lMh7ImnweiSEZQP39MN9BEN403xzHZlwNfu+WGG3z8AWxYqmAAfdZhp36PnXtrZ/cWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lYbdQxt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lYbdQxt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6F9C4CEF1;
	Tue,  2 Dec 2025 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764691391;
	bh=fYCDeDcj9pNv/mfsKKmk2uwvO7Y7Kxac6VTOaKZ1izs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=lYbdQxt7JlYRGUvZiO3As3Ag53dkTjjFscxwHl8jnMZab/QubP4mc4EUjE9noaPqo
	 YWbVtAuIZqdZnb0sdH5pbKm7tKfNJIozieDVdJ1bG7XdTNZi+oUMLRZFNMIClKGeD4
	 XjEe6UVIlZLugk3ZSW8l+0iayRFqIdGUIzDOIXjw=
Subject: Patch "selftests: mptcp: join: endpoints: longer transfer" has been added to the 6.1-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 17:02:44 +0100
In-Reply-To: <20251129165510.2124040-2-matttbe@kernel.org>
Message-ID: <2025120244-scraggly-drone-522a@gregkh>
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

    selftests: mptcp: join: endpoints: longer transfer

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-endpoints-longer-transfer.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197643-greg=kroah.com@vger.kernel.org Sat Nov 29 17:56:00 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Nov 2025 17:55:11 +0100
Subject: selftests: mptcp: join: endpoints: longer transfer
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Message-ID: <20251129165510.2124040-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 6457595db9870298ee30b6d75287b8548e33fe19 ]

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all endpoints tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-3-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ removed curly braces and stderr redirection ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Conflicts in mptcp_join.sh because commit 0c93af1f8907 ("selftests:
  mptcp: drop test_linkfail parameter") is not in this version. It moved
  the 4th parameter to an env var. To fix the conflicts, the new value
  simply needs to be added as the 4th argument instead of an env var. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3313,7 +3313,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3336,7 +3336,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3401,7 +3401,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3464,7 +3464,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_20 2>/dev/null &
 		local tests_pid=$!
 
 		wait_attempt_fail $ns2


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-endpoints-longer-transfer.patch
queue-6.1/mptcp-disallow-mptcp-subflows-from-sockmap.patch
queue-6.1/selftests-mptcp-connect-trunc-read-all-recv-data.patch
queue-6.1/mptcp-fix-race-condition-in-mptcp_schedule_work.patch
queue-6.1/mptcp-restore-window-probe.patch
queue-6.1/mptcp-fix-proto-fallback-detection-with-bpf.patch
queue-6.1/selftests-mptcp-join-mark-delete-re-add-signal-as-skipped-if-not-supported.patch
queue-6.1/mptcp-do-not-fallback-when-ooo-is-present.patch
queue-6.1/mptcp-decouple-mptcp-fastclose-from-tcp-close.patch
queue-6.1/mptcp-fix-duplicate-reset-on-fastclose.patch
queue-6.1/mptcp-drop-bogus-optimization-in-__mptcp_check_push.patch
queue-6.1/selftests-mptcp-join-rm-set-backup-flag.patch
queue-6.1/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-6.1/selftests-mptcp-disable-add_addr-retrans-in-endpoint_tests.patch
queue-6.1/mptcp-fix-ack-generation-for-fallback-msk.patch
queue-6.1/mptcp-pm-in-kernel-c-flag-handle-late-add_addr.patch
queue-6.1/mptcp-fix-premature-close-in-case-of-fallback.patch
queue-6.1/mptcp-fix-a-race-in-mptcp_pm_del_add_timer.patch
queue-6.1/gcov-add-support-for-gcc-15.patch
queue-6.1/mptcp-avoid-unneeded-subflow-level-drops.patch
