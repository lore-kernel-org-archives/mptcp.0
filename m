Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D891F920
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 16:55:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f608ba2e06so818225e9.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684860905; x=1687452905;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21/wNpzZB4QW1BNkWfwsih5bn3hms5mNp2FoBsmiTro=;
        b=V0YrWrFw4OzZZ1RWo0ovKORByFjM2BZXMmwx2Jt5YpCHwHspfPXW3t9PM6FCv0G5h4
         IAP8omZ3+5V8BDqHl77ZV0bzzT77nCzjYp4j3RcvfKCBHC8Jg9TE3n/FJy86aMkOa0cv
         6nDsZ3nxmI2IogQ0FRAziiIxlazb88y80RNIa9yyPzCXm0CRN+QCw+Y9kKEHCAH/hWow
         y/890lsO3XnXxLiwQVEmjC5rU/gvpxqfxBS0Nu5qfJXO5kiWypPEQWFyvph4nx5Exg3j
         z5V7bEaI6Hr/fRv+rXIiR+/okRh8PLZD7u2cd0e9ibMgOWj33si0e7p97ZMSInTZCa4z
         EF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860905; x=1687452905;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21/wNpzZB4QW1BNkWfwsih5bn3hms5mNp2FoBsmiTro=;
        b=YypKCjPRlQznnbEfwCIc26rF81Tyk1KxdZ7Op49YklumPHn3TUPlGiflzSb3UnYpF6
         Unsr2+n/jLClC9wRQrNa3D+4GbvmLmae20emusSiFKUaw9vvar5goTnSCKxcDBah6Cnk
         DCEXLYPpnOCLn1wai4jxA2B/9VJS//a6+okIT9I6nONb1cnbK61CvfY5gqbrI20xCA0d
         ePkzI2fvUdjGu++5F6yPrYxlpNFsv1HtJ+tAfM83vBQw+KAcH/qhAcluCos0jwAQkGAH
         4QfZVgsPWTDvjtmPB8I1Q2UpdhGfRMobwf9gtAjcDSQlI0yaKKJcwGycE3OE4PrXPA/C
         W4UQ==
X-Gm-Message-State: AC+VfDyRrOmPvYp9JTU9Z2v1s79UvIOliKK2TmMkraC5V+/r8gwE+8ch
	OUkTRqPjzp0WjE5IaLOA/xTazA==
X-Google-Smtp-Source: ACHHUZ40fM690QaCKDpTXtsZPbHxIHuohvV8Tg5rLelwWzibKPv4Jk5/JRSlhyjVT9jIgDNkDZ+pvg==
X-Received: by 2002:a1c:6a04:0:b0:3f6:c8c:7048 with SMTP id f4-20020a1c6a04000000b003f60c8c7048mr2037021wmc.20.1684860904855;
        Tue, 23 May 2023 09:55:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id d25-20020a1c7319000000b003f4ddde398csm12701652wmb.21.2023.05.23.09.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:55:04 -0700 (PDT)
Message-ID: <c89568ea-37c5-5e64-2a5b-1ef810f5e4a0@tessares.net>
Date: Tue, 23 May 2023 18:55:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684763196.git.pabeni@redhat.com>
 <7caed74486cdeec1c929cd2b62d3f04dd67db46e.1684763196.git.pabeni@redhat.com>
 <ee0d7408-4b5c-857f-10eb-02cb1162b5db@tessares.net>
 <1f166b0fe5d7d79682cf8bdc398c7638e1a52a72.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1f166b0fe5d7d79682cf8bdc398c7638e1a52a72.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/05/2023 18:46, Paolo Abeni wrote:
> On Tue, 2023-05-23 at 17:31 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 22/05/2023 15:56, Paolo Abeni wrote:
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> Do you mind motivating the addition of this new socket option? :)
> 
> Sure, I will do.
> 
>> Also, it is not clear how we manage the different size for struct
>> tcp_info and struct mptcp_subflow_addrs but I will look at that in more
>> details later.
> 
> This patch does not allow for different mptcp_subflow_addrs size. I
> hope it's not a problem??!

I guess it is fine, it should not change. But then it is probably better
to add a note in mptcp.h, no?

The alternative is write something like:

 - header with the features we want + number of subflows per feature
(and the kernel can write how many were available)
 - feature 1 (tcp_info):
   - mptcp_subflow_data structure
   - tcp_info for each subflow
 - feature 2 (addr):
   - mptcp_subflow_data structure
   - addr for each subflow

So we can accept multiple features and we can pick what we want.

Just an idea, maybe it is not useful or too complex to manage.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
