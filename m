Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431934B410
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660685; cv=none; b=mBQI3SQfw9Ht/SfIIah58K2XktglrJU2LguCm5FZltzRK8lhgmmG0v7HhLaY7luaBL66aypX0O5gGjehYJcdAdT7rMeijjQVrpx1Ys+xGYFwvfW9J0UPUO5DbLoCYeo3NBom8N2P9OHmzqw13JRIAPgywt687LIjXBNDwY0ok1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660685; c=relaxed/simple;
	bh=RnzcoqiCgiO1PMBkGL95IiCkLD+8z6QAFA5shSuEMyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKCDgIcGMFA+3zDKxKr5SnLAsA3Ou/YvVh+OTa5g/+e6ao89s+fF8OFXs/FhbCtkeebIeBEaEkWP1htJD1x2v/DhzJgiy9cWoFglTp56NXhg+b82VOy78hNdpi69CMsshCJugR9ptzHwwAjHNu+qMxczLOFPaumWn2gAU4fyktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/yymGbn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/yymGbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
	b=d/yymGbnR6Zo4Cp56EDz80mzlMy73/hUUT/ZOtUs3LWua/Nq+o1rsGONOBkzMkgAdn+rY6
	GVD5Ei4bDiHg0biABtDnPnmVWTC0PDUTLQ9q0teeZLXYoprPVZMrl6D77bBIo6Du8+uIsQ
	57JpZ/JmDN59mc/Zwze0R8yPmGkLerc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-yxaTUtNoMresjCr6dfYqiA-1; Mon, 16 Mar 2026 07:31:21 -0400
X-MC-Unique: yxaTUtNoMresjCr6dfYqiA-1
X-Mimecast-MFC-AGG-ID: yxaTUtNoMresjCr6dfYqiA_1773660680
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b42fe9031so691822f8f.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 04:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660680; x=1774265480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
        b=idf9Q9vr+nyVQkBysBRJsPM54Y0S82qKcB0LO47Dz9d/+Jn6+BG0YKDRzRTuTMQ4/J
         kh/snqKJjFNlRfUY9Q1lXpv54swZpwQWt+VrRzpNdlmxpCbJNyE5o3D3rJlZ7grmDnFd
         NghoT/UzprppGao4y6X6sQ++1C3CsYCmdXyvTrldNLT/YHNQSbMB+qK13vZT7m8DJ1C+
         Pubw4DE/u3O1uFiV95iaJ/rLiP9Gw74IVGHTUoxSPQQBpAkg+y+ZjVx8UKPvrRiI85qG
         B39lAv35pBkX9lH12Ls9fdffcTo0WR6P5vTzWCUZZwXmRKr/lNYdDXG+h+wlHlhy85kN
         8ZkA==
X-Forwarded-Encrypted: i=1; AJvYcCVnWZV5Vwvino3FZP2FG85Iav6tFq1t5e1Phg3PkMt8vbPwdzVfzG1dmp0UuU40sW1hjlwIiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9jrSs0Ay/KFiwWDiqNFwpZDa/UmojnlldRdIjEnKdKIWxaQXq
	SlkHyvI8vitp6ANYpQO40jM9sAs4A7fgN/9x1sn2t2DjtdcglufmVdDlIQb3xCWkXZ+nbKbHiBz
	1Q0Pbpjc4V7JWvEYl4QipcPZQd274LtFmCRxDrS3qgFZiIxdxOxmwb0kX
X-Gm-Gg: ATEYQzz+ywPKjH+A/GiMrlV3lRAYACQCHJhgpNmcAxPxtqEYyOS1B8iyeOHfZd0uRIu
	sxqMwYUaxfvZn+lQSijP+EbiSnsxkw5OJqmkWqLnDjqztlnWPj8jxITBAene949N1cjqdyDzp83
	OuSo4qYZrHGPrXLwbW+LwotjFsZgNC0iYpzQvIhFdBAhB1Nzm9JXAbQJIvD30Y72RVUqKey+RTt
	P6RLjFsPoRG0xennT7EvHsRPCwMGtJPP1ktuKd7kbh+mr11lvrK9AP5RP1AWWK2CQ0T6pNS/XRk
	bCVmCp39m94inL1V6dSPFms5Hy6XvqOFHxTNpscY4aLOP5912uvJ718JwdTMaFEgKdFqDg8i2jg
	IKMGOTLNoOXC2ajMQOvn0B5qHlgd9ichzJwaDtYo/yvnNzabWxP5TaT0=
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932745f8f.27.1773660680181;
        Mon, 16 Mar 2026 04:31:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932679f8f.27.1773660679649;
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2e2c71sm28145619f8f.22.2026.03.16.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Message-ID: <95ecd36e-e32f-4ca2-ba35-6d251a64ad30@redhat.com>
Date: Mon, 16 Mar 2026 12:31:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JKKeUbO8pRECnyG11B7jK0o2zbxQ_d4-yckqiNMToF8_1773660680
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 57a2a6daaad3..53781cf591d2 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
>  	 * scaled window will not line up with the MSS boundary anyway.
>  	 */
>  	if (tp->rx_opt.rcv_wscale) {
> +		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
> +
>  		window = free_space;
>  
>  		/* Advertise enough space so that it won't get scaled away.
> -		 * Import case: prevent zero window announcement if
> +		 * Important case: prevent zero-window announcement if
>  		 * 1<<rcv_wscale > mss.
>  		 */
> -		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +		window = ALIGN(window, rcv_wscale);
> +
> +		/* Back any scale-quantization slack before we expose it.
> +		 * Otherwise tcp_can_ingest() can reject data which is still
> +		 * within the sender-visible window.
> +		 */
> +		if (window > free_space &&
> +		    (!tcp_rcvbuf_grow_allowed(sk) ||
> +		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
> +			window = round_down(free_space, rcv_wscale);

It looks like this can cause the advertised window to shrink even if we
are in the 'do not allow window to shrink' branch.

Also why the other branch (shrinking allowed) is not touched?

/P

