Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C58F6A
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 13:59:17 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2832048f8f.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687787955; x=1690379955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmDFcpDCQnGTjWnsw7zTM0du5TTOwHlC7cuIqerPw5k=;
        b=X21h8D/NIiDS3F6lTdnRWMAhNcUy2VJ2KgD9hUEmBvrSivfr1pxRV8elAX4gJaeNXU
         LQNtuQgCaFzv0Uf+dXSSSpnjo28/N2WiOs2H4ba/WGtIHZMDteLTu1XFc8+GHua7UTPB
         mjjraJN/3YYKbdv9w0EQtq9jj5Byvv0kfA4WDxsQXzZIQ3jKhhgbkx0aJm6m2kLknphq
         X3CgjpanYq56mv9Vjjg9jtMyO8flQw4zMiQz+cfV/doJV8Rko5KXIMDJZQGnJ2+SnGys
         +TmtWdvNpv7W5KGB4h+GXOfFG63ZBSA3PuesQNEPSvO6x5hW0mmU2iG1gFsXVJvkF0yk
         DdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787955; x=1690379955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmDFcpDCQnGTjWnsw7zTM0du5TTOwHlC7cuIqerPw5k=;
        b=OjmTiRncazMZ7GwgNftfpPGWDFQbCg4vlD+A5M1yZhVDr8GBUHYuQLLyYDFS/eOeoj
         qGTE0ytKd6Inw2/SyZtH9LqDNDJv1v1iEZtB0xtcE9/c+wena1N0ZU4DyiI24gSkFkoU
         55YLyUMFPQQxnTp74jyw6DafV6T4d5oCalbZgb+JCNO2s9o9ARzjbM5pi6x/GKEmwHoK
         Uh80DHEOy7Koc5GNfM1Sf4043L1toWiDgtbKT9ndYop1CXRP3cR0M04xRsEWF6Z/Bm5O
         znFrxcUNYnmPY18Xld1jNcsslG06I1x+Xjj9V/X10LNQ1HkswisiC+hcjyiGT1zbx10C
         A7+A==
X-Gm-Message-State: AC+VfDwA8TnvOyPAs8WawttamD4COA36L0ceNc1SJGawT7h+MzdvWdVA
	6M6VTPnShimDXxJjtklFM064wmdxDjTZt8F0rHOXhA==
X-Google-Smtp-Source: ACHHUZ5k2IhkvVKHXDFXGUD5FKU3nNGSrFOvlWKIIzO1GraP24/KG45mcctz9t6cbZ/LNTwLw6eU4Q==
X-Received: by 2002:a5d:68c6:0:b0:313:e952:e500 with SMTP id p6-20020a5d68c6000000b00313e952e500mr2962884wrw.7.1687787955533;
        Mon, 26 Jun 2023 06:59:15 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0031118d80246sm7458419wrs.29.2023.06.26.06.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:59:15 -0700 (PDT)
Message-ID: <af0fb740-4b70-5a2d-0349-49abc1045239@tessares.net>
Date: Mon, 26 Jun 2023 15:59:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net] mptcp: ensure subflow is unhashed before
 cleaning the backlog
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/06/2023 16:51, Paolo Abeni wrote:
> While tacking care of the mptcp-level listener I unintentionally
> moved the subflow level unhash after the subflow listener backlog
> cleanup.
> 
> That could cause some nasty race and makes the code harder to read.
> 
> Address the issue restoring the proper order of operations.
> 
> Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 61f0a42bb0c0: mptcp: ensure subflow is unhashed before cleaning the
backlog
- Results: d3dabc07c83c..4303dba6139f (export-net)
- Results: cc9edd912a76..3b62cbd7cc66 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230626T134743
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230626T134743

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
