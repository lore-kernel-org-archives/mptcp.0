Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF62FC86E;
	Fri, 22 Aug 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868298; cv=none; b=bAnw9goEuA07p9j1ZVbPzpLNGWgJsnC5hjzLRHEP0IvFiO7fC0bc6P5bcim3rPwdCEoEhAbAUONxCRnFAIxSZ3NE/eyWOh36VN4CmAblHjYDM7zKulZ1qM3FGKNa2zxWy43egr9pBCSj6gYQ3tBFrOWJAW+8t+MtcSbz6+AIoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868298; c=relaxed/simple;
	bh=ReX8NPMWq4RnbRsLWTvXUkT1Y59b0puBfgltbBQmtjw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=sh3nR/fSXj/ekpJgUjV9OvHX1/iP8p9MYNxQ4aI9K2V13vtH82beJfhEDxCeSuBP/2ksf3AZuu9Z8+pY3T5aH8xN8mIAXALuv8U8/oibwY4Xi5NUKPb0dfzYT51XO7Q7POY3KnQgHHQoUYNK8rGe0/t3znTDJ3Z2PWEYMm8qOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2e6kTcVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2e6kTcVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F6C113CF;
	Fri, 22 Aug 2025 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755868297;
	bh=ReX8NPMWq4RnbRsLWTvXUkT1Y59b0puBfgltbBQmtjw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=2e6kTcVQlT/X3nqpdJAtfNyqW86Y2yzO43i3QF4Wk4Ag5V+8u0nB6IJnUOHBGG2Vz
	 /BHn3dBvvZ3+UKOA09XikjAGcr7Jn8SC7TMx0fQUpPp4QNmueMEvXVqpFt5nosLc5T
	 26umUzt8mHZ+OaHts9sJE2p7zB94dMqF1MIGENq8=
Subject: Patch "mptcp: reset fallback status gracefully at disconnect() time" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:11:07 +0200
In-Reply-To: <20250728132919.3904847-8-matttbe@kernel.org>
Message-ID: <2025082207-unturned-fifteen-d2f2@gregkh>
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

    mptcp: reset fallback status gracefully at disconnect() time

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-164938-greg=kroah.com@vger.kernel.org Mon Jul 28 15:29:45 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 28 Jul 2025 15:29:23 +0200
Subject: mptcp: reset fallback status gracefully at disconnect() time
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250728132919.3904847-8-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit da9b2fc7b73d147d88abe1922de5ab72d72d7756 upstream.

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that --
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE -- but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit ebc1e08f01eb ("mptcp: drop
  last_snd and MPTCP_RESET_SCHEDULER") is not in this version and
  changed the context. The same modification can still be applied at the
  same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3204,7 +3204,16 @@ static int mptcp_disconnect(struct sock
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	msk->last_snd = NULL;
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	msk->can_ack = false;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-6.1/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-6.1/mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
queue-6.1/mptcp-make-fallback-action-and-fallback-decision-atomic.patch
queue-6.1/mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
