Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6F7B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 17:39:14 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id lw20so40436408ejb.4
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Av68bdaXj6y1tf/Pcp1EeOwmWlbovGTlmYdZvahqlPo=;
        b=1sV8cguqQykFuuab/I1e81PZpMY5DXbOtNFKl/erHwzXqpyNpyjJB8jWWGR3C9B0Wo
         nSlqCR8Ovf43b5WM/xudq6vOwu7x00eL1amFPwSnJTZWobbD6dhZgrD5QcrDIL9cWIn9
         iNZMAZDa3e1BLCoEmzhBW2qqamC1SYsAx84WtHt6Ff2+4sKQz5VxxDwqNnN2SJH/JbBD
         jexF5CRZfAVKLcGDAtcu622qQTQAB6Ce5ER0q81fyssFOds192ecJSgKn3BMr6Kw+kIE
         hIdbxOX2FPAgmNbrNns4rP827JhTAbsEiVTF9SY+aKhnPWFsE5PzflrnEltGhXdykc4+
         lMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Av68bdaXj6y1tf/Pcp1EeOwmWlbovGTlmYdZvahqlPo=;
        b=swjFRfaprF5nsh84CsmOfuDk3ZWhaTC7MBqPBVn/ICwqsKMCi4AGEv1t8uUo9ID0uv
         D0AWyuwqunD5Bt6cMotcuW9MH5PLwkfTsBKV+zyjsC2Rpri4QVP6rG130HgO7t+2139x
         LwccaUhnyfZteOuRQOanb4BO7+7OM4G5dsOVDqI6r0+T582cf0bUPyZ53qP/Mge1dDq+
         m1xNrz+oxc2hCdBXGvxMjOm6jwLwBkF2g3vlxj4O0BlJ/D6aVgdkznjMu+kNNSpJrJRm
         DQ4WRzXMZNfKN4u9982OSNdxPlc3ShozYVKObgoBQJjY0O81/pe/jJ93TuMIx/IGl9wx
         3HPA==
X-Gm-Message-State: AJIora8CpxdDIbj/3GOK3ABoU08S8mfYKzro3ag6sxven2+eg4FTXw2p
	z/63JqZ0u0I57dRi70r0PefUoIZQZ30W/A==
X-Google-Smtp-Source: AGRyM1ualv19u22WkIHWqJ5Qsnd+ZnLWoxdLwFT1tiQZv9p0yAZvhHONu55CS8yttheEtzT4AidlSQ==
X-Received: by 2002:a17:906:c048:b0:718:ca61:e7b9 with SMTP id bm8-20020a170906c04800b00718ca61e7b9mr9960793ejb.120.1656610752667;
        Thu, 30 Jun 2022 10:39:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6947:dee2:2822:3dc2? ([2a02:578:8593:1200:6947:dee2:2822:3dc2])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b0070efa110afcsm9328637ejo.83.2022.06.30.10.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:39:12 -0700 (PDT)
Message-ID: <fb9cb01b-1e0c-da03-fea2-0f576de3c0ff@tessares.net>
Date: Thu, 30 Jun 2022 19:39:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-net v3 0/2] Locking fixes for subflow flag changes
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220629225327.657202-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220629225327.657202-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 30/06/2022 00:53, Mat Martineau wrote:
> When working with Kishen on the userspace PM, the locking code in
> mptcp_pm_nl_mp_prio_send_ack() caught my attention. The
> release-and-reacquire of the PM lock in that function was requiring the
> userspace PM code to grab that lock, even though nothing protected by
> that lock was being accessed. Patch 1 addresses this.
> 
> While investigating that issue, I realized that
> mptcp_pm_nl_mp_prio_send_ack() was not holding the subflow socket lock
> while modifying several parts of the subflow context. Patch 2 addresses
> this, and is not a drastic change since the subflow lock was being
> acquired anyway in mptcp_subflow_send_ack().
> 
> v2->v3: Fix build error
> 
> v1->v2: Based on Paolo's feedback, fix MIB issue with atomic context in
> patch 1 (tested with CONFIG_PREEMPT), and squash patches 2 & 3.
> 
> 
> Mat Martineau (2):
>   mptcp: Avoid acquiring PM lock for subflow priority changes
>   mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags

Thank you for the patches and the reviews!

Now in our tree (fixes for -net) with Paolo's ACK and without the
internal changelog.


New patches for t/upstream-net:
- 2ac39a576e95: mptcp: Avoid acquiring PM lock for subflow priority changes
- 1554cc2cec00: mptcp: Acquire the subflow socket lock before modifying
MP_PRIO flags
- Results: 1fc747ab56ea..3c88708b1aca (export-net)

New patches for t/upstream:
- 2ac39a576e95: mptcp: Avoid acquiring PM lock for subflow priority changes
- 1554cc2cec00: mptcp: Acquire the subflow socket lock before modifying
MP_PRIO flags
- Results: 223590507ff9..ce6114ac321d (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220630T173736
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220630T173736
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
