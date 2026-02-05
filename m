Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479835CB71
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286046; cv=none; b=Pd4wdTfkfXBVuh3zRXofRP4aIKdlUX07VBLpRYTEIr1Y9lRT+2qUjvYRoSMLndXzi6OmNz9XFn1ZizsVz04lvLYjZu6X9+1DdIIu6AoIZqQ7A3n+LENr2JfEHkUW56/lIQGgf4Up1+hTpBpfn0grgTv9ojYr30OE1hed8hQZ0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286046; c=relaxed/simple;
	bh=5oADlz0AICkDgzc9yhNYXwwi9s3dJPCPZYH5cO4ELhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujh5PFbji/xJrtZxIq4oclxtYAwvi1tbPHOmoh71OjOvqLVYLv+hv5K4v9XXlO8O6yhk4uuzoSfGucnTnblYAYw0ve7vHlYks1gTjejDy0IzwYKxT4HAFdy848jG4mzqnZfk2nqCQlStVHQJ/+ImVsKedHJ9+Qr42FFkhTrEmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOPKtVv2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOPKtVv2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770286044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8nIFJHezlxT29Qp+LLPEHwdxs/H04O0061GTEnltsc=;
	b=IOPKtVv2NUgm21uaV5sXCkfetn1QspCCTK4Z+i/9BE9BZPep00fNiQpZh3ZLE23tpDW2PV
	kTn+196qU7Y8boJQphE+x6S+yyaoYpLwuPF5Pbv203XSZ/Q1Fqj+0bDMewb/WV+dtITQF4
	nRXoDG7BrdNhaBq3m+pHX/XiGGPDY0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-uhv7RVQ3Px2Om8VZxTzb8Q-1; Thu, 05 Feb 2026 05:07:21 -0500
X-MC-Unique: uhv7RVQ3Px2Om8VZxTzb8Q-1
X-Mimecast-MFC-AGG-ID: uhv7RVQ3Px2Om8VZxTzb8Q_1770286040
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f57cd2caso795517f8f.0
        for <mptcp@lists.linux.dev>; Thu, 05 Feb 2026 02:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286040; x=1770890840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8nIFJHezlxT29Qp+LLPEHwdxs/H04O0061GTEnltsc=;
        b=SwdZ/gKDhLZqqEHQfH1ttbub0OWdbv54HKtgTDtZEXNozbQ1kCcADUZUCJ6vUI/RED
         g0ZlSzqh1K0AjDz8b+yyPuRdbKN5zvDqWl1ww7Q0LyxnsQSpfAo6XU2NO0wLS28zjgAS
         GciILvgmyMJnGFe1sTNHWDCBgKL7ZZg1ZuY5iBHCxEBcCnIULCt0WyDH3CQjiaJrAyMD
         nRmcUYxlM9bBAk0kvP6zW+c6i3Jeq73qC8yzPpLSQT5Z8cC7MsMvHYq3a9hBnT0pF6bf
         61a+tkvFO07MPuPKkzkZVmlNFQWabXTPH/ZkSP3vnscxR1GmDqia1BwdMwRqQ12ql+IE
         VYbw==
X-Forwarded-Encrypted: i=1; AJvYcCV3de12/S2hMBZPgSlydLHdnCBKCv+601kBGvTp1GgSfO6MmJ054uHFk/Q81AYs6X3YoMjjVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymYsbsQrIvrILbB5cyoBKnQwqeB/NsHk93uWvWEeyUjwQ+qtaI
	Q49ak0++n9xdYASKVydlfhh1t13rVMsM0FFbz25fhbQAQvmjlZGDO+smNyh4IaI8oFPgoJYfTIK
	t7OrWpECwpPYmKJJHNhzyjyhMOnVzAkjYzmbzESFHeC07ZA8Ef4HF2bSL
X-Gm-Gg: AZuq6aLvZLWa/qytdJKmHTrdmcmPDNWzZmqnQDl8lDNNTe7kaBENOPhETqGlK2dlM9f
	QwYON108pxQUmdxSs8ISnhPPOkPo6brj+S2AySns5TQpIvacg1113H+a4p7IhCAbQfQas9UsIh9
	tlJ2hCdTFh8vyLfDjcs6beMY9OBbDiIfHFl02iqILVGnxUWLYLirgy+Dr9XCBHwEVeaw4Vnvfvb
	nInLi1HT9R9guOlJk9liiCnJNfyK6UJ7P03HsK5w0NiIfSnL80+8urFvCzjmZSmmyM7IJgqmcWe
	yVcbBk3aMq5207vOyosFSKZlUFoeLj9aMkNp4pV/aIK1/9Nal9G9oZTn+Z9U4f54nbWCBEDXQWH
	aksRKWjXB+1Cg
