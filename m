Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36927304BD3;
	Fri, 22 Aug 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870341; cv=none; b=JdCaY5srWuf4zFt/tYQeoXqcgoS/zOOA8jhUnuTy878kEUPtNWE+2BWIJwpy3P0FrtKFJJ6pq9wrvlBB8bwx5/YyoCRahxYvx484TOgrVSNvOEcS4hHi5NL4vM5t9P5JfTlBwQk17saLb2Z2AdqoLH5b4SxIqNLW1MC4T6F2Plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870341; c=relaxed/simple;
	bh=/FkFAFQcdqGsJQDGCumLsbZ+jTXgoOPoki4i+I5LosY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=T7I0JiIE7VqfpVbQTddqwsN8/aKfmynaFgLoizovuZcarLqaTpTm+Mf8aX2hFJ0haQRmYCZTk3FnXit9IMrsbfuILAQ9TswI8FTZoWZTt5oOWTmAKkfsVfnWf8r9uw692EJ712mqIXbZa9OP819krWQ13ZLl945LFivPhUfMjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSG8rhET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSG8rhET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF5AC116B1;
	Fri, 22 Aug 2025 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870340;
	bh=/FkFAFQcdqGsJQDGCumLsbZ+jTXgoOPoki4i+I5LosY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=gSG8rhETHn1PLXWPijG82IaGPOuVDXiLkAyrkM299QoVTWrfoXO7Fd7dtmRWXArNz
	 KrSTeR1qre8qXK7pBCk5kHWz8riXBAX3e+PxddJlKuORsWM2G3Alvg3DCrahRlJ0yb
	 gmZkUy6FAmg7/CAyiUiZU++yWQ3VwPRTkFAAmqCg=
Subject: Patch "selftests: mptcp: add missing join check" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:35 +0200
In-Reply-To: <20250731112353.2638719-9-matttbe@kernel.org>
Message-ID: <2025082234-dramatize-sandstorm-d9a7@gregkh>
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

    selftests: mptcp: add missing join check

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-missing-join-check.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165646-greg=kroah.com@vger.kernel.org Thu Jul 31 13:24:22 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 31 Jul 2025 13:23:55 +0200
Subject: selftests: mptcp: add missing join check
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, sashal@kernel.org, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250731112353.2638719-9-matttbe@kernel.org>

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 857898eb4b28daf3faca3ae334c78b2bb141475e upstream.

This function also writes the name of the test with its ID, making clear
a new test has been executed.

Without that, the ADD_ADDR results from this test was appended at the
end of the previous test causing confusions. Especially when the second
test was failing, we had:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
                                  add[fail] got 2 ADD_ADDR[s] expected 3

In fact, this 17th test was OK but not the 18th one.

Now we have:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
  18 signal addresses race test   syn[fail] got 2 JOIN[s] syn expected 3
   - synack[fail] got 2 JOIN[s] synack expected
   - ack[fail] got 2 JOIN[s] ack expected 3
                                  add[fail] got 2 ADD_ADDR[s] expected 3

Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in mptcp_join.sh, because commit 86e39e04482b ("mptcp: keep
  track of local endpoint still available for each msk") is not in this
  version and changed the context. The same line can still be applied at
  the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1138,6 +1138,7 @@ signal_address_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal addresses race test" 3 3 3
 	chk_add_nr 4 4
 }
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-drop-unused-sk-in-mptcp_push_release.patch
queue-5.15/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-5.15/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-5.15/selftests-mptcp-connect-also-cover-checksum.patch
queue-5.15/selftests-mptcp-make-sendfile-selftest-work.patch
queue-5.15/selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
queue-5.15/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-5.15/mptcp-do-not-queue-data-on-closed-subflows.patch
queue-5.15/selftests-mptcp-add-missing-join-check.patch
queue-5.15/mptcp-fix-error-mibs-accounting.patch
queue-5.15/mptcp-introduce-mapping_bad_csum.patch
