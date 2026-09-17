Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9439D6D6
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643820; cv=none; b=qbi6eM2dIltIyF0WheCJS+XM5I1b0Jku+ZMBUy3nHc6KdN5cRLAX1Ym6n/bFx3NsyNZTmu/ynBXpc46cybVm7JvQVYP5a8rEqo+BbxpvxbMrx777nofKtfhNwqf/5cTOvRZnFTW6pQW0PT1PYSbTuNxKLFD2nm8dpvTQvgkyUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643820; c=relaxed/simple;
	bh=zLcvCiAPD5wWmnt5hHFi7ShfG7dr6QAZVgPTgrRf4+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQBlnsCxPuI+zNviSybEBb6crNqhbQT6iQNNEpq7g8wV/9YSXjFXnaWgkDEpj0KcWt2GsA8jrk5gM0mqJpSW3yzks1NkV3XbtvbT3qyVNm4z/dlYtHL3Pz6G0tB57H9Ao4LK3xiZhe2EUWWK26KYCFjCzRDvp1aeHSi+Jv11ALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drOQEkCB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drOQEkCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789643811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eP1uMmtD3DxvMqH6cKa6vonPQmGtZJRICWnH6003KGo=;
	b=drOQEkCBVYwK7T6CZAawK6i30DUddFk31qF3fi69vcFC9jqAJ4mGHnqGdwwrgS5UaptirV
	Rwi2lqkHS2pWBFTyHlFwcJAMHt24U8/HwAgSB3+9peELWYOR1c4JX0DqnzzHMXjLiu/rZA
	BvlrqDebhK1HJcTbWThxp8sbosX6OVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ibUGBGIeOK2O9b1Fk0a_mw-1; Thu, 17 Sep 2026 07:16:34 -0400
X-MC-Unique: ibUGBGIeOK2O9b1Fk0a_mw-1
X-Mimecast-MFC-AGG-ID: ibUGBGIeOK2O9b1Fk0a_mw_1789643793
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso5262515e9.1
        for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 04:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643793; x=1790248593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eP1uMmtD3DxvMqH6cKa6vonPQmGtZJRICWnH6003KGo=;
        b=tnT66xptolHvRd8UsnP5+kdLfTLnwl8j2+l8jFMhnzkN3BVCR0C7id1JDlCAYYoksu
         NYMslI1iYbchcix0gjpDi8ikbKy63VmrV4aoZW62nwVv/flhIVvhoXTWVO9Jdok3bRLP
         RzOZhqg261V+4H6SaxnuWcBdJhrabcDfWDbW+3f5ob+XCOoCKV03LvkPPEp1wTzOk1zr
         K8wKw+9yWH/6H0x37HbmLrW3kkJFRlbi66O3308N/fvRhQxBYlaJ1cbUOYjZbOvxU9Qt
         3m/HC7EqM54JnYl4A7uNs8PyMinKwQnlqTsli2OApGKI4s4jnqnUUGicKO4iKICt3LSr
         P44g==
X-Forwarded-Encrypted: i=1; AKwUvBy5ERTnMfVhFxQqROsGDjklYHm8Eliyejl0+cEr0X7MWJsp/Lhhl5vykclEhRzpIeA7NzqosA==@lists.linux.dev
X-Gm-Message-State: AFuF++k8WGYSVK5xr25XmeynK4PAZ1b3H0IJk6S+eFOoZqE9NDe+vZ5p
	rJq0srW6wsueBM7JSyR5QmXnz8WW/trkzWK5u8aEEC6o4oGO3qf+xJXA3dV5zrwh6YyZv35DNBn
	wSCLwc8+wrfeZQeAIF0hssyQiBM5ry+sN/sH/EjSU9gsviyJKR0nirZ+h
