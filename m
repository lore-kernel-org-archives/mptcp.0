Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC0171A2;
	Mon,  4 Mar 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539914; cv=none; b=Qmm5D5Cqv7CHXGBzN6AAWxbMsPkyhsh03LpxFRMasKFsAXbge6RQXN3cSP/WAFUoORcuwO1IZxdLlI1OV1yCOfETlPaFXg1/q3iU/GXYipmbZIpA0FdO3jj1nF3FM+ftTQ7D9Pv5KGm+sZ1AWF3jRgIleXw/s1XC3OCQdaSceNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539914; c=relaxed/simple;
	bh=7FtWVicChMZpC9q80APFvNl2PA1RVRtKPM+JPVn6Rjw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jryh0KMLT/2BwennHj2665n4Qfzh12KiGHn99jFfS1k+niGQErawpFDDeRlBYm453xYrnnZ3Jo/lKBZcUbj0eLrL+E1FjUnQMjQljcMzQX9BcfGIFUVHiV9TxhEAY8qRajt2+HMpWrCU/xu2Jsx71HNhJWypXfrbW9Lk2W5QVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgBO8N6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgBO8N6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22145C433C7;
	Mon,  4 Mar 2024 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709539913;
	bh=7FtWVicChMZpC9q80APFvNl2PA1RVRtKPM+JPVn6Rjw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pgBO8N6nfqV6JZlNSoxvtF5dPUq37r3aksy2d66Fw6PiLsSL4d3JmdEwopOaZBlEg
	 l3wVGJdigwRsaaTsNJvDGZBHlfiCxzm3k2B7sApI0V+9crTchhaq4XfLWyixA4RQrJ
	 DvESMw27nRP9iaFLFKNK3J8GLCRbsJP7SQDs7xiY=
Subject: Patch "mptcp: continue marking the first subflow as UNCONNECTED" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:11:45 +0100
In-Reply-To: <20240228172121.243458-2-matttbe@kernel.org>
Message-ID: <2024030445-basically-wager-ba53@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-continue-marking-the-first-subflow-as-unconnected.patch
and it can be found in the queue-6.1 subdirectory.

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
 net/mptcp/protocol.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,6 +2440,8 @@ static void __mptcp_close_ssk(struct soc
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		if (msk->subflow && ssk == msk->subflow->sk)
+			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
 
 		goto out;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-continue-marking-the-first-subflow-as-unconnected.patch
queue-6.1/mptcp-fix-data-races-on-local_id.patch
queue-6.1/mptcp-fix-duplicate-subflow-creation.patch
queue-6.1/mptcp-fix-data-races-on-remote_id.patch
