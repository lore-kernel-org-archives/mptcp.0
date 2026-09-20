Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BA3E1231;
	Sun, 20 Sep 2026 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890024; cv=none; b=VI4LiXOEPTq9ZdztHecLhR7vDO4e3AKgOykHQb0n0FFG1P/0uegJ23eMF7diD6zFuu7Fd3RwWh05Bm/Fr+C7gpy2hk0DovHi8L7EEUAsAlnSCjEhDsKrw1eTbGPQKxxw2h4O5Qu2in0Mcpqnu9e9rsKTNZoWUcy56n7y4+6Rdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890024; c=relaxed/simple;
	bh=og9+KnQ3yaC9HK9seiloncE1qMuU7SeUzysKpQOaP94=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ElMuZmf+ptDPK4CJhtkM+eQdgHcKA7s3ipcXR6pHe9HfkFZOoMUY0iPKsqtSveGMjtVQiiTyJbFrZwVqV3MPqgTF/vLZKdjIeOseiZWiwU78IUGi0b17tDClKOjw8t4k2QqSjvxtMpQ6BCBN2fwBLv64z2J6YfYbXHsEQkvKqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mb6ivL9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mb6ivL9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ADD1F000FF;
	Sun, 20 Sep 2026 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890022;
	bh=OxiAyhSMnckfrOltjD7GKYIutLZzXo9+IKQe8TjUVEI=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=mb6ivL9Xhx/5cyO1qZOQftaMoMpsD5JnP0KQdxFH8LyTkeFVlBqwNBaHmLoztnnCL
	 EITZooZDF3etAMgPJCYFGTOJ2I0Q2qDGXKqZeyNtGFu7EGgY7cWIbDgqNNlxmLcUhE
	 pe+lxHZVYyEUploXfcNJRjq7rQM2Ee637KSNodyE=
Subject: Patch "mptcp: fix bad accounting in __mptcp_subflow_push_pending()" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:39 +0200
In-Reply-To: <20260919193948.1927666-10-matttbe@kernel.org>
Message-ID: <2026092039-struggle-clumsily-98b5@gregkh>
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

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338596-greg=kroah.com@vger.kernel.org Sat Sep 19 21:46:24 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:39:53 +0200
Subject: mptcp: fix bad accounting in __mptcp_subflow_push_pending()
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193948.1927666-10-matttbe@kernel.org>

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
@@ -1705,7 +1705,8 @@ static void __mptcp_subflow_push_pending
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.18/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.18/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.18/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-6.18/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.18/mptcp-remove-unneeded-read_once-annotation.patch
queue-6.18/mptcp-pm-kernel-drop-pending-add_addr-when-removing-id0.patch
queue-6.18/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.18/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-6.18/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-6.18/mptcp-pm-userspace-fix-address-id-overflow.patch
queue-6.18/mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
queue-6.18/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.18/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.18/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-6.18/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
