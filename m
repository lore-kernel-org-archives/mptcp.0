Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AB171A2;
	Mon,  4 Mar 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539885; cv=none; b=XKrJ4PZsoHGA38mis3TTQH1DhOAMuZBaCCoXGT0SGwQ5q3ZmhrbLFhU7N3Dc/JpXfh5kEFEBB8y09AV9vn7CLabJrq1JllfZ8olexg/Z7HfhuILhUoV1wYeJdLdE7tdQV80hsrhlqoEQFR01dCwb5EcECEY0XNgXt9ZTNbkPhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539885; c=relaxed/simple;
	bh=4/I0huzIspezx6Jd99JrbC7cqCCT01qZXk+r8aXwOHo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=XjL7SmPctKhSKbP70+20w8bTRNLxiXlWLUKuhGCpRkT9mOpmjeuzdE2JbrvFz/NkX6OJ2O49cDjt1mIQScX0hibViJ+U/w7jls6Dz3DdObcyMQZc69wQgrCaJF9pDhVfenxAziLk2/NcrqsB/EwL5jFxb/E2vDbNlxJfSsesjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqjdHTUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqjdHTUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A57EC433C7;
	Mon,  4 Mar 2024 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709539885;
	bh=4/I0huzIspezx6Jd99JrbC7cqCCT01qZXk+r8aXwOHo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=UqjdHTUPlbA/6lyFRYakbLmLMS4eJizNlvzNLLPt3E+JSrSDrI+hXF4jT/9gT97gU
	 QFeKfyAeqC/ZQpur1BxG/GGQLlUt8MqG04JpeWttW3RuKpdHDhleTe9Jo+jkWLxSOf
	 29W/TV+eFlQ94vvmkDr/2iaIizHoS3OTtrOQ1Mx4=
Subject: Patch "mptcp: continue marking the first subflow as UNCONNECTED" has been added to the 5.4-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:11:22 +0100
In-Reply-To: <20240228172121.243458-2-matttbe@kernel.org>
Message-ID: <2024030422-divinity-blimp-6559@gregkh>
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

    mptcp: continue marking the first subflow as UNCONNECTED

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-continue-marking-the-first-subflow-as-unconnected.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org  Mon Mar  4 09:10:32 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:21:21 +0100
Subject: mptcp: continue marking the first subflow as UNCONNECTED
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20240228172121.243458-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

After the 'Fixes' commit mentioned below, which is a partial backport,
the MPTCP worker was no longer marking the first subflow as "UNCONNECTED"
when the socket was transitioning to TCP_CLOSE state.

As a result, in v6.1, it was no longer possible to reconnect to the just
disconnected socket. Continue to do that like before, only for the first
subflow.

A few refactoring have been done around the 'msk->subflow' in later
versions, and it looks like this is not needed to do that there, but
still needed in v6.1. Without that, the 'disconnect' tests from the
mptcp_connect.sh selftest fail: they repeat the transfer 3 times by
reconnecting to the server each time.

Fixes: 7857e35ef10e ("mptcp: get rid of msk->subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdabb00648bd2..125825db642cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,6 +2440,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		if (msk->subflow && ssk == msk->subflow->sk)
+			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
 
 		goto out;
-- 
2.43.0



Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.4/mptcp-continue-marking-the-first-subflow-as-unconnected.patch
