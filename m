Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E7846B
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 19:49:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id z4so8259721wrr.3
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5p6pgZnVc4WCZ07xlvj5WCB/cD22dbqg0E3bvAobOWc=;
        b=ZUwwjL7C2AO9JVuRT0Vp7iwRrUvBhdtJfphp/61oidG/SvICPRMSx8RFAIAWhoV7Jp
         pzx9IiIxgHuvIIJcCFuMC/kS/D+/+dSwp+p2fd4iJe3E3va3dgMgriVEWwiYXdJQxl25
         U0uuA4heM3sO71//u78yW+dv7mWr4321/2iWPvIPa2erOu69JzA3gv9hrY1S1jj5AfSN
         9YeK7+c9JX9pxQYZfWIQ4fB14nxps0nD0RpgGNt3C5d80ebnWqtewWpUGS6Qh9XOYivY
         MVvu6iveZ/pL1WUGH26VPFmqjXydGayhkBXBf2mNWeMDtBQxrtBds84KLIaKWYv3Xvh9
         Zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p6pgZnVc4WCZ07xlvj5WCB/cD22dbqg0E3bvAobOWc=;
        b=WVOp9a5dVQEg6QBfMNC0xNa+ZlkxSp3NCeuPvY5z8fenLpCgaWjI2yV0hfSZbvDTLu
         /nNKk827eSXO3nwn4yZPCoZDqYcm5JjYQMUtdKxjdTM2aj/eU/AY/ViFajNTTORk0YrJ
         W22tiBF/f1Eqk/XotpuLkJupIZoeZ7W0v02vgkbM70QgZ6F+nUg7dwy2B8uxyOf8UH9T
         eAkby1MsS/ZY696snpfeJyYtbhI05k9qNHXZ2HdJ8Uvu1XLynd4a9rpGwKUvsahMtIHx
         rTBrJkjyAo+eK+8NQo99MG602lz93fIgFfL7yPRdUy3z0q1o3SHkbirGLfoof1PryQGE
         rR6g==
X-Gm-Message-State: ANoB5plGwzWvPQMM2rJN7jUyx8gtYdvKkQbk/5F6tjGBPjgDueJvDBL3
	W9JPY/XlLe8ILw0x1p1GEKHM8idTrbQmTOg7
X-Google-Smtp-Source: AA0mqf7RTRF5O7KP2aLTbk3aqNCsamYsUDmAebuZxMGKiTYk706ZS3iyu0T3tFJ0EyWtsdAjuCIMxw==
X-Received: by 2002:a5d:6551:0:b0:236:8fa1:47cf with SMTP id z17-20020a5d6551000000b002368fa147cfmr25826162wrv.50.1669405756131;
        Fri, 25 Nov 2022 11:49:16 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:290:7ca:2a3e:9f9e? ([2a02:578:8593:1200:290:7ca:2a3e:9f9e])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00241f632c90fsm4971978wro.117.2022.11.25.11.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 11:49:15 -0800 (PST)
Message-ID: <2e8221b1-61d7-5045-6225-d198d1b477f4@tessares.net>
Date: Fri, 25 Nov 2022 20:49:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next] mptcp: add support for TCP_FASTOPEN_KEY
 sockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20221125145257.123844-1-matthieu.baerts@tessares.net>
 <bd8f3e4cbf84a3beaf2cd5cbf6f6aa0cb69c8d71.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bd8f3e4cbf84a3beaf2cd5cbf6f6aa0cb69c8d71.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/11/2022 16:16, Paolo Abeni wrote:
> On Fri, 2022-11-25 at 15:52 +0100, Matthieu Baerts wrote:
>> The goal of this socket option is to set different keys per listener,
>> see commit 1fba70e5b6be ("tcp: socket option to set TCP fast open key")
>> for more details about this socket option.
>>
>> The only thing to do here with MPTCP is to relay the request to the
>> first subflow like it is already done for the other TCP_FASTOPEN* socket
>> options.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the review!

Now in our tree, between "mptcp: add TCP_FASTOPEN sock option" and
"selftests: mptcp: mptfo Initiator/Listener":

New patches for t/upstream:
- 0525a935c675: mptcp: add support for TCP_FASTOPEN_KEY sockopt
- Results: bc1626baad5a..2deca8211919 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221125T194530

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
