Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA821D3CB;
	Thu, 13 Feb 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452509; cv=none; b=jjkMf0lWx3SOs6Ik9OEMMPI8LhqG0eW8Rxm4cT0hP1BKDNbwBDq5TtvctIugsDBQUzMlLTTJOkmbtz3xdijOUz0UNFB0jhd9srkVImzalNkTZqmH14viH8vwiAJWv1yxNwGy0iakMQJpSqCTSr57nCGzJMKnQxTGDfrdODfZzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452509; c=relaxed/simple;
	bh=Ggp/ECmDCoW4aL0f4UUd9e9jyBe2uXXhxi81bgqRCKo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LgK7BxgkGoiLID8FuswfX/nWftFYPGh4ZHGCaZfkuImXJseXI0lUPQZFv5jrrgscbif9Hv+FflFReNBbmomRsVq/rQ0Rsbq+p1urGMFqcG+SD+0fBMSkMLlnWZl/vbmBAkdDEI811RF+9U7Hb+LR7Np2WeUe6ov6BlFU/ACYzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHAYQqGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHAYQqGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7390C4CED1;
	Thu, 13 Feb 2025 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739452509;
	bh=Ggp/ECmDCoW4aL0f4UUd9e9jyBe2uXXhxi81bgqRCKo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nHAYQqGW+Ek/kuuZqVxQeXmGdK4dKs+4AtmAnhhGQ4dall8yyOCQPqULGeNT4Io/Z
	 kPoTQ7GH78I9OW8osxE7W8bVGzRkKZ25QP6phtT5C+t5yE9weilJgVvNfNuQIiDtnM
	 qo1HnY195+3M5Bd5jmiVSTazlppm9Fsb0NUZlXp0=
Subject: Patch "mptcp: prevent excessive coalescing on receive" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Feb 2025 14:14:00 +0100
In-Reply-To: <20250209174828.3397229-6-matttbe@kernel.org>
Message-ID: <2025021300-footage-amiable-d6af@gregkh>
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

    mptcp: prevent excessive coalescing on receive

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-prevent-excessive-coalescing-on-receive.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-114460-greg=kroah.com@vger.kernel.org Sun Feb  9 18:48:49 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun,  9 Feb 2025 18:48:31 +0100
Subject: mptcp: prevent excessive coalescing on receive
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250209174828.3397229-6-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,7 @@ static bool mptcp_try_coalesce(struct so
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mm-kmemleak-fix-upper-boundary-check-for-physical-address-objects.patch
queue-6.1/mptcp-handle-fastopen-disconnect-correctly.patch
queue-6.1/mptcp-prevent-excessive-coalescing-on-receive.patch
queue-6.1/mptcp-consolidate-suboption-status.patch
queue-6.1/selftests-mptcp-connect-f-no-reconnect.patch
queue-6.1/mptcp-pm-only-set-fullmesh-for-subflow-endp.patch
