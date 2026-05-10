Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CD2F8E8B
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778443753; cv=none; b=mAEV8dSVkmS999t5GGlAkTcpDgwVZiJ4L3PItCHJD4IjXNSk8cui+2yy6NnBBEAO7t7qZ5ZXdQfctCPpJaFJfnxiOYX3YG2lK+KQDwmfQ5WpPrdkFhQTYkhbx8OiFhlwpmK+YV9rUJIaarfysbvl+S23bXP72kJnGFIgYO3tgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778443753; c=relaxed/simple;
	bh=b4jW2nqrAAFekrPfKAgHsfPbg3pXcUNeRMVRWfTr0U8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YcfGU+/99j3AqSRmYqOU6BwZvIXQuVyUj0czGy+LWntecRN1UOKXBM6Y17YK1b32llm9uDwwoD/L7EoTNhjDIW+APhTrstqj+lc+kfvJxVUtnubpdUG3dbVNYGqnQr9ZH/DGiYJqILTheXCC/XpdWEpuikEMWcNo9Dc6D4Jho1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP9uFR4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP9uFR4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778443751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn4Egq1OjdM7URzzG5AYLIQCMiCBXQclV93onXzlJHA=;
	b=IP9uFR4jyP+6E3eJ1SzrY9GkR6C5vaRdpdTPwpkQNXLIpm3tFsy1gxInUWxutN+EutDU9f
	Cto+hu+hkcPjsk5SROWCqD7DBQqFbkUJ38lIm6nUHbuKqpNyZ+CoVJRx1Hm4iWpt8bX9IC
	RcwGSpiGn3/DN4gHXbH92wIgGL/qk9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-9GzeYNnhNNmMhjnSR6EcTw-1; Sun, 10 May 2026 16:09:09 -0400
X-MC-Unique: 9GzeYNnhNNmMhjnSR6EcTw-1
X-Mimecast-MFC-AGG-ID: 9GzeYNnhNNmMhjnSR6EcTw_1778443748
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-449b2a183d3so2702228f8f.0
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 13:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778443748; x=1779048548;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn4Egq1OjdM7URzzG5AYLIQCMiCBXQclV93onXzlJHA=;
        b=RbNaITbq/G7h8dL/Xo9cCaTZa8nGfELip0Keih9AtEC/ZIap3u2xtLgq0Ps6pwksyf
         SHJAeDKF2UMKBd4zFKdAp07eB1JPQKsGRjCuIvUcCTzjJ/X3nlHXUYHnJsRQWvbedWBm
         9RZSmfqqexl0s5PsSFSYqZxo+QPyUR1zUHZlOREB2UI8EehrKemw5uw+WU6ZXOz3ertC
         Y2xuFn93nRDOHpc7sTanoe5jbMYMZAde+PT29/THN+rP+oDKF38MQue7wyHt18SmTIqw
         J2grWKLvlzk2m/IzncEhPA/SV1Lnr2cFmnjBlsHPj81VnvUPis5lLOnSVvH/2luIz50O
         kWkA==
X-Gm-Message-State: AOJu0Yzy273IEBnr9QGz676VrtM2jVSyIxSH8IjkGdlecwQjPS82NdyL
	yriXD3KgIe8Z+9Hy9f6W9F57qdvxaXHZAtT66I+Bs66V4OUrJNHPJ7hepoWtu/cRHKDR1oL+uXb
	eSq7KbnQnhsRMVWsbGHaPI4tp0c2otuTZNXpIHgUZ9XLTjIPVbg9T4Nsh1WNubbe/GOsovWA81+
	xB48ggsvoGvCVjbBltX2EJwlwwYRBrUp+PAvvE4A==
X-Gm-Gg: Acq92OFiFc9j4jeiluPSJHGYtJdPnl8pi+QvMn4eULa6ARJx/sjEYTQRp72BCcNukyH
	VJ9Ww+pEFsHXJSmVWsekq3ylk0VU0bVYqIaxVDrkTPcl+NIEMr4cDSlnWyYVLkcDPSR2g7okqJe
	NmqTcN4G429OEn+nJDvrwUpLCsppRzqoRFoiW4YpjWBkWxiBpnbHouwM3cTHE6oPSLwRmBvKCqF
	qK2OhIlJfNVFw+HQ2RzTyLRjwHBqSb4ovcIgwo9JC4Gudjtne5yd0zfwcct+IZUuuy4uvGryDCV
	QBd4s6o7asuzmIPQvjAfhhORJ06lS7oyQ61aaJvkbNn88M0JJNpk/aMDGOPPOfyAra2nd2Uj1Q+
	1jsInjVl7KStp04OQcoTTB8E+TQ1hMCb70a+kDMpv4i+HbWKCE2ysUOqS
X-Received: by 2002:a5d:5f87:0:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-452ea177716mr25179304f8f.20.1778443748044;
        Sun, 10 May 2026 13:09:08 -0700 (PDT)
X-Received: by 2002:a5d:5f87:0:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-452ea177716mr25179266f8f.20.1778443747440;
        Sun, 10 May 2026 13:09:07 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm19396744f8f.16.2026.05.10.13.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:09:06 -0700 (PDT)
Message-ID: <95fd8dce-e72e-4e11-8246-75482d9f375c@redhat.com>
Date: Sun, 10 May 2026 22:09:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 02/12] mptcp: explicitly drop over memory
 limits
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <cover.1778312843.git.pabeni@redhat.com>
 <ce7beeb758f004cc86fe194db4c91ea4b487d042.1778312843.git.pabeni@redhat.com>
In-Reply-To: <ce7beeb758f004cc86fe194db4c91ea4b487d042.1778312843.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w0rLw-wNVFRLM3NtSI2_su-g8MDZjSn2sy9ff-hTuuI_1778443748
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:48 AM, Paolo Abeni wrote:
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4cc583fdc7a9..19c0bc92f04e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1158,8 +1158,29 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  	return hmac == mp_opt->ahmac;
>  }
>  
> -/* Return false in case of error (or subflow has been reset),
> - * else return true.
> +static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
> +			     const struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	if (likely(sk_rmem_alloc_get(sk) + READ_ONCE(msk->backlog_len) <=
> +		   READ_ONCE(sk->sk_rcvbuf)))
> +		return false;
> +
> +	/* Avoid silently dropping pure acks, fin or zero win probes. */
> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> +		return false;
> +
> +	/* Dropped due to memory constraints, schedule an ack. */
> +	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
> +	inet_csk_schedule_ack(ssk);

Sashiko says:

---
Does returning true here cause a permanent data transfer stall?
When mptcp_over_limit() decides to drop a packet, it schedules an ACK and
returns true, which in turn makes mptcp_incoming_options() return false.
When this occurs in the TCP fast path or early in tcp_v4_rcv(), returning
false instructs the TCP stack to jump immediately to the discard label. This
bypasses the standard tcp_ack_snd_check() calls located at the end of the
receive path.
Since inet_csk_schedule_ack() only sets the ICSK_ACK_SCHED pending flag and
does not arm the delayed ACK timer, the scheduled ACK is never dispatched.
The sender will eventually timeout, retransmit the identical packet, hit
this exact same memory limit, and be dropped again without an ACK.
---
That is a bit of an allucination: mptcp subflow can't hit fastpath, and
the other referenced mptcp_incoming_options() calls happens only for
states that prevent the other end from sending more data: the mentioned
stall is not possible

/P

