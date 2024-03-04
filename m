Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AD4CE11;
	Mon,  4 Mar 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570712; cv=none; b=Le736W8zx7TyMl0iSx1fnhoFqPzuCufYUZx9k+FeLt8UpLn1YEI7yoQ5FxCuy3So4teFhWu1r8kdNxrIUMvb7kZ7uAY2hOVAR/ZP1q4ehn1qyS2bspRFH08+r2QDhBPcSTIv24j2lKUp9Vfxm8zLqmBllRuhxfPtHKjQeu2y9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570712; c=relaxed/simple;
	bh=8uP/2/k7qOml1m7pLQW5o0Sz5ByxElc53MKFepMcrWE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=gFDTtZXK2XoK3fUtDXesZKRBd+1pq1p+nPIB4SxVYbHXOnojGHWpgiu+DIZV+OtNgPI7gNY2bIuGyrb7ktLQuq8KEPbgx4P+WlGUxTiUHk7xQZRLfzQbfsi65YpX1Ru1HrK9wX6WbCIn/uPMcxlGYbLEzOva+rUGBypBaV1+CgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0zPdQfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0zPdQfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84975C43390;
	Mon,  4 Mar 2024 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570712;
	bh=8uP/2/k7qOml1m7pLQW5o0Sz5ByxElc53MKFepMcrWE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=l0zPdQfjarVHp5nYo58uQXX720K+sEFscJWYJF/oqmlDPLGwxyz+LpKkRRXwFX+eY
	 7QR1AcBX47Q45ZRiv6/2OnnasY+2vp1mXEF6asxn53Zl+GJwycr7bJOwKK8lVi/I2i
	 gda5DL0Dp1OECNrhcpPg7r3gpxctUv7m5VIvHWhw=
Subject: Patch "selftests: mptcp: add mptcp_lib_is_v6" has been added to the 6.7-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 17:44:55 +0100
In-Reply-To: <20240304133827.1989736-11-matttbe@kernel.org>
Message-ID: <2024030455-pester-fantasize-9d49@gregkh>
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

    selftests: mptcp: add mptcp_lib_is_v6

to the 6.7-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-mptcp_lib_is_v6.patch
and it can be found in the queue-6.7 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25929-greg=kroah.com@vger.kernel.org Mon Mar  4 14:39:55 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon,  4 Mar 2024 14:38:32 +0100
Subject: selftests: mptcp: add mptcp_lib_is_v6
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240304133827.1989736-11-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit b850f2c7dd85ecd14a333685c4ffd23f12665e94 upstream.

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

is_v6() helper is defined in mptcp_connect.sh, mptcp_join.sh and
mptcp_sockopt.sh, so export it into mptcp_lib.sh and rename it as
mptcp_lib_is_v6(). Use this new helper in all scripts.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-10-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   16 +++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   14 ++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |    5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    8 +-------
 4 files changed, 15 insertions(+), 28 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -620,12 +614,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -693,7 +687,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -726,7 +720,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -592,12 +592,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -877,7 +871,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -929,7 +923,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -971,7 +965,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -3339,7 +3333,7 @@ userspace_pm_rm_sf()
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if is_v6 $2; then ip=6; fi
+	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -227,6 +227,11 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else


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