X-Received: by 2002:adf:ea44:0:b0:436:1e6:e1d6 with SMTP id ffacd0b85a97d-4361805cff0mr7608460f8f.46.1770286040156;
        Thu, 05 Feb 2026 02:07:20 -0800 (PST)
X-Received: by 2002:adf:ea44:0:b0:436:1e6:e1d6 with SMTP id ffacd0b85a97d-4361805cff0mr7608414f8f.46.1770286039609;
        Thu, 05 Feb 2026 02:07:19 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640e5sm12040659f8f.40.2026.02.05.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:07:19 -0800 (PST)
Message-ID: <44a1f815-45bf-49b2-a772-6e0d53fdbbae@redhat.com>
Date: Thu, 5 Feb 2026 11:07:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mptcp-net 3/3] mptcp: fix stall because of data_ready
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IG0t-LwJnfbjVaT8qyxkFIKfYeGvMYeL559gqGoG2LQ_1770286040
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 7:41 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch fixes the second type of backlog_list stall issue that
> occurs when the data_ready callback attempts to trigger data transfer.
> The issue reproduces at approximately a 20% rate (once every five runs)
> when running multi_chunk.sh tests.
> 
> The stall occurs under the following conditions:
> 1. A large amount of out-of-order (OFO) data causes sk_rmem_alloc to
>    exceed sk_rcvbuf

Thinking again about this scenario, the above condition is quite
unexpected to me. Could you please share a pcap capture of this stall?
In theory the sender should not fill the rcv window with OoO skb only.

> 2. The skb matching the current ack_seq is not present in backlog_list
> 3. Data reception relies on data_ready callback notification
> 
> In this scenario, the data_ready callback (via mptcp_data_ready() ->
> sk->sk_data_ready()) attempts to trigger data movement, but
> __mptcp_move_skbs_from_subflow() repeatedly moves the ack_seq skb into
> backlog_list and returns false:
> 
> '''
> [  144.961282][    C0] MPTCP: msk->ack_seq:3442119990924456661, map_seq:3442119990924456661, offset:0, fin:0
> [  144.961293][    C0] MPTCP: [MPTCP_BACKLOG] #0 map_seq=3442119990924655746 end_seq=3442119990924660542 len=4796
> [  144.962310][    C0] MPTCP: [MPTCP_BACKLOG] #1 map_seq=3442119990924491850 end_seq=3442119990924500364 len=8514
> [  144.962783][    C0] MPTCP: [MPTCP_BACKLOG] #2 map_seq=3442119990924660542 end_seq=3442119990924726001 len=65459
> [  144.963260][    C0] MPTCP: [MPTCP_BACKLOG] #3 map_seq=3442119990924508114 end_seq=3442119990924514971 len=6857
> [  144.963729][    C0] MPTCP: [MPTCP_BACKLOG] #4 map_seq=3442119990924726001 end_seq=3442119990924731093 len=5092
> [  144.964193][    C0] MPTCP: [MPTCP_BACKLOG] #5 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.964651][    C0] MPTCP: [MPTCP_BACKLOG] #6 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.965164][    C0] MPTCP: [MPTCP_BACKLOG] #7 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.965711][    C0] MPTCP: [MPTCP_BACKLOG] #8 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.966260][    C0] MPTCP: [MPTCP_BACKLOG] #9 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.966804][    C0] MPTCP: [MPTCP_BACKLOG] #10 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.967308][    C0] MPTCP: [MPTCP_BACKLOG] #11 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [  144.967793][    C0] MPTCP: [MPTCP_BACKLOG] #12 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> ...
> '''
> 
> The fix adds a check for an empty receive queue in addition to the
> rcvbuf comparison. When the receive queue is empty, skbs should still
> be moved to prevent the stall. With this patch, all mptcp_tls tests
> pass successfully.
> 
> Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b6bafc37eea4..054aa72c9aa6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -739,7 +739,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  
>  			mptcp_init_skb(ssk, skb, offset, len);
>  
> -			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> +			if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
> +					skb_queue_empty(&sk->sk_receive_queue))) {

Similar consideration WRT the previous patch, we need protect against
possible attacks. I think checking and allowing in-sequence skbs should
be enough:

			if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
			    MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq)) {

/P

