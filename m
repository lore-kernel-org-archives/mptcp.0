Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55A495F0;
	Mon,  4 Mar 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570716; cv=none; b=BaxNpD0KYp64NTXwUFbG+vcPxTp0etTduFCmgwp2LZuAxwuwfV9AOKvpINSa+cbSnV+f+cGJLI+QHah3kE5MVJyDcZxAadr26u6yOfQcV45ugK2SUE96aoi7skLQIO1fdVVknnAYbPQbkArzw9hmmFR6txqzOzpCUcmjhId2Yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570716; c=relaxed/simple;
	bh=uc5CaEjjhdDrFnSBY3Sb4+JeYrsba9Hjw0vIInOraew=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=d64B32RiTtk4qzzOMgMxgsnl7YV9keGQtfEsYDfDStjewmKvTytPTFAMRJRHOCU09UOQt2bJyJzx53nXuV6JDuvs95I2dV6+8MHbVYZkaED7reveeU1/FW4Gf2wf/t61n7vFUHsoK6kLVX+aIuxD3CGyEXAjqcsxeWxwy/13hmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUBEG4lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUBEG4lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D45C433C7;
	Mon,  4 Mar 2024 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570715;
	bh=uc5CaEjjhdDrFnSBY3Sb4+JeYrsba9Hjw0vIInOraew=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=gUBEG4luYmjJLJdVYtyMdiG5NbkvfDTAjID58Gr5bgo4Gp6ObTwYAvT1ignKEvzy8
	 IN/PeMtIH51+Pq4YO1f8zXLC7Qf5vMmlAfMoP7MjfizpRkS3zT/6ckuXDDwSKq/A91
	 SRs+lKgJ5ybBkO4dYedpMU64O9Gfn+m89SgGYPtk=
Subject: Patch "selftests: mptcp: rm subflow with v4/v4mapped addr" has been added to the 6.7-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 17:44:55 +0100
In-Reply-To: <20240304133827.1989736-12-matttbe@kernel.org>
Message-ID: <2024030455-amino-pacifism-0b2b@gregkh>
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

    selftests: mptcp: rm subflow with v4/v4mapped addr

to the 6.7-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-rm-subflow-with-v4-v4mapped-addr.patch
and it can be found in the queue-6.7 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25930-greg=kroah.com@vger.kernel.org Mon Mar  4 14:39:58 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon,  4 Mar 2024 14:38:33 +0100
Subject: selftests: mptcp: rm subflow with v4/v4mapped addr
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <tanggeliang@kylinos.cn>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240304133827.1989736-12-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 7092dbee23282b6fcf1313fc64e2b92649ee16e8 upstream.

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds a second subflow
to "userspace pm add & remove address" test, and two subflows could
be removed two different ways, one with the v4mapped and one with v4.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-2-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   28 +++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |    4 +--
 2 files changed, 18 insertions(+), 14 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3328,16 +3328,17 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
-	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
-	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
-	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t $2)
 
 	cnt=$(rm_sf_count ${1})
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
@@ -3424,20 +3425,23 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns2 2 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_subflows_total 2 2
-		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_add_addr $ns1 10.0.3.1 20
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
-		chk_rm_nr 1 1 invert
+		userspace_pm_rm_addr $ns1 20
+		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -213,9 +213,9 @@ mptcp_lib_get_info_value() {
 	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
 }
 
-# $1: info name ; $2: evts_ns ; $3: event type
+# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
 mptcp_lib_evts_get_info() {
-	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.7/selftests-mptcp-add-mptcp_lib_is_v6.patch
queue-6.7/x86-bugs-use-alternative-instead-of-mds_user_clear-static-key.patch
queue-6.7/kvm-vmx-move-verw-closer-to-vmentry-for-mds-mitigation.patch
queue-6.7/selftests-mptcp-rm-subflow-with-v4-v4mapped-addr.patch
queue-6.7/x86-entry_32-add-verw-just-before-userspace-transition.patch
queue-6.7/x86-entry_64-add-verw-just-before-userspace-transition.patch
queue-6.7/selftests-mptcp-update-userspace-pm-test-helpers.patch
queue-6.7/selftests-mptcp-add-evts_get_info-helper.patch
queue-6.7/kvm-vmx-use-bt-jnc-i.e.-eflags.cf-to-select-vmresume-vs.-vmlaunch.patch
queue-6.7/selftests-mptcp-add-chk_subflows_total-helper.patch
