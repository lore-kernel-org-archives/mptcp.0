Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CB41D104
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693779; cv=none; b=alPoBEogAhxx1b2UTq0jJ7V5pXQBnY3p3wRInh3ufeRiJE3n9k22yg7HHRsimDORQ3EVuIzMb5GVCwTbm3FReZ8tGyHqsmBxaq4UX7uGBQUhIjEmbe+svBd2iGmwgqFdQRzu2jpfIHb8Ffj8kkX2654atrFxgFZJEfjZoSILH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693779; c=relaxed/simple;
	bh=l8NMWgeK+aObgQnBLCwwZ39bxDxP+CW033R8NKfQ+JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un/MaH5maguJ6syaHo9JXrFiTtFmkPjXBn21rdsLMNSnQc3RjD4w03wHSW91r1PX395vICik7PS0tj6zjypPGEFwz+IEJTJCDgiMJ9JdH0OU+L1RFuluwBNF9b1qD0L52u8toVubNg12spgtKqxTmeRSx3NGtPSDiWn4LCBdyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X20jjcYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X20jjcYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786693772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL0SPRjMSSQznv5rLFncff5bp35rpu9P3ikchBKuyig=;
	b=X20jjcYG4RySKwP6F0A1zFLFKHeENp1r6Wuu4VnL+GiRhE5DKTzCxPKq1vGtxcPU92vXEg
	90NMle5ntcfufoDvdSB38RIgiqp5WK3WecVAjkW6g5QnAAiMUPEe5fLgBAcwteepOVX075
	KVDBvIDHNHL8L0hCugA/7+en4a8PY2A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-FT5LRhZtP0KUj-W-aNFjsQ-1; Fri, 14 Aug 2026 03:49:31 -0400
X-MC-Unique: FT5LRhZtP0KUj-W-aNFjsQ-1
X-Mimecast-MFC-AGG-ID: FT5LRhZtP0KUj-W-aNFjsQ_1786693770
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f726186c4so367117f8f.2
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 00:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693770; x=1787298570;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xL0SPRjMSSQznv5rLFncff5bp35rpu9P3ikchBKuyig=;
        b=hqLvMyt688bsODBvln1o1CvyscGp03iq+CfIq25VyY8m1+CUQkhHvaevBljdptuGDd
         b8qUFSdPJ0C+EVv0eJTwSalJzZPyIloeQ5Qz7/mNAFCVyD/JEDohGMXblliKDDOjyN1w
         R2sSmQaHjMQQoEm9LN3ZjjAIqxcVGskGmlAmUp/T+A2qe9K2c78ZsfHho7kia2jdwhQu
         pMCr4H0VKzsx1/f9hIpbr2ViGr0MPxD03v4ILE2RmmTPgbMseola9+YHdJ3GBDpThNwk
         o5FLASnMtvN96egzL3M4P08vnkRoafQQ0mCPiRFwLbYAEdJ0tqeT9UcxGA8+rDNKA1T3
         FZWA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0a6KQcgrbfbjISqimdgjysybVRsz52FsYpkuNxxI+FCaaS+y5RN99WxId4dx8mDlxrAm4Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7I8sciM2qtyIwoD3d6zGCJE789LDQLkRhVoPZgKz4P+5//ZRP
	rf6n2oxGcl2ULcre3xaT9X0PTJf12gRXwTGypvSpc/e1t4wqmYQmV9bEXQ5M/5msgEEGVuLX69H
	gZTWEuNxZQxwizzcZZkpfoXXzrFbdq+kApsOyp8uhdHMjusp0BoKIgX8d
