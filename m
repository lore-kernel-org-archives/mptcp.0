Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77A4176D
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 16:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17263C433C7;
	Fri, 22 Sep 2023 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695401950;
	bh=TCl6113yrW63g8QuiPAvTb2+GZciCI7fyYdU9EpzuHs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bbiE3Ya4CtuUoudzZGT4itcFErD6qeoBUjF30Cb79+L/fIKO6OsqpeJyIIKJgISBL
	 ATJkvQqy+Sdptk/qAh8kfISD5Y9xiZu3UwBQr6CKB2rao6RkJIfBGl+2m52VLfpLdQ
	 XgiAPzQbTTF3zBG1GHj11D4dy+Kp3xKSpdWIn4xjgtVkAxINnczzIMlTRjWp4TpaR1
	 VqT/I2P2X0pijYgd2c4Wn+vKS4rSOM8UjmHdvBZPVSKnwcnuyijl2cpgk4cnKJK0zc
	 gBHfjyRpxkO8MMDqgpk++IdTK30+5U7K8pb3SVvEpHt9665nK62co3p0ytZfc+2k4T
	 wUpMcCrBcNoYw==
Date: Fri, 22 Sep 2023 09:59:09 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] mptcp: performance improvemets
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
Message-ID: <f5c987c5-25b9-a156-cedc-5646b2154588@kernel.org>
References: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 Sep 2023, Paolo Abeni wrote:

> Cool subj just to catch more attention;)
>
> This is a follow-up the yday mtg and to the discussion started from
> issues/437.
>
> The first 3 patches implement a working support for rcvlowat, with the
> intended and relevant side effect of avoiding most TCP-level immediate
> acks.
>
> The existing check in:
>
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L5534
>
> newarly always triggers immediate ack, as the any data received
> on the subflow is usually immediately moved into the msk. That is, we
> nearly always have: tp->rcv_nxt == tp->copied_seq.
>
> That causes an unneeded large amount of (tcp-level) ack. After patch
> 3, MPTCP behaves much more alike plain TCP, compressing/delaying many
> unneeded immediate ack and moving some of them at recvmsg() time.
>
> Such change has quite a relevant effect on the max tput, ranging
> from -4% to + 40% depending on the specific setup.
> The small regression happens on CPU-bounded bulk transfers, with
> not-so-large write buffer and can be elimitated increasing the write
> buffer size. Even in such scenario, the overall efficency (B/W divided
> by the total CPU cycles consumed) increases.
> My personal take is that overall this for the better.
>
> The last patch gives some speed-up to the tx path, just by using the
> 'correct' (or better) helper to memcpy the data from the user-space
> into the kernel buffer.
>

Hi Paolo -

Series looks good to me, thanks for the fixes and enhancements

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Paolo Abeni (4):
>  mptcp: properly account fastopen data
>  mptcp: use plain bool instead of custom binary enum
>  mptcp: give rcvlowat some love.
>  mptcp: use copy_from_iter helpers on transmit..
>
> net/mptcp/fastopen.c |  1 +
> net/mptcp/protocol.c | 42 +++++++++++++++++++++++++-----------------
> net/mptcp/protocol.h | 27 +++++++++++++++++++++------
> net/mptcp/sockopt.c  | 31 +++++++++++++++++++++++++++++++
> net/mptcp/subflow.c  | 24 ++++++++++++++++--------
> 5 files changed, 94 insertions(+), 31 deletions(-)
>
> -- 
> 2.41.0
>
>
>
