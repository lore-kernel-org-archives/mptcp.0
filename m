Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D23AE193
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954256; cv=none; b=KDOEcOZGHPuKkHcoENoEhjF3WavMBP2qDr4Wgw4K71HSeDDr4KTon+MMGqRmln2x9LEt6rcB/u5n5wPPiYMb8T5UfCd7OifO9bB3R76NbWL/cYK3aR9EJwXSV0mFT7nOAwvvli5FxeBOjC9Q7WKThrN5QFVKj3Bft0nghL4THlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954256; c=relaxed/simple;
	bh=RQ/HYRjU/ImxAuRKRbdgwlfE1gosTvjvsLja1iX+LOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S8KI2yotzotiq2WJFnvAACvK3AXuCNxtWpCcopD5chBDIiTuKuSIa+PFD1xshyMA/JhV4VKHDmAgEGppLUQbib7tbvtdgUop0Nx/L52cSwCz/HyqXapvra02OgtN0XEN1bFXEB2NpS2IEHACRf6rNpUiKPoUiF8+2e743/m9Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkhV20XN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkhV20XN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786954253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDBf2qiKG8HIIf5ENQQhevmo0/gK5A/G797MbRj3sVA=;
	b=BkhV20XNpfSbLwut8I/4pj23v1ICYxla7w0QpxEIZNc8hhTLJFKFlJY09Xf1rk9rQBu1vR
	PyFO1mVnq66S/Ed+sKy6VlZbG6dlT0jsQ4VWfMjkq4h1H4lscYRzmnf1dehF6r0jRBq0RA
	rOZiO3wQ2ic7fLiDYx7vWiBTq0JAcVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-PhJqQpNaPSazhn6-CeNC0Q-1; Mon, 17 Aug 2026 04:10:52 -0400
X-MC-Unique: PhJqQpNaPSazhn6-CeNC0Q-1
X-Mimecast-MFC-AGG-ID: PhJqQpNaPSazhn6-CeNC0Q_1786954251
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83450a8eso2486477f8f.0
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 01:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954251; x=1787559051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDBf2qiKG8HIIf5ENQQhevmo0/gK5A/G797MbRj3sVA=;
        b=SYGPOabNFec5WK+LbBLjDsJ3Uuamm/W3ggHebWNQAJk2czPaQ6+Z6910pM3Kz+erp/
         zNkdpHcRYeuaX70CgYPJDt/OE0fyM7UCIQUFAa8Os/L6xzoInzy6jkUDvhSwUmoSaDKq
         RE64VoNfVlKWltn7yC2nJYAA/6Kidbvx1jKSYZYrw6nqycMtLAvXj1DbZEyZeo3aOanM
         VogLbmP2LsnuTvn8ogh5fosAIbU1TojZbcjJDERHqtwJKRuVArq71k5DOSXRJxlK6dom
         GKYazQ0n+WfxBD/6SnZXbfhMh/iV1fK8GmpOXVxLTBH4dfQgHaGPScN7jiZBpaShaOCd
         ZUaA==
X-Forwarded-Encrypted: i=1; AHgh+RputCeNYDi4YkOcOBEQfSRYWCzGEvUtBAJiD9j+jr3YY59Muz6HuAqHLYTDrQiU0G4B+vj4pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK+QbmMTxXR2uE8Zgvj2Yq+PCZQd30mG44MuPvhJ4gN7TcaKh/
	DXeBwwa+a9ozgXTQWRYzivR21INiG+hJKEX7nDk2hI6BdLSHDSZ5i/hta7kP/6nlCKuaKcH6kTb
	aj7EVwuOfkML8KIwrv5ch74RSqs4v9jl6TOouu2jL/q3ev3+JLab0mbRt
X-Gm-Gg: AR+sD11WJNq+7Qq3cSz0uPzj/vE2DoEFYSQfISzNLqyyXFGJ9rtrw6pGeNNIgDm7OQs
	xaGlLz52A9+7dyaa7THicqYt2q6hBKExAke2Uk3+S7/KgQmJNT9ylM8zVI7FOVR3rzgAAA4Lu9Q
	1rlB++/Qoa6LJaQ7v/4T64TzQyyj9dkfYVWG8N284QVC5u2Oi0yoqSIIoc5SeRECOEpBx0537ZC
	WSAhvjxp9mCKA0z3oJ6B9OqePGYiCT8DnOvb5txcqKuQclUiW/+ILyQN1mz1AJRSXQQONUinVfe
	ucbxHC8R9hq1mnkBiKOqmZi0E1hNpmU1wUpc4AUxva6SHSyTA0/vXlvlyIAjg6Qk98qJWG+gqE5
	XTkHcSM45h6YoJzrFf72rHfoj4mPw7JjhzZUgkZbLUjATAh5RMlc5oaqsiXnz9Vetgk8ONNyDMU
	M=
X-Received: by 2002:a05:6000:41ef:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-4816069d0ccmr36468768f8f.0.1786954251101;
        Mon, 17 Aug 2026 01:10:51 -0700 (PDT)
X-Received: by 2002:a05:6000:41ef:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-4816069d0ccmr36468694f8f.0.1786954250731;
        Mon, 17 Aug 2026 01:10:50 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b660sm1925721f8f.15.2026.08.17.01.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:10:50 -0700 (PDT)
Message-ID: <ae6ed7ab-1e3e-4b38-bcc7-a98307c91f0a@redhat.com>
Date: Mon, 17 Aug 2026 10:10:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
 <b8ac43a1-d5f1-4498-8aae-dc87c2e3b437@redhat.com>
 <a11eca34-7a65-4023-94a3-9ca9f5cb8490@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a11eca34-7a65-4023-94a3-9ca9f5cb8490@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p9gdVaulumuZURKh9yfm6PAlofDqME0PYPB_tB4Fpq0_1786954251
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 7:15 PM, Matthieu Baerts wrote:
> On 14/08/2026 18:44, Paolo Abeni wrote:
>> - Can we avoid the pipe? with something alike the following:
>> 	(void)system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s *Tcp*
> 
> Oh nice, I didn't think about that. Yes it works except it keeps the
> header (#kernel). Maybe fine here, but we don't change that in the .sh
> scripts?
Changing the script is IMHO an unrelated nice to have, for eventual
follow-ups.

/P

