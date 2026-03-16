Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CD3914F9
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661468; cv=none; b=iMEfXBFjocEowpQdqUy1AeU0qY69oGrtFC/d7RQ9cyrsvWrObFwanr6HpLrCDwEy6gFaOdaPtlZL7WsNnhM85ChSk66mwL/wtKTCl9HApV0RB0zhfG7h9MDX2x8shLFYcK81y2M1ku2mb1qyb3p9hogCSrnkjf00U0CGKJtj2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661468; c=relaxed/simple;
	bh=XYZ/Z8E6vtXI8ekr+HAC+mYeXCVml7M5yCUGxNj3tfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQKwDn+qMCBDWnhVBifciQCahUjXrpXHs0n2XvWoNrOryagKB1jNf2qBIStOE36epm2oGl2xYv9giJMLJa9pxCyB69rabz8n37vdnhbT24sors7Rdq7b/ulFc9SfeAOgBxzCLPPQHyk7fvcD3ukYUgGMDq3+TgLLpQfLWS7wNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLdiH2iA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLdiH2iA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773661466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
	b=WLdiH2iA1Fj30KikWqsTr882TlmQNJPxWsd0yhTZuWtCrsmTWGoe98gePWbWrQ62SYG6x0
	VQGKKM1la8NrwjL/yG5UQzFfbbI/xKgbkJB1xQT0r5ntW+WkifUQzM/MX5IhIpbXwo2b5C
	Ls4NSIj5HCfVsA39eD/a2Dpf0JKsyYQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-4YXTBPgtM06XIzDUEhttUg-1; Mon, 16 Mar 2026 07:44:25 -0400
X-MC-Unique: 4YXTBPgtM06XIzDUEhttUg-1
X-Mimecast-MFC-AGG-ID: 4YXTBPgtM06XIzDUEhttUg_1773661464
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b979df03fc8so138370466b.1
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 04:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661464; x=1774266264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
        b=Xd4eh0N7D94U4dyKXWJO1AqodVNu1UTFW7CwG1WErrlrmrkn7FhC0nkXG7jGccdI8I
         c079yqw6Kh98/jj08Kv3vVL3oqIbIcUxwKSXmfxVP/BiIXf2bVyy5R+DCAsyWOir6LCt
         ldvSUtKVrg3/+E8Jg5ac+WBp8AFHp5NHQzmy0Aajo+monNnzxeQOrPQJsqoytCTDYG7f
         zLuJpotF1QoPgwOJaB06aiKnRr+u+x1dqd7d/u5Eq3gWqmGJepykcyiYWqUrLf2v7ETf
         EtasFrvcJNAR3ggkqj+n5s6jCJkGrLNh/vMDjG76svJfX9IJLCP5w8nQceee97h5v+fV
         +suw==
X-Forwarded-Encrypted: i=1; AJvYcCVFo2zyKLb/k8HfzEXJW0FrQ01hT0W1BZ7AmGk5eCFsGfMaiZdSVT+s5TSFLjqCxg4baJ1C4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz8Mw+vrsOzj2Z5kbrqfaP6+6CnrAlxZLYbcRlunXN4MQRstZ5
	8fZm+Q3jrxXZDlGsaXbUQmf8vvhISj/i8T5InDr/AnKb5SpLs7toTAdIyXSzSAlREE0yt1NQEz8
	+DwhaXWH09V/OEQsJh0GVm3YBe4ozlx5H61c/G2XtVNLF58gotO9Tn06s
X-Gm-Gg: ATEYQzx5ZbtjI/4DdJ1O5m4nzIeF9+l/AbxUolQr3CWtVSI8phb4mI0kaHy+2Bb6P+T
	D+vZmtiJzYXLTxT490fWAmAzZPnx5yPUX6HoALkqZXcpLzfT18sT7TWu9DPegmIpWX/IEzXwfz/
	S3UZTjtgyL80JY9CVB4LT1AeVlpleNyMDVS9m18meUp/O60woTRQW0N4xT2xI7AD2bVf24fSk0b
	VrcUsIbIQMND7LwJ4S9yPLuvufm/QX0GaGKVADQiioRmdGeXUMcYJh0iiNjhLGWl6NsgZH3/lAh
	7Y6mNFovGRbqKd0fB2l0WAM2BnRskY1pbdlPtRuhG8iOhPyAkMDCf35UeNsMQGL1QjdBOVVLkn6
	g19wpI6CN4izjgm9Y4JBVDED1auZJW5WBQ0WEw98LWQM1DXffMsSUGyU=
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285764166b.11.1773661463829;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285762266b.11.1773661463375;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d096d58sm533417666b.62.2026.03.16.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:44:22 -0700 (PDT)
Message-ID: <dddab568-a7dc-472c-8799-095ab96cef0c@redhat.com>
Date: Mon, 16 Mar 2026 12:44:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/14] tcp: honor the maximum advertised
 window after live retraction
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
 <20260314201348.1786972-8-atwellwea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-8-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pt0NE_XtCSrDFLjvs13r-7fW6yi6P6swzLKVupTrZOI_1773661464
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> +/* Sender-visible window rescue does not relax hard receive-memory admission.
> + * If growth did not make room, fall back to the established prune/collapse
> + * path.
> + */
>  static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
>  				 unsigned int size)
>  {
> -	if (!tcp_can_ingest(sk, skb) ||
> -	    !sk_rmem_schedule(sk, skb, size)) {
> +	bool can_ingest = tcp_can_ingest(sk, skb);
> +	bool scheduled = can_ingest && sk_rmem_schedule(sk, skb, size);
> +
> +	if (!scheduled) {
> +		int pruned = tcp_prune_queue(sk, skb);
>  
> -		if (tcp_prune_queue(sk, skb) < 0)
> +		if (pruned < 0)
>  			return -1;
>  
>  		while (!sk_rmem_schedule(sk, skb, size)) {
> -			if (!tcp_prune_ofo_queue(sk, skb))
> +			bool pruned_ofo = tcp_prune_ofo_queue(sk, skb);
> +
> +			if (!pruned_ofo)
>  				return -1;
>  		}
>  	}

The above chunk is AFAICS pure noise. Please have a more careful local
review of this series before any next revision.

/P

