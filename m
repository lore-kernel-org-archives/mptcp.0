Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19C1DB55F;
	Wed,  4 Sep 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460159; cv=none; b=F+IZaVBVvq80TZ41Z8LckIane3JQJAgDQOKVzyhfYtLuPwHat25S7F69gcxmI1EypW+GnYpW/GZ6NNLH7J/jF2FihQEYyB6FUniuM0RyWSddU188hy1Jq9nTZDt/z2T9R22SUN1VZ1SmzG1LxGG2R5qrJS2Wu4ci7JctEPZNuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460159; c=relaxed/simple;
	bh=aSaUhDz52LwUck4URmh197YbE4dsfA0V+eFh0+6J8s8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ApjRTwhmgstOGw1HdwXx4vSLV6b4IeQw6QBXnVCsmlfV0EJhg0JSB2veYI04HY0S5+zPsf+jibWxl5i1hqDVMD5gxcSFQ1W9Jh7/HUPckfG7+J58J6jt1I6WAFKb1VEDLjxQAJxWg4gAMyoNmIA+hlpAfOQIbLwWzbJbyp8b3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbU1QOvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbU1QOvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E1BC4CEC2;
	Wed,  4 Sep 2024 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460158;
	bh=aSaUhDz52LwUck4URmh197YbE4dsfA0V+eFh0+6J8s8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=MbU1QOvk1lcOJs/yVFINS97sZhA7wXJMds4ehahTH3u3WYy9oHhJXX+6QPjwxCAoD
	 7US5vp1xH+toUfzz60wFJK71CAygyx12GKFcQs3B6eC0ehOqcQI0acZQ8y+de6LPwG
	 GKtXnkYzg21bKF73l/N1gXrpYuKWeQUUEamEn3SM=
Subject: Patch "selftests: mptcp: add mptcp_lib_events helper" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:29:04 +0200
In-Reply-To: <20240903102347.3384947-6-matttbe@kernel.org>
Message-ID: <2024090404-silica-kinsman-f10d@gregkh>
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

    selftests: mptcp: add mptcp_lib_events helper

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-mptcp_lib_events-helper.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-72804-greg=kroah.com@vger.kernel.org Tue Sep  3 12:24:14 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue,  3 Sep 2024 12:23:49 +0200
Subject: selftests: mptcp: add mptcp_lib_events helper
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240903102347.3384947-6-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 35bc143a8514ee72b2e9d6b8b385468608b93a53 upstream.

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into a helper mptcp_lib_events(). Define it in
mptcp_lib.sh and use it in both scripts.

Note that mptcp_lib_kill_wait is now call before starting 'events' for
mptcp_join.sh as well, but that's fine: each test is started from a new
netns, so there will not be any existing pid there, and nothing is done
when mptcp_lib_kill_wait is called with 0.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-6-bc79e6e5e6a0@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers")
[ Conflicts in mptcp_lib.sh, because the context is different at the end
  of the file, where the new helper is supposed to go. The new helper
  has simply be added at the end. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |   10 ++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |   12 ++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh |   14 ++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -468,12 +468,8 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
 }
 
 reset_with_tcp_filter()
@@ -672,7 +668,9 @@ wait_mpj()
 kill_events_pids()
 {
 	mptcp_lib_kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
 	mptcp_lib_kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
 }
 
 pm_nl_set_limits()
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -258,3 +258,15 @@ mptcp_lib_get_counter() {
 
 	echo "${count}"
 }
+
+mptcp_lib_events() {
+	local ns="${1}"
+	local evts="${2}"
+	declare -n pid="${3}"
+
+	:>"${evts}"
+
+	mptcp_lib_kill_wait "${pid:-0}"
+	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
+	pid=$!
+}
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,21 +201,11 @@ make_connection()
 	if [ -z "$client_evts" ]; then
 		client_evts=$(mktemp)
 	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
+	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 	if [ -z "$server_evts" ]; then
 		server_evts=$(mktemp)
 	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 	sleep 0.5
 
 	# Run the server


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
