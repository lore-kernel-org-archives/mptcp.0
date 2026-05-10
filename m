Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317F25A642
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778445505; cv=none; b=LNSiFyeeV2pryfeb6/PVWKDeuiSIXAVPjwentMobGFK/47sk29fHSRUxodVYc4Q4JeszKd7keLv8AtFwcrBS//ai0TAc5ArDN/qov/FD6YJUtJtutd2tjwZCQf8wDrghXNqTwfaxVmW1aXA8l9dOFWkZ9CV+HF/H9gSSt5Vc+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778445505; c=relaxed/simple;
	bh=BWYgK/yueKwuIjI5869eDxl55jnMMwS4D6wCINU1aHE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VCmX4ONPxPfdfYTwvdlGZhR0BDuJCYXX0pd01TECxUCONkVfzuKA7UsASmFnH1wUW0G5tWYtDDEn23FSOrTA5F9VrhYF0005yBx2olrvTmo5jcUxvVSFpKL2CTG6MoF2jDwlMKs7s5ID+cEFaVJYhztNNqyO/R8GElB5obXH4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDlP4TDi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDlP4TDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778445503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YvvZWai2wA9H/veFYK/P7Qfs2gyrK2wOrJK2epk33I=;
	b=YDlP4TDiNc6ySsmiyPdbZXiIQ0mthzjUwXkAzhb2b4CVw9xFn8qqK7kL8nPjVn/xJ1J8u4
	lCR+giXvYLX12cH/V564taTha/hMWrV0X33xepFQLVvfRK1ZHYcxxc0Ua0ZK4reVE1HsFU
	BXKaNSahbg6Ri/GeXjoUm4RkNmfejbk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-BVLrx2WhPwS8RvkojuyLEg-1; Sun, 10 May 2026 16:38:21 -0400
X-MC-Unique: BVLrx2WhPwS8RvkojuyLEg-1
X-Mimecast-MFC-AGG-ID: BVLrx2WhPwS8RvkojuyLEg_1778445500
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so3585485f8f.2
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 13:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778445500; x=1779050300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YvvZWai2wA9H/veFYK/P7Qfs2gyrK2wOrJK2epk33I=;
        b=SIB8bSWkIA46guqxzdiZsFktInUBBjRFbq0qMndZps66iLMccLaVJaCBigiH9Zndzf
         X7r6q4O6KzIGxHp3ICc2gOnHqSmftItFiF3ChefqBwPXylx2Vz9Hw7YuoGk57a4tcmKl
         ODORetI2K98cHYIU0TxKa+f/sk0cM+rnnB1r/xoLL2N14kinT1mgIshJhnxrry9RlG1v
         2tXuPUHv5RwvY+mk0WkYgNnGt+9s4Ek3moY1ypqMc1BFXHf33LvAc0F4lANolbtnX8rb
         h2zmYcdIDIz2sVHyxnsRbJzCcfbFBR5VMXthP0iMZ6uOBUoi/xegtiIxdrjNQGdjG5pj
         JxXQ==
X-Gm-Message-State: AOJu0YwF990fb9K8O9Er0KYptN5tbQ11XZotymuU3EtPcZqZ1OCXzXCw
	KVnO7ATAp3Th7j8z8Dp0hNCdevhlRha4sj049AKmuxPnp4WqelZ9yxxUzd1B4R8oT+BVsCKNhDH
	NsweUP31yXVFlcPssGKhzwRlMrvsxpQ/8x5JaDeKSXaAGMu/qy9ERNzescSN/382WTtp+L0Sy/e
	8773n9c0FvM++Mxr4ujvrdwv8DhJEfUckLs0Oukw==
X-Gm-Gg: Acq92OE4xtmi6292di8C89JnNyRtrEduj2gggP7Bn1baQCTbPkauQaJUagyy+lrDUoB
	0lJy2nCdokMrtqyU8sGe2Uk9YK+CFPi8PIhWqfM3GIx9kSzoD5tvEpIsg3OW5Xp2WKF6YjQwgqe
	BLCLf7EE9hkZtfCfO8j1Ske7D441GRf0oqMf6RorxTpFxpX8DwIpi5U1GdDNxOl8MPYdDaqPA60
	vaaW97GkiBsWPzgltNmTpbTAugvs2uilQTyRP5ndLb2Dl9S+xy/nGE1AjukuUNucXwawwqAzWhl
	yPcrs665/T00H6OTvJMbV9JZ3EUxJAp4zJXAp9AnOz9fqvF90nxhOcOBAqiLNc6zu1q+/70QbSh
	WZLK59Lj5YV/4T5j5Glj7bTNSC1Co2wukY1ALDpfJ7Q/quWgJq7M5ZUQLoVSPi42qtLU=
X-Received: by 2002:a5d:64c8:0:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-456a44fbcd9mr10919588f8f.29.1778445500197;
        Sun, 10 May 2026 13:38:20 -0700 (PDT)
X-Received: by 2002:a5d:64c8:0:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-456a44fbcd9mr10919560f8f.29.1778445499596;
        Sun, 10 May 2026 13:38:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm20525307f8f.18.2026.05.10.13.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:38:19 -0700 (PDT)
Message-ID: <55ea8256-31a7-455d-a56c-f7b6960572e8@redhat.com>
Date: Sun, 10 May 2026 22:38:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 06/12] mptcp: remove CB offset field
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <cover.1778312843.git.pabeni@redhat.com>
 <abe9923377952ae63c600c888512b0e8c835bcea.1778312843.git.pabeni@redhat.com>
In-Reply-To: <abe9923377952ae63c600c888512b0e8c835bcea.1778312843.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WDrZ0kiv45ISfga4AyaocB4qnU5EW_Oa2G843mHGi1A_1778445500
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:48 AM, Paolo Abeni wrote:
> @@ -4390,7 +4381,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  		mptcp_move_skbs(sk);
>  
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> -		offset = MPTCP_SKB_CB(skb)->offset;
> +		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off = offset;
>  			return skb;

Sashiko says:

---
Could this sequence lead to an integer underflow and data loss?
When the remote key is received and the socket is owned by the user,
subflow_set_remote_key() defers the copied_seq update by setting
MPTCP_SYNC_SEQ.
If synchronous backlog processing occurs via mptcp_move_skbs() before the
release callback can run, __mptcp_sync_rcv_sequence() will update map_seq
to iasn - skb->len.
Because copied_seq remains at -skb->len, calculating offset in
mptcp_recv_skb() as msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq appears
to result in -iasn.
Since this causes offset to become a very large positive value, will
offset < skb->len evaluate to false, causing mptcp_eat_recv_skb() to
unintentionally drop the skb?
Additionally, does this desynchronization affect mptcp_inq_hint(),
causing it to calculate a hint_val that frequently exceeds INT_MAX
and falsely report pending data?
---

It's allocinating WRT the integer overflow here: copied seq is
explicitly kept in sync with the current queue head map_seq.

The mptcp_inq_hint() race is real (even if IMHO not very relevant). I'll
address it in the next iteration

/P

