Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634E37AA92
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284200; cv=none; b=oQIcOtakTmbhHXKZMdjkTB/kkrOwgy9WaBqYEYQEC3tnw2uWcunwiqPvT9w7N51eb0pRDZL2O5gg1xE9CSOBfUGdBgQfhjU8Mb5podzqmAibTtD/XV4eSnaDU7mVkuF1i0i3VlcUWTqhDJBmkUtaTkpTc0vwNXa0Z+KA1N28cOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284200; c=relaxed/simple;
	bh=8q5o6Y52Wt9WQUBdkSM17CyT8Vr0/s2tzjA4kGuLSQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFOuZUOHTdbeSnV8ZkzeWTh1ZihQHkHsYAdwnAH24xwhvHQHRyvgFK0A0zJ1KsLY4d0SPmo2/POfWDl3v+IBFfXXDAxQOkLPTbmO4qp8aaPYhbYX9U3+fDxq3yX5AwHmyQjU+sLMpVMlhbTuqWhUipznlTCHygH4BFr2ObkRn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSROIv6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSROIv6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770284199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8solOUPM0ao64dQUOwA+0d1u0Z47YN+ehqgVBmKb4k=;
	b=eSROIv6PZHx8uJxWLzQ3Ohd9i/KEv4hHTzWUkY7TDILGBR0F9MPYYWFz0HSqnLNW1Csw3x
	rPfSg+r+SC+xUMY1gcv2t4PzNbtVY7jdAmWMhqhv61x0YqlcrbzGv7/ZejAAbE0gta/yQc
	giD8vp//gbCkCD6ObvQ9cca9y0E4MV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-hhKf389YNSikn70d6CD72g-1; Thu, 05 Feb 2026 04:36:38 -0500
X-MC-Unique: hhKf389YNSikn70d6CD72g-1
X-Mimecast-MFC-AGG-ID: hhKf389YNSikn70d6CD72g_1770284197
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso6984305e9.3
        for <mptcp@lists.linux.dev>; Thu, 05 Feb 2026 01:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284197; x=1770888997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8solOUPM0ao64dQUOwA+0d1u0Z47YN+ehqgVBmKb4k=;
        b=eQAZHtw2eGyNTIcdldCkrh0EgicU26+vl15MZCKI3dKVIXmBNrnLCtchwmDUWgdqFO
         PFENnHKssu9XBtV2VdUHoOgBy+YDTt0hWuA4ZyVgUfzg6NehQcY5ENbUPl2TDCvHXTd2
         yDZ4lx1TSalKz8kGaqJ14g5NDu8go54lNclPNjD2WXuGsk804gdmVFopDmxrzXQV0cdv
         zOleHwUvI7EptwXsfS6MHWylqXY9ifBWwvGh8udh1WkBLz4ukKYngk4bxsIiqxSU4Vct
         1Wc9cmSU1QrC/wsJUJ8NZPtkg5rkx6TXY7F+UKkYWaUJ5f5tT4hm3xASZMjULi2A4cTD
         b5kA==
X-Forwarded-Encrypted: i=1; AJvYcCWkGZYzDVR58/g5lvgDAQ54moXcwIAGjGA8951Q54mFmYmyiyh7aPyBLhd4XLC7uxg+kTMvVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQB6dZp2d4BXYyo+GLJ+NCH8GKgzAGwPiZHgumPoSwoMMRIxZA
	ZtQepWnejfFqKUqQtVoHtNqHFEK0JPomzNMFFeV4viLOAhs7/8xHKZm3i1IvV/JoNc3re4wDgQn
	1w4wTbUUfFWiMFre9OxekcTVBPCe/1PdIBf0RFzE09wLdeSFACTGj98RPCRK+ekEf
X-Gm-Gg: AZuq6aJ0PhvdtOSRVqKmuvdCIvF3MsQzljFijeyK9G7VD5B2GSTqcu1dPHdDG7Yb900
	eS/kSJjRqllvmXy3tSNtyXaIM6CYj2s8WuDlIphmQU7YG9/FJIkwWMynoENptOVMtJuYyhYiMnf
	DlUK+8VGYA8vxsk1Ngo77K0B2iuQM09+QhHXT6mwkSIawn6hg9bwZtruigG0m3tgu3cAJ6zrOmD
	R7IiXy3ulGfGGt9JbxY2bsA3G4+FjhYF93UvnUa/ThZ7aHL7ndIaLR3OxdL0GQmSNZ+D87JbmwL
	Biewx4M4Lx28/nLWdj1NWEAuP+sd2HMLbLkrYzPzl72wTHVyi6C0168gbVl4PCarAuFyJkURx1Z
	cS664F8nFwWIH
X-Received: by 2002:a05:600c:19cd:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4830e950d34mr85013245e9.16.1770284196934;
        Thu, 05 Feb 2026 01:36:36 -0800 (PST)
X-Received: by 2002:a05:600c:19cd:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4830e950d34mr85012965e9.16.1770284196498;
        Thu, 05 Feb 2026 01:36:36 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e263b9sm12181776f8f.4.2026.02.05.01.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 01:36:35 -0800 (PST)
Message-ID: <e1ccad35-0ffc-4219-a7af-3b2541d95612@redhat.com>
Date: Thu, 5 Feb 2026 10:36:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mptcp-net 2/3] mptcp: fix receive stalls when 'ack_seq' in
 backlog_list
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <7bee08bb168041f1fa0440b1b605548bdc03f241.1770273341.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7bee08bb168041f1fa0440b1b605548bdc03f241.1770273341.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TcAShmz1TIC4ptQSOlgNGCcwnACZYfMdz0XSJWC0QqU_1770284197
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 7:41 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch fixes the first backlog_list issue, which can be 100%
> reproduced by the multi_chunk.sh test case.
> 
> The problem occurs when out-of-order (OFO) queue data accumulates,
> causing sk_rmem_alloc to exceed sk_rcvbuf. In this condition, skbs
> in backlog_list fail to move to sk->receive_queue even when the
> receive queue is empty, leading to transmission stalls.

Very good catch! How did you hit the issue?

> 
> This patch adds an empty check for sk->receieve_queue, when it is empty,
> the skb should moved too.
> 
> Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff06bbee7781..b6bafc37eea4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2176,7 +2176,8 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>  	*delta = 0;
>  	while (1) {
>  		/* If the msk recvbuf is full stop, don't drop */
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
> +		    !skb_queue_empty(&sk->sk_receive_queue))

I think we need to be more conservative, otherwise this could be
exploited to allow unbound increase of the rcvbuf.

Unfortunately it does not look easy, but I think it would be doable:

- convert the backlog to a rbtree, sorted by MPTCP-level sequence
number; that would likely require:
  - factoring out a slightly more generic helper out of mptcp_data_queue_ofo
  - use it for both mptcp_data_queue_ofo() and enqueue to backlog
- implement an helper to check if we can dequeue from the backlog; it
should check that we are below memory bounds or that the first skb in
the backlog is in-sequence.
- use such helper here and in mptcp_can_spool_backlog()

I see it's not easy, but I think is necessary. Simpler alternatives more
than welcome!

(side note, on top of my head I think that even plain TCP stumbled upon
a similar situation, i.e. could overrun some limits for in-sequence skbs).

/P

