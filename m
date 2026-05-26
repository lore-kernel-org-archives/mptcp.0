Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEDB3C062C
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778243; cv=none; b=Qz+awp2T4tUPZP9G+B/QyhIXze2GFjE96lTqoIYd/mJPTcnSz4uJ0LTBuic/mgFyy2dhkuYPYXQxcrS0RwWr/0E3nD5L+RxRrFWeYAM4JUQoCsehq4epz6Ll7FHDvomfnndW0dbwsRF1IbPOZsHW9uYqtu1Cq0SkSIT8V4923Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778243; c=relaxed/simple;
	bh=Zo4gXg+tBZ5CvkzxN7/LDQLeGDaw9+sWHgRGROJFzKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Sx6FQstwegt/kVybVOJPotRW0ec/bZHLlTt4dLPmxZ+Wj8/MsAbbs0IMfBWem8jmaBx6kb3r3swK0dL4qgWYQtNl0S4ZZTV1wBxfBJKAVQkwkOiOW06k7HffQewj3Mh+ATrJB8ixbZAFpOLoSKIZjOsS2X3q4z7h+M6bKsk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de5K/xTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de5K/xTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779778239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRdnpsBUAv59MgdBi2RF31IP1Qn93TrdZVNGtDaX+R4=;
	b=de5K/xTOaH/deql0F7w654kMYXTz/qTpFb1qa3g8zm3XhclsQHFuwfodj7gYcIzmWph47k
	hhPS++m6Tt5I3lWGiNvagODUn8S/lDnyXnMLaBgC+JOWyv6tSQaXVTQPOd+tXd1FcQoGNw
	rXCFWptTkOAvbspVKQ8VZRyYLE0cb0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-hq82bYIaM4iveNWqeWbtgA-1; Tue, 26 May 2026 02:50:35 -0400
X-MC-Unique: hq82bYIaM4iveNWqeWbtgA-1
X-Mimecast-MFC-AGG-ID: hq82bYIaM4iveNWqeWbtgA_1779778234
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a52d5e572so7101874f8f.3
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 23:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778234; x=1780383034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRdnpsBUAv59MgdBi2RF31IP1Qn93TrdZVNGtDaX+R4=;
        b=DXJYwqHtCtGNBYwP5jBEoHUibFZTEd5KoCSGXzTeY9YuaLL4knHT6XIM0MbJCmiHSc
         INkh2KzQuL7lz8pZle8IvewW78k/r+qZc43GWvUy3z2lTapmErp1iW1QBjbpSwf29MZO
         7XF8beHW/Td4JHEm6cWUC9mOqbT6m2wjCZgeMBxjBr6/FednJvgkB9yAGq1YrovGBQA4
         qEPVkwCG534zx0mYnw7hlTQHmc9mWKS0wzO+kPtv/wQIJyiA+qiV9Zt0AdpGBxE+H/Z0
         8ilebP0Ev5UvBpKSMZ+6gmwzV01joTPddc9jdu64fuiIHWONiQ4/w6bjk5WSZ9ppwMl3
         fUlg==
X-Forwarded-Encrypted: i=1; AFNElJ/h0cxTFQYJLyeZ+KNXQrxn+61x5qkX6ONz4M28oWxV4UE5Dpfb9i6GAzEVgMNOX6YGQfYECQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz858jrkAEDKqiqCTGfx77IE3n9UB455hUAv04RP1F3H3kSykRq
	sLO9iI7glOVo8Ltuq/qazO8yoivB7bxMFkV56O01MvlohbNg+H68N8hfeXHSxDfaKnrRdPKSck1
	jemkEeROgsRyXbCvj0ODzZdt4iZiI0khTFAD2YfZvw0RNQIhC+oxOnUIb
X-Gm-Gg: Acq92OGAbsKvth9ZD0NlKGcppUY8wq0vWMvgclLjZsyP0pzDsuVzJXjxA91GvV0x3x/
	nFC72IJpYzRW28Sz65m0uvGaOlLY4HdFqJO/VXUFNjEIiNglAodI71Fua/WR+8r2LgWL7Mn1tx2
	2sNNYmUnTfj8uylXqtd/viEr6KP0EwmJTsTSj+334HaGYJEqu0arkoG5gdlqOpWoLA16Yw4LFse
	UQkwAODDwux+ISQnwzSkuVPk4K8iDZM9Zy5HBpkEjI0q6wqY2AGIVgOgsSnmZVP58/9bKENu3Qb
	3H2rL18wGjLriGD7ilkkTHRA/80v3XmF6h90s9SyYu2ahJKnrXgn0mEU9onFQpjt5WJk/Hc6amL
	I/G/oyxYDwIAJkIiWdMslvcsr0YHWCSlTHxscSW/y8bl/WjMYnyw8NCjhLR82UGYsH9gO
