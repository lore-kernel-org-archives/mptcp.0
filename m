Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636333;
	b=NqXkIRE0iuvsF9OaAbRBrsPVV1VM09tTBYpCz/eig75Ogqh04vZw58EZQTPjHk6pNMd/
	 kEWwk+nW2hSF41uzb22CRVn5C9yODMkSrNMO5b7n+c6CmFBp4xwT2zNBYprw0rlEZ5QHm
	 iHOM4OV32CDmLAI7rygL1djp4pRRwmq5qk9ZmS1uIJ4rYw3DlaD4A+Wn0q3z36UiupZsn
	 v8qxf1ZAegtHej/l0F/MrS1QanJRJIBcumiiCqkDJ+V4IEsjWoa6ohvH8Oa8KedBayA7k
	 4FWU6j6oqxJdAsEBlmVltFkHiXQpkU4xRwOGnkol8tDDc59F1yJvsmNl9DAkgrpRYsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
	b=UF3h3Bk+MWLCET+i74QYqoGsZMDql++3N9HnkMotd0Y56FHBJhHqDakYsXmrAg9Y+E7m
	 bxQP5/dqwq//HPBhlerTelVRPnFWsiRaLeftiTk06MLeBSx+dApCdUZQs4w82WLwO7b6D
	 AEq6BLlMe3nlNVba5D4LpoW5uwIJ+/lc82Gw0U3+eUHvdvR/+YWekJ+2QTHnFjsj3SjTL
	 gaEjJ7OJwstlw764yj/tQ4PQwH8gR4HB5kQwAFlCuPYXq/sh5KbFKh2xMgdPviq1ghDD6
	 aNf/85VE89vIgReUbnv4A7WpoFdLNa9pT8i4mF37SHEmz11WQ2xbR7zDIrNcA2S8bKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOghAqiM;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B0606A912
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236B0606A912
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOghAqiM
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89f639ba307so1141059b3a.3
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636332; x=1794241132; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=IOghAqiMOxvCt0yRmlkZGve1KQPIis1zWBEiJnZ3DvSjM3bjg09sCc6muLOxmBf9Gw
         BYas2JSAfppkI7m45H5bjMulbJ+6zX1jamD47GCUEls6kdUcOo4OaOOst4lywEKkrrms
         aQDJG1CxjB5PKGhA1TdooDeS7KrQjaQFa73OWJ8OH8Zaa9764JKvd99Yqi5dVs9aOJ02
         097pwZ8njvJlyaaPLtMi4MKG/Kk1XJh2q8pmcdn1f74WZBalnJlbi6lVMVkwO3XQLBcn
         ttQFXAicMj2BdUCL2sWYRB4m2dprpWsPy/THh2xQxRCxDbtmGoKaqGeNAC/vk3P9S+TV
         oBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636332; x=1794241132;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=VRpzwGw9JBwJevawQKAkrYHAp91+34j8VZN4EZHCXf0WGlsQp+ps6SU5zSvnOvkmsy
         lymbEU9JZr8rSKpbe0J/AEu1JWl4gD/An/snclgJdYrsErBEj4Zl/4CGBbRZjHvDVK+A
         OtVPhy1lzhEj/CzbyudkMSs9b7d9MxKx7hMmRZS5EKDVjGnHIM3QnnO2fChXtmVEOolG
         rgtx0CvQLYdOPFd0bU6WdS8uasj18GIBn2N8rkPhH1/BZvP1uKq1KnjivoE8Yo6m7lwS
         eomiTGBds8zt3/meP5JjKqaT3a85vad2i4XbDv0kcVW8/ZZqNypCTz8yFazDHX6I+62/
         XXQw==
X-Forwarded-Encrypted: i=1; AKwUvBwA1y+ijYYiC375ojSBQI6h9HphsE8KJ9RSkw9rZlP/OwV9Yx7UFZ3valdggIeGKRo2r/kJyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJ4obSQMHOllBNL/I5QirFnyCI4sd9jSiSJ9cS+6h3Vng9tJtq
	fx+i6jG7CRItp4QrEnjbz/8PcKk/k0OrxNAst+O9/9fKuZVky8OWCDwi
X-Gm-Gg: AYBFou1zZF5+oU3ZbI4/clk0eLdmpVIu8BiyZbBS1Tqt4GkxdSrUmzDq0Xm3UFClGFc
	x+N4QgjDE/Bj42qOk2CSlGOa8SqpMCPBY8xtnyB+njzqb3fowbcEbRqMoxBD0rKaBAmjp/+7amQ
	p8D1zn4gdYYbBCqo3H5r8aJms2yySK13Zuah0NVKISMkWAp4i4FR74mWO9EQrpqb9WWPWDXTuK5
	sXPKFDn2clWnsmoEueji9n+ix6kyhPUWThhpXVI5XwKPK63I7GWZFRRy14SU/Q0nMJzcCHswqHF
	5e1koYoxdsgyOTPmFsfX3wCXG/pvxaRNiuoE5UjyuJ+mQWMDfRrQ6e2CGoY8vTd6bdOJB/eMYSg
	kS2EcjpcXbrt/AT+9Il3nxe1KtH99bTBLA4BqWIjBzQWb7nppAqIQRNrUhJsc3NsQK6nHD60jMg
	UnW16SzHsoNwuTXwQRSOYvHS0aD6GyzQcdnBlmXvjOmNasXYSHDpuIxC5xHu2D6sDcmnBjTk5Oi
	Mzp7jseLQBzG/WVbESnpGsRxTJRNUeLs0ZpDs3vm6BoGlhBsI1J5+dIAs4uSm1mXQACdRJDK2r6
	9zg7j2QPvYSUPL1i3j2w3zm1udDbEzcaodW048M9vvvVBn6hxwaZ/OAc6Oxkaxep+Jtx2skIU9o
	IECP1FbDF5raNpq9ixCWvVoonOoU6+pJll+DRa3mogYBIjw88I5Z5iTo=
X-Received: by 2002:a05:6300:8047:b0:3e1:7b85:5a95 with SMTP id adf61e73a8af0-3e928ce91b7mr8254146637.28.1793636332340;
        Mon, 02 Nov 2026 08:18:52 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03424sm2308383b3a.24.2026.11.02.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:18:51 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:18:50 +0000
Message-Id: <DMKV0IW3XAU1.3KSPCJSXR3Z3K@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 04:32 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> I can trigger it by redirecting data to a non-accept sk.
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in tcp_sendmsg_locked+0xfb8/0x4550
> Write of size 8 at addr 0000000000000008 by task repro/488

Thanks for testing.
All patches have reproducers.
I didn't share them, hough it's a weak defense.
Anyone can build a repro from the patch.
