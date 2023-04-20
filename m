Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD78F44
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 17:05:39 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id ay3-20020a05600c1e0300b003f17289710aso1458894wmb.5
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682010337; x=1684602337;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCxOzbZUOIFFtdEzYE5SVQBqMHkyJKEgWebsP7We1qo=;
        b=LQexlinPECyGvIBl+CNCZarV2Fbc0b79l3BwRI7e368wgwxGb28DmnENeFkLnbgDho
         unaOQffLbkbgrxksF+YRlgl7zVGprg4Yp4xE7u/YvvUqmGNuxRmcMwRVORr81/qvnvT/
         kYaEecZQ6Kte9V7vii9mz2lmR9Ll7HarVQvunN66H3zWfU4CoX5vtnp4KqtEZ5GxId3J
         reGxPeQbLF3dRzAhQEKWeznL2DRCJo06hPpBZJgy3Namz38CU1+sXlARPFO1VI4Wa+FY
         ACXvP1wcbMJbUxi8tjKZe5eHcCl20MDlNRLrMdKDJvhzcsZ2vC0WxuedmpDmq9fVscMB
         9bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010337; x=1684602337;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCxOzbZUOIFFtdEzYE5SVQBqMHkyJKEgWebsP7We1qo=;
        b=I1gavHqjR6BfzbfvLaZpRE+aqBZS2ZfWhPs/++23Z3gzF7wuLl7l0WbH6rhF9KMxvA
         R0lhV3CTRR2gJTLC4+mIo1Qx2yWtCA2kfXPb+vuWBnWSK4gBIuIWzjsa+EJnBF8s/CWr
         Ep1V68l/az67qYm7vsOIu0Z/eNg+fPvllMAwes2oUOP2Tv3upa4jt+t5roY/90276Rr4
         o86owUTs0V5z/1iNy2458aU6VPE4M2Jp5V23QVXplNjAuMVvgi6L9kokXeCO2ER7X0r+
         32B4AhmzI08YpxGsKpuc9XQIisANH8DOvA5CNJn5IsnOHLIvt6HQSePdLnZiFjIO++iZ
         ucTQ==
X-Gm-Message-State: AAQBX9elCxayTJiUNU5OFdakdUcPwPiovFUBVkEyByeUXkMvWwH92PWT
	IsuC34ltYHimaN2/YKssk631LAeZbMYRURmPUT3i6VzH
X-Google-Smtp-Source: AKy350bCJneqUZPGLFQqGGz3gkvsT5O1Ag51hAUFGvKpcbpfbzh8BNRCIk8MmyvsWTP2+ODG5JiB8w==
X-Received: by 2002:a05:600c:21cf:b0:3f1:80a7:bfb2 with SMTP id x15-20020a05600c21cf00b003f180a7bfb2mr1830144wmj.32.1682010337513;
        Thu, 20 Apr 2023 10:05:37 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2c80:31d2:9220:ee01? ([2a02:578:8593:1200:2c80:31d2:9220:ee01])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm2561594wmj.12.2023.04.20.10.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:05:37 -0700 (PDT)
Message-ID: <f7aec0e5-56f3-695c-110b-2e44cead3a01@tessares.net>
Date: Thu, 20 Apr 2023 19:05:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next 0/2] Squash to "security: SELinux/LSM label
 with MPTCP and accept "
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230420161957.664328-1-matthieu.baerts@tessares.net>
 <f63b8cadb98db9fe7eee556207082f6c607874a5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f63b8cadb98db9fe7eee556207082f6c607874a5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/04/2023 18:40, Paolo Abeni wrote:
> On Thu, 2023-04-20 at 18:19 +0200, Matthieu Baerts wrote:
>> These two patches address the comments from Paul Moore on the series I
>> sent yesterday containing Paolo's patches.
>>
>> Note that I used 'MPTCP socket' instead of 'main MPTCP socket' as
>> suggested: there is only one MPTCP socket owning subflows (TCP) sockets,
>> no main MPTCP ones.
>>
>> These patches will likely be applied on lsm/next after the next merge
>> window:
>>
>>   As far as potential merge issues with netdev/net-next and lsm/next, I
>>   think we'll be okay.  I have a general policy[1] of not accepting new
>>   patchsets, unless critical bugfixes, past rc5/rc6 so this would be
>>   merged into lsm/next *after* the current merge window closes and
>>   presumably after the netdev/net-next branch finds its way into Linus'
>>   tree.
>>
>> Link: https://lore.kernel.org/mptcp/20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net/
>>
>> Matthieu Baerts (2):
>>   Squash to "security, lsm: Introduce security_mptcp_add_subflow()"
>>   Squash to "selinux: Implement mptcp_add_subflow hook"
>>
>>  .topmsg                  | 15 +++++++++++----
>>  security/security.c      |  4 +++-
>>  .topmsg                  | 13 +++++++++----
>>  security/selinux/hooks.c |  2 +-
>>  4 files changed, 24 insertions(+), 10 deletions(-)
>>
> 
> LGTM, thanks Matttbe!!!

Thank you for the quick review!

New patches for t/upstream:
- 606a5bfd97fb: "squashed" patch 1/2 in "security, lsm: Introduce
security_mptcp_add_subflow()"
- debe883ebd81: "squashed" patch 2/2 in "selinux: Implement
mptcp_add_subflow hook"
- Results: aee6812b6fce..f2f9d7ddde6e (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230420T165933

> p.s. no formal tags, it would feel strange acking patches I co-devel.
> Feel free to add your co-devel tag instead.

I don't think I should add the co-dev tags, I simply applied Paul's
comments :-D

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
