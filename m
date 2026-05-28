Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C263254A2
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956816; cv=none; b=Uuw4WxkY6UlwHptd5GoRuCwyRevGw8y1t8SRFHDRTHGI8d7PzNLfkSU5l91JwmNU+WPP/LRf7e0VzRwUdjIBF5BKJyj2imByRwksFvkSfj0dmQMPP4IPW6TW/2UGjZaZiyfJX3aGq8UlMyOHnVr/9FXUIXOfmj7IE9t/ko6Vi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956816; c=relaxed/simple;
	bh=+8nQAVOrTu76PXyE1Nexdaiz2Bin89K3CrUCJdKOBP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V06+e/+182VbskoqbffReicY9MujMucYFzevZhuIiqOuLIQj51IKqskfhAv2qgjOkeYSmoJ7fPIKzAjYPXYEyNOjD3cl1J+m9E8AnDe8V3aQMfmY9REq8RpkUrnMSOEXRc9hGO/u8eoflUOh+k4c/shgzCBr90DOdmYp3sKSWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P95YJhsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P95YJhsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779956814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSiR/j49/YTV9JerPy6Sj/0Oj3KxS5e+SLLbPpGEy5U=;
	b=P95YJhsfNYr0/NYhA4yxeU28X7dfB/A2UqWK2m8TwWUmyiaKo+oMwXAjzwT7uivgIdwuVu
	VZkXIpKCfV2o0zrAdcAjXyzwQIKghrnRV6f6wg8sBUwj/jqISUklktf+VeYnrBsuotTzNh
	nQyvuZ43/VWuq5F1CH2hfohK/eBRRss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-aEUDxkaWMU2oSM6PqniGdQ-1; Thu, 28 May 2026 04:26:51 -0400
X-MC-Unique: aEUDxkaWMU2oSM6PqniGdQ-1
X-Mimecast-MFC-AGG-ID: aEUDxkaWMU2oSM6PqniGdQ_1779956810
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fed2519daso59918325e9.0
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 01:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779956810; x=1780561610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSiR/j49/YTV9JerPy6Sj/0Oj3KxS5e+SLLbPpGEy5U=;
        b=BAt0YYhgMjOjkZB0eXCDl7kHbSWqE36UlBjyesa1U9u4+U30ym8Z/20yzAIT7VeKpP
         bK7yl5bPP85/dD8VYCfj1u9BDvU0wqx9Iu6ofd4zpwZOd6bB3ApzJDR4qbYQasyiguLg
         raHvl+d697i5Nu5TWx5iL3Gz/Gc9wM2NaicfVG1aNY2VkgwnKQDFkFgfR5J6k5S+boH7
         j4SaKWfV4Iuf0Fzdp/fBXjWBZpl5vKd+aJ2D7Zd28zdKY8V+ennNHHsGKR1XYOA1kXbQ
         TV1PW0mEP+Rua2Zoqhxkh17STDRThSUWtKmskHoHHqjISnr2uQl3Rkx3YWQlSo0ca704
         GP7w==
X-Gm-Message-State: AOJu0YzexVE6VCBfSSP5q42TiXtGQrVs5KN2UWIjLgP2KsVF1Mjjh+86
	Ffg398wl9nuzvQQAoh//uUVIC+iCbSB/8UW9fNLPuqaET4gCv6GW2rZrNJp7O40ffDncr8D6Bgg
	xgr4lwohTKb/70COnvPSVfCYO2L9kwtz+AgDEh6xpCYzicQtHX6JpQU95
X-Gm-Gg: Acq92OF0K4su12AWd8xZ5zENNlWzNBZUUjY1X9v/yM8PzY/0RyRDIYbKTRCT2IuKUOt
	r23aAbWFXZTOIi4wAnaWBULEb/6ho9OEfyQwt+XsP1kHn4hLdWcrIhQO2pZwAXAXD8n9cYymJ7P
	2lgBgSzO3fRkIy/7JYhnaQNHCb9F4CML1vl+fF/oDNbeQqw0GwLQ9tnuq187qXagVSsml9wuv81
	I+25hho5ku9yzWjpeoARmpYhUoE4FsMIBGKdvtMLCFrNYoJeVFlAWCvJngJ0wjM6CPKp5qJQltO
	S8bBqoGp2u72ygbby6Z7W2xi2X7tD7TXZpIVkphh2FxU1E6LKs1uxreKfcErsFsjqpD1hAy4mag
	ngawKh1G5UmCKGonn/iEvUzO3AHZNzcH0K6GQxsYpnA8vpjF5h44RfjVzctN+ZZlmrw==
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4904249d11amr319868765e9.7.1779956810484;
        Thu, 28 May 2026 01:26:50 -0700 (PDT)
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4904249d11amr319868235e9.7.1779956809893;
        Thu, 28 May 2026 01:26:49 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909298d41bsm24802725e9.11.2026.05.28.01.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 01:26:49 -0700 (PDT)
Message-ID: <c45eb641-3f97-4206-bb7a-60fc208b732a@redhat.com>
Date: Thu, 28 May 2026 10:26:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mptcp-next 2/6] mptcp: explicitly drop over memory
 limits
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1779876523.git.pabeni@redhat.com>
 <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
 <eed92bb8-8b77-44e4-9f1f-242db72177b9@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eed92bb8-8b77-44e4-9f1f-242db72177b9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tu6MFywIJ0QfIp8HKIkTVfZ7ezcB5jAZX8PnqlMF3Rc_1779956810
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 10:21 AM, Matthieu Baerts wrote:
> On 27/05/2026 20:45, Paolo Abeni wrote:
>> Currently the enforcement of the rcvbuf constraint is implemented
>> when moving the skbs into the msk receive or OoO queue, keeping the
>> incoming skbs in the subflow queue when over limit.
>>
>> Under significant memory pressure the above can cause permanent data
>> transfer stalls, as the skb needed to make forward progress can be
>> stuck in a subflow queue.
>>
>> Over memory limits, drop the incoming skb, relaying on MPTCP-level
>> retransmissions.
>>
>> Note that fallback socket must perform the limit before the skb reaches
>> the subflow-level queue, as dropping an in-sequence already acked skb
>> would break the stream.
>>
>> This is not a complete fix for the stall issue, as the drop strategy
>> needs refinements that will come in the next patches.
> 
> Thank you for working on that!
> 
> (...)
> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 97ea4aa37b33..2b35bdc113a5 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1161,8 +1161,30 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>>  	return hmac == mp_opt->ahmac;
>>  }
>>  
>> -/* Return false in case of error (or subflow has been reset),
>> - * else return true.
>> +static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
>> +			     const struct sk_buff *skb)
>> +{
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	u64 mem = sk_rmem_alloc_get(sk);
>> +
>> +	mem += READ_ONCE(msk->backlog_len);
>> +	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
>> +		return false;
>> +
>> +	/* Avoid silently dropping pure acks, fin or zero win probes. */
>> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
>> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
>> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
>> +		return false;
>> +
>> +	/* Dropped due to memory constraints, schedule an ack. */
>> +	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
>> +	inet_csk_schedule_ack(ssk);
> 
> Just to be sure, no need to increment a MIB counter here?

Uhm... I did not consider that.

I guess:

	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);

could be added here, but still the caller will do __kfree_skb instead of
using a proper drop reason.

I think/guess an eventual follow-up patch could do?

/P


