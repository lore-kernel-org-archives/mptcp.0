Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3434D3B2;
	Sun, 20 Sep 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889989; cv=none; b=rZleXDdurGSivUDWLqkDLQ817W6hVFS5o1Gc0eERc207vO0a9QUBb7oWp3+kvpSX/v23wxdVhdFEzgyJABVCcUXOL8NLWseZSusUjwWNvcEv0OZPIOT7eO8BkK+mOsh+5giDSFsqOwNcA8s8gMaGncRXIBp/hk6xtR0Dixa9ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889989; c=relaxed/simple;
	bh=qrZ/LV/YJGEs/k7YvRE/yzrjY6n0dY8GZgfyBqYSj3Q=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=lT09MIqHJSRb7ysoUgwKMasj0wV2DUyZbOP1gNJbuZyDKkqedcwzXO1rpCKjVfYDJYmMGaH5iETruma6kdREpjrOcUwCIqOSJ+r7CiHMSG9YrCxWImmpSoiczujRBLwLwTvnE32LCkXVUVeKVk04G4lW0v7VPxKaE2S6tn8sN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+1SiW+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+1SiW+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03971F000FF;
	Sun, 20 Sep 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889988;
	bh=g2VcfhI5MmM82V8W99R2sfP48pVHCXBw9keaPVZUS68=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=1+1SiW+4K/TzU6yg7FFIlwAKY9uNW9ldjxCcvbWrcdrXZv1NYSyv8swyHaGh9WvQ4
	 Dx5da77VgZhnuUEw/sFkRLIVkP5u5u1JpcvMd5yi4tILFbbjhLVDrwgbgV0SJRnHUv
	 NnDk4zTvvSC9qWrsorYRrgwEd5AtDFAQXcxWQAl4=
Subject: Patch "mptcp: close race between scheduler and state change" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,shardul.b@mpiricsoftware.com,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:34 +0200
In-Reply-To: <20260919201252.2025112-8-matttbe@kernel.org>
Message-ID: <2026092034-impale-lunchtime-8778@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-close-race-between-scheduler-and-state-change.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338610-greg=kroah.com@vger.kernel.org Sat Sep 19 22:13:35 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:12:56 +0200
Subject: mptcp: close race between scheduler and state change
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919201252.2025112-8-matttbe@kernel.org>

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
@@ -1636,7 +1636,9 @@ static struct sock *mptcp_subflow_get_se
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.1/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.1/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.1/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.1/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.1/mptcp-consolidate-subflow-cleanup.patch
queue-6.1/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
