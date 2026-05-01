Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766723CBE73
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647826; cv=none; b=QhpjWUZxufexqeORE6keg2IRPs0abM9m3Xhuoa15evMs+js9O2VvPG8/uAscYm+ML8Md/AzXS9r+54dwC/f299qDoK5xh0XPdFQ3C6Edgl+q51JGseXTXswNzxVpoi+JBKOxPWn5aoXWIwwR4VizhJ3xGumqNzllpFOMe16rihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647826; c=relaxed/simple;
	bh=q5e1xOpcTrn7xD8O0rR3x+3ZTIiHyVN5Itc6qv+3byE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tiUl//2fup0FDMaxO1DG8dg0RqtEZtHMU7n6XzX8EkjmDmzhJO05d7Nlz03psbDoEHl+kmUoJOiQTj27xDJ4SdqCpq/QvvP5Ccj/cteLGbNev5raL4szGOFdDT5xP/5F4sa6XLY8VnDgBpJQgbuB5NkweD3LiCtdMRcVs4vXH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr01gLua; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr01gLua"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso927994b3a.1
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777647825; x=1778252625; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKfKDBG4nQIPuXIP0f+ttVpOH+ACDabeqb+h30Y3zAs=;
        b=Zr01gLuawqQCtdC5cFcqy8BnCfjjN0TDZ0P3jROovUqFsObH8ihOwSLBHM6bvzPM66
         EhEcPydnTwADfFw3uPsQA/zv2IMdrYisRnqNmmNARd0BynTf5Y3EGmbxXWrb8xJI6P9N
         u7iuIn+PXc8ETIjqdrHq/XeF17JNqzVWlCOZD6pEWV9I1Z1Kal23Ra7LueWI9R7ySzEw
         SjoiLxqymyINuzJeeVt99PYT2XZCXThrX5va6lFOrksLAMJo7pmaKR50CzNvGHIF17Nt
         NGb38XmlkmLixjZDorf34dhbjxLyqvvO3YpyukUKsxWEz44XTu/v4og6yKLowz0SyUgs
         ay9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647825; x=1778252625;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKfKDBG4nQIPuXIP0f+ttVpOH+ACDabeqb+h30Y3zAs=;
        b=mM6RVUOCz1UkdD7COU4yeENJMX3viep6FptrFktYKTZyi7DtbL5Osy0y3+OVJC9zWo
         7xvhJk8DldEAplbSBxbN0/SyP2tQlmk6DTEW4sbkEqOxjYgaviouWwUn2c4dVqe5PQJP
         j5T9843j43gowpQ5JTo30dtfGfoUymHUu4wCIzRHhrqVPkZjuVdWJSqu2uhqfbCRAIOU
         kjxz9T5ODkcGx5oK7kRo1tx1S4NnduCfCJCpqpNGTjLsAYm0TtiZx27Mff8FpzXsD6kU
         B5hRtlM1Q1OClNyYPVabEYY2/0yXkQNMAV5Kp67BjnE+9VF2ZK23UcJL/xspFR11iyUW
         duHg==
X-Gm-Message-State: AOJu0YyuOrzusSgPvo4tXVitSUvP0bUizhoPDRSTpModGICSE+MDwwg3
	vWjSADmnQ753g38bDn8v2S/y1PH8AwpvGfhuUgkCRRWC/+69lHnFO8Hg
X-Gm-Gg: AeBDiesFTzIf+0KXB2DCmirGziezChKTgYl0trOBSls7b48tSXSHvgAsjVDWm9MBnxW
	CAHpIgLKu4T6sJ8KzjvEwfmqPmSJ42BeqCilJNIU7QrjSlWxVucsHTR5qyaWH+n0Z1UYcpg5h+8
	/ke8i0vx3VJ6OeV1hSMbazzM7G6j/rPr000zo4nMAo7idylPMQgG/Uqq8AgHEdClyHqOp+VX1RF
	yxfFs7DeLj0vHduPAe1pUsaN+AQp14PnIGjyJ0pzIY4w6GwBShp3M7fngv/3LlnNoptvNclZYxE
	GSz8Y6rj4jJIVFZgZii+BTl+cNFo54GxSR8GSE9jHTAA7iG9z1xFwRZW0Ti0p2bcuYpCZJuVRSq
	+qAcER8JtPD+541rjC5fV166FCmIKGXYf5dWdQ8Ujf/BMttlW2OtCRWsddskpS5TbQ93tVc3/zl
	i0EIeHGnvAlas7xpbDGYxMGjLSyCnAMA0LEIRb5lLnjsb2bx+mMK2eWIpAH+t04do=
