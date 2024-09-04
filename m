Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFE1D014A;
	Wed,  4 Sep 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460172; cv=none; b=tKgnAu8DpKS1MwS72w7Kf+SrOEXcqdvjcg+B3DgVrh2Tlk1oZiArxMtXbvbVEKSfZrvXMtOqAisxh4Xw0Hfw/DMROhQxNjB6M32GFpCFamzgpV6/22XrDUec8ykiNlTFlglmwVsuoCqpz7Oe5UtcNQ4rxjLUomt2UA1StDxgpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460172; c=relaxed/simple;
	bh=XjHDCWlQDN+7H5m/ZsUN0ib5UNreV7SWViTKUZcHw3c=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=uSR8aEnR/4uK2yXM560PUgyiC/kut5fB5yHssD1+TSDhPhdL2Hq+2GtoUT8DYCly5aXLANPp1ZWtDQ+RTDP5FVHeInakR3T/2hCAln5HxszFESEsmvsw2powsLFbo2UQi6hwZDkuKwr9nAp2nRJb/1g4fbbncYtOqQKbAV7/708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXLg2k0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXLg2k0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F3DC4CEC2;
	Wed,  4 Sep 2024 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460172;
	bh=XjHDCWlQDN+7H5m/ZsUN0ib5UNreV7SWViTKUZcHw3c=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=fXLg2k0VueRBaYbfFnETPon7b4Oez0IJclVNbAsRUZuxaqDkdtyD40w6I213Moc0c
	 Deowacknc7a6qy5rQ+XFXMXIC2Hkv/MvlobYo62RssXUFMpYud7VMxDbq/2A5Q4fFX
	 xHSpXAh+nIPVycRUBtTJJmtzMu02K5sg6e3S1r0s=
Subject: Patch "selftests: mptcp: join: validate event numbers" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:29:06 +0200
In-Reply-To: <20240903102347.3384947-7-matttbe@kernel.org>
Message-ID: <2024090406-paralysis-partake-fb9e@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-event-numbers.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-72805-greg=kroah.com@vger.kernel.org Tue Sep  3 12:24:15 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue,  3 Sep 2024 12:23:50 +0200
Subject: selftests: mptcp: join: validate event numbers
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240903102347.3384947-7-matttbe@kernel.org>

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
  to ease future backports if any. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   74 +++++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   15 ++++
 2 files changed, 86 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -464,12 +464,17 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+}
+
 reset_with_events()
 {
 	reset "${1}" || return 1
 
-	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
-	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+	start_events
 }
 
 reset_with_tcp_filter()
@@ -3489,6 +3494,36 @@ userspace_pm_chk_get_addr()
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
+	print_check "event ${ns} ${evt_name} (${exp})"
+
+	if [[ "${evt_name}" = "LISTENER_"* ]] &&
+	   ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		print_skip "event not supported"
+		return
+	fi
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		fail_test "got ${count} events, expected ${exp}"
+	else
+		print_ok
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3678,6 +3713,7 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
@@ -3729,12 +3765,28 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
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
@@ -3775,6 +3827,22 @@ endpoint_tests()
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
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
@@ -19,6 +19,21 @@ declare -rx MPTCP_LIB_EVENT_LISTENER_CLO
 declare -rx MPTCP_LIB_AF_INET=2
 declare -rx MPTCP_LIB_AF_INET6=10
 
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
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-add-mptcp_lib_events-helper.patch
queue-6.6/selftests-mptcp-join-validate-event-numbers.patch
queue-6.6/selftests-mptcp-join-check-re-re-adding-id-0-signal.patch
queue-6.6/selftests-mptcp-join-cannot-rm-sf-if-closed.patch
queue-6.6/selftests-mptcp-declare-event-macros-in-mptcp_lib.patch
queue-6.6/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.6/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.6/selftests-mptcp-dump-userspace-addrs-list.patch
queue-6.6/selftests-mptcp-join-stop-transfer-when-check-is-done-part-2.2.patch
queue-6.6/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.6/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.6/mptcp-avoid-duplicated-sub_closed-events.patch
queue-6.6/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.6/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.6/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.6/selftests-mptcp-userspace-pm-create-id-0-subflow.patch
queue-6.6/selftests-mptcp-userspace-pm-get-addr-tests.patch
queue-6.6/selftests-mptcp-join-disable-get-and-dump-addr-checks.patch
