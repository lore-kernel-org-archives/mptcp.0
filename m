Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735796;
	b=raaPkS7VT+AAp3bc5Sybh9t/90bw6P/5mDrwwpBpbPzckHg9EbI1ltzaeCVj8/VrMYKe
	 +izQTa7dIL9jMhshv1GLCZWFhZ/dfNPU/yJ8uhP8pHGxPk7C2AiyOcfLdAEHlp6xGKR+e
	 AWaUMmAp7aRWLoDFMdMuwyU8JAe9+VwyeIrZu35SfhlOCY4spppkCy+dYFeBWJj2ucMjd
	 tnKMNvXdGawEZoSOdX3p0jiC0dZshR2W2pz/y1ETV9O9KmTDPSLvRvwUCvmd/G6TcKKx4
	 wNoe8a3Zyx+J1kphdHnAENnD9uSbDSQjTTnoJbBKuJpW6GCksLwBkw28n2nmXGbVbPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735796;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MmCU3hkNbRTqCLcRVQcMhlbvwIcTUj9z+/XtWjZy/8I=;
	b=yqWnPm4k1rjWeSS4zoLTwX6Zcha9f7GFnFR8E4zpd6Si76hsu8bxUy6+quuvBS7yhLdn
	 tLvWkjD3JaYaZ+8E3uKIrvD3LZZ6f7McbJMJKfjiXG11wJd2tD2ra7akj5XxKZyfwgJHl
	 8zvi9Pr6OSIyVG4lQ4AgSxYKKbedRgWWhDAhQfB2ywzYy11UtlK4khIar0eiduZKG/RfM
	 o1o1HTPB29+h/9SXA4zH2FVutqtGN5uKYAU3paLnTuvr5X+W937PmCLYiIPUh0tBJs/oO
	 +Tp9cx8Nxk8SWo11TZ5kML8q1ezSLNgy3MKFIaDnBQC2ugOjHACnweBWtK54N+KC1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+ixJtrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC6606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+ixJtrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91AA1F00899;
	Thu, 26 Nov 2026 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735796;
	bh=MmCU3hkNbRTqCLcRVQcMhlbvwIcTUj9z+/XtWjZy/8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n+ixJtrxeZxEFsscRhyJqhfmtOA+CzeP6WwTRtzN35gbEC4mT5tlXDvuw/QNL/9SU
	 ZwAAwBjHLZGVZq0R2gwPDI1qkEsyPfAvsIugNrd4IuDNK8z8C2UObebtWA8RMRHhYp
	 hRyCeoPdBWc7fSbwsl7jPpMFmo9hQrGbKuo3SIsttGhwJ+4Gat6dVzkvR5IutuGQpY
	 q7mjMjcmBFVMOzXETGNUDacTrL11mUI1tCwsfPOFr6zcZRQWC8TgrLpZvkuCuwezKX
	 TY1kjOAbRkgrj68ouSkDpuUHvRvcwe4VchPDhVS8FW1KgvMyHk9HiQxYcPDyY32e+6
	 y0LQN6TBAjVhQ==
Subject:
 Re: [PATCH mptcp-net v3 43/50] mptcp: order write_seq and DATA_FIN flag
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:55 +0000
Message-ID: <179573579554.3133.9291175102818265682@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-43-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-43-416c0920c73f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit adds smp_store_release(&msk->snd_data_fin_enable, 1)
  in __mptcp_wr_shutdown() (net/mptcp/protocol.c), but pairs it with an…

--

mptcp: order write_seq and DATA_FIN flag

This commit changes __mptcp_wr_shutdown() so that it sets
snd_data_fin_enable with smp_store_release() after it bumps write_seq.
It also makes mptcp_data_fin_enabled() read the flag with
smp_load_acquire(). Lockless readers in the subflow TX path should then
see the new write_seq whenever they see the DATA_FIN flag set.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f89719e84545..e0f39931493ea 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3694,7 +3694,8 @@ static void __mptcp_wr_shutdown(struct sock *sk)
>  
>  	/* will be ignored by fallback sockets */
>  	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> -	WRITE_ONCE(msk->snd_data_fin_enable, 1);
> +	/* pairs with the acquire in mptcp_data_fin_enabled() */
> +	smp_store_release(&msk->snd_data_fin_enable, 1);

[Severity: Low]
Is mptcp_data_fin_enabled() the only lockless reader that needs to pair
with this release?

mptcp_try_fallback() in net/mptcp/protocol.h runs in BH and reads the
same two fields. It still reads the flag with a plain READ_ONCE():

net/mptcp/protocol.h:mptcp_try_fallback() {
    ...
	/* no FIN before new data: see mptcp_check_send_data_fin() */
	if (READ_ONCE(msk->snd_data_fin_enable) &&
	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
		...
		ssk->sk_shutdown |= SEND_SHUTDOWN;
		tcp_shutdown(ssk, SEND_SHUTDOWN);
		...
	}
    ...
}

Nothing orders the flag read before the write_seq read here. On a weakly
ordered CPU, could this path see the flag set but still read the old
write_seq?

If exactly one byte of data is still unsent, the before64() check would
pass. The subflow FIN would then be sent before that byte.

The next patch in this series, "mptcp: order write_seq and DATA_FIN flag
for fallback", changes mptcp_try_fallback() to use smp_load_acquire(). It
also updates this comment to name both mptcp_data_fin_enabled() and
mptcp_try_fallback(). So the gap only exists at this intermediate commit.
The split looks intentional, since each patch carries its own Fixes tag.

Until that patch lands, the comment above names only one of the two
readers.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
