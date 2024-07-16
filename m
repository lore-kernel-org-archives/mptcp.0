Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75B198E60
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126148; cv=none; b=lQe6qH3BjOn8LZ0Cz/SiLcpcnoDYVjeNoy9fD+gb90g6KMjHmiOraAh2euqmhqSartuZnOQyLE+FuoHq0IIfx2oCE8K1RrnBdBYuS6GN+bO+yC2kqgVlmn58Zsemn2jut62MT7x/Rldtl41tJZyFqtSzyWdngknsyPJ+jQFL6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126148; c=relaxed/simple;
	bh=TO7sQ3l4Ocw7ngAGMF37Xr7+fWofdxgiA9ChVi/v4ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JN+eCbZVZlS76+QwTyNe4po77Wng/IMFDSwoge9HW1Ku7hmCPpdi+cSO6lig5qZZ3jXQf6l8o6uUCTIGhN6cKXnRjfdgFZrH66RvCEad9l1JB6XZlcfAH50EqMkf1JfcYce8y+doHmxPL6+LJy4uEsS+Nenc93UNZA69E5+Eje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Csr7VoDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Csr7VoDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721126145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGf1srjAfkgUJwlJ98m5S8Ec/e1tD+REVq/3yTgsHxA=;
	b=Csr7VoDPGsmVJU756K5/F9I0gHnaUiOgAhEBgIGyTBd5ZXRCU0WWECjdaZmvnM4ON8l6gO
	GiiPZrglGOmLUoZJOGPiGl3EQa0DmgXfRljuptmJ9ARbuPegq8M9X6PfhLQB+wH8u7O+G1
	5sg7JnEg1XgYfAXv7oxNg0nW7DR9Wpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-msAFLx_-OUipqJ4l0NfUHg-1; Tue, 16 Jul 2024 06:35:41 -0400
X-MC-Unique: msAFLx_-OUipqJ4l0NfUHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367916e42d1so78083f8f.1
        for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721126139; x=1721730939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGf1srjAfkgUJwlJ98m5S8Ec/e1tD+REVq/3yTgsHxA=;
        b=V9ImP/e8MHCDBT29B+R6LeL6V55ixI4dFUuj7gpQbOdzihhlEoMUkwVFvEhTx87PQq
         CSOBdLIpVRQlpqIU0F/kX3YuKycjv+3crRxMZYdcZh9YHEB0HHu5UzkbUDv0XOVl6wsG
         j6i1FwYkR/Q/E/aCYByL21Fb9icoH4JZ716upAuVwuQf+IuO4aQdrAtQIVclK8xGeWeH
         2jlErMiOuDT+ylU9xxhTgnEuc14CyEC5HvTPLAAOaJggCJ9f0MdDL3+g59FR9lCoqz+1
         AheQW0ADGv3HSucdJCHSFprgvgWOzbm5GbMAqVRb+eypdBMbMgoY/cq6HVXe9B3lNLps
         WolQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDPWmB1x1SVNwQfC7oAjGYrwNvdO25Rjz7WlWei0UB/Fas+rwQyliE3++HrxdSlz1puCH5Ipw9BTbwbMy3PO5QvqJTCnY=
X-Gm-Message-State: AOJu0YxN62JBEGfpv8vEUoOFpDgq2jS4C0M0f7u0NYW4DmKTd6jjeo3+
	7+J8BZt3p2to4huaoW42mZs7QAJdxuDSCMOJ6ToGYZeprxJAsocqbv71cFRLwpDUytW2RS4Qb//
	pnGXzLqrJ8hRb364Y9Gbz6zSJKUH3lEF+wfeKyr2Yw+fCiCYLPv9C+goTbGdS
X-Received: by 2002:a05:600c:5107:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-427b92f39cdmr9122055e9.1.1721126139504;
        Tue, 16 Jul 2024 03:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmogmOkNUOz1J0+S08ncUIRkZtradZ9HOqAZuLGzygQPQ9J+ULtImbM6JxJmaDNN0VuvTI2w==
X-Received: by 2002:a05:600c:5107:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-427b92f39cdmr9122015e9.1.1721126139107;
        Tue, 16 Jul 2024 03:35:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427b8609d54sm31602185e9.42.2024.07.16.03.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 03:35:38 -0700 (PDT)
Message-ID: <504957bf-8de8-4ea4-aadf-b84b62d267ea@redhat.com>
Date: Tue, 16 Jul 2024 12:35:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mptcp-next fixes] mptcp: process MP_JOIN's 4th ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 21:09, Matthieu Baerts (NGI0) wrote:
> The 'Fixes' commit recently changed the behaviour for MPTCP Join
> requests for listening sockets: when receiving the 3rd ACK of a request
> adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
> MPTCP sock that has been created when the MPTCP connection got created
> before with the first path. The newly added 'goto' will then skip the
> process of the segment text (step 7) and not go through tcp_data_queue()
> where the MPTCP options are validated, and some actions are triggered,
> e.g. sending the MPJ 4th ACK [1].
> 
> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> delayed, but it looks like it affects the MPTFO feature as well --
> probably in case of retransmissions I suppose -- and being the reason
> why the selftests started to be unstable the last few days [2].
> 
> TODO: it is not clear to me if we need to fix something for MPTCP. The
> following packetdrill test doesn't seem to be failing with the following
> patch, we can see a fallback to TCP, which seems OK in this case, no?
> 
>    `../common/defaults.sh`
> 
>     0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
>    +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
> 
>    +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>    +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>    +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>    +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
> 
>    +0 write(3, ..., 100) = 100
>    +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>
>    +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [1]
> Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [2]
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>   net/ipv4/tcp_input.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ff9ab3d01ced..ff981d7776c3 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>   		if (sk->sk_shutdown & SEND_SHUTDOWN)
>   			tcp_shutdown(sk, SEND_SHUTDOWN);
>   
> -		if (sk->sk_socket)
> +		if (sk->sk_socket && !sk_is_mptcp(sk))
>   			goto consume;
>   		break;
>   
> 
> ---

patch LGTM, but I'm wondering if a similar problem can be reproduced 
with plain TCP and  TFO?


syn + TFO	->
		<- syn ack
			[accept]
ack		->
		NO 3rd ack????

If so possibly the 'if (sk->sk_socket ...' check should be refined even 
more?!??

Thanks,

Paolo

