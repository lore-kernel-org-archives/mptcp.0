Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F537258ED1
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084486; cv=none; b=ewz5IXz3YM111MTaOs/7k5OuXCXfC/WA+1NLTzUZZ6aLrzEiORdXHEa/s9BCTzdEmPflB+/M+gzCLd76feOb9CCH2wyLLxBlFXklCIuAycK29F71MAyds6toylWiWCg3cbD4Achz+TXPjf88CtgzSwIbH9uyiJg7WUuafy+7Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084486; c=relaxed/simple;
	bh=x8uSAw0JIa7F8V/C5xMZKtucx18B6WjhRuKysymhOes=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SouczR2tJeF6t0Kdh+Fu8JEQ5CQJMMH8StgbtCV+9ZitUQEBBUZqoeavNh2EqCA1kSW3AF2ZqKWshpV06QqGkiyVFknuEKncZx2HCcZGz7wtDJgyRjqRfKt1D23fJ3alnikgBJyLHrL9lytjp0hgKganrncmIkWrTCVfh7KBJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HE2bKdry; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE2bKdry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760084484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCL6bhO8Nb88/ZlOKaZn32lbcshkKaopvkravVW07Vw=;
	b=HE2bKdryd4I1qU2iNTkfHlHaDbn2b37Ez2Hadq3XZBoEyGqT/8tBDIuNxX8ttyCWybZLm/
	28r7xNatXPbG99b6pM/JfQsgqhPHn03PROA7j8zRButKI0OSsFn1TyIPqUoloxh3mq+VRG
	rCCT0KNxmlr2zZ4emtYRlCni2i8Hs4M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-1BR1v8AzNi6cuf_7LpePvA-1; Fri, 10 Oct 2025 04:21:22 -0400
X-MC-Unique: 1BR1v8AzNi6cuf_7LpePvA-1
X-Mimecast-MFC-AGG-ID: 1BR1v8AzNi6cuf_7LpePvA_1760084482
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso11420185e9.0
        for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 01:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760084481; x=1760689281;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCL6bhO8Nb88/ZlOKaZn32lbcshkKaopvkravVW07Vw=;
        b=oWZykIG9fnSXoRkEoTLQNPdDWYYJJILmK+WdijiuaYmWIY/tapm70pv3CAnXnTOaey
         mkLO0zSjeuv9PUGmt2fh8wRplb1BhguhQcjLUh0aF0JuRkyxpdzEHhkb08Y1pQr0yLZi
         sMz69VcJNI6jU9WlhREFj5aeCXvTy8tw8NqIb5YQGbEm0bN6uQNdrD5bJZ0m8YURlU8b
         h8olu9QSWOvNaEwapViP75dRpkr+83GAJJzR1BvdpNtd8ixPjAWJeTpQr+dGUWxLWaMt
         wMZ0xUSWfURhxGVCSL2R9TS2b/4mMRkCJMZh8/+rTQrWMDh1EafOiss6Ux3CK90eHIQx
         OaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUghT6v1LzAPy5oYj0a46MZpYSLwj/1O2nYvoPw+dz9AawzK5T1sescEFfUFdmx+8cHPR07BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyODtrWgru9UyUZ4l3Q23X6uXzqQTobIhxgEy7fMYTE8FGbeUtr
	UANeJrg3J7Is+HdZyAbhYO7oBHjSxaRO/OnU3YI07p/yF7LwMQKW1Mrwv4L7gYAklmtvL9ccW4/
	zql/7222EVZm9E8JGT1qBewlSGot4IYaCTVVIVVZDUUJDElhyt1utjFpA
X-Gm-Gg: ASbGnctH8A3DENq1UsUtgLzYcy9ql9DXmknV8beN/vYFMyIBddwZjQFJcZho6MV6UON
	N7xASHVfy7Q26yzlEfcUSOvky6s+kwgbVsuO9hFO8oGc9MFzqD0vscsArwCWvpFhhndt1GU9Low
	ufz345vBV7gDhsm5zze97wFduN7/GGDolgA9qDgle38yjNbTYHIzBZUUWgd3GFCvP23jsmSi1N1
	TaYOm/ZfhlyRTN88DUataqswRRYHaitva2YI6/2rDPC+BfuxgjrfmCZAoM19Mz79TnLYCISInOA
	Q1i2ebEN0XehJss9tIPPSiCbrwO0uoLVSp0Pdn0LbnHbzn/cgGzCDvh8gAf9aJBXcjlS83mD21t
	Z11Z37aDmfGsl
X-Received: by 2002:a05:600c:4ed1:b0:46f:b42e:ed85 with SMTP id 5b1f17b1804b1-46fb42eedfcmr19697655e9.38.1760084481634;
        Fri, 10 Oct 2025 01:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP42uZDe58VHCnZ4wRrYsTMYOjxozIEnkZmpoxtxm7gxQdrMkhBabGTCsJ1a0jQGGBKPybsA==
X-Received: by 2002:a05:600c:4ed1:b0:46f:b42e:ed85 with SMTP id 5b1f17b1804b1-46fb42eedfcmr19697445e9.38.1760084481169;
        Fri, 10 Oct 2025 01:21:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm2876203f8f.35.2025.10.10.01.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 01:21:20 -0700 (PDT)
Message-ID: <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
Date: Fri, 10 Oct 2025 10:21:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
In-Reply-To: <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BIKyvHIjc1xqkNomBD0nIrzW_4VO9_CV3Ev3ai2AWUI_1760084482
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/25 3:58 PM, Paolo Abeni wrote:
> @Geliang: if you reproduce the issue multiple times, are there any
> common patterns ? i.e. sender files considerably larger than the client
> one, or only a specific subsets of all the test-cases failing, or ...

Other questions:
- Can you please share your setup details (VM vs baremetal, debug config
vs non debug, vmg vs plain qemu, number of [v]cores...)? I can't repro
the issue locally.
- Can you please share a pcap capture _and_ the selftest text output for
the same failing  test?

In the log shared previously the sender had data queued at the
mptcp-level, but not at TCP-level. In the shared pcap capture the
receiver sends a couple of acks opening the tcp-level and mptcp-level
window, but the sender never replies.

In such scenario the incoming ack should reach ack_update_msk() ->
__mptcp_check_push() -> __mptcp_subflow_push_pending() (or
mptcp_release_cb -> __mptcp_push_pending() ) -> mptcp_sendmsg_frag() but
such chain is apparently broken somewhere in the failing scenario. Could
you please add probe points the the mentioned funtions and perf record
the test, to try to see where the mentioned chain is interrupted?

Thanks,

Paolo

