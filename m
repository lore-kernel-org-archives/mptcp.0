Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87463B7A8;
	Mon, 12 Aug 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466319; cv=none; b=GtIDb1UqHyKGzLseydGICte4C/HHvQWN9vK6txQuBDlPnmOzqH56R8ucY5wNNsUvHd4iqdVbM6FWkgBjQs8R870pD1FC0vHulg4Rd1a9yRaYMxQCYyGw8oSh4xTerQZMRIq7zmsX50QL1v1F1W1jVqKzlC7DIdg6ky6BG7TKclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466319; c=relaxed/simple;
	bh=+95YrsmFqGrpieCDsXwwEyJzUB8w0sjB0TTQ6KIjmqA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=CzINQEq+flhirrGvRmUcW7XKluVgueToP0ry7pVeOlY3LH5xTQj2reS/InCJzCH31rqV1cpIb0AJYv7V4vFrHoAN1TnPmYa8G/5Z3/gVrV6Lsw0Nc1JTiVItZgC10FV+9TH6On1uLsj7jQMJZAVT1kkXtCY1iz37f83XQ2gGx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j6URnRjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6URnRjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA6C4AF0D;
	Mon, 12 Aug 2024 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466318;
	bh=+95YrsmFqGrpieCDsXwwEyJzUB8w0sjB0TTQ6KIjmqA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=j6URnRjl5dLZzpW0rgTuT1JYtD+x2Iw8Teq5Zm57aCpvuj2V7DWJlxwkkGaXCkA0r
	 tVGujGKTWlIgsKGYJZOM/YzDbpC5DUi/82tKYHw7WetsbT/5yFiAn1/8k5GttLi4hQ
	 pVhl3i5YL13ZEs7SLq31YXBqymGOwVLcN/vj9WQ8=
Subject: Patch "mptcp: fix bad RCVPRUNED mib accounting" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:27 +0200
In-Reply-To: <20240809090813.2700287-2-matttbe@kernel.org>
Message-ID: <2024081227-levitator-spiritism-9493@gregkh>
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

    mptcp: fix bad RCVPRUNED mib accounting

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-bad-rcvpruned-mib-accounting.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66131-greg=kroah.com@vger.kernel.org Fri Aug  9 11:08:26 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:08:14 +0200
Subject: mptcp: fix bad RCVPRUNED mib accounting
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240809090813.2700287-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 0a567c2a10033bf04ed618368d179bce6977984b upstream.

Since its introduction, the mentioned MIB accounted for the wrong
event: wake-up being skipped as not-needed on some edge condition
instead of incoming skb being dropped after landing in the (subflow)
receive queue.

Move the increment in the correct location.

Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.c, because the commit 6511882cdd82 ("mptcp:
  allocate fwd memory separately on the rx and tx path") is not in this
  version. The fix can still be applied before the 'goto drop'. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -288,8 +288,10 @@ static bool __mptcp_move_skb(struct mptc
 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
 
-		if (ssk->sk_forward_alloc < amount)
+		if (ssk->sk_forward_alloc < amount) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 			goto drop;
+		}
 
 		ssk->sk_forward_alloc -= amount;
 		sk->sk_forward_alloc += amount;
@@ -774,10 +776,8 @@ void mptcp_data_ready(struct sock *sk, s
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
