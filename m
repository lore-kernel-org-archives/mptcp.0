Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186191DB941;
	Wed,  4 Sep 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460406; cv=none; b=rCjQnALcEAwuVuO7tOH3PgWzQoOH6bHZ1N3k1vZ39zhLLb9PFjYNnzDQJdDNOe30HNE9LOvHFaWZGseE4r9ioipD/6dRUt7xcaDAVaOnL+ryTHPjhy9oEMQXwjceScVu/yG2RDpJvRpEcOsohEPLReFtLZSudhyzDaqRm+DsSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460406; c=relaxed/simple;
	bh=iAASqB79WMfwm6SeQ23eMfoHDhCr5mRkOF3/b3sIi1o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=O3bOyOo5EoJtjc6MLeKNyLoUnXng4aVM3f0qDeP9A+R9Gnsqw5f6/Hqdzno593C3Nhie2LTCd+8lpsmhXdZr0+HDHuDzrz1xcaED3Da8WxDMd/tDkhKRVWDHaiFhFybeGdUmnMn6SfBdlhPbLvsYtr3pIoNdavUVi9o0WqojjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wPQ1mvJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPQ1mvJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B57C4CEC2;
	Wed,  4 Sep 2024 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460405;
	bh=iAASqB79WMfwm6SeQ23eMfoHDhCr5mRkOF3/b3sIi1o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=wPQ1mvJzs8cf8o2gn5IeedZoVHU2djKoUFSK6TbHRUTE0OA05SLOEVA+S0n/jSr4Z
	 lKZkupmWqMV46N2wVg1h/UUqnOyF5XibraaQJHB94HBXiEsQN1KSycUD9+11jA/RCg
	 SmlG6pfj8S9U1uszG43ybYSmdYntzNKL+Wkp8unM=
Subject: Patch "selftests: mptcp: join: check re-adding init endp with != id" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:32:52 +0200
In-Reply-To: <20240904110830.4089238-2-matttbe@kernel.org>
Message-ID: <2024090452-overfull-mounted-d8e8@gregkh>
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

    selftests: mptcp: join: check re-adding init endp with != id

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-re-adding-init-endp-with-id.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73012-greg=kroah.com@vger.kernel.org Wed Sep  4 13:09:09 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:08:31 +0200
Subject: selftests: mptcp: join: check re-adding init endp with != id
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240904110830.4089238-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 1c2326fcae4f0c5de8ad0d734ced43a8e5f17dac upstream.

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID, but the kernel should still use the ID 0 if it corresponds
to the initial address.

This test validates this behaviour: the endpoint linked to the initial
subflow is removed, and re-added with a different ID.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3243,11 +3243,12 @@ userspace_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 2 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 		local tests_pid=$!
 
@@ -3263,11 +3264,19 @@ userspace_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
 		kill_tests_wait
 
-		chk_join_nr 3 3 3
-		chk_add_nr 4 4
-		chk_rm_nr 2 1 invert
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
 	fi
 
 }


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
