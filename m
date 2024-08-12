Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2A18453F;
	Mon, 12 Aug 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477885; cv=none; b=R47ZrsCh8yityMrW07hsvr2brnWfMl40NkecpOH0xB1WG0cxVVISM1PIDOT1/7AV7+V9cP6Dr7EmfNATuWcSb1FEP8NIu6vnFhT1QmjXwottFZhmabvaFvLdX5gprB793VAQunMLXoiiwYo4KoWvptFpXchtNEWQMjQ7ghl6fdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477885; c=relaxed/simple;
	bh=WVq9nc1D42mm7+Igf/e2M4y5IMx4NUJYfiSlTF1pfBQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=qzB0i7CMrMsEl5pdEA0msqIrxSWo+S8ehffhaWaKgr/Qd+bHgf6orIqnfSDy7uUuHsSwAxxt0eTiMPO/uW8uEtghrERM7/iyvXCfnxGOCKQ4o7MtATQTTvNJg1qkqTEIiOfB0pL+W51ieefmnX4wKC9m6BCbEH6Kr9/Vb+d1bDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8tQUQkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8tQUQkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D79C32782;
	Mon, 12 Aug 2024 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477885;
	bh=WVq9nc1D42mm7+Igf/e2M4y5IMx4NUJYfiSlTF1pfBQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=y8tQUQkxG7yKFHascgKyGFuJw37MkBpb8npgwaqmYx3BAReck/7Yfx2CCfmd6vYj1
	 Y0sdtEck5c7CAlpc3NlIE2TGVO2c0wOi+WqEInj9zw2KE6zt6Kr2W+YwnQ255iwgcD
	 U9J93Q+G3+E5hwNK+xKvKF4eh3aq5wVf8GpQKwH8=
Subject: Patch "selftests: mptcp: join: test both signal & subflow" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:51:01 +0200
In-Reply-To: <20240812153050.573404-12-matttbe@kernel.org>
Message-ID: <2024081201-ritalin-landmine-7252@gregkh>
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

    selftests: mptcp: join: test both signal & subflow

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-test-both-signal-subflow.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66755-greg=kroah.com@vger.kernel.org Mon Aug 12 17:32:54 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Aug 2024 17:30:56 +0200
Subject: selftests: mptcp: join: test both signal & subflow
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240812153050.573404-12-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 4d2868b5d191c74262f7407972d68d1bf3245d6a upstream.

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-7-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2133,6 +2133,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.6/selftests-mptcp-join-ability-to-invert-add_addr-check.patch
queue-6.6/revert-selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky.patch
queue-6.6/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.6/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.6/mptcp-pm-reduce-indentation-blocks.patch
