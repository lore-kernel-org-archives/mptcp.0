Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB2182C7
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 14:27:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3095b1b6e02so660148f8f.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684938453; x=1687530453;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7unRHo/kCLXey9B0y2lWJAoPJNB9dJ+QVZae0+A+YE=;
        b=HDqnMuZ5u5yuZBusHCZxs2giZRsUVG9n3KJ+z8xsTvvrrQ9L/dyZlEd35aiTgOSQEI
         4OYHmY9S4mY7cyQPndx68zM+a0ohSMPr23zfYJOQnyCSfjuaJTfsL9qFg7fnJy9eTUjj
         JuO7jXUHXQbv5RlfINfaihyZOBT/p7pb0cVsyyo9Hg7Q2HL2RLxraR4l0THqS4xk2zIg
         5ElVqFDHJapZB1+Sx7lj7eZkZHSF77j8FT2owK+P7oyF7UgwlGLxjjwJAP61+ATTZ8bm
         82ualwPB9p3abHPYc6Fdd82fKy6GMx0DCSjDuVuPrLP5OLMI83Dp5SrnKUg6vn2o7lbT
         oqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684938453; x=1687530453;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7unRHo/kCLXey9B0y2lWJAoPJNB9dJ+QVZae0+A+YE=;
        b=NQ3Irw/qDRZIop3W75jryUosPbYvFBYMP9dy7zyB1QstHSW5wL6nJeAS300bdbamia
         4sfki9JpDgvvpQc228G/cY7Y+Lf0SIGm4K/zwDEAM0Cc9//MxmxkJSHo9nmSl8UBwB/o
         SHv3j71jQmvF7tcVXM4rgw3KzbY0kTTd+kdRKONrQnTwHTX9iwzXybSWrJ9uC4qchSk1
         Z6ivprlzH8hrgRGWf9Q8+EHGH8ThxnJg0RMuTn2tpQ/xrDCn4/4oOXJGBkH1zLJXWgpF
         7WZj3DcqMSFfZcGTQzegA94Qb6kH77jSGFGxCyMcGv1GHGmRrQTe08AtMXKemrgnUoXD
         mDVw==
X-Gm-Message-State: AC+VfDxCiDlBYW1rDE9ALig8xkCWRyLNgcRUi2Xgm12s6EQJZK9wsFM4
	0mUL4vTITgSE4x92WKgL11Z0rGhzGj1RcsXwBZURdg==
X-Google-Smtp-Source: ACHHUZ6Avyh/kDWOEQh9azRlRM/b4qM7fWc8TveWcgibbAgSrF2K+628JdxRTe/UlBN/GerpKWf2QA==
X-Received: by 2002:a5d:65d0:0:b0:309:4ed5:b458 with SMTP id e16-20020a5d65d0000000b003094ed5b458mr11481361wrw.30.1684938453303;
        Wed, 24 May 2023 07:27:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id s5-20020adfecc5000000b00307bbbecd29sm14636871wro.62.2023.05.24.07.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:27:33 -0700 (PDT)
Message-ID: <69ac1616-bd9b-514a-bb77-c7371b573072@tessares.net>
Date: Wed, 24 May 2023 16:27:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 0/5] update userspace pm mptcp_info fields
 part 1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684915182.git.geliang.tang@suse.com>
 <b1c8500d-15be-38b4-c4a6-ac5c725d97c8@tessares.net>
In-Reply-To: <b1c8500d-15be-38b4-c4a6-ac5c725d97c8@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/05/2023 15:27, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/05/2023 10:02, Geliang Tang wrote:
>> v15:
>>  - drop "mptcp: export remove_anno_list_by_saddr"
>>  - drop MPTCP_USER_PM_FLAG_RM_* flags
>>  - drop mptcp_pm_alloc_anno_list in mptcp_nl_cmd_sf_create.
> 
> Thank you for the v15, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> I suggest to apply this series today.

Just did, applied in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 7b19c98c1195: mptcp: only send RM_ADDR in nl_cmd_remove
- c9fb355d4359: selftests: mptcp: update userspace pm addr tests
- d8a70092983f: mptcp: add address into userspace pm list
- ce75026f702c: selftests: mptcp: update userspace pm subflow tests
- 3a08dcee555f: mptcp: update userspace pm infos
- Results: b87768580a4d..a38ce6e2d547 (export-net)



- Results: 0a9978390b78..ba37a83b8dc3 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230524T141239
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230524T141239

Cheers,
Matt

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
