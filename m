Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD83B5820
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174651; cv=none; b=RzPFcCiEJ9gLcwjSqJf6HQANKuLrdS2JZqKMrlxzTyv2oAhkjosZRr0mld/0OZl15Jw3iYbA/+UNGv61VEp1Lq+1P+5LjcOZtXo4I1BUeLl9Vegu4Fcp8bsdVyblHyWEOSG3u613FCd+pIAWR59dlO6LDrIz5agncJN29KGGfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174651; c=relaxed/simple;
	bh=DNfz+RkFyCt8NqkPqDJBHs2lJq6fxj/YDGWrw6T6OiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6rPZYItxXdBnYaVOHMGuvUcTJJ1yyxP9iBEzbhUTd/qpdae0IpkA4xPGTH+at5qwpml6vPETjy6ghd8LXpyxT7OxJy4TlpAVLQSNNBF2l/yK5mIf+u83feMO8EGuArenLAHB7QTFbEoryQPATG/j685mZJN8bL7CQaU3KtGJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcWv/obK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcWv/obK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779174647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCfXOAap2ZwonWatsbBwYVaPs+ys+zdcFEcdb9jcBaM=;
	b=FcWv/obKPVzGrAPtVr0l0wxchdaqKo88H7g19Z0oMnqXyVatQAe6auR4m9Gwa0RZqBcwKE
	UQHWtkj0iU+tLAbwSlWriOp1qrbPdRB2ISiBMjzvD3U2geTF8x4Dc/+VlNEqyE920RPo00
	oMdlD7MjMY5bBbjQLZaCeiaO5fuad28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-H0-FQsy2PKu_dcaWGqyiIQ-1; Tue, 19 May 2026 03:10:43 -0400
X-MC-Unique: H0-FQsy2PKu_dcaWGqyiIQ-1
X-Mimecast-MFC-AGG-ID: H0-FQsy2PKu_dcaWGqyiIQ_1779174642
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a52d5e572so2495071f8f.3
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 00:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174642; x=1779779442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCfXOAap2ZwonWatsbBwYVaPs+ys+zdcFEcdb9jcBaM=;
        b=P0PUD+i/lUN228Gmh+RaFqXQthKwyd+NQHLro+6biWqADNK4AtP/tK/n0Yp0uF6MRe
         n1KWvrC3gwtFSmm99J6hRAlhsL700v8IBMUZA+6iClce5UWr0CUKRAnpBljEDScV2DYB
         Zx9cgHGOiVZhTjGRCIzR9WIhW6Jhh3+8ntNjiEm8qR+JQ9UWIj3j3+69ijCpPJBe/PBB
         iVWNXn8l+3lqHMqrFJAKySnRDDvdBVxX3UD1P8vXqud9giyh5XpGEuZG+gc3pHIg63Mf
         0Ae7csHQMaNpgws3l44JzqvuEwcF5VtZkzDxdMD4WhEYMceKaLGaw6ihumQms44G6DOq
         9sWg==
X-Gm-Message-State: AOJu0Yy5hir+qlJmpRoxqcI5lJjN+rG3+tR6qkT1tjlBG2QWztfJi0jj
	ul8hTttnM+CSKo4LWOFbDCS1WotTWcHLfiFNWdI2sjEwt4pTSf69lUxs6mjtRjlHcdM3ApMzzZ4
	r0zlR8qjeZlmdGqFSCPbIbzPNV7fwcCItkaIBucDekHdiC0sGLh0kWht5Rkn0QZo1
X-Gm-Gg: Acq92OGrSNjqmOi4BM6wyWJZky68lFeDS1bRCV3W04tqNgiFD8lOMxztSsiUwyqHgj2
	qcrmSCxh/ilhcN0ZYt5gBE36Xjtz9kSlvznCqv0NQ2aKO11o13eSbj7m6asewAT72z4gNFxdUAw
	6FrTTM2gjfyIOucrMQrGDRAo37LnXNT8T75oau8ycvQTTDBA6LvFn4aOV05v92PxwGSsF4AXepJ
	b4kyX9/9bJLFNz1fxRg5digbz3HWrdFlxuOhy9qp5szf3vqZLBRkjkfoOaDBJ9pHhXW+owzNl1u
	BNOTy8TKwUXUyUvpLpbCVA8RhFpq6eUyGcvN/r5I1G8vSJH/+g/ULEbdisc4KX0jyVi+3dLcT5G
	mYfmHc2mQpo8w8UPziCjwXvmbNxeNEqFn60SnLeFuKX3yAlwLGoR6B78=
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr275968555e9.5.1779174642086;
        Tue, 19 May 2026 00:10:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr275968155e9.5.1779174641633;
        Tue, 19 May 2026 00:10:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe67688sm126331525e9.5.2026.05.19.00.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:10:41 -0700 (PDT)
Message-ID: <d86df020-4976-4a34-9f27-6ef09fa9b2d5@redhat.com>
Date: Tue, 19 May 2026 09:10:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 03/12] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
 <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org>
 <9878b113-59e9-4100-92b8-fed412466097@redhat.com>
 <e8eab089-38a9-4786-9052-b2d0a4d2aab4@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e8eab089-38a9-4786-9052-b2d0a4d2aab4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D2J-BYFqAkEc-XhXGEYDmz1C1QT8ZLYwLNyviN6HHP4_1779174642
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/18/26 7:17 PM, Matthieu Baerts wrote:
> 19 May 2026 01:19:36 Paolo Abeni <pabeni@redhat.com>:
>> On 5/18/26 2:59 PM, Matthieu Baerts (NGI0) wrote:
>>>         if (mptcp_established_options(sk, skb, &optsize, remaining,
>>> -                         &opts->mptcp)) {
>>> +                         &drop_ts, &opts->mptcp)) {
>>
>> What about passing `opts` instead of both `drop_ts` and `opts->mptcp` ?
> 
> I didn't do that because "struct tcp_out_options" is defined only in
> tcp_output.c. Do you think it would be worth it to export it?

I did not consider the above. I think it would make sense to move
`struct tcp_out_options` definition to an header file, possibly even in
net/ipv4/. I admit I'm not sure Eric will agree. Possibly an early check
could help.

/P