X-Received: by 2002:a05:6a00:3e1b:b0:82f:6b94:99d6 with SMTP id d2e1a72fcca58-834fdb08b31mr8388481b3a.5.1777647824604;
        Fri, 01 May 2026 08:03:44 -0700 (PDT)
Received: from [0.0.0.0] (softbank060083182156.bbtec.net. [60.83.182.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad8eb6sm2634678b3a.37.2026.05.01.08.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 08:03:44 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
Message-ID: <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
Date: Fri, 1 May 2026 23:03:40 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space insufficient
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, weiyongjun1@huawei.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, Li Xiasong <lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
 <177755524215.1566930.3209225574765644709.b4-review@b4>
In-Reply-To: <177755524215.1566930.3209225574765644709.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Matt

On 4/30/26 9:20 PM, Matthieu Baerts wrote:
> On Thu, 30 Apr 2026 19:20:25 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:
>> When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
>> IPv6 address and port while tcp_timestamps is enabled), the original code
>> jumped to out_unlock without clearing the addr_signal flag. This caused
>> mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
>> preventing subsequent addresses in the endpoint list from being announced.
>>
>> Handle this case by clearing the ADD_ADDR signal and skipping the matching
>> ADD_ADDR retransmission entry. The skip path cancels the matching timer
>> (with id check) and advances PM state progression, preserving forward
>> progress to subsequent PM work.
>>
>> This avoids endless retries for an ADD_ADDR that cannot be emitted in the
>> current pure-ACK option-space constrained path.
> 
> Thank you for this new version!
> 
>>
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 57a456690406..a94177d9f265 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -401,6 +401,13 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>>  	return entry;
>>  }
>>  
>> +static void mptcp_pm_add_addr_skip(struct mptcp_sock *msk,
>> +				   const struct mptcp_addr_info *addr)
>> +{
>> +	mptcp_pm_del_add_timer(msk, addr, true);
> 
> I *think* sashiko is right here, and I guess sk_stop_timer() should be
> called instead of the _sync() version. Thinking about that, I wonder if
> sk_stop_timer() shouldn't always be called when check_id == true, no? Do
> you mind checking this please?
> 
>   https://sashiko.dev/#/patchset/15237?part=1
> 

Sure, I'll re-check that path and confirm whether `sk_stop_timer()` is
enough when `check_id == true`.

>> @@ -881,24 +889,47 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>> [ ... skip 26 lines ... ]
>> +			goto out_unlock;
>> +
>> +		if (*echo) {
>> +			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
>> +		} else {
>> +			skip_add_addr = true;
> 
> Even if I don't think we would have space issues with the echo, should
> this variable also be set also in case of ADD_ADDR echo?
> 
> (In this case, the variable could also simply be called 'skip', or
> 'drop', similar to the MIB counters here.)
> 

My current understanding is that the skip marker is only required for
the non-echo ADD_ADDR path, because that is the one tied to the local
ADD_ADDR retransmission timer flow.

For the echo case here, it looks more like a reply path to a received
peer ADD_ADDR, so on option-space shortage, clearing the signal bit and
accounting the drop might be sufficient.

But I may be missing something in this area — if you think echo should
also go through the same skip handling, I can align with that in v3.

>> [ ... skip 13 lines ... ]
>> +	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
>> +	 * clear the signal bit, cancel the matching retransmission timer, and
>> +	 * let the PM state machine progress.
>> +	 */
>> +	if (skip_add_addr)
>> +		mptcp_pm_add_addr_skip(msk, addr);
> 
> If you have to modify something else, maybe the new helper is not
> needed, and the code can be added here directly? I know I suggested the
> introduction of this helper, but now that I see the code, I think it
> would be easier to understand the new comment above without it, and to
> backport this patch.
> 

Agreed. I'll likely inline that logic to keep the change simpler and
easier to backport.

FYI: I’m replying from my personal address during the holiday period, as
I currently don’t have access to my corporate mailbox. I’ll keep
following up on this patchset and send v3 shortly.

Thanks,
Li Xiasong

