Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E86108
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:38:49 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso1322113a12.2
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684489128; x=1687081128;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jyz86tKkdEio7EqoPXIIMeQ2F2EKBe591Fl9Ic2xio=;
        b=yvovI99BHQ8BZDkDuN42Bi+b1m/zHBqUEcl2PMleEI0noN/R4M8RZvCxZS0HTmiMBN
         UkPgVjnWBO35bRLGVNzRxcrQfYysIWykmNjrWZyqHj5t7KRrekgIFFDtpE1aeLjw2e7W
         h7ctps9uam3sEwA5ed30IJRWDIKR3IIcnsf06FK12A8Ymok13rRjYHXCHt7xCAM5dW1g
         YkV0YEYRqqsP419vaxQN01+7c3zmlzVA9oR40foDQem3JCq1COjPF+mTtIhtpf+gpCwy
         kzQ/Q8lugQiRQJh6u1QpU3QBWg5Y2gTmodtfsEFHNf4fpwn3PEGPeg8UE4WOXEVe7bmw
         dQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489128; x=1687081128;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jyz86tKkdEio7EqoPXIIMeQ2F2EKBe591Fl9Ic2xio=;
        b=l1HC/8EMhgr1uHPKpD2pdsftykdK0CPuvlXB6SeurdEQzO0xhpVHEw7VN9Fdylb+CG
         KXDf1gku09WuZdEd+j7AlQjifVAanaQ+br5SXV7k05Qv2rOQEqWR9rd+dDCgwKVyyas+
         DZbffN+DNDdshiOibfJ/STC4a3JfW6GGy3XmwoegACuSNvPX5Nzn/hxrSYTqDJ4HQ96l
         CxPB6LhE5LDZQQlr0jzhtrto2vrMNLlDpZnRyIsHMfP37G2un/qxXteQtJ7lfg1dJ45Z
         2o4Qe5Gh5mwBIfsBcNgTYG1jZ/9I8vz+9PTJKL1bScYBdKle6i67xN2SdkhpXOh1bVG7
         ZU2A==
X-Gm-Message-State: AC+VfDzBy61OxYJP17Nf06xFuzvcYVF+t2IZseJuA5/IwaGBxpQXyCxO
	zcHHNyT6onC7n1KMLK9E8ihOP1DezVhwR/swz2c=
X-Google-Smtp-Source: ACHHUZ5w3qyGWFbG7FYQtuwSqyJGMT3vvDFng3yJmQjAwh/wW4jYbjJFmV84n77TcLg5pK/AFIDYXg==
X-Received: by 2002:a17:907:a07:b0:966:3c82:4a95 with SMTP id bb7-20020a1709070a0700b009663c824a95mr1080719ejc.19.1684489128018;
        Fri, 19 May 2023 02:38:48 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d27-20020a056402517b00b004c2158e87e6sm1459594ede.97.2023.05.19.02.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:38:47 -0700 (PDT)
Message-ID: <52302b1a-1e01-e25f-26b9-8aa13b05fca2@tessares.net>
Date: Fri, 19 May 2023 11:38:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v4 2/6] selftests/bpf: add two mptcp netns
 helpers
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684362296.git.geliang.tang@suse.com>
 <c098dd4dd76ffa67dc4e5e7850c3838882f2a32c.1684362296.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c098dd4dd76ffa67dc4e5e7850c3838882f2a32c.1684362296.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/05/2023 00:29, Geliang Tang wrote:
> Add two netns helpers for mptcp tests: create_netns() and
> cleanup_netns(). Use them in test_base().

I suggest to add the reason behind this patch:

  These new helpers will be re-used in future other subtests.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
