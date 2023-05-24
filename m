Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3201992C
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 15:22:22 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so951832f8f.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684941740; x=1687533740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iDRiYI0iNSQL4R61x8ryTdUaPTdPd24KTyNKb16yLc=;
        b=x2qqBaH/nh+k1Ol123YXyAAxCI33x7uDRsFgm9ZmJ9Ql6w50lMthhYlBZ6s9mFNJe4
         cgj8SNZeewlCEy/UL8iM49Dg8xkJ2mv5jXGnvnfyuRRv7AATeg4hXYlo3XBRAuVIcBrW
         ExsSUsytIgHM75v89cVGYbOiCyxUZDUw7941l9IUi5CacJoV+7Hi84ePvzt7trI+R3D7
         thiZQmKPRXKLLA9whpl5q6ii5fiLNAR7ngGXt40vomaXMMtYeHEEAAofcngbHyhlXMj1
         XpOwLnFdlZSQinKdSzvClXS7KV4vic+JwLaPxzxNOQJf1//E3nyG07EcWiN9F6aDoUqu
         ia1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941740; x=1687533740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iDRiYI0iNSQL4R61x8ryTdUaPTdPd24KTyNKb16yLc=;
        b=fxxqpJT5UEMDUrSjAWEyYhdI1ZB3ck0JmgAWyweRh/Wte4REWWSjRC4TOLjWUW02zF
         ur5rcyDaf81KScnIarjRwPf+NATK6INA8UuQNuHoq6+J62DgnQchGoGDdH4SQDxIMaN0
         phbs2w2+FkS/eXvGwdPvVZCPp2t+19AHsbypM9AUIaR2VnNzdB3ZJ2TGKTfpCCG9Xrfs
         oCDpxxu/QOLBmJ0C0cB85t2f5sToKmioJf3DBLgHCbNo6kCsZrpigCnY1laoK5mWz/Su
         EyyebKe6heyCLf2W30fhe1AsQz2LEEDHyi+oMhi+CtZXScwsKlzFVKJp8dmBugQlyeRn
         DbBw==
X-Gm-Message-State: AC+VfDyLysPZMCacPmuu+o49c4jZL2LdFpmO+DCbkdbD0pBWM2rKSaXq
	eyNFYtSrFMymr6f4XCil6QfhD+bXPAB3V7Plof9kTg==
X-Google-Smtp-Source: ACHHUZ7GDvNzgnFTlj2uaqKAjVMFtey+Zc5i5FsQ2cuEkA4SkmcybW8f1RySdRPYHDT6qMEcpEgoeg==
X-Received: by 2002:a5d:6744:0:b0:2fe:f2d1:dcab with SMTP id l4-20020a5d6744000000b002fef2d1dcabmr102001wrw.58.1684941740401;
        Wed, 24 May 2023 08:22:20 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id e3-20020adff343000000b003048477729asm14800216wrp.81.2023.05.24.08.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:22:20 -0700 (PDT)
Message-ID: <ecc97177-6b51-2509-14e2-9d212ea69cc0@tessares.net>
Date: Wed, 24 May 2023 17:22:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO
 testcase
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684935727.git.pabeni@redhat.com>
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 15:50, Paolo Abeni wrote:
> Add a testcase explicitly triggering the newly introduce
> MPTCP_FULL_INFO getsockopt.

If you need to send a v5, maybe better to move this patch after the 2nd
one, no?

Patches 3-5 looks good to me and only concern MPTCP_INFO while 1-2,6 are
linked to the new MPTCP_FULL_INFO.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
