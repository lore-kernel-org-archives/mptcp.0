Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04D18453F;
	Mon, 12 Aug 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477888; cv=none; b=dO8oIUbD2h5T7eFoL2IOPysVU7S3/MEuV6C7oXb2wh8ppsi1puxXaLk/C1KivAypDIvrvuSmQKrEVg8C8EacezCbfG/phlpDE0BYQnltm/zEkoTpcTQxSoKONc7ydR41RISNXpez7LcXjDlxBa0XxDmAYKw8a9bJn9m8+r/NeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477888; c=relaxed/simple;
	bh=x2yW0LAxHszm1/qOkrGsPkxKQG4cgLDIstlJwDQSXqM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=l0xClCTiYPXCTRPlUkw9KKLBYJ+d8wMsC7Z/sQuHaObA+aPaTbn8Ec+wYRf90vnuoqIrGKw4skhWCVO80kz3oyxlaQpAYQgbxVs8fBsdwsjvzf1ZqS33PMKZtFMBc+kmPuimy4fTA6sqyz8SuZy1YcWm7BX3Buh6TXlsqs8sb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6NXvWLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6NXvWLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDBC32782;
	Mon, 12 Aug 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477888;
	bh=x2yW0LAxHszm1/qOkrGsPkxKQG4cgLDIstlJwDQSXqM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=b6NXvWLksddSwemfDuS7ttYXL7mZHeNFae6a4YW8tmlijQ/Jh82rYMNiez7TA7QbI
	 PKVw/7Kqrmtsii9iHhbUh02onJnJHnlw3kbfspB1q/gMY1PHMmBIA5kS+E+vIsLoP6
	 wG4ImR2XP731OohCtKJbh0/LZeJbvQXnr0bkWyJc=
Subject: Patch "Revert "selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky"" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:51:01 +0200
In-Reply-To: <20240812153133.574382-2-matttbe@kernel.org>
Message-ID: <2024081200-reward-washing-4d15@gregkh>
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

    Revert "selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky"

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66756-greg=kroah.com@vger.kernel.org Mon Aug 12 17:32:58 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Aug 2024 17:31:34 +0200
Subject: Revert "selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky"
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20240812153133.574382-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

This reverts commit 052c9f0c140c78e5d6826688b5d2f33e19db0ae7.

If the test doesn't pass, we can get this error:

  # ./simult_flows.sh: line 275: mptcp_lib_subtest_is_flaky: command not found

This patch is not needed in v6.6: it is there to mark a test as "flaky",
but the MPTCP selftests infrastructure in v6.6 doesn't support them. So
it looks better to revert this patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -262,7 +262,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
+	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -272,7 +272,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
+	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -305,7 +305,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.6/selftests-mptcp-join-ability-to-invert-add_addr-check.patch
queue-6.6/revert-selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky.patch
queue-6.6/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.6/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.6/mptcp-pm-reduce-indentation-blocks.patch
