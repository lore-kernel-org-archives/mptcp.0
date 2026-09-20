Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E332B13E;
	Sun, 20 Sep 2026 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889975; cv=none; b=eqcMQ302kWa7dyXMRtZ1RSoN5iuP3/XKJt7kKgEiS73W6Yev4Kd3gyN+Wn/A0XoI47EcAwPictqV3xbK5JzPUMeDMHsz7IHH70442vL00UoR6x2L92K/cS/WMu6gvdkngqjohdV8W7lVKlxXMQxWhGCp7WoHRtS5yeVkGa5Xzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889975; c=relaxed/simple;
	bh=EVPHPgkJ3245SqyvYLkiucMjAUb0nYeI0qujaHJZdLM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=dgK279UDbQrhIdz2ZUU8NQRGq9NYl5TmV+DxhVJldI4obmbWpz2lVV9u7LPviRXBqIZ7MEy6OuvDMeoGnJry92KSfmoqT9+KZ/0refxUv0vtU77tOgaTet0mdnvZ6amJn0UM6L36vzwYW7tViEE3Ra+cf8l+E64iUF5hUP9F9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lk/kiOp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lk/kiOp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEF61F000FF;
	Sun, 20 Sep 2026 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889973;
	bh=+A6n+7MfkIRAZOilM5wKaWWAGQSTclCT+q1aGqhcOos=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=Lk/kiOp2sXGDtkB1qv3S2+8Sd5oIGYh905bJXT0dZrGYGX0bO1gEGlYaUdeqhHIYA
	 kBBDDwjQqySB3lrVcgQ9NyKry/0AVcvMhJXxiRvkWs2nEny3gquo45WV73A4OHCjaL
	 9kurBgcgrdbl1VfHBekzPBtBbIh5sNwADhWOylCE=
Subject: Patch "mptcp: close race between scheduler and state change" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,shardul.b@mpiricsoftware.com,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:31 +0200
In-Reply-To: <20260919204002.2106015-8-matttbe@kernel.org>
Message-ID: <2026092031-flounder-extras-8230@gregkh>
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

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-close-race-between-scheduler-and-state-change.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338617-greg=kroah.com@vger.kernel.org Sat Sep 19 22:40:32 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:40:06 +0200
Subject: mptcp: close race between scheduler and state change
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919204002.2106015-8-matttbe@kernel.org>

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
[ Note: moved the mss_now check in previous places before commit
  d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
  which is not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1381,7 +1381,7 @@ restart:
 	}
 
 	mptcp_set_timeout(sk, ssk);
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 
@@ -1891,7 +1891,7 @@ static void mptcp_worker(struct work_str
 		if (!mptcp_ext_cache_refill(msk))
 			break;
 	}
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-hold-mptcp-socket-before-calling-tcp_done.patch
queue-5.10/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-5.10/mptcp-close-race-between-scheduler-and-state-change.patch
queue-5.10/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
