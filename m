Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF14A01
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908641; cv=none; b=Uc+T+bncbISgfGMne2XinGcWrhbqv70fxUg6yvbbVYD+VU9l44L7x+ycUMAMtC+9VEcfxIn97P7CnvR9Gf+oDcxdAcV4qNhulEausvdOU2rVn6Z9eWkWVorDUb8cZn8qpbQ2UMC15Hcyp9mDet2E0aNEv2sH6Lij2jnv+lG3No4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908641; c=relaxed/simple;
	bh=k8DX/flW9WCn9HI45cgXFW7YXqukUszgWNyOReWeFgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ToCGdhhkhinVW9ICboBWJBZfIV5+tjq5bUvuxqPUqvD1iwAjOSrFJoEcXIzPTbb3v3gfpfzGJLZyxNGl19tyKfG/sQ0KBwCMhgnpRcpQ9qG2BWF1pgSh4J6YcaXRyTcwNOeofySscbSIQ51N+GTXui2movSN7hmFMigNUHiPqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhoCyg8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhoCyg8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759908638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlzH580ALVGgMVSbeE1B8Vqh43ydV0OGQbW4U+EaSRo=;
	b=KhoCyg8LVpoZ4n1dFSFLkrlvKk8vbSBJqqw6skIRbghBhHXhP56ua6emXfivUnNXW5GiFC
	0PB7p6lqEdjC7KV+qiHWlfPMN2eV5977qgVMGXXj4LLlYAEYRchGufhD1nZ5mjRvSbRNYO
	2hukpUWVexWM9YPoLbC9f1IZHWtpdf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-QyAcc3mzMUG7PfI7ZWeMVQ-1; Wed, 08 Oct 2025 03:30:37 -0400
X-MC-Unique: QyAcc3mzMUG7PfI7ZWeMVQ-1
X-Mimecast-MFC-AGG-ID: QyAcc3mzMUG7PfI7ZWeMVQ_1759908636
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so2638845e9.3
        for <mptcp@lists.linux.dev>; Wed, 08 Oct 2025 00:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908636; x=1760513436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlzH580ALVGgMVSbeE1B8Vqh43ydV0OGQbW4U+EaSRo=;
        b=Ad2pvDDp+hn+rDkhFmZjWVeNxVMtJ/01M/vhvPp44+GO8mVTekmJ+tBeivj2O/aGbl
         B2XG2xuk08pEXjAuMJdrR/7JZIRhxb2evU19jV0SeBERriMSla1np5r+vz5K8QIxDK6x
         cOHLotD4RTi1c8wh0IK3kyor81CQ/pGUKJ78wKIwY9Dvxl7Gbdpynp+u5MUl3/wAIxAq
         E3Nioki6sOEHawUxDJDzaTdNyqC58lO7isBS06A/RbrCOgbwWDN/yulYa8JvRhcdpVvx
         OMqiyQ1pYzTb1ggv4g8c1ZD4VaCt5KzwZiyEkmsYCTjtkmpHanAVRSj1oWMa6qP3iifz
         +iqg==
X-Forwarded-Encrypted: i=1; AJvYcCXjK3FXGg9DsnmDUysyBCE15nQpWEydhzK3uoJjpwIEoLeUFXw8RrALghsmJVhPN7emN1Ounw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWA4qOx4/zFedhLz0RXdk66JFCCwXWgl+jRRlK+7aAzV5zttH6
	7l/TlRNb4b67yOtKhbX/kiMNDKLGvLDW20+zA+X0SqMAdGi5JnSbtVVeygq4i02J1iqqxVujtka
	UWMG+hvIKzCpvXeG3Pfp6ol6ekHLsY2sw1h2op6FT/kx4G0xwi9OTkED2
X-Gm-Gg: ASbGncsUYt47QrEtqhn0PiM1RbscmkZZW5+b2elEGZKVZyXA6U3B+dj4Tbe6dO2R44k
	xIL/eEK1VPpPaT8dclQJAWb7dwvULS6f3zJ++4+biowtPkuvjLjWCjorX2bLzCzo4vlE5xt23N+
	+cAkW4brjrWtt8e4qVHPuD9dQy8Twoaob344ekynAY7anT+c2dia3MNkPupvx5IM86duJh9XzA4
	L6VIiqO6gT+8fLLWU4m7ZW5nyDgftADOTKbqV8nbF4iKdYolXKlaY3bVvsTynaUrjfA1kWo9gjk
	MeE3vJn94f4woBtjNXwvpfDBr7aJVDBNrctUOjvDDh8pRuTKhDogZtd+pVR/V1L9ZOQnBGUe6CL
	TmtGTBDKX7jBcR7HlVA==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id 5b1f17b1804b1-46fa9b08bd7mr12440715e9.32.1759908636375;
        Wed, 08 Oct 2025 00:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6n7P1AQDFYVCT670hupTJnE6Sh0Bpc6AYqfdw8bBGFZ7fsNKJLVn7UXKv4jVHCDk0G4JP/A==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id 5b1f17b1804b1-46fa9b08bd7mr12440575e9.32.1759908635920;
        Wed, 08 Oct 2025 00:30:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d4c8c5sm24240525e9.11.2025.10.08.00.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 00:30:35 -0700 (PDT)