X-Gm-Gg: AYBFou1/w2OOz8OEfKDutPV4aprUcHevLTweaXx2dTEiPSm+u8rTKbnZVC2kylw64VZ
	BIqNefoPVRq0q4M9tRvWiriQhNfwtKhHaONNMmMqzcNrVmKAgwDgzFL722a6YXM25tHhiuJTBp4
	GP+VzthaatnsCt8nux+egxqDT14isemvq5CXjsq13OfBuh+zGAdDFSp+5Y1KvCpwEBxqT8tHzjB
	6oLaOYRqHUAsnWz8zbKN1oc/V1fl3GGBRtsDGB5K6VwVJ9H+YYQ00Y/kTNgPAE+wNIRpNs00I6c
	7477Aa3nAoSKxuSrmq7yRyNlTBJuGKYbvSmnDjo9poiGdUtYR50tA9kQ8KTmNM3AOz5RLaP++MM
	7l9LTQAbpgcTvx4zqFpYquyw6jMtnwpjcX32T9aU8m5QeVnDjXg3x5F6ukZqJawPnUqREKUC3VQ
	==
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id 5b1f17b1804b1-49eb7301fd4mr64756615e9.15.1789643793389;
        Thu, 17 Sep 2026 04:16:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id 5b1f17b1804b1-49eb7301fd4mr64756235e9.15.1789643792937;
        Thu, 17 Sep 2026 04:16:32 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbf415058sm42188045e9.0.2026.09.17.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:16:31 -0700 (PDT)
Message-ID: <b32628f0-834d-4906-8479-7687887e371b@redhat.com>
Date: Thu, 17 Sep 2026 13:16:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] mptcp: close race between scheduler and state
 change
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, netdev-bot+sashiko@kernel.org,
 mptcp@lists.linux.dev, stable@vger.kernel.org, shardul.b@mpiricsoftware.com,
 xinyang@anthropic.com
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-2-a257797dd5d0@kernel.org>
 <178959153630.22033.1222004531183755077@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178959153630.22033.1222004531183755077@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mtRJvuiEJdx451erUsp8miY5SVFq-usYUlBz1No7lVY_1789643793
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 22:45, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] Incomplete fix: the identical `mss_now == 0` divide-by-zero that
>    the patch guards in `mptcp_push_release()` (net/mptcp/protocol.c:1667)…
> 
> --
> 
> mptcp: close race between scheduler and state change
> 
> The patch guards the tcp_push() call in mptcp_push_release() with a check
> for info->mss_now being non-zero, so that a subflow which failed
> transmission (leaving mss_now at 0) is not used for a divide operation.
> 
> Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0098e28309318..709610db3ce9d 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1664,7 +1664,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>   
>>   static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
>>   {
>> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
>> +	if (info->mss_now)
>> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
>> +			 info->size_goal);
>>   	release_sock(ssk);
>>   }
> 
> [Severity: High]
> Should the same guard also be added to the second tcp_push() call site, in
> __mptcp_subflow_push_pending()?
> 
> That function starts with a zeroed info:
> 
> net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> 	...
> 	int copied = 0;
> 
> and info.mss_now is only ever assigned inside mptcp_sendmsg_frag(), after
> the early return the commit message refers to:
> 
> 	if (unlikely(!__tcp_can_send(ssk)))
> 		return -EAGAIN;
> 
> 	/* compute send limit */
> 	...
> 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> 
> In the non-first iteration, the return value is accumulated into copied
> without filtering negatives:
> 
> net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
> 		if (READ_ONCE(subflow->scheduled)) {
> 			mptcp_subflow_set_scheduled(subflow, false);
> 			ret = __subflow_push_pending(sk, ssk, &info);
> 			if (ret <= 0)
> 				keep_pushing = false;
> 			copied += ret;
> 		}
> 
> __subflow_push_pending() passes mptcp_sendmsg_frag()'s -EAGAIN through
> verbatim when the first frag fails, so copied becomes -EAGAIN, which is
> non-zero, while info.mss_now is still 0:
This is a pre-existing issue but it could deserve to be fixed in the 
same series.

/P

