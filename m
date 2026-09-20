Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A88388E58;
	Sun, 20 Sep 2026 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890033; cv=none; b=SRG/HTNPVNcIkJeQDHMEMypiqPY31z8ldA81zo3MKjbmTnV6d2/t8C45V/ds5PXQBcMmSEO+5q2UcQzV2lqJG7hpbsr3T//MQm7pmwx3tlFoP8fkzAudp3j7bmJm9Rd1Z510EdrYODJMD4jE4pzxcKrmaNTK5mXPSiaMXeGWgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890033; c=relaxed/simple;
	bh=lc636GMVOBllB6O8K27e2FHoad8mbQzFCf9o5BtY+lU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jI2xfjjeVZOAYrahjjObEj+T+YBSzqbUHHFJXZlAoJbtEluQ4ynHq1kN4tz5jBaVnGOoJX1Y446OrOrxZj8xEyzULCxrk7ymAYwpRkWKy9rrdoiTciT7htDJ+XcY2l/I2St378CIq8t+22Pyd4JgaspYv4I4Jb/gUFVuqzevwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCXLZPlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCXLZPlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7741F000FF;
	Sun, 20 Sep 2026 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890031;
	bh=Lpnws3nB74PmaZnDEBqU6Xxtkz5+DimFftdTc/GCQLs=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=NCXLZPlNmP9k1yGDs0vcFwy0DuUDEBFt32AlMbxKkyFzgttiPv5olQ1FDhvxxEQ9o
	 nHt/opF8860BkUZLGqfqpuLGm+snCzCYHtSED16vtxwPAELmUuhObb7eVjigNUFcyd
	 y3BPAJ4LsAHNTo52OmNkCAbP+SvQ8o1gVgYt6ENc=
Subject: Patch "mptcp: close race between scheduler and state change" has been added to the 7.2-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,shardul.b@mpiricsoftware.com,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:40 +0200
In-Reply-To: <20260919193541.1915297-9-matttbe@kernel.org>
Message-ID: <2026092040-upriver-wasabi-e76c@gregkh>
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

    mptcp: close race between scheduler and state change

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-close-race-between-scheduler-and-state-change.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338590-greg=kroah.com@vger.kernel.org Sat Sep 19 21:36:25 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:35:45 +0200
Subject: mptcp: close race between scheduler and state change
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193541.1915297-9-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 42064de57fb83231fcc89663a94885f228a1ee53 upstream.

The mptcp scheduler may race with subflow sockets state change: data
transmission on the selected socket may fail and a later release could
try to use mss_now reset to 0 for a divide operation.

Address the issue by explicitly checking for the critical scenario.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Cc: stable@vger.kernel.org
Reported-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1588,7 +1588,9 @@ struct sock *mptcp_subflow_get_send(stru
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 


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
