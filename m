Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812F388E58;
	Sun, 20 Sep 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890036; cv=none; b=DeBh4Ka8kt6/PdBRHALtw3aNo8siqxyY+FM5whfIID7WeMJsDJaYH5AQOYyznihXjVZTzUR8WxKqgytn0UuLVQixut9yRtvdHToFfcGGh0ldvrKtG0V4a+T3rhteIk2hDTmlV6OvtUFLJDulj3SKZyC96yRC8gcbrI1DcR1gKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890036; c=relaxed/simple;
	bh=pFUG5s8alXRfwo204rEXh3b7s6hO4AeSemzeOgXTw5g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=emM3ienINRn7SxOV9HOA287N4pSpwqEZVK35EQHLet/PgfO7Z7CDPNa20k51uI5ZIR5byGUc+3ArzgORME18bHdZn956LGSGjYeqzygncYWQUtk4t0wyS4VRTQYRtDDUKpvAgxzZMvnuhxMKdTCSLIavVEha4l9Zp12XE/OPoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQAJ2vcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQAJ2vcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619C31F000FF;
	Sun, 20 Sep 2026 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890034;
	bh=sm08LihvlNBIZHab5LoGIbilhHIr6wSK3Y06T/9Rd+Y=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=uQAJ2vcG4PArio2DYrASTrD23+39Zd06f3nJExWf+0Z7BGa3WViw11LcpPTB35UqV
	 YyD3qBkVEHF8KKmvGW9HbaRSl4kjrTcXW79WYohX1L65CiqFixNWf4NxeR2Lw3ECxb
	 HLvKKvRpczEiKLz6UxHU6kN0MR943Pe1XM7cnU3U=
Subject: Patch "mptcp: fix bad accounting in __mptcp_subflow_push_pending()" has been added to the 7.2-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:40 +0200
In-Reply-To: <20260919193541.1915297-10-matttbe@kernel.org>
Message-ID: <2026092040-stalling-decimal-062b@gregkh>
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

    mptcp: fix bad accounting in __mptcp_subflow_push_pending()

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Sep 19 21:36:13 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:35:46 +0200
Subject: mptcp: fix bad accounting in __mptcp_subflow_push_pending()
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193541.1915297-10-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit f3ef03357396d4b147d8e76c75fb612c2f264ffc upstream.

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1778,7 +1778,8 @@ static void __mptcp_subflow_push_pending
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-7.2/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-7.2/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-7.2/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-7.2/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-7.2/mptcp-remove-unneeded-read_once-annotation.patch
queue-7.2/mptcp-options-fix-uninit-value-in-mptcp_write_data_fin.patch
queue-7.2/mptcp-pm-kernel-drop-pending-add_addr-when-removing-id0.patch
queue-7.2/mptcp-close-race-between-scheduler-and-state-change.patch
queue-7.2/selftests-mptcp-lib-get-counters-for-the-right-test.patch
queue-7.2/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-7.2/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-7.2/mptcp-pm-userspace-fix-address-id-overflow.patch
queue-7.2/mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
queue-7.2/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-7.2/selftests-mptcp-lib-dump-nstat-for-the-right-test.patch
queue-7.2/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-7.2/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-7.2/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
