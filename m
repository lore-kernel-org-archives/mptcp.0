Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FD1509AB
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384886; cv=none; b=gFaD+d041p3RRbB8IIDSUvmSmAU1hiSlYPDHuMeMwNId0Q7ZAgdNrLohepxJNh+H10VMxI/c44eAhcokUkkMmqRNXjSWVEcy/g0t2aQAMsifxMGiueK7wuWYm2glJ+yNHAfBwk1IncccjXmxTbbJd8mcYcFCA3hU+JgVoUaJorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384886; c=relaxed/simple;
	bh=RN+NcHynuv1yanICeSYX/3FAE/1ZEwNu7vVDy1VtxX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urz+maOvat6keXBUhsoBkQrIHDABTzjs0vN9eAoU9od9haMIyPeibU8AhXeg3iIo/MNdIiMbHUz5mcNcF2gzksxyQP9AwT4Xr4enTK/3NgcyHfekpttn3RTMgQleEcCIIvI24O4/pY7CX9f5v9alqC/Js8OmXkeZ4lFdZpf5NAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4A8WBlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4A8WBlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA551F00893;
	Tue,  2 Jun 2026 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780384884;
	bh=7TcyeTPPvWxOxYnHnc9AkClCRVGdMQylxYpiu/M0Beg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G4A8WBlY2Dmic2cB/5kSAUV8i+anLIUWsxFkBI7a89ZyixLN3LM32JDSdEttSvG9c
	 Fv9MB7EnOV3ngUV1dUcnVc+s8Xwcw+YhfxICT679X919o248Y8pXWd0ZaEpN0EDTmi
	 m04d8SVG15Lh3KgchjNEfA4jn7qU378D5CQKfUb6xCTzt4ZHRvLQ2xoZvR41b966gn
	 /F7woBOM8P6R6LR/gWO3174nDgbP1MsO6IJrucOj5wx4GZttqjrqWMMBQYi4wYwuAZ
	 fRJu9q6Tp4o0SPX7PHWs2PjgJydL7yntLY+gjnvUw4fVsfpC0YiI64Wk2JcUw9KiCs
	 yTYuyGPbifBoQ==
Message-ID: <36a71a3f-9895-42e6-8dc6-02ce7b6cded2@kernel.org>
Date: Tue, 2 Jun 2026 17:21:21 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 03/10] mptcp: close TOCTOU race while computing
 rcv_wnd
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-3-a5ae7791754b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-3-a5ae7791754b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

(-Cc Netdev)

On 01/06/2026 13:09, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The MPTCP output path access locklessly the MPTCP-level ack_seq
> in multiple times, using possibly different values for the data_ack
> in the DSS option and to compute the announced rcv wnd for the same
> packet.
> 
> Refactor the cote to avoid inconsistencies which may confuse the
> peer. Also ensure that the MPTCP level rcv wnd is updated only when
> the egress packet actually contains a DSS ack.
> 
> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1c5698983c..5c228344e83f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

(...)

> @@ -1708,9 +1711,6 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>  			i += 4;
>  		}
>  	}
> -
> -	if (tp)
> -		mptcp_set_rwin(tp, th);

Claude has a comment about this line that is moved above:

---------------------------------- 8< ----------------------------------
With this hunk, the call to mptcp_set_rwin() is now reachable only from
the mpext->use_ack branch above. mptcp_set_rwin() does more than just
update msk->rcv_wnd_sent; the update_wspace label also runs:

	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);

After this change, is old_wspace still refreshed for outgoing packets
that carry MPTCP options without a DSS ack, for example MPC ACK without
data, MPJ ACK, ADD_ADDR, RM_ADDR, or MP_PRIO?

The fallback-to-TCP path keeps the old_wspace update via
mptcp_track_rwin(), but the MPTCP-options-without-DSS-ack paths reach
neither mptcp_track_rwin() nor mptcp_set_rwin().

mptcp_cleanup_rbuf() consults old_wspace when deciding whether to send
subflow-level window updates:

	cleanup = space >= old_space << 1

so a stale old_wspace can lead to delayed or spurious window-update
ACKs. Is this intentional, and if so, should the commit message mention
that the change also restricts old_wspace updates to DSS-ack-bearing
packets?
---------------------------------- 8< ----------------------------------

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b%40kernel.org?part=3


I think that's fine not to have window updates when sending MPTCP
options without DSS ACK, but I wanted to have a confirmation from you,
just in case.

>  }
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

