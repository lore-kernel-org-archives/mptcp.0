Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DA1BD014;
	Wed, 14 Aug 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657491; cv=none; b=iMU3rDzTqrehpyUbPFxe27P2JQVSx6rxCC4KTKiBHqGdzDRNgH5gFT3BHozB6WUZ8fCbbi8kPnFi4WRYQEc65dxHdr4zXj6d1+X/r9FTBOrIsPMLo9xPZaAZ2O6111oddN+UELB1G7BN4ujUdZzQmKSEUlXcjmIo6LvcPTvv+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657491; c=relaxed/simple;
	bh=k8RMEswTpy9SFmCxhZvxoZDESiKHwcdtUC1qxV2zrao=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BfWMu6Zd0FfnCbPFK7RCGwmNNO2mV+mWafNNZnPjAjQ35gcu2lw9e111bTpk5TChX9RzGusjjUaUJb9RT8UZatQiYyrky2K00Gyzg5zMDTvncXC4DuXE+TOkUXnmovd9iVNLxLY5ze8LeTuTnQnq8dZbO7YsuOfFkCxmIpohfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2hidcqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2hidcqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2AEC4AF09;
	Wed, 14 Aug 2024 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723657491;
	bh=k8RMEswTpy9SFmCxhZvxoZDESiKHwcdtUC1qxV2zrao=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=r2hidcqcKwUisy5+ZjKLTp6VSBDDtOvco4UlNhHprTM5nCjTtMD0bvJWI2SOaCcO0
	 XKOXPiX3yCNmrTgSPmtHkYUa0JDnXUvqwWwcn5SbwsyudSM+OhuZo8F1W+TNOD8Aer
	 6qlYfAz9FfflqHv9AlU59Z3sBifx4pQLPSwjspuI=
Subject: Patch "selftests: mptcp: join: test both signal & subflow" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Aug 2024 19:44:34 +0200
In-Reply-To: <20240813092815.966749-12-matttbe@kernel.org>
Message-ID: <2024081434-excusably-dizzy-57f8@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-test-both-signal-subflow.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-67442-greg=kroah.com@vger.kernel.org Tue Aug 13 11:28:51 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 11:28:21 +0200
Subject: selftests: mptcp: join: test both signal & subflow
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240813092815.966749-12-matttbe@kernel.org>

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
[ No conflicts, but not using 'chk_add_nr 1 1 0 invert': in this
  version, 'chk_add_nr' cannot be used with 'invert': d73bb9d3957b
  ("selftests: mptcp: join: ability to invert ADD_ADDR check") is not in
  this version, and backporting it causes a lot of conflicts. That's
  fine, checking that there is an additional subflow should be enough. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2090,6 +2090,20 @@ signal_address_tests()
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
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.1/mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
queue-6.1/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.1/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.1/mptcp-pm-reduce-indentation-blocks.patch
