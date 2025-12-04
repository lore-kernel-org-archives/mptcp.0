Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E257343D8C
	for <mptcp@lists.linux.dev>; Thu,  4 Dec 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870124; cv=none; b=lqXMIz5lVEoXcDYAU9uIV14Vgpl8Uw5uJEP1TeuArv/7UzvEQ5i5qyD2Vh7ZkXycyDD6Q6eH7x0DFu3ULyCpGREMHOhZZ3bnX3OlgkicMmgcec5uxSEvWdPEQSdceE3yH4tMM5K1XoSOLLr2+pgjwa5f8GttPNSf4yCOU6R6Zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870124; c=relaxed/simple;
	bh=04eznu63bRzCceVhLl9sysJACGgpZgxcVBqFdoih1FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGzLcM4AQS1EyLWJL+JLZRL7E2cdWgp2z4uS2uvvpju3SnDompNAW1PNsOlijpIwrUpj+vtf+ItDLpeVvWM6ch0063dEuXvBWqs1W3wgflcHZmdSVxExtPyA3IFJy/J1MMYksX1MM5g0oDVIaRJZdcBjlu3AdbVAbo25HQ7GRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFG7vuLY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFG7vuLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764870120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Apn1ii+kL29/iiH1gv9+7vJMZ0ZBWCRhM37tdP0HYk=;
	b=XFG7vuLYTXRjbIgogw0eEMyaxQLBNuGQLrZlj5MiD9yN79DJno93WiFMgtJKMbNt9ifWzi
	d+wWKuttsu31L94xnzOX+XwpchR5VWzkPBAeDQ6uxcV/bTFpKaafzqeBDum21UoFhwF7lp
	hT2EjjH7oZ0+nz1yoNSQV7aN3TZPpNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-YIjAewzfPeyuTEhy6S3ldQ-1; Thu, 04 Dec 2025 12:41:59 -0500
X-MC-Unique: YIjAewzfPeyuTEhy6S3ldQ-1
X-Mimecast-MFC-AGG-ID: YIjAewzfPeyuTEhy6S3ldQ_1764870118
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47918084ac1so9204825e9.2
        for <mptcp@lists.linux.dev>; Thu, 04 Dec 2025 09:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870118; x=1765474918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Apn1ii+kL29/iiH1gv9+7vJMZ0ZBWCRhM37tdP0HYk=;
        b=Dr2xERO8KDetQXXsJS6t/e1cbLiXcuHhnW8S4VOV53pFgI55e5AhCPJ7WoEj0s9Q4T
         NEoajG6shs5ugJzmQaj6+bFtfwS82xclL0DbSb4ukDeiLY4tgClHLSPi/4lARALa+yrU
         eVTGf9Bwc6vrbXuffDDPP8JniC5hvwks4msiJU9AbUHBgGHJAwNfUalRsE54eG6LjiUn
         sx4z0vKUh75XuM5qq/UBgfRFJF3p1tuBlTT2rep1FRfW3c1ZuQzeI/9tGvw8jOtRKJzo
         jzty+OuY0AXRDP7ApJlt5knTuq0BqJeROLyXLASPPfi8kEqnzcW3dQOq3Kfj0s1tSJJV
         Z6FQ==
X-Gm-Message-State: AOJu0Ywx4PloEVw/NSAjk138TdxuvNoZq/oO9HdAnj9XttFTaOxbyEQk
	liwYESVJCcObEpOKdF/kmBxdVz2eKRNwpTCs29QNbhVMqYJLgu3of572NDuji1Dmmdna3hNAJ+W
	TpScTc4YhL5Hpw7NL5qUAXTS0vCZ+XrqN/9xDMq4XE6FbBVq6MDmrGVQmIpvwtA96
X-Gm-Gg: ASbGncs3H+3DvjQzygFnFhISG9tRnPzxZQmcw2yeKe3wZ5GGMHYkTnrv/brMqV8OqcJ
	XaKTkXTAoUmx2/fR3MxUfhJgQKcsfEWfH5ZbrybVNXBhsnrdgcAYD2gLEx0CZhttawLO/jBmZMN
	r+ZbG5OT/tkLsjPKxKYOCvdAK8mgR4byxrNTae/TgNDShqIj5qRFixNEKTKqWq9grv7NSEtV/ab
	ADvLYxiuP42YFotto6xVheRQ1zeOZ3Hv6U3E+vg9KlY8DAVo6Ymhmkl0fAm42n1nqUnzZFPLpN0
	Gadf03nzgw8CY8j3MKwyeUwSJQE2LWUNdGBmOM0vJeKwl280PXCyl+gZOAnl6Fiinks1F3L70XX
	HN4pf13PTrsD8
X-Received: by 2002:a05:600c:548e:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4792aee37b6mr66949545e9.10.1764870118142;
        Thu, 04 Dec 2025 09:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRbFbC4NEoor6P8ZWYOQEe2Eya3I4gHklZjHLe1aA15I3KAtWd4tHaz8ndj2hklvMztCzTpw==
X-Received: by 2002:a05:600c:548e:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4792aee37b6mr66949355e9.10.1764870117762;
        Thu, 04 Dec 2025 09:41:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930ca15adsm44102595e9.13.2025.12.04.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:41:57 -0800 (PST)
Message-ID: <c3ad9194-e77c-4504-9302-5a5bffcad265@redhat.com>
Date: Thu, 4 Dec 2025 18:41:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: cleanup duplicate ack suppression on
 fastclose.
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
 <24ac4eeb-5092-4f13-a1e7-423ea5659016@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <24ac4eeb-5092-4f13-a1e7-423ea5659016@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p7rO7m7OGlwvZ3xyE-PVksFy7c5NrOCVu63ZT5GR-nE_1764870118
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 6:22 PM, Matthieu Baerts wrote:
> On 03/12/2025 19:25, Paolo Abeni wrote:
>> The current transition to TCP_CLOSE in __mptcp_close_ssk() is rather
>> obscure, especially since it's done unconditionally for all subflow.
>>
>> Such action is needed only when disposing the given socket - that is
>> for MPJ subflows, or at mptcp close time.
>>
>> Move the statement in a better place and explain it's role for future
>> memory.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index cd5a19ab3ba1..61066eb81412 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2533,9 +2533,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>  	if (dispose_it)
>>  		list_del(&subflow->node);
>>  
>> -	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
>> -		tcp_set_state(ssk, TCP_CLOSE);
>> -
>>  	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
>>  	if (!dispose_it) {
>>  		__mptcp_subflow_disconnect(ssk, subflow, flags);
> 
> Just to be sure, is it not an issue to transition to TCP_CLOSE after
> having called __mptcp_subflow_disconnect()? 

That would be indeed an issue, but the following 2 lines (after
__mptcp_subflow_disconnect()) are:

		release_sock(ssk);
		goto out;

that, is

	tcp_set_state(..CLOSE);

should never be called after __mptcp_subflow_disconnect().

> I guess no because the
> transition above was done if "subflow->send_fastclose", which is also
> check there. Also, tcp_disconnect() will transition to TCP_CLOSE but the
> old state might cause extra RST, but I think that's fine, right?

Good point! I cooked the patch too hastly, and did not consider such
path (I stumble upon it while preparing the previous fixes, that do not
do the tcp_disconnect() thing).

I think you can simply drop this patch, or possibly even better just add
a suitable comment to the set_state() transition.

/P

