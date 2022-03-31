Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5707E0
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 13:39:46 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id y10so28192282edv.7
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HVQgAAPoKsCh6NfHtd9NA4k44xj7rgmGl11lNwDGuFA=;
        b=JCCI2lHXsNwenfn+U35q7lgFOJ7FGb2gK+PR0oo9HERFlO86BwPk8WR+zH+NgM6eTU
         RcsfoTve19f6OPnwaHqorL0dOmu3ZN8cgzzKdZpXo044EsRVf0keyLUC0ztsX5IFKAwm
         /sZJU3m8XRMk9NFI8tWziTNv1K+bJyv75AuxG6qmj6WUux1N9gtXiwOoofmXarSnccAl
         hlreWQMOVLeajjoLpNSGy4sMll5FehJhWILMe1aKTO24amzbfGT+5x5dnYuFT32tlau7
         c2oDACiTzM017R2M9Opcdymu00HiOFFuuc0J2pvTU4DSIUmAD+EwOWHtW54fE8ZqrXMT
         BHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HVQgAAPoKsCh6NfHtd9NA4k44xj7rgmGl11lNwDGuFA=;
        b=E6tLjiig54ZM9gv67fgZCAos/8k+k5DncScfL0WpYlgxlsebb+r35NQ3JKGLRPoSaD
         C53wEsxZS40MoffOCO2Z0NrvqJG69/vWH6kKgNt2HPMmHQAv23YBnLSl0lT4MDfYg/wU
         D4MxfR/O1mPmdU8FHGNwJ3vSrYGS14qAishLh0Xn/bn8oUKS9vly93MFLHezA099uEbV
         CNuJ3PzOagITUVzMjhDLD3MNdDR89zGU+FvVbG8hEZz4RC+c+5E0jcKw6Ux+Q5NL/99/
         oMdJ0q9m8geia6Kequ3UMoFFVbNQ0M9jyM6JRdp252yppD4BmoIT2BWNx4oSvRxuvmTj
         3QyA==
X-Gm-Message-State: AOAM530H3WI8zbL3GmR3hD/GWkzU5em9BuuFNJLwDmc/Ugh9DqFc7KYj
	S+FBJiH8WjN1LA9n34N9pMVg5iTEp/m1CQ==
X-Google-Smtp-Source: ABdhPJzSYo7951mSGIbyeQlwVlEUaqCvSr4wpjcCmUUkvgjt8vxszEiiTpZhxQt5624wZLPtCo8O2A==
X-Received: by 2002:aa7:c58e:0:b0:418:f6f7:ccd4 with SMTP id g14-20020aa7c58e000000b00418f6f7ccd4mr16472745edq.132.1648733984344;
        Thu, 31 Mar 2022 06:39:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b006dfd53a0e39sm9427004ejc.135.2022.03.31.06.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:39:43 -0700 (PDT)
Message-ID: <9be5e69a-f4c4-603d-fa2a-c92dee1a387c@tessares.net>
Date: Thu, 31 Mar 2022 15:39:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests: bpf: test
 bpf_skc_to_mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <ee4784e6ba97d5b44994fcad328d4742b0f0ccaf.1648714461.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ee4784e6ba97d5b44994fcad328d4742b0f0ccaf.1648714461.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2022 10:15, Geliang Tang wrote:
> Use dedicated bpf_mptcp_helpers.h for MPTCP tests, instead of sharing
> with bpf_tcp_helpers.h.

Thank you for the patch and the instructions!

Now in our tree:

New patches for t/upstream:
- d5c86aa2ae25: Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
- 9a0c295c72ec: conflict in
t/selftests-bpf-verify-token-of-struct-mptcp_sock
- fcd9fe171917: conflict in
t/selftests-bpf-verify-ca_name-of-struct-mptcp_sock
- dc518d373c04: conflict in
t/selftests-bpf-verify-first-of-struct-mptcp_sock
- Results: 3012e4c62c2c..92bd3ceeef3e (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220331T133156
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
