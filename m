Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AB1F18A
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:25:09 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-970056276acso688564066b.2
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686587108; x=1689179108;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dp/4wSKw1HKXpEOdTpYEhZlRL/j4iQMZOw1i/Lzgo8=;
        b=Rd/hZFwfQTZRHmoPqhXRBcSQSMNG5V0RcLJejeIPlu+gpMrS1Cf3BBkWBTT+WF7XWk
         drNuFyv8FvFehBuCb6egO/Mga6opo+P21jRGr4i6NfMjLJznv+YdKcOdQ3nF4exufyYO
         FsTe4p8O44T4qg47yNyQ08EKQUi6+lsZH9ZCuE/prrBWOmU+eR4q9Gf2nYlyZocIIOg1
         s3gqWkGWidRj7QpLDqDD68uLHRk4zLl3OYdQsDnPOtrbbUIvQ9o1b1GwmGKTrhi8EROY
         g4kQIRQ9uMzoHw54F8x0XQGNYL7hyFsAhruGPXy+F8O1RPyKDSAnV0zZnfkdl2c92FRX
         89Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587108; x=1689179108;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dp/4wSKw1HKXpEOdTpYEhZlRL/j4iQMZOw1i/Lzgo8=;
        b=OIRNWZdUT3UREVNByJ1mQcCymMkrOrYBXS9oIN0UqCKxsoJrQvM0if6u1JAtaBAvgU
         m3ADAySBVtGi7se9N/KPVVF1SitQnxnUbWtoSKYLfpng7R+QuVsKvYdSlKXj1q0sGbs4
         M6cYVktGg3WUBJiEbaGRUMCf8+XWq3ls1lrU6YLDgQXKi4d4LFe0NZ8fhGdb4GqATUe1
         1ya/qurc8F8JUiDlUli9liWQxbf/he+Ck8I2MPiEZezfr+J+Gv/gBmynrVfe3wmL2UW8
         hSHDZ5cpuG2umNUdbw8L0rhcHre3ejxPog1tU/YEIjFD47etfRwkyeZfOT7b6VViLYm5
         1kDA==
X-Gm-Message-State: AC+VfDwFsYP6VcGOnu+oiVk4Oddujp/s00su5/DoVhjuP9T1Gg6htQ9m
	UC5cPuOaaSUnKJw+aEIhnWSYYrzv9TDfm10X8Ug=
X-Google-Smtp-Source: ACHHUZ7GF1cNfBHOhBCecuHvxvCyJy1IVfYMx6If/y+giw0jUjoMqkUMfBfwdWgo8rND6qCX4eiJJA==
X-Received: by 2002:a17:907:97d6:b0:978:6be4:7efa with SMTP id js22-20020a17090797d600b009786be47efamr9107764ejc.18.1686587108233;
        Mon, 12 Jun 2023 09:25:08 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b009788d51e4b9sm5442250ejc.130.2023.06.12.09.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:25:07 -0700 (PDT)
Message-ID: <bfd70acb-53f6-4ffe-8e5e-d3fa43b901c2@tessares.net>
Date: Mon, 12 Jun 2023 18:25:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v18 4/7] selftests: mptcp: drop test_linkfail
 parameter
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686554287.git.geliang.tang@suse.com>
 <f48449370d0fe5de299db3c8ce1f543b7cf85bcf.1686554287.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f48449370d0fe5de299db3c8ce1f543b7cf85bcf.1686554287.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/06/2023 09:19, Geliang Tang wrote:
> This patch switchs to key/value "test_linkfail=*" instead of positional
> parameter test_linkfail of do_transfer() and run_tests().

This patch and the next ones look nice, it looks way clearer!

I only have a comment, shared with Paolo on IRC: it is about the commit
description. Do you mind always adding the reason? e.g.

  run_tests() accepts many optional parameters, too many. Before this
  modification, it was required to set all of then when only the last
  one had to be changed. That's not clear to see all these 0 and it
  makes the maintenance harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

  Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

(same for the following patches)

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 179 +++++++++---------
>  1 file changed, 89 insertions(+), 90 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1697b0b89d9c..bd23fba70361 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

> @@ -2178,7 +2177,7 @@ link_failure_tests()
>  		pm_nl_set_limits $ns2 1 2
>  		FAILING_LINKS="1"
>  		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> -		run_tests $ns1 $ns2 10.0.1.1 1
> +		test_linkfail=1 run_tests $ns1 $ns2 10.0.1.1

Would it be clearer to have this in two lines?

  test_linkfail=1 \
      run_tests $ns1 $ns2 10.0.1.1

(up to you, maybe it is not?)

>  		chk_join_nr 2 2 2
>  		chk_add_nr 1 1
>  		chk_link_usage $ns2 ns2eth3 $cinsent 0
> @@ -2193,7 +2192,7 @@ link_failure_tests()
>  		pm_nl_set_limits $ns2 1 2
>  		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
>  		FAILING_LINKS="1 2"

(this env could be only set when calling run_tests in fact -- maybe in a
dedicated commit)

> -		run_tests $ns1 $ns2 10.0.1.1 1
> +		test_linkfail=1 run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 2 2 2
>  		chk_add_nr 1 1
>  		chk_stale_nr $ns2 2 4 2

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