Message-ID: <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
Date: Wed, 8 Oct 2025 09:30:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tJXf0UcXEI0_T8716B9zZte3Mdwl9oXaak9fG-I7BkA_1759908636
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 5:07 AM, Geliang Tang wrote:
> On Mon, 2025-10-06 at 19:07 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 06/10/2025 10:11, Paolo Abeni wrote:
>>> This series includes RX path improvement built around backlog
>>> processing
>> Thank you for the new version! This is not a review, but just a note
>> to
>> tell you patchew didn't manage to apply the patches due to the same
>> conflict that was already there with the v4 (mptcp_init_skb()
>> parameters
>> have been moved to the previous line). I just applied the patches
>> manually. While at it, I also used this test branch for syzkaller to
>> validate them.
>>
>> (Also, on patch "mptcp: drop the __mptcp_data_ready() helper", git
>> complained that there is a trailing whitespace.)
> 
> Sorry, patches 9-10 break my "implement mptcp read_sock" v12 series. I
> rebased this series on patches 1-8, it works well. But after applying
> patches 9-10, I changed mptcp_recv_skb() in [1] from

Thanks for the feedback, the applied delta looks good to me.

> # INFO: with MPTFO start
> # 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP     (duration
> 60989ms) [FAIL] client exit code 0, server 124
> # 
> # netns ns1-RqXF2p (listener) socket stat for 10054:
> # Failed to find cgroup2 mount
> # Failed to find cgroup2 mount
> # Failed to find cgroup2 mount
> # Netid State    Recv-Q Send-Q Local Address:Port  Peer Address:Port  
> # tcp   ESTAB    0      0           10.0.1.1:10054     10.0.1.2:55516
> ino:2064372 sk:1 cgroup:unreachable:1 <->
> # 	 skmem:(r0,rb131072,t0,tb340992,f0,w0,o0,bl0,d0) sack cubic
> wscale:8,8 rto:206 rtt:5.026/10.034 ato:40 mss:1460 pmtu:1500
> rcvmss:1436 advmss:1460 cwnd:10 bytes_sent:115312 bytes_retrans:1560
> bytes_acked:113752 bytes_received:5136 segs_out:85 segs_in:16
> data_segs_out:83 data_segs_in:4 send 23239156bps lastsnd:60939
> lastrcv:61035 lastack:60912 pacing_rate 343879640bps delivery_rate
> 1994680bps delivered:84 busy:123ms sndbuf_limited:41ms(33.3%)
> retrans:0/2 dsack_dups:2 rcv_space:14600 rcv_ssthresh:75432
> minrtt:0.003 rcv_wnd:75520 tcp-ulp-mptcp flags:Mec
> token:0000(id:0)/32ed0950(id:0) seq:2946228641406205031 sfseq:1
> ssnoff:1349223625 maplen:5136
> # mptcp LAST-ACK 0      0           10.0.1.1:10054     10.0.1.2:55516
> timer:(keepalive,59sec,0) ino:0 sk:2 cgroup:unreachable:1 ---
> # 	 skmem:(r0,rb131072,t0,tb345088,f4088,w352264,o0,bl0,d0)
> subflows_max:2 remote_key token:32ed0950 write_seq:6317574787800720824
> snd_una:6317574787800376423 rcv_nxt:2946228641406210168
> bytes_sent:113752 bytes_received:5136 bytes_acked:113752
> subflows_total:1 last_data_sent:60954 last_data_recv:61036
> last_ack_recv:60913                                       

bytes_sent == bytes_sent, possibly we are missing a window-open event,
which in turn should be triggered by a mptcp_cleanp_rbuf(), which AFAICS
are correctly invoked in the splice code. TL;DR: I can't find anything
obviously wrong :-P

Also the default rx buf size is suspect.

Can you reproduce the issue while capturing the traffic with tcpdump? if
so, could you please share the capture?

Are TFO cases the only one failing?

Thanks,

Paolo

