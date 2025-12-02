Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890D3128A6;
	Tue,  2 Dec 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691174; cv=none; b=G0sRfCa4t00ai/J2/yRhK/0E+4AKvf3/B69JLcnCQARFfs1aNnWnsMlZkF9OvNPOInY2/icp4Je2QJfynkLez4KCMvS9UBofz8V8hcYcjWGGWjLfSWNrNtsA4aS8GRKIb0H/WyOKFQZAtUPED5r6xW+88AGFfMtpmWgRzNsoU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691174; c=relaxed/simple;
	bh=hl8HdzerSSccMPrIaI93fOaT7Vsy3fKekQcJV/6yYMc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FfribldroEkZpoEA6HXBdSquPwbA7KnKhgsuJ6sjuKzUWkfkNSmcE+IJMXbwRnmWh9M36erBPo5jJRUqbLlg2xVtrS5mqMXynGuonlQrfeaaMbvLm+R30Y41M2riStR1mCJ/EEGTMVGMRul8/vfciFrtmeVxiugcz0/FDMGo2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZS42reU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZS42reU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EACC4CEF1;
	Tue,  2 Dec 2025 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764691174;
	bh=hl8HdzerSSccMPrIaI93fOaT7Vsy3fKekQcJV/6yYMc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=bZS42reUR/ApeIebRIxbGO1GYazzFmlcAsTGMyO4ta6xO/E1ulvTC1y4STW2UtWdh
	 6lNxRVzEH3L1dSVA3JwOizWhITcDBg1/pMyyFZE5UTWWq81YxhN5qTlX3wpJKZESOL
	 c/jCRnIglUNd+mVilL7qbiVVCjJ8/zqgZqrQf5Ss=
Subject: Patch "selftests: mptcp: join: properly kill background tasks" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 16:59:04 +0100
In-Reply-To: <20251127182810.3578622-2-matttbe@kernel.org>
Message-ID: <2025120204-creamed-parted-f300@gregkh>
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

    selftests: mptcp: join: properly kill background tasks

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-properly-kill-background-tasks.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197530-greg=kroah.com@vger.kernel.org Thu Nov 27 19:28:37 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Nov 2025 19:28:11 +0100
Subject: selftests: mptcp: join: properly kill background tasks
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251127182810.3578622-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 852b644acbce1529307a4bb283752c4e77b5cda7 upstream.

The 'run_tests' function is executed in the background, but killing its
associated PID would not kill the children tasks running in the
background.

To properly kill all background tasks, 'kill -- -PID' could be used, but
this requires kill from procps-ng. Instead, all children tasks are
listed using 'ps', and 'kill' is called with all PIDs of this group.

Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when check is done (part 1)")
Cc: stable@vger.kernel.org
Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-6-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because commit e3b47e460b4b ("selftests:
  mptcp: userspace pm remove initial subflow") and commit b9fb176081fb
  ("selftests: mptcp: userspace pm send RM_ADDR for ID 0") are not in
  this version. They introduced new subtests that got modified by this
  patch. That's OK, no need to modify them if they are not there: the
  conflicts can be dropped. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   14 +++++++-------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3679,7 +3679,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3707,7 +3707,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow
@@ -3728,7 +3728,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 }
 
@@ -3758,7 +3758,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -3813,7 +3813,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 3 subflows 3
 		done
 
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -3886,7 +3886,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -3933,7 +3933,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -242,6 +242,27 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: PID
+mptcp_lib_pid_list_children() {
+	local curr="${1}"
+	# evoke 'ps' only once
+	local pids="${2:-"$(ps o pid,ppid)"}"
+
+	echo "${curr}"
+
+	local pid
+	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print \$1 }"); do
+		mptcp_lib_pid_list_children "${pid}" "${pids}"
+	done
+}
+
+# $1: PID
+mptcp_lib_kill_group_wait() {
+	# Some users might not have procps-ng: cannot use "kill -- -PID"
+	mptcp_lib_pid_list_children "${1}" | xargs -r kill &>/dev/null
+	wait "${1}" 2>/dev/null
+}
+
 # $1: IP address
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-clear-scheduled-subflows-on-retransmit.patch
queue-6.6/mptcp-fix-duplicate-reset-on-fastclose.patch
queue-6.6/selftests-mptcp-join-properly-kill-background-tasks.patch
