Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED22765F8
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659380; cv=none; b=RqvLU+Rm3ztqusNLUcoqAzGnp+PtXUW7FzPmT55+ML2mwTd7W+myXjHTxRTVUQ/LPBT0/XiKVlf5y+sT+8ULhDxOAhJnj1fWXlVZq4/GgaVvRHXb2ALk5V9eZyqRfT+tsPTwKbTajw6Ntb7odFi6RZCDAeRPT/q7Z2hQR1GQj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659380; c=relaxed/simple;
	bh=4jmmhwQ9HX1nE0wu5X/8gnKDvmvDMxjNyuG7KPrwFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP0OYMjiJrGgs7oKsQB9O0EWl9MhHLs1xeDBjKTVHMfnNBKEcHdOlj1QnMzOZU1P+S+VYBtRWueCJayMdEPHiZ2AIf/xqXUtp3m6LOdkd5Fj0E2IWyafXu7okpBiGnSwU9oUwKACo9ufwRTZRXh6NeZnba+IVEIXcWaJXR/adkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJmyttGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJmyttGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
	b=aJmyttGJVUFAI9sl6w0H+S1qR8xULZmZXGX+0nG9xXKVGdVOOaiqmd9VP1oc5pffWTR5Mn
	VNlPoM4YXu6EZJ5ct05/IAPOiwdg2M9ly8reBzhlpvL7EFPwatvHYLtalEPHXM9gBt1z1P
	+sYdHjloxX6KyPaKiTLabW4DTLsfXtc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-yheZ3vg3PhOYcGcYENJ6Ww-1; Mon, 16 Mar 2026 07:09:36 -0400
X-MC-Unique: yheZ3vg3PhOYcGcYENJ6Ww-1
X-Mimecast-MFC-AGG-ID: yheZ3vg3PhOYcGcYENJ6Ww_1773659375
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48541cac34dso41925825e9.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659375; x=1774264175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=tD/J8Kg5PeGMc3ccwg1k2PcsOVaxtXEaeubf8tbGURmRVRwuyaPAvmHeeNiql1ZBkX
         nGFQTomg1Kl0zyA0TDcVLrrGCcd5xRiLiExKTgyo6yJ9AzIpHa2cbVKhaWoR36dtDKpD
         opuOCGPxtnKfP+3crnyRoXDKuTJ7tw5H7Vb5MJKOYqcRE0zPUAEg+u8A6uvgqKbwe1Qd
         bO+6dV1M2HGHjlxJcRa6e+q00PC6r70A+h5MXeAfcClhWO/e44BiikVYvYXbTtlKi7a3
         UrBUeBBW7Md8spuv3ceddOhZKxjpdjGr5etv101SiyIeG3EA/dClFdDydo26+DrpUxkG
         twdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUymtu2QGKkFId/kZiOe4qFVl2n7CdPyJpY940HE6FR5Lw0vUequszqmCsz1QWE+gWlNOcThw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTR5gO9TtilYq/5vKT+Njn4RzKSlijPjjMeNOqmjC8mNIqxWoa
	icy2reVeT+No1U8DzgyktOacfMgrseIh3iropUpyLCuPJU996rWVwDKblyJWppOxARtdG+OkxvF
	SCf4U0TOTEuae6qR8A2Ne7MqkhWeczzWgfGxrWnTm8gD8euQgJiXUVOh1
X-Gm-Gg: ATEYQzxVpDpGgBepFr5t+bmhJq6fW2PL5sB9eIOad2KzfyV2EJSR7pQie5QR97rBXgn
	mgZm/qhghyj77pvx/jvfMKWbDRLQQAYZ4ae0sVO3mAeYG5zITpG2+IaScU6d6NNiQdm/6fLLarP
	WA0ORUju8cHHsl6D3PPqXGQc6j52pRLe3HEU3IZYSK79Euf2emuVvi5so84IPvTPLMCQ1sqHiEz
	CcJAdjeu5Us0ffCvS3iF+/pib9FK3oS6V9d4ntL+RQDfKGAGmGSLFUNqdkI3hr6Fne2vLvfOCcO
	Ue4AOItPpXsAEgKJs769eEL6MTQhVHacd+jz6muhPpRwvAA8cU8A3XaAyTRP0u4BAgEPcGDk//L
	bXCra1E/CVfiZz/AqdttsWTsyFLr2UGANGjMCiYhQrPHDTnVKbtx6l4A=
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211849415e9.19.1773659375341;
        Mon, 16 Mar 2026 04:09:35 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211848875e9.19.1773659374904;
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1212991845e9.2.2026.03.16.04.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Message-ID: <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
Date: Mon, 16 Mar 2026 12:09:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QLibotoHvVUBDUIGREq-cw4NulJ4RWs5nNQMVpbOTT8_1773659375
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> This series keeps sender-visible TCP receive-window accounting tied to the
> scaling basis that was in force when the window was advertised, even if
> later receive-side truesize inflation lowers scaling_ratio or the live
> receive window retracts below the largest right edge already exposed to the
> sender.
> 
> After the receive-window retraction changes, the receive path needs to keep
> track of two related pieces of sender-visible state:
> 
>   1. the live advertised receive window
>   2. the maximum advertised right edge and the basis it was exposed with
> 
> This repost snapshots both, uses them to repair receive-buffer backing when
> ratio drift would otherwise strand sender-visible space, extends
> TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
> truesize-drift coverage through TUN packetdrill tests and netdevsim-based
> selftests.

The series is IMHO significantly not trivial. Can the end-user meet the
relevant condition in practice? How? What is the net benefit in
practice? Is that observable under usual conditions or require
exceptional circumstances?

I think we need a strong motivation to merge this kind of changes.

/P

