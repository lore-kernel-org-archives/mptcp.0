Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50134D3B2;
	Sun, 20 Sep 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889986; cv=none; b=OG7indIRAVtCZeefhGdjhu9XFAqmCgE2Xgdcl5C1EP1zuJp/Wzb2/lDo/CAyywqgi0eYDgBrG/C0SCTbRYJspL9aleHwNKJtZNfsFEvhvtZ/pr1NOBIC2n+0IUDjWRAzvMuQllPLaqhsyHANRw3SlUAVwP0niEVJRGQmpoIZ+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889986; c=relaxed/simple;
	bh=N8WH8P/tPoJHqVuZzg9R/ft/IZoQczssSnVx4pLBHmo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Um7QnzopdgweJ74TcunfmgBKcW/BEAy0uai7Xi9l+BHE+0VHlFkg0Y+2splT5IbDdMfiejuW8IWVeCnwMabJKG4hYjt6bVPkXlBlWPZAZmj25zNBEdpZddlXrlvkUSUa6GJ/B5K+Uj9FPfnqFqN4fn7dzzD4ng2jdqWrUiz/kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IOc0V6Ob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOc0V6Ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9351F000FF;
	Sun, 20 Sep 2026 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889985;
	bh=mJRgIUvU1gm8IQDS5kTS1Rkm/50FyBeNrIXvtXiR4v8=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=IOc0V6ObnNwCoLKJ4ILnCS4OUNoyoap8uwDVATK8cAi7gZ3jmXQWr4npDXt/53q7i
	 vA5rG7uiwd6hz84hv378D+pCEozqWbF+mG1TAcOr9czBoowX4uS155hThdP3Q19fRS
	 PQD375BaboZkgwHbyeEyG36cmlhEaIEdW//mvDiY=
Subject: Patch "mptcp: close race between scheduler and state change" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,shardul.b@mpiricsoftware.com,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:33 +0200
In-Reply-To: <20260919202918.2074632-6-matttbe@kernel.org>
Message-ID: <2026092032-scorpion-parasitic-605a@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-close-race-between-scheduler-and-state-change.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338613-greg=kroah.com@vger.kernel.org Sat Sep 19 22:29:43 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:29:21 +0200
Subject: mptcp: close race between scheduler and state change
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919202918.2074632-6-matttbe@kernel.org>

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
@@ -1621,7 +1621,9 @@ static struct sock *mptcp_subflow_get_se
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-5.15/mptcp-close-race-between-scheduler-and-state-change.patch
queue-5.15/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-5.15/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
