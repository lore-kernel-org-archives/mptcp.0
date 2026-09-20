Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7234D3B2;
	Sun, 20 Sep 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890006; cv=none; b=Jw3PeLgZ/nRq+nLOEEFZJLee1uwHBoQy9KWjPsXsznnVBGIFcIUgnPnBdzAAAXWo/CpjNQ6sGdGf92Wc5GMs9xe8Dlhoa7+wi28tcV64hEp/6WbCHt2txlChDONfvN5ugUtT0bvotHWVRc3QN+KNvYQljA1y2tlZcr37YIU02Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890006; c=relaxed/simple;
	bh=A32RFvRAq+A5909utLmA2thv38Nr8c/zbKxElRWUN0E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tD5ODG61pYSzlD6TNF3Mc/mR6MKQNOt9KZmGX4LwEYzEDSSdfysPPtMcnEU6E9d6m/5S6tTXWxb3cpwicqbSiXLJgNQcxTU7l7GUtvcASiALJq+1auVtdkthwgitoDILXeWl+OtpSUsc6MoHLQAZByNmIc+wR340SGnN9KtNk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tv1Ksk00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tv1Ksk00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FA71F000FF;
	Sun, 20 Sep 2026 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890004;
	bh=wKWq8IVMNEyxPICkXxfZLOnh/fcYJlWkL5pkc7HWXc8=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=tv1Ksk004EosJv0NKkZc83oaXPpdYe6lWFS6rQKAXJOFhZLUC1jVb/ZurzWe9JYL6
	 W5dcMBcNjZbXcudY8gQnuWrzcKErmBbP/uGuVuEOlEw9/2c4NSG7treOVDSs1IH28Z
	 re6yEiDQzNc3yRJ3K2sprZrulPzR53z37KVvTbI4=
Subject: Patch "mptcp: close race between scheduler and state change" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,shardul.b@mpiricsoftware.com,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:36 +0200
In-Reply-To: <20260919200554.2005069-7-matttbe@kernel.org>
Message-ID: <2026092035-flask-snowboard-e5a3@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-close-race-between-scheduler-and-state-change.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338605-greg=kroah.com@vger.kernel.org Sat Sep 19 22:06:18 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:05:57 +0200
Subject: mptcp: close race between scheduler and state change
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919200554.2005069-7-matttbe@kernel.org>

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
@@ -1562,7 +1562,9 @@ struct sock *mptcp_subflow_get_send(stru
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.6/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.6/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.6/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.6/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.6/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.6/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
