Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646795;
	b=jfOygm7FyZ6Urg+71hMYGuyv8+b9g2weWS80qtdrPO5gSGdH0RpEpyH1KejgbYcsfund
	 wRAAH1BsV2Wou1Ioxdb95IQiH9QNOYkf43IXjXl8X7cVE5oDIB/TTKIJa4xb2UacAp1Dc
	 NbnO/Xuw96Uhl7ggIPryrdTk9okW1WwYJ1im95b34JQbx5U7j7qAVok8GewgZ1SpqlEFl
	 J1o4a1faoiV3PMNYN6f7s8H6fZUdol2lUgdmrW/I1xyRHpbHRNr+GY27We5u+6rf3WSnr
	 aeCTng4dIPDA+ldJB8j/frTvbi99nQ21o9r6pBzsJYNvlNU/tPHk4Q+U7eDeYDOeSZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
	b=0DNE8QLBHwOcslKhi1M11Yl45HO66NXx05EO1N9OFxMxfXFe6B0Z3av/3FYL090n3+OB
	 4dWzYkbGewuls7IqftbeY87x42gRhZKdCUpnJF10yrkbUjQIKJZMm0cWhp5boc6XK3979
	 V5ZoAjObearhyoK3hit30Yxrv4bt9FGCClkRtKqd9+Ee2yrhcIgAZewHa60XUCasvnBfY
	 dwy0SrGZ4lJGlpJD3qkNeVxeA7Ws9lrEs5ePrpOmDmg3iUEXPS2TnVjuDPy/8V0cHkc9Y
	 iQwcTyXDxBJjnseDoy4WFFBXGMKd1CJDg40PqYdLA25Yc23STJ9seqfAC92RR26x7GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PlNE3Tu;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A0606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 19:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB6A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PlNE3Tu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2450174a91.1
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646794; x=1794251594; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=0PlNE3TutdnACV0ujyavEIOskBq5QcZPWYhEfm55qjw7zwYAlGuCaD2Cu3c1JqAD2V
         3QmHyYWACcWVHL7v0Q5OosRxQUVkWGwAxeEfCqPSle44v7qnpsuWClR6GZO0DfwcX0kH
         jA7zE49uHtzMvw/OML6owgB4FGBG3527Z8+4oV/eDEOYHNYS5O+7WXmMAWzfOXDx+B76
         WmDCITUUrTVcXBb/tZr3iWMxJ7iKGHCSiL/RgV1DVOPfJLPcuFQPK7NuKb9Alq540Mhi
         3cAQ6/IEq8XGR84xr5rK4ZBxYbQMUHq8KQnnJiGCzZVbTJ+tXo1eotJaHirWzHIFyc0v
         IezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646794; x=1794251594;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWSc3wxeA0aUeT06xpUv57ACRWiYfD6BXLwXzl7b/xU=;
        b=YVrCnpbfwfdDpt7c3BGalohZA0e13kRLuBZS59yGhdU4jtlB5WiYWoxYyfNb0yfWti
         Ll0nk83S+zslyFqOyAvFJVay+FrQV5OrAFj/NFHVu1UnlFGtr8MNsAOW6SOWEofEJOd6
         fE8hx315/bFjY6eNPI5jaoOAFFLlZPEpjJ/ngHYQzpTziN6+0mI71rWkzEFCx0ThhHNP
         D+9AYAzzKgfJJypsd06McM7Z1mc77SHC1TrQ2JYhOCaHa3nG9ChPCNytEGPi1oy3oiV6
         AzXE0j41wi37SS622bi5BVBMGPib5fcUssgGROBgLfAVLnW6GAu3gLuDgkwMWM1CY3hR
         O7Tg==
X-Gm-Message-State: APuU4Z89QuZHlakdl3APrKS0xHfvvEwi/EsGuaUhFatSt51gul6Jxo91
	s5bM/r+AxF54bfMR23nLUuYYHhCI1/FHI9ikpooXMezyhYPsa24P4V0boWjmpw==
X-Gm-Gg: AYBFou26p715a2skNb2yV8Yn/ZcwptiWSSNjn8rqHpsjwFTasQJjtikjqEVPc0Nf90b
	XlyL0rShimugrpXvsGvUSnaA3hjS9rN2Y1ppvST5dL2ksxiu/wl6/VBbxhpzj/rtghPy+6fvxaU
	ebPXXaTmEK+2YXY5ZXZxnRbb1AxGD7471JiyXd+LCiAAdtrrPksB1SfYAwL7T7rPWuQQv3n/oEg
	Q+tA9KgutPO62Ab1JmqT6wbJBA3RE2X44Tkt6VKhTlhcov7G61YmOAx1Sxop0YkMF34NcavZI4m
	KA/g+GDUbaCpGi8TM1OgWyIrwscVDSF2JRt3aMi0djY4tMaxdilhjBNNuFRbuzpPT/Bvc51wKcr
	j3B/gCTK9hos+dDXbbWkpi2i/pS6pnK7BCDYQeBvDnxhkhCZwWp+LFN03Yy6z9AhFeiVTlqIDQW
	fMQuD1SUZ12UwlXuccrK/VlU6tr3aDsilgAXSSd/23MUWUED1uMBgnL1cVsyvdrQm0jVd5gPZQ7
	BP8DRjHM2n5D66fLyGLByYW1PFxhYeb0Pudh5Tni9c1rOA5YDA65IuZrE/Vchj60x78WfJFAsSx
	csux+ldeCnlwVJezLCu4afZS4lsiktB0xJt8Cz7kx2769HtdGpY+UqYVBaudkKLJlu3O
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3ae897c87acmr9116933a91.23.1793646794112;
        Mon, 02 Nov 2026 11:13:14 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm451194a91.5.2026.11.02.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:13:13 -0800 (PST)
Date: Mon, 02 Nov 2026 12:12:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
Message-ID: <tnw2q0.1tgt7zq8oeb0@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
>message. It then subtracts tosend bytes from *copied, the return value of
>sendmsg(). But tosend is the number of bytes that the verdict applies to.
>After bpf_msg_apply_bytes() tosend can be less than the message size. Then
>sendmsg() reports dropped bytes as sent.
>
>Subtract the number of bytes that sk_msg_free() frees. After an error the
>SK_PASS branch already does this. The SK_REDIRECT branch does the same if
>the message is not the cork. Nothing changes when tosend is equal to the
>message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
>Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