X-Received: by 2002:a05:6000:2007:b0:44a:247e:67b4 with SMTP id ffacd0b85a97d-45eb3689031mr28498804f8f.18.1779778234109;
        Mon, 25 May 2026 23:50:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2007:b0:44a:247e:67b4 with SMTP id ffacd0b85a97d-45eb3689031mr28498751f8f.18.1779778233591;
        Mon, 25 May 2026 23:50:33 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ed8873a35sm1845897f8f.14.2026.05.25.23.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:50:33 -0700 (PDT)
Message-ID: <1445abca-9a84-46df-be7d-8f7b656772a1@redhat.com>
Date: Tue, 26 May 2026 08:50:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 7/9] mptcp: implemented OoO queue pruning
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <cover.1779485511.git.pabeni@redhat.com>
 <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
 <9c1d28dbc379eff6cc09e9b02a6b77beafcdc4f2@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9c1d28dbc379eff6cc09e9b02a6b77beafcdc4f2@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FixegxMNWlY_bCTTs21T9bbeeqg_HZijfHOBuN8nwKc_1779778234
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/26 5:13 AM, gang.yan@linux.dev wrote:
> May 23, 2026 at 5:43 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index ef65e2df709f..d9bd4f4afcc0 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>>  SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>>  SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>> + SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
>>  };
>>  
>>  /* mptcp_mib_alloc - allocate percpu mib counters
>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>> index c84eb853d499..18f35f7e0a2d 100644
>> --- a/net/mptcp/mib.h
>> +++ b/net/mptcp/mib.h
>> @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
>>  MPTCP_MIB_WINPROBE, /* MPTCP-level zero window probe */
>>  MPTCP_MIB_BACKLOGDROP, /* Backlog over memory limit */
>>  MPTCP_MIB_RCVPRUNED, /* Dropped due to memory constrains */
>> + MPTCP_MIB_OFO_PRUNED, /* MPTCP-level OoO queue pruned */
>>  __MPTCP_MIB_MAX
>>  };
>>  
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 03d6f8658467..f446e22148b9 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -373,6 +373,43 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>>  skb_dst_drop(skb);
>>  }
>>  
>> +/* "Inspired" from the TCP version */
>> +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
>> +{
>> + struct mptcp_sock *msk = mptcp_sk(sk);
>> + struct rb_node *node, *prev;
>> + bool pruned = false;
>> + u64 mem;
>> +
>> + if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
>> + return;
>> +
>> + node = &msk->ooo_last_skb->rbnode;
>> +
>> + do {
>> + struct sk_buff *skb = rb_to_skb(node);
>> +
>> + /* Stop pruning if the incoming skb would land in OoO tail. */
>> + if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
>> + break;
>> +
>> + pruned = true;
>> + prev = rb_prev(node);
>> + rb_erase(node, &msk->out_of_order_queue);
>> + mptcp_drop(sk, skb);
>> + msk->ooo_last_skb = rb_to_skb(prev);
>> +
>> + mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
>> + if (mem < sk->sk_rcvbuf)
>> + break;
> Hi Paolo,
> 
> Thanks for the v8. While going through the code, I ran into a
> point that I'm not entirely sure about.
> 
> TCP‘s design uses sk->sk_rcvbuf >> 3 (one eighth of the buffer)
> as a goal. It we use sk->sk_rcvbuf here, the loop may break after
> deleting just one packet, right? This may fail to free enough space
> for the incoming out‑of‑order packet, leading to repeated pruning
> calls and potential packet drops.

Thank you for your review.

Yes, here there is some difference vs plain TCP and I think it's for the
better.

TCP tries to make a "significant" amount of space in the receiver buffer
while MPTCP tries to make room for a single packet.

Both strategies make sense in their respective context: TCP invokes
tcp_prune_ofo_queue() only after collapsing, and the latter is very CPU
intensive; if tcp_prune_ofo_queue() would make room for a single packet,
the next incoming one could still trigger collapsing and burn a lot of
CPU cycles (note that this bad chain of events could still happen if
sk_rcvbuf / 8 is not bigger than 2 packets).

MPTCP (intentionally, as per discussion in the last iterations here)
does not perform collapsing, and directly does pruning when over limit.
Pruning is relatively cheap - computational complexity wise we could do
it for each incoming packet with "no issues", at least compared to
collapsing.

Dropping the minimal amount of packets to fit the incoming one, allows
MPTCP to minimize the need for reinjections (for packets already acked
at the TCP-level, which we really should avoid). I think overall this
compromise is a better fit for MPTCP.

BTW did you have the chance to perform testing on top of this revision?

Thanks,

Paolo

