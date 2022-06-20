Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2552580
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:38:53 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id me5so22247936ejb.2
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pTBjQOu78C6rd0Ifhxhb6Jn9sL2SGJ8ZWNOB83K45NQ=;
        b=zz4Q+CsekLGgZ5XIRS/VMTcQQRglmUivG2jxU0vB0d1iet6O3QVV0+CG1HLnG//Jz/
         b7QbiJ0GROAQer8GhU2mupylikfJ1DZe9Ce9iDsZ+PCb+Sc64rOBczAfOyzid8NQMDzy
         caUhzNKK4KLAHWOYPjK8tGajxjtn/R0QH6p1g2JagWOc9RXTGSeo7pg+exy4MC0ONM7u
         XS7IMc16nfFoL8z2WbUKgQtiEcHhPIQuJI3Kdn8/asjFxv77q+CTU1EC/GTSCVOzb0IB
         OP06H9YxJhrR2J9jUsly2l0lvAzE0NowkHHAxt6gdyERLIpQo1NyBC+gIJ9zz1A0Xl7T
         Yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pTBjQOu78C6rd0Ifhxhb6Jn9sL2SGJ8ZWNOB83K45NQ=;
        b=hmh5WLWwPxhmInJBHe6xWDgGgQFEeKKi/miAY1K6Tm4riex/li592dYkP3yyqVvZpF
         bEnPdV6jP1F3eUT4fGW1/Bl0ZLYt1wZrx8Y8tjFZLjfLwjXZ+qYNgHo4qVGYaX52r3oL
         Br/TZakvSAmuSY+a2pYw+ps+KdvJKrykvWUvA9zYvOlVr1+K9Netew5g0D7nRaohkNEr
         5gvkgb7BUnPW4RcXiK1mQahGudBogOkf1Iw5wDCDi+YwJ3QeGs5y+OC7ZbqAUKl5op//
         k6gSnWF8wuM7IwskQ0U3LEMRfvyFydczz8WrR+RUkBIZcr7FTrValHkC3ISVc8eWuoR3
         f6Iw==
X-Gm-Message-State: AJIora8O5y8A67bUWzaEf7VvYAlJwez0xWvzcwLjoFJavGraR4gOpQaT
	5XrwebUy8XYZhmh88P3EoRAtiQ==
X-Google-Smtp-Source: AGRyM1sIZRUtzqN6oRT/EMB9X6RELi/2nOmuoVXBpDb9tVOVfWi/Or21XH6xZzy50OVCN+DV6wYvQw==
X-Received: by 2002:a17:906:7786:b0:712:3c92:4335 with SMTP id s6-20020a170906778600b007123c924335mr21375511ejm.610.1655743132157;
        Mon, 20 Jun 2022 09:38:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dab4:d6b9:b46d:dda6? ([2a02:578:8593:1200:dab4:d6b9:b46d:dda6])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b00704b196e59bsm6231162ejq.185.2022.06.20.09.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:38:51 -0700 (PDT)
Message-ID: <1c15521b-e748-eec5-205f-9ac75ce0cd98@tessares.net>
Date: Mon, 20 Jun 2022 18:38:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: tweak simult_flows for debug
 kernels.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/06/2022 15:55, Paolo Abeni wrote:
> The mentioned test measures the transfer run-time to verify
> that the user-space program is able to use the full aggregate B/W.
> 
> Even on (virtual) link-speed-bound tests, debug kernel can slow
> down the transfer enough to cause sporadic test failures.
> 
> Instead of unconditionally raising the maximum allowed run-time,
> tweak when the running kernel is a debug one, and use some simple/
> rough heuristic to guess such scenarios.
> 
> Note: this intentionally avoids looking for /boot/config-<version> as
> the latter file is not always available in our reference CI
> environments.

Thank you for the patch and review!

Now in our tree (feat. for net-next but it could also go in 'fixes for
-net', no?) with Mat's RvB tag and a small diff, see below:

New patches for t/upstream:
- 87eefff9e9e8: selftests: mptcp: tweak simult_flows for debug kernels
- Results: 1445c5fa4907..065936dc9f58 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220620T163537
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index f441ff7904fc..141fcf0d40d1 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh

(...)

> @@ -241,7 +250,7 @@ run_test()
>  
>  	# mptcp_connect will do some sleeps to allow the mp_join handshake
>  	# completion (see mptcp_connect): 200ms on each side, add some slack
> -	time=$((time + 450))
> +	time=$((time + 400 + $slack))

(detail: I removed the extra '$' before 'slack' just for the uniformity :) )

Cheers,
Matt

>  
>  	printf "%-60s" "$msg"
>  	do_transfer $small $large $time

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
