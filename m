Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB473321BF
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683269; cv=none; b=pHXg0rBc9Jnl9F3Us38esGkswN618xqvuhACXb0oEe34vpPpdmQNojWyopL08zHVeeU+kS7PWounmSxXCHt6TFs1wGObm3svTCZQ7dkZTNMXDq+PeCHl9dsINsoBx1rQZJk5JJcDvV0OdpUcWsfgCtCTtemIHEucdM45FAl/fpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683269; c=relaxed/simple;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbzZeSxqrB80e2JzRZ3kLxlSyIJ+4fP82XLow7SC19/Cfsr2dFAaybY0ScDqCeD3yxiIyVp0uh38EHNbupU7V+QZ29v6Ntg66qn18+ZiblJ0sr+NprVSB6l/BK/P6GoyT4/a2UM3Fph5Dsf1xf+9zzZpB3TfZQ3svW2F5q9DpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duj3MXX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duj3MXX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773683267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	b=duj3MXX+njab/VmBcvZw8iSHnEVw8y88Qw7L3ta4xobC5cVUB6q191Irw6IgQEuTHApnha
	nuFaS2q6BLjsPjdi2ZLDLAnTRhm6sJj+AnwxMp9f4c0NjjRdCl/3SblC2HzB+LC0qFVPXt
	H8r3v61AXtLQpEsrSuELzOJ5RMokaZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-o9rPQDHhP5qeyTTQJs9_ig-1; Mon, 16 Mar 2026 13:47:45 -0400
X-MC-Unique: o9rPQDHhP5qeyTTQJs9_ig-1
X-Mimecast-MFC-AGG-ID: o9rPQDHhP5qeyTTQJs9_ig_1773683265
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439fbfd93e8so3241677f8f.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683264; x=1774288064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
        b=OeNK0maSt854p9FfwabIwz/e9HArsKuOtpuj584LEDH85oyUIZkqwHHNm8nvkqd2m6
         EfQvcy3sOKMSLx87eqr3AALXrEOwsid4SvzUmlnhN5LCMHPKAgqTCqHcBixfhqxme7p6
         +NRvSw81SUGhzpLYb/z35Z641N5bNQ9Bz3LoN1t80ya49FpWoBN8kCzNPxlrxJWXfYRg
         jvU7VuXUKZut23AcniaZeuc0GpNrAOtmo8rZ3JWBKKcQgkRZkJMt0RDTi48nsXalQskw
         BHAlswDphUqufLo9lngUdp7nApHRcSuq2IqVPMyS/MX65ZhzXvz7e3cYUis9wOcK/5zp
         hifQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxzdMJ1yBg3uygQ8H5rhRK+45nBxOEenaykL0GO0xKRggI9seqGbj0WS7uIP1/oHJnDgXK+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtkMW2AB7BEGxo/4Qs6TXcs33Tq2lX/C9IBYW2lWPqMmha+xJW
	XiqTzKhZlbhkKk+pSzG8LDnMa1kd31XScWNOp++swn33HB+ADkr3/VklmaLalm+2skn/E4OtJod
	yldO9FAnopPEXzmOagKzeHhYb32vy+CFomcP5Xhu1it37r/wzUT+Gx0f1
X-Gm-Gg: ATEYQzyTcjmOTe2E1ChxMDJ8gqKsa/obtlq/Ayk6rh0WKqY6xMdqi1Dl2nFw+f8P2Yv
	O19z7B4l6nRQngOVPMXkbC7h/9o24NCY24F/mxz8W9dynp9j8YLilDhYFIoyURXnaWTNeaZY8bn
	U4Ci3KBAte/IyYxKYzXeqcvH94JNT3Soh9gGOlOkAAO0Qy7bz59qCqiJXaUdcJHWsvkuymZw6uK
	XP9vPlPNkfuGpe5gcl5EzxURVE5rJ1eJeKo+CZwGlyax+OKeF4CYrgLyFvgIfFPC6CqdT68M60w
	JnV+Ri4hh13zT2Jo3AgFsj0arMf6r5lyITFm9MEydWgONaynKSPuQp+be4GFW1McyHPBoJR4wbp
	sl//Goa5HEek4uk3txUaxb+tMo4PhoWZ7E1YPEQE3vPMVztMc1btPr+4=
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977680f8f.43.1773683264563;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977613f8f.43.1773683264127;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41ff92a6sm17659188f8f.11.2026.03.16.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:47:43 -0700 (PDT)
Message-ID: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
Date: Mon, 16 Mar 2026 18:47:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y6IBsAbFTdELH7l1dA20IeNey3ZpOl_2Sw3mEGP5xpg_1773683265
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/16/26 6:29 PM, Wesley Atwell wrote:
> The strongest real anchor here is the already documented regression
> around sender-visible rwnd diverging from hard receive-memory backing,
> rather than a general receive-accounting cleanup.

I likely missed some of the prior discussion. Could you please share a
pointer/link to the mentioned regression report?

When posting on netdev please:
- use plaintext only messages
- avoid top-posting

Thanks,

Paolo

