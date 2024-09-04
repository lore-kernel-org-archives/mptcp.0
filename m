Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9351DB950;
	Wed,  4 Sep 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460162; cv=none; b=qp71LqduIqFtO+UOemu2GU4XLoVVH+oaDSR7OBEEU38UNmZJ2slMBwoly04yWdZr+B6/O8P6YjvkirRFvqGaXHqFI969Br+ttUmhcO7qi3eij8sGnkbWNg54FuNSgGzb1q6At7fU8OhqtNfDMgmUaRFWfaMPL8p1h/lsCROq6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460162; c=relaxed/simple;
	bh=2LFRH4B9szwvimkXoK7PUxmq+thQpate/e9RGXTNzfI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jZIdPCKmxFFJLh5RkRfGAz+mpfCTG+gFtCn7liMQgkpdBYlmtyHd5TGySS8yWH4KWjdV0vptgv+pON0Ib2u7OY2xLwaZlIcDBRKiD87AGfI8Mu3mk3EDX5BjLLwEpnXNva5dNQNqIZGYboiIwyILXRhmXYUwVecG6AjPXt5iOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1uaNDf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1uaNDf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C286FC4CEC2;
	Wed,  4 Sep 2024 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460162;
	bh=2LFRH4B9szwvimkXoK7PUxmq+thQpate/e9RGXTNzfI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=M1uaNDf6lAWQ+PosJDJ93YpVP9VPeEVEhv4AWqxkd6gs6PiAU4a/Xmzdg9/FoqLe4
	 /GOCk9Q61NIDX8eHvapBCnEWJqIlGyMF0GEnW3ISig6dPxr7nrB+fkpgBaMpq4ZRvt
	 PM+gfCvMoJQow4gJXJUH4atT0qj92wx5kOPlDjVs=
Subject: Patch "selftests: mptcp: join: disable get and dump addr checks" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:29:05 +0200
In-Reply-To: <20240904133755.67974-5-matttbe@kernel.org>
Message-ID: <2024090405-condiment-viewer-237c@gregkh>
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

    selftests: mptcp: join: disable get and dump addr checks

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-disable-get-and-dump-addr-checks.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73054-greg=kroah.com@vger.kernel.org Wed Sep  4 15:39:40 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 15:37:57 +0200
Subject: selftests: mptcp: join: disable get and dump addr checks
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org
Message-ID: <20240904133755.67974-5-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

These new checks have been recently queued to v6.6 [1] with the backport
of commit 38f027fca1b7 ("selftests: mptcp: dump userspace addrs list"),
and commit 4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr
tests").

On v6.6, these checks will simply print 'skip', because the associated
features are not available in this version. That's fine, except that the
MPTCP CI sets the SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1 env var,
which will force these subtests to fail when using the selftests from
v6.6 on a v6.6 kernel, because the feature is not available.

To ease the backports (and possible future ones), I suggest to keep the
recent backports, but skip calling mptcp_lib_kallsyms_has() not to have
the CIs setting this env var complaining about the associated features
not being available.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=bd2122541bd8 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3472,7 +3472,7 @@ userspace_pm_chk_dump_addr()
 
 	print_check "dump addrs ${check}"
 
-	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+	if false && mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
 		check_output "userspace_pm_dump ${ns}" "${exp}"
 	else
 		print_skip
@@ -3487,7 +3487,7 @@ userspace_pm_chk_get_addr()
 
 	print_check "get id ${id} addr"
 
-	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+	if false && mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
 		check_output "userspace_pm_get_addr ${ns} ${id}" "${exp}"
 	else
 		print_skip


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
