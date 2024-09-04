Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892041E871;
	Wed,  4 Sep 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460399; cv=none; b=uIRBdjRBCd7DPBMZuWrK+uzskSb3b85Va0xKegR6fWJYWxp0KbAkTHHM/qF6TWYvzAw3J1L1OhPQEfaBycgDM7IBn2trEK79mfF38UTQKBJ9Kqa3haHPYMZg/HjJhKbpRX7b16MwJRM1XWIbcHqng39xhfmlVfTmjg8WYqFEwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460399; c=relaxed/simple;
	bh=YwoHBhFskB8t6HWCR4gyIRzlfaToDf8lERyeUxWlKn4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=dsLFEIHBrUDjHijZehoMciYab5X9GMUW82UaD3O8y9Zh0D0pCnVbkWFqQRgd6WR1+rXSJEvlel5MfLANq2gI+PkjrqLMDN2OepcUnrlp6WITZLO17NJ6JpArODe2OWpULXcvc0v4bhoNLiC09UpnQ//GAg8XrTendjRLrLt3yVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IXRF8xmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IXRF8xmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937C9C4CEC2;
	Wed,  4 Sep 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460399;
	bh=YwoHBhFskB8t6HWCR4gyIRzlfaToDf8lERyeUxWlKn4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=IXRF8xmi+r0VD+JTSflZsYqXsqw5TVgPQX4WkxMmdpbd6r1FNJcd6ippnGop+MYsS
	 TGL6FKpoVCXrvaD7IWOAcsdN3YQz3xUeqCXZD4xJy9IOb8UJ7Z9ibIQyguo99K8RaO
	 4HmoW2zmGvS9l5Sx8AlB2ppZuJLFn1kKQmuas3UM=
Subject: Patch "selftests: mptcp: join: check re-using ID of closed subflow" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:32:52 +0200
In-Reply-To: <20240904110510.4085066-2-matttbe@kernel.org>
Message-ID: <2024090452-caddy-igloo-07d1@gregkh>
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

    selftests: mptcp: join: check re-using ID of closed subflow

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Wed Sep  4 13:05:24 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:05:11 +0200
Subject: selftests: mptcp: join: check re-using ID of closed subflow
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240904110510.4085066-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 65fb58afa341ad68e71e5c4d816b407e6a683a66 upstream.

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-4-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because this subtest has been modified in
  newer versions, e.g. commit 9095ce97bf8a ("selftests: mptcp: add
  mptcp_info tests") added chk_mptcp_info check, commit 03668c65d153
  ("selftests: mptcp: join: rework detailed report") changed the way
  the info are displayed, commit 04b57c9e096a ("selftests: mptcp: join:
  stop transfer when check is done (part 2)") uses the new
  mptcp_lib_kill_wait helper instead of kill_tests_wait.
  Conflicts have been resolved by not using the new helpers, the rest
  was the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -402,9 +402,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3265,10 +3266,10 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
@@ -3277,10 +3278,24 @@ endpoint_tests()
 		sleep 0.5
 		chk_subflow_nr needtitle "after delete" 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "" "after new reject" 2
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after no reject" 3
+
 		kill_tests_wait
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 
 	# remove and re-add


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.1/selftests-mptcp-join-validate-fullmesh-endp-on-1st-sf.patch
queue-6.1/mptcp-pm-fix-id-0-endp-usage-after-multiple-re-creations.patch
queue-6.1/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.1/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-6.1/mptcp-pm-reuse-id-0-after-delete-and-re-add.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-id.patch
queue-6.1/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
queue-6.1/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-6.1/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add_addr.patch
