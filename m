Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967072;
	b=mLtPkGX8WTcy1zaAZAau7nIUzWnchs8RRHMCuHehj1siBMyZBPelyeitIgrtOFDcEH9j
	 u/nkBXt2Umg+s4EaetshXGxRxqJbMXs3kPW+Nm0aRyHJeD1HR4xgzI9HYxypyf+5N0TZx
	 8OWAAh+4uGo/Iv/yCyCFzu+AGmGBvIxaLNNAvcYu8STDo5/uloFvg7/ug3oxXcOaYFN87
	 4ypfWYPeR/SuiqtvFH4/nmGbPL5603BxD3uvKYRIq92qnDAJLk7yJDHd6z3OhCRTWmS5+
	 sbgShc0BzdXx1tx6KGbLB3aVdJeA0CJqhCOhV/pCj59C+SkAnLQGo58FFdWwjuUPn3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rjqAw38vPbGQvqmUsvw0Y7hLEWvwjcXHb3HpAqnEm08=;
	b=y8XnH0jNv8n1ZnSUmXWf9S5de5Aj5FUH7t7KWyNGvNLjv34HvlDzMO3EkC3A9HVr3PhP
	 C+/j0V/LuR8SnNpuopBnJXJvCPTqrdV2tQzux4eHnekUV44PU+sALP7IgVzzkyoSKqVAM
	 kYmI79VzoP8lIR68dg+vCKdRr52mqB+d76wot7p03Xc+RBFoSmzXEXOti1128jUHBq8Hc
	 D4met8s1QHP4UEzESQkVOwqYM57Fm0E2QlW9MzhHJFoqPhfWfF5T7xao+bHbvhgUEm0Ji
	 NPQt55WoKABLGDOk6tS6i4PuapEPxDEcH2qw7VxfuEQH8t1pnbAljRForgXFPqzzLLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htgherhq;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEA606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htgherhq
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso639353c88.1
        for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 17:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967071; x=1795571871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjqAw38vPbGQvqmUsvw0Y7hLEWvwjcXHb3HpAqnEm08=;
        b=htgherhqK5de04z8lCVWgrLJhRVDfkwn2KS+eumHAaqe0WVfxdw5EcTbEDnQ/+WrsP
         GViIAcP3fa3EubUUxIQwRp+zfWkuCA4vBJtnBAUvdvo6bZ1bPiM64Kn6IIiTVGphsE/6
         Z6hty6H655uHAmv3mWJltu+MK6FTvhMIcBZ03p5ctQ2FhJ53O/vza60DG/rtICkCnFj+
         GofT20mSSO+WWrB99+CWUlwKRYmV3m+EQHugnyjvlpmt5ZIVURxMZl5U8qjg8kXxSBZP
         RGFw3AxUGxZyhGVPY4r//yiChKAAAIaHrgYWYB5HGOcwTiduW5dYFCk9Po8iNVwqH9rR
         L3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967071; x=1795571871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjqAw38vPbGQvqmUsvw0Y7hLEWvwjcXHb3HpAqnEm08=;
        b=cmJZp/lJlZYDm1f1VbRIk9MC8ie7QyGm+jY/ZzEkhEWTNjO3py1DiGF4g8fIFCUbH3
         b6ORXAFYjApqboxd4QEb4/YEgqbnz53BAnD6tufYZTS9WhoU+Fprzs04yLFCPimOW1EV
         quRFIUeRugIyWI23rFKTXCWQ5bZbNuilkjbZo39cVr8zBd+vHtlxNBokRH3bAGyEt6T0
         ZqYSPfUlkgY5PnOAG4PbD574/vtQeQ4rk/sCPJjkuZuzav60BOrcfXI5/xVTJ/EXHS4f
         etfvIkDZ0kFUc8NwWhyK3RSHpEc6qL/JnzXcVimDN62Jlv5p1q0qwiAt+McNrPsZPYjn
         mN0w==
X-Gm-Message-State: APuU4Z8yHr0j1k4lqme93duhJ7VCDzDEGT3I5kYYRgbdnS7lfO0t4YHW
	AKn8hUpjkjtEexXUPGhOE7nN4nJxbrLhcHLKpT2iapYy2UuWSLPjeJ7fnPJ/jw==
X-Gm-Gg: AYBFou2xSi4o461cPkiBp6FNidYW0MgFGE/SWLtGoT5N6QG+SYophkvDzD9079krMfE
	65mxCSNMoO5yfiOXseym6z0IzjyXP9q9vKyoEk8/fhyiUEAe5vNSvyx6c0E16JLflxL/SXeHTPI
	fLrfNroHFOZOXtn0fIbHMhdDfRoJcjrJV0D9nVg06nTb4Mh2RexP/ygUT+H19/8zVcRyaP7iE21
	bwCYesMYuyEKLXkpirg0gtsnSaJ1vwuOqanmZNTWuq0pZr/ehS9DUyghipe9KB7IDUiT/ZXCRwv
	fL68J1k8CPv0lHqClVhnMAIPBVAIFapcZlmx/rNY8QQp1Fad9kaML0G26agkoQMgoMRFQUYBbq0
	S1rakT31qCI1H1x48+VcOrWxzUO4nGbQHTeP2jbeQcPLvmrppRxnBtWChqVNAEG+NsV/ZBP0ohj
	4biAyOE47c/LzAvVTl+alpecIMbHIRAdat84qklLhR26VLpAkHD1znyPuFmXmLCj9d3tcUAcKA6
	d/fFFZuj9okv7Twows5Kv6NXMVb2/yvAwNj69RN4BMKywxNsIQ0tshOssvC7gtfgTjDazMNbLgx
	db0b3g+jFlMraEXFYM5/TrQVAYoEK/vgLh7o30vYc2usWRkSQw3nJOuL9mqlY8ij36w20lMEIK1
	D3FVQ3A1oqNOfbw216KL2OceJXRl4Tm6VwGhLYUIYxs1RA6ku4oLlk2PwMDsbQN3BY5lda46pdw
	==
X-Received: by 2002:a05:7022:b887:b0:1a3:87c8:7efc with SMTP id a92af1059eb24-1b543d3f0fcmr1058232c88.39.1794967070344;
        Tue, 17 Nov 2026 17:57:50 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447811efsm2114046c88.3.2026.11.17.17.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:57:49 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev,
	anilkaushikwireless@gmail.com
Subject: Re: [PATCH mptcp-next v15 0/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Wed, 18 Nov 2026 01:57:46 +0000
Message-Id: <20261118015746.1766470-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
References: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
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

Hi Matt,

Gentle reminder on this series.

One question: I would also like to add the new subflow-retries limit
to "ip mptcp limits" in iproute2. Should I send that now, or wait
until this series is accepted?

Regards,
Anil
