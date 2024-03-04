Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FF4D12D;
	Mon,  4 Mar 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570670; cv=none; b=oYzt4T0g38ay2McaDfcqw/I0hOcJ2UBSreHstIlqym1/Rt3sPUWTVEqlu1BwV3gCGubGjmqPeTLnBRdrenL6eKVECf9U9EhMiaSFXhi4krp/IuJYlEXTOmG9+jwaCfNmcKDW67aQznV9/Grihc51TkezuJpwQ7BcHE9UTGhCZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570670; c=relaxed/simple;
	bh=exmdBp/idelUtrnY8PYNwDlMxiyQRAGMlHJRF+lv22g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jZ9QqmTVAPtWXZFvy8rm5ogIsEAaVB5NwROkY5Sv1sn0oj+EN380qZvuN2CLi/Z42aKIdGaw4VrhDVjT2fvg0QbHYfwIAGmzE/2OCIPjWEhjKGVXSLFvFiGxWHVmAkpaOl+VHbyPXuISW7JPyTa6JcfyPzw/1PJ30xOqlocrJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxpLTuOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pxpLTuOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9E9C433F1;
	Mon,  4 Mar 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570669;
	bh=exmdBp/idelUtrnY8PYNwDlMxiyQRAGMlHJRF+lv22g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pxpLTuOOTZ324RttYJ+810jwdN2A1Pz8sIsoGZgURLykm42BjRwRvMuhliXeFLc9Y
	 lApBDDkA2F58qdKvoKscybzV1EeOp4vrJNolrX5eNg2q9YaOK/c0wAeDa6NQ7S3j5O
	 zQeNOd6WGc6x3QGubiOPt76DR1jxSeOmyiQF29/g=
Subject: Patch "selftests: mptcp: add chk_subflows_total helper" has been added to the 6.6-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 17:44:26 +0100
In-Reply-To: <20240304142508.2086803-9-matttbe@kernel.org>
Message-ID: <2024030426-storm-deserve-d134@gregkh>
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

    selftests: mptcp: add chk_subflows_total helper

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-chk_subflows_total-helper.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Mon Mar  4 15:25:24 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon,  4 Mar 2024 15:25:11 +0100
Subject: selftests: mptcp: add chk_subflows_total helper
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240304142508.2086803-9-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit 80775412882e273b8ef62124fae861cde8e6fb3d upstream.

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one.

To be compatible with old 'ss' or kernel versions not supporting this
counter, get the total subflows by listing TCP connections that are
MPTCP subflows:

    ss -ti state state established state syn-sent state syn-recv |
        grep -c tcp-ulp-mptcp.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-3-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   42 +++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1840,7 +1840,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1861,6 +1861,42 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+	local dump_stats
+
+	# if subflows_total counter is supported, use it:
+	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	# if not, count the TCP connections that are in fact MPTCP subflows
+	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3404,10 +3440,12 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
@@ -3424,9 +3462,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-add-mptcp_lib_is_v6.patch
queue-6.6/mptcp-push-at-dss-boundaries.patch
queue-6.6/mptcp-fix-double-free-on-socket-dismantle.patch
queue-6.6/mptcp-fix-snd_wnd-initialization-for-passive-socket.patch
queue-6.6/selftests-mptcp-rm-subflow-with-v4-v4mapped-addr.patch
queue-6.6/selftests-mptcp-update-userspace-pm-test-helpers.patch
queue-6.6/mptcp-map-v4-address-to-v6-when-destroying-subflow.patch
queue-6.6/selftests-mptcp-add-evts_get_info-helper.patch
queue-6.6/mptcp-fix-potential-wake-up-event-loss.patch
queue-6.6/selftests-mptcp-join-add-ss-mptcp-support-check.patch
queue-6.6/mptcp-fix-possible-deadlock-in-subflow-diag.patch
queue-6.6/mptcp-avoid-printing-warning-once-on-client-side.patch
queue-6.6/selftests-mptcp-add-chk_subflows_total-helper.patch
