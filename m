Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877E1DA619;
	Wed,  4 Sep 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460165; cv=none; b=DnzrP9XSBVtgrH5s7sBKxAUwAYyesBHBSYvXzGoQ4D9bwxlT+c+UkR8Io0QVwv7v4YgQrOZwY38ONv4MHCx+Tf5pR77D8ym0n3wiNwPS45iU9x9+L+wK8oQi/ndV6P9DYp/Ve38eV2PURpeWtEk+7w3YYK2xO5Kidvlej8+03hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460165; c=relaxed/simple;
	bh=Hp3jZpWehb69Z33gWhXwT2TzWA3CumQwPAtXBaiB9bY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=fMiqQhBKr+UFUQVXe3m/eumPtfiBk7zkCno19U8Fg9DBVddZnJhqP1/yHSU8ozZ0Ll1e+3ccvrjMXq7Zu30fmqDE0z1vAMlWyqDotQhs0Ath1lVV0E5bPO/mxgkQh/tUzhYushbHA1kCQ95hYZDd/jeyN3JgQ1e0RsfjGorfP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVxoXAQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVxoXAQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B898C4CEC2;
	Wed,  4 Sep 2024 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460165;
	bh=Hp3jZpWehb69Z33gWhXwT2TzWA3CumQwPAtXBaiB9bY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=lVxoXAQIxMRLCIvhQedt9g+j5d4oqxoLdCN1enXxlQa9+K6VAh7EF2HtKJXE4hMgl
	 uk0M9sAT68s1F61+HfsW/IT1vxqLFWrXTvt4cZMFTTqbIe3bWNZ3ma/serSyj/oX4W
	 mAZzR9hZ08ym16vdF5e4ki9YNglCQ7S09T7QHQ+s=
Subject: Patch "selftests: mptcp: join: stop transfer when check is done (part 2.2)" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:29:05 +0200
In-Reply-To: <20240904133755.67974-6-matttbe@kernel.org>
Message-ID: <2024090405-catcher-snowstorm-7dc1@gregkh>
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

    selftests: mptcp: join: stop transfer when check is done (part 2.2)

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-stop-transfer-when-check-is-done-part-2.2.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73055-greg=kroah.com@vger.kernel.org Wed Sep  4 15:39:40 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 15:37:58 +0200
Subject: selftests: mptcp: join: stop transfer when check is done (part 2.2)
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org
Message-ID: <20240904133755.67974-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Use mptcp_lib_kill_wait in "userspace pm create id 0 subflow" subtest.

This new test has recently been queued to v6.6 [1] with the backport of
commit b2e2248f365a ("selftests: mptcp: userspace pm create id 0
subflow").

The modification here was part of commit 04b57c9e096a ("selftests:
mptcp: join: stop transfer when check is done (part 2)") that has been
backported to v6.6 a few months ago -- see commit 358f02b84fbb
("selftests: mptcp: join: stop transfer when check is done (part 2)") --
but it was not modifying this subtest as it was not present in v6.6.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=bd2122541bd8 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3678,7 +3678,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 


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
