Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D72FA47
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 19:05:07 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4839638a12.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689879906; x=1690484706;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDHKn7SWoifpe5DB4D2y2DD1YBBdAlYzmtCOd8erQ+k=;
        b=pZs58JbhujvAdFdUXhi1hRkTDPQMIOZuWSa9SkngRlii8TT+NnAnuDQp6toFEzv5VL
         DnTVMkdMYsh5ypXms61VCJ1OdPoRKmJxhzhHDiwAwn41dkKIinDY1AHY2m+vINVRlETO
         Y3xXffwLMCHdy15XxWzpuHnst+mbtvgACrPdg9tp9KivStcm7dxwWt5J3ZuO6xqr+gkw
         RjudPC1Lb4zdgeGGq8hqYpLcRILUrMV9h+ydk98JD7Kz83kICf7FtjdpvVl3hsG09GM5
         wa96i4mGj5I7A4VziScdMEalfwUTG9/782MuoaH6c6SiV9dfBKdRmtJJH1gLWMBnlm82
         pV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879906; x=1690484706;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDHKn7SWoifpe5DB4D2y2DD1YBBdAlYzmtCOd8erQ+k=;
        b=IoGBbB5hs+WPccHzl4YeiM7GrIh9da7+aBhYCevPZ9HASBTsP6R+NK74NSaAsxxUPx
         xxboeBHzapF1CEAMgB2zNf1p1jmjzsfLUqqY51qSJ8Q6wiDPff8kHT6uKObe6ZO20Nf+
         BhdwVsHK9iqh+9Y6SxCMXRNIWf3UCTZT6ZDkiXkWdCC7cNwRTbQ1v9vr43+zeczBGHmc
         /QnWEz2k/F8uZT0CiaRayUFewBm/cuMIUpPTFh9F0wjVrzhNtWtL9UU+FjZxGKXKAwrH
         H/+qcP27I+UVGrto6YO4FQEMNwCSfqYZYD53W5hqhX/TQqJY+RAAP+3Z41VrqIZCwEXo
         a3Ag==
X-Gm-Message-State: ABy/qLZHcxlo/2rpg4k2Fzhbw+oEBaMtpl9BnOMn4H+fYX71LS5hDmJw
	CGS1u8TQi86AldQiF9y4w0RWIw==
X-Google-Smtp-Source: APBJJlHkwBpG8lmzTkAW55Vy4BPcT72GCunCyGRWqefDPbhiddoBSwDL6fkg1c47kbq9jJwl2E02mg==
X-Received: by 2002:a17:906:9f25:b0:98e:2413:952f with SMTP id fy37-20020a1709069f2500b0098e2413952fmr6625406ejc.18.1689879905820;
        Thu, 20 Jul 2023 12:05:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:82bd:30b5:d889:7e87? ([2a02:578:8593:1200:82bd:30b5:d889:7e87])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906a01800b00992f2befcbcsm1060312ejy.180.2023.07.20.12.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:05:05 -0700 (PDT)
Message-ID: <2419f14e-a79a-0d2f-30f8-4825975c3a36@tessares.net>
Date: Thu, 20 Jul 2023 21:05:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next 0/2] mptcp: subflow removal follow-ups
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Christoph Paasch <cpaasch@apple.com>
References: <cover.1689834758.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <cover.1689834758.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Christoph,

On 20/07/2023 08:34, Paolo Abeni wrote:
> A couple of follow-up to the recent refactor.
> 
> Patch 1 address the serious issue reported by Christoph/syzkaller.
> Patch 2 is just a cleanup.

@Paolo: Thank you for the fixes!

@Christoph: happy testing :-) (thank you!)
Do we already close some of the new tickets that have been opened two
days ago? (421+)

> Anyhow everything is useless untill we fix/revert the tcp induced
> mptcp breakage ;)

This has been fixed so I can apply these two patches :)

Now in our tree (feat. for net-next):

- 9fea9fa43aca: "squashed" (with conflicts) patch 1/2 in "mptcp: avoid
unneeded mptcp_token_destroy() calls"
- 1a98012d684c: tg:msg: replace commit msg as requested by Paolo
- cf229e670d26: conflict in
t/mptcp-avoid-additional-__inet_stream_connect-call

- 8c64a5490e5e: "squashed" patch 2/2 in "mptcp: avoid additional
__inet_stream_connect() call"
- 04f57dcde15e: tg:msg: adapt commit msg as requested by Paolo
- Results: 6af60b285fa0..528b797b3425 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230720T190202

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
