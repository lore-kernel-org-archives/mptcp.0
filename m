Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72E29CF7;
	Sun,  8 Sep 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804217; cv=none; b=JxFXXrVUnu9frK6YsXZuNvY4zeYodRKOW47EZ1CeQrDxcIeQp55jZsAP2HK8yjFoWj6P/l9Iu5ZQRxArU0vDjcKOQVvYnJ1BnTJc8x0ezasdUaiABr8GkQwwOB0KCN4WvW72jWI3L5Mt2JQ2RjGfGIm6nokTwSznLC5ozmGYH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804217; c=relaxed/simple;
	bh=icMbO+HkDcLHbYzdkxAjPKTtzTt+CbHdee81oUD6VDY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=qCWLYu6CIsl7ynrKRq9WA8/DQ5D6GMlYaugv07c4YJaDra1eGxzmzdbZeqv+dlzxKoXagBQcVCxCAztB9u74hVHs25E7xtod5WEmiQmDf3y/vcKDSrb+rFFExfjP6q3CJ2DsgUB3SHbfw03ikKTzVIOJYZ/qqNFvST67YsDOaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ECynAVnf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ECynAVnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB05C4CEC3;
	Sun,  8 Sep 2024 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725804215;
	bh=icMbO+HkDcLHbYzdkxAjPKTtzTt+CbHdee81oUD6VDY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ECynAVnfRFXp7UFRbIrjbYHTpJOnOdcHNqhjCEXwDrsbPsQwUYpyb8omMOXVVvjDg
	 MumqGglHDa3FYSSix4gZS8TiD0UBtmXhxaNsedCDSC15T8Q4CtfMLmkztEDeraNMGz
	 J+Iq/9wON/ucNYcYlPu6fIw7JqYrvWFRMD20rVVs=
Subject: Patch "selftests: mptcp: join: validate event numbers" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 16:03:23 +0200
In-Reply-To: <20240905144306.1192409-7-matttbe@kernel.org>
Message-ID: <2024090822-groggy-repaying-d64f@gregkh>
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

    selftests: mptcp: join: validate event numbers

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-event-numbers.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73612-greg=kroah.com@vger.kernel.org Thu Sep  5 16:44:28 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  5 Sep 2024 16:43:09 +0200
Subject: selftests: mptcp: join: validate event numbers
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240905144306.1192409-7-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.

This test extends "delete and re-add" and "delete re-add signal" to
validate the previous commit: the number of MPTCP events are checked to
make sure there are no duplicated or unexpected ones.

A new helper has been introduced to easily check these events. The
missing events have been added to the lib.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh and mptcp_lib.sh, due to commit
  38f027fca1b7 ("selftests: mptcp: dump userspace addrs list") -- linked
  to a new feature, not backportable to stable -- and commit
  23a0485d1c04 ("selftests: mptcp: declare event macros in mptcp_lib")
  -- depending on the previous one -- not in this version. The conflicts
  in mptcp_join.sh were in the context, because a new helper had to be
  added after others that are not in this version. The conflicts in
  mptcp_lib.sh were due to the fact the other MPTCP_LIB_EVENT_*
  constants were not present. They have all been added in this version
  to ease future backports if any.
  In this version, it was also needed to import reset_with_events and
  kill_events_pids from the newer version, and adapt chk_evt_nr to how
  the results are printed in this version, plus remove the LISTENER
  events checks because the linked feature is not available in this
  kernel version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   90 +++++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   15 ++++
 2 files changed, 104 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -394,6 +394,25 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	evts_ns1=$(mktemp)
+	evts_ns2=$(mktemp)
+	:> "$evts_ns1"
+	:> "$evts_ns2"
+	ip netns exec "${ns1}" ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+	evts_ns1_pid=$!
+	ip netns exec "${ns2}" ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+	evts_ns2_pid=$!
+}
+
+reset_with_events()
+{
+	reset "${1}" || return 1
+
+	start_events
+}
+
 reset_with_tcp_filter()
 {
 	reset "${1}" || return 1
@@ -596,6 +615,14 @@ kill_tests_wait()
 	wait
 }
 
+kill_events_pids()
+{
+	kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
+	kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3143,6 +3170,32 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: event type ; $3: count
+chk_evt_nr()
+{
+	local ns=${1}
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evts="${evts_ns1}"
+	local evt="${!evt_name}"
+	local count
+
+	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp})"
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		echo "[fail] got $count events, expected $exp"
+		fail_test
+		dump_stats
+	else
+		echo "[ ok ]"
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3265,11 +3318,13 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3301,14 +3356,30 @@ endpoint_tests()
 			chk_subflow_nr "" "after re-add id 0 ($i)" 3
 		done
 
+		kill_wait "${tests_pid}"
+		kill_events_pids
 		kill_tests_wait
 
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 4
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 5 # one has been closed before estab
+
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add
-	if reset "delete re-add signal" &&
+	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
@@ -3339,8 +3410,25 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 3
+
+		kill_wait "${tests_pid}"
+		kill_events_pids
 		kill_tests_wait
 
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
 		chk_join_nr 4 4 4
 		chk_add_nr 5 5
 		chk_rm_nr 3 2 invert
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,6 +4,21 @@
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
+# These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
+declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_CLOSED=3            # MPTCP_EVENT_CLOSED
+declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_SUB_PRIORITY=13     # MPTCP_EVENT_SUB_PRIORITY
+declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+declare -rx MPTCP_LIB_AF_INET=2
+declare -rx MPTCP_LIB_AF_INET6=10
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-validate-event-numbers.patch
queue-6.1/selftests-mptcp-join-check-re-re-adding-id-0-signal.patch
queue-6.1/selftests-mptcp-fix-backport-issues.patch