X-Gm-Gg: AR+sD131iUP042IA0qb0/CoT5RgHXNwa1EzFWR+7NW8dkAIuI1n7DtMp7yK6GlIbof6
	wFFGMxdafNX2MZ48mjBMpF0ufC4nNMAO9dfdMDeAl/e4TLz9Zn6B+nFpkfHTDfXqOCaKvcYjuVc
	CyBpkBaa+4FkR6i0Bx/nH7+kacv7xQwwXiIriLhjudTieGk8hvcqn0bT16FWAOs9OQf+1/wrdhi
	r+ZnEa3TMGN9DqyPpCTH4QyxOqHTC/K8XdoxrgF299XFcWyFPf1Rd8lu5rdkneRk76jxfrLHIWM
	fKcxqMcV/pdzbl+F5wqPGx9zMtBA/D7m4jIdyuOXF22Q+Jr5JSRwXvjAANtaWhdlpvwK5sp3RIo
	ieBSTnXd/9ckXUNulzcfgaNp4pcO3aIKFY95lARbd4PKxOEzmvKxb0l+psEx5DkNHJcjPqkrzmT
	U=
X-Received: by 2002:a05:6000:4915:b0:47f:f828:9f32 with SMTP id ffacd0b85a97d-48160786ba2mr5928618f8f.27.1786693770225;
        Fri, 14 Aug 2026 00:49:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4915:b0:47f:f828:9f32 with SMTP id ffacd0b85a97d-48160786ba2mr5928538f8f.27.1786693769817;
        Fri, 14 Aug 2026 00:49:29 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm5904632f8f.32.2026.08.14.00.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:49:29 -0700 (PDT)
Message-ID: <74e1a388-2d49-4dea-96d1-4a7844a63b08@redhat.com>
Date: Fri, 14 Aug 2026 09:49:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/2] mptcp: sched: let schedulers mark a
 subflow to avoid
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, shardul.b@mpiricsoftware.com,
 janak@mpiric.us, kalpanjani009@gmail.com, akshit@mpiricsoftware.com
References: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3sHg13Fx2Ndh8t8zILSfgbwr-EPlMwGTginPrh8eN_4_1786693770
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 12:11 PM, Kalpan Jani wrote:
> The core benches a subflow via the "stale" bit after
> net.mptcp.stale_loss_cnt retransmission intervals without progress. That
> bit is owned by the core and tightly coupled to the RTO: it is cleared as
> soon as a packet is acked on the subflow, in mptcp_subflow_active(). A
> packet scheduler therefore cannot repurpose it to bench a subflow for its
> own reasons (too high latency, too unstable) and keep it benched: the core
> would clear it on the next ack, unrelated to the scheduler's intent.
> 
> Add a separate, scheduler-owned "avoid" flag on the subflow context, set
> and cleared only through mptcp_subflow_set_avoid(), exposed to BPF
> struct_ops schedulers as a kfunc (same registration and filter as
> mptcp_subflow_set_scheduled(), so only schedulers can call it). The flag is
> scheduler-local state: the scheduler sets it to remember a subflow should
> be skipped and consults it when picking a subflow to send on. It lives in
> the struct_group(reset) block, so it is cleared on subflow reset and a
> re-established path is re-evaluated. The core send and retransmit paths are
> left unchanged.
> 
> This is the "manage a new bit" option from issue #349, kept independent of
> the RTO-driven stale bit as that issue requests. Regular probing of an
> avoided subflow (#348) and any core-side consumption of the flag are left
> for follow-up.
> 
> Patch 1 adds the flag, the setter and the kfunc. Patch 2 adds a BPF
> struct_ops scheduler selftest that marks all but the first subflow avoided,
> reads the flag back, and schedules only a non-avoided subflow; the existing
> harness confirms the avoided path carries no data, exercising the kfunc
> round-trip from eBPF.
> 
> Tested with the mptcp-upstream-virtme-docker CI (auto-normal and auto-btf):
> all selftests, packetdrill and BPF tests pass, including the new avoid
> subtest.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Please note that the above issue was filed before the introduction of
the 'scheduled' flag.

I don't see the `avoid` bool adding more capabilities on top of the
other field, and without any usage from the core I think this change
misses a relevant point from the linked issue.

Finally the proposed patch creates a 4 bytes hole in the subflow struct,
possibly a better location is available.

More importantly you need to provide a meaningful working scenario
demonstrating a relevant use-case not covered by the `scheduled` bit.

/P

