Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4C111BE
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 10:29:24 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bd1d0cf2fso275249266b.3
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690540163; x=1691144963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQu6Jvwpq/GGrKWyeLnBsxN62z0o0jvgcvGGkLRatmk=;
        b=PLzW9yTUljezwiX63DbaddG82ABe+HQJoeT14C9Kmyis/MBFqBHuggwV9YlEvFbV2k
         wwzlPYvZ7FmFWo6nru5ggjIvGmWkx7GeV8v3BPSpREsMbKRDkUKvS/RIy9RHdJnwtW5k
         KQ2O3GteEK1H+dyiKA4bV3WzyyFRkQzy+ZJ7LKC0F6C9xZOeWnCHhJPWU4B773KTMpvS
         0LRWc9+otpzEtGLTJhHdWP+CQtjlhXrl9vWjyAMDAfWRljjcfdSgoQZyEsl8cXXDymqz
         TI/eBOewSXMVH/oZDoGW5zD9ntPKfvV0Y9kwvd30JUpXDJrz9n40e+OL8ZLgfRXm1VXL
         VnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540163; x=1691144963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQu6Jvwpq/GGrKWyeLnBsxN62z0o0jvgcvGGkLRatmk=;
        b=FvS5d767txPA3WAsM1g5uWaq1VEgtfMtJxih1ZxFRe60GOHqCW8JzqaBt5TqORa8Qe
         mb7K77kjE9t965BoUJfHWsYoX0pVtBUJLUNQbwMZQO5hKz8oO4003JjwbkqyESweY6uq
         zbkUX+iqeGgXgzQ1HP/5yfkVaGt7H/NsA1/u08BK06boE4bxrGRVWLBnJ8LfiU8xsI1r
         Fh/jOzWjButfPvw7UDERDsQyE47jfxXTBbIj2Ujv9XuN9KpHn7naiAEqAd0HKgxu5+Sj
         RKdK5IphW61lOENyRjavxUcZ7+BAAI/9bn6KfMBXzGETPupnzRzYeW/aHPaOdUxdLaPP
         oNBA==
X-Gm-Message-State: ABy/qLZNYlAts8d4il9MWG8Df/UxiBUiWJdPlzIrj5S+frU+3zBKEJmP
	FEjKL65hpEgzhUb05MFKHG7BFQ==
X-Google-Smtp-Source: APBJJlG+UcX7aLUaQaYT7JLfWnHBSQ/XwA30WJCVTlPKpx9bcmHQVliT+ejDLX24U64mvvvNghQCjg==
X-Received: by 2002:a17:906:3044:b0:992:a9c3:244f with SMTP id d4-20020a170906304400b00992a9c3244fmr1727269ejd.4.1690540163013;
        Fri, 28 Jul 2023 03:29:23 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090668d600b0099251942e1esm1849834ejr.119.2023.07.28.03.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:29:22 -0700 (PDT)
Message-ID: <9de77983-c553-11b5-3fc2-08a60242803c@tessares.net>
Date: Fri, 28 Jul 2023 12:29:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: fix mptcp_join test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1690454072.git.aclaudi@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1690454072.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 27/07/2023 13:08, Andrea Claudi wrote:
> This series fixes two mptcp_join testcases when using ip mptcp:
> - 'implicit EP' fails because of:
>   - missing iproute support for mptcp 'implicit' flag, fixed with
>     iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
>     flag")
>   - pm_nl_check_endpoint expecting two ip addresses, while only one is
>     present in the iproute output;
> - 'delete and re-add' fails because the endpoint delete command
>   provide both id and ip address, while address should be provided only
>   if id is 0.

Thank you for the patches!

Now in our tree (fixes for -net) with my RvB tag and the use of the
right Fixes tag:

New patches for t/upstream-net and t/upstream:
- 5013654dafcc: selftests: mptcp: join: fix 'delete and re-add' test
- b2b73765f521: selftests: mptcp: join: fix 'implicit EP' test
- Results: 401d3a99d2a9..be9e061da26c (export-net)
- Results: 570583e20711..c4e88c45e27d (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230728T102732
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230728T102732

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
