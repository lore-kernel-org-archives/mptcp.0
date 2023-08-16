Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01CFBFD
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 11:55:05 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31783d02093so5616152f8f.0
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692186903; x=1692791703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+0jj+wZ9Rz1CGnrPykMwsnOBbOjozayM+DmWuP9SF8=;
        b=71qtuPqHsB/gYegsLpmTfM8f43T8EfGgKhdvORGx9MyRGPKn+2PQNOKlF4ejbcVM6v
         nVtfwqebw8XCuym4GJja9nWvnOVX0UsH7xPdngJooEVBOZIwAEpaAyo6FnhPifoq2Hf9
         Z2+TNEy3CzueOdHDZAGLXaO1CnjqnVAo5lLslN/hp2snWSW5XGwkVPDV5/2r2vZ4cylg
         hyW73gC9efZ0kO6fL6T6r3c3u3KVOyGAOtZqen4X2OE3HU4Sw8wjZ01F0+/nAFHJqCfh
         n/aUe9pLEnZCHRxkFZqFLUKqT+FjPERn8o4J1xDM4qVpWt0KBbuo6GwRFqAvkoIwhEXd
         ROQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186903; x=1692791703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+0jj+wZ9Rz1CGnrPykMwsnOBbOjozayM+DmWuP9SF8=;
        b=Kc/0u9Axapf+X02d+ZHRhzoHtjR5mQo3qFfvMw5Hu55dttC3zraWTREoqPhyEuOIx7
         TxmuWtUZmy2UfXlf4/wM/T4/fow5mMgtpDDIOrfP1RMOmGOgyJgVZ0DbEZicRdGeA4AM
         8gwEjS7Fl0tDAVwe2rLvDDV/Fo5J2775XApx8tg72XNmv/tbcvf4ABxSTlXhPG+T5PGW
         2ZzsABdke9rsgzV+auuHTNLv22RCJI0lDOHO+aaGgph5d37s94r+Rv0i7jzQBuWsZ4C8
         l7cLt7GwMgG7168QtEIfuVUHnISz7f1DjwP8YxmNc1pYntQCsL+LtzbHmPVQWTCeBVQZ
         6PMA==
X-Gm-Message-State: AOJu0YztLrkJdlfV1SfeTYrx+o8wncpwSwmThJybeBozNoYdRgOm5WyF
	y97cfqoUiDQJZYGNzFC7oYGFsPzEICzweFzOSW8=
X-Google-Smtp-Source: AGHT+IHdRlkVNbngqcit07eVrNRHSjecAXwSOEnauEdR9XKtyR6jIm3Unm1ytt5h17BaNgNByS01kQ==
X-Received: by 2002:adf:d0d2:0:b0:318:e4c4:497e with SMTP id z18-20020adfd0d2000000b00318e4c4497emr1239021wrh.50.1692186903256;
        Wed, 16 Aug 2023 04:55:03 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8c09:b284:9ea1:cfb8? ([2a02:578:8593:1200:8c09:b284:9ea1:cfb8])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003fe2120ad0bsm23852296wmc.41.2023.08.16.04.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:55:02 -0700 (PDT)
Message-ID: <b2f50040-0373-4e5e-b4d1-f94c40e2f2b6@tessares.net>
Date: Wed, 16 Aug 2023 13:55:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 5/6] Squash to "bpf: Export more bpf_burst
 related functions"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1691036765.git.geliang.tang@suse.com>
 <644d34afc1b3b8d72b7c87baf099417d0be561ec.1691036765.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <644d34afc1b3b8d72b7c87baf099417d0be561ec.1691036765.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/08/2023 06:27, Geliang Tang wrote:
> Add "ignore -Wmissing-prototypes" for bpf_mptcp_subflow_queues_empty(),
> drop the declarations in protocol.h.
> 
> Drop bpf_mptcp_subflow_memory_free(), it will be defined in BPF context.
> 
> Update bpf_mptcp_subflow_queues_empty().

I also had to partially revert this commit.

Maybe "__bpf_kfunc" would avoid such issues reported by Sparse?

  #define __bpf_kfunc __used noinline

Do you mind looking at that please?

New patches for t/upstream:
- 11ace9718934: mptcp: partially revert "Squash to "bpf: Export more
bpf_burst related functions""
- Results: d30c287ad522..dd7fb06cb618 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230816T115317

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
