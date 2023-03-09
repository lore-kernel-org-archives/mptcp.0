Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C933ED
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 09:28:05 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id bw19so1148066wrb.13
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 01:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678354083;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHsvrw0dPhkF8ri7wKMb9gSDVoCDKrFWiyUtrSOcd3E=;
        b=yJVxQyn2i72Fl6UNTDdhiI5Wk27FXkWDrFAvdzpsKvRIFxJR/jmX9l1UROOGETF0g4
         Awb4+MkZIY1mBsqAoaJj1dQTPy0Fx+jaLdVXBEpRfpDUAygLXdibyt8jwvuGsHkjfOUS
         tmh2QzkwBcWPQLlhs0Ri65/8/XK5DYDc6wRDqbEVDoH2QE4PzfZfV3iKsZmkThQI58GA
         gMt4yEiJ/sWUy8GTDU7HlRILUZYwyqnE9Q3Fm/sqZu4fKWsGs8+FL5ox3KB49yiByTFD
         RvFioS+3x9uLdtIVs5AHbzW6EMHODf+DLQesxY57lIudllIRjnIV02sdIHRbayt5y0Fc
         W3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354083;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHsvrw0dPhkF8ri7wKMb9gSDVoCDKrFWiyUtrSOcd3E=;
        b=r7rwd0BPQvdoYDkUgO6ag6tNnPtC6w7zHgGWodABn6jgR4DaUQSwZ+hTPEXy7jEe4h
         J4NYaLUlM7ECwKi+gjRn94HSc54evQOHfATf8kRhPnwluvilgLg8z/wNHE+3R9UGv/3i
         1GlVDPug+35BIwWPhoGzevOVZnPT524Kt+m9s9qe/GsItx61Ht0cIs+BUNjd5UeLMUH3
         HCQhIbv1FsfOTfwC8BFC6r+a0wOW1fOB6tyGFktwAAJn439UIKVV2bnVhDka+a9LjTUT
         O8NzzOFV6obGvlf8Sy4lHOuee2AaPtPTZLYEawgFtcmCd+SzTqJtmnwheP7rf8cGHWS4
         nXoQ==
X-Gm-Message-State: AO0yUKUmvEnheF2kjPrytUIkmzlWx0gOUSEJUX6S7tDUNYAlqMOhQJRl
	EGRwjfwAiAF458K4j6un2qxB9JMioyPNaPArZEuIYA==
X-Google-Smtp-Source: AK7set8pc0NPyHSsWvjrjseXqGBrcVUpDUGhBzZfQPx/YjPLIKqJrPbCIkQB1jkwaTnk/pBS+cLSXg==
X-Received: by 2002:adf:f587:0:b0:2c7:deb:c61 with SMTP id f7-20020adff587000000b002c70deb0c61mr15142098wro.39.1678354083278;
        Thu, 09 Mar 2023 01:28:03 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:cf48:2681:518b:ac83? ([2a02:578:8593:1200:cf48:2681:518b:ac83])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d5150000000b002c559843748sm17487405wrt.10.2023.03.09.01.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:28:03 -0800 (PST)
Message-ID: <ad01ca78-fc41-a39b-d73d-86a6d2f945b5@tessares.net>
Date: Thu, 9 Mar 2023 10:28:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mptcp_info tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/03/2023 03:04, Geliang Tang wrote:
> This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
> new function chk_mptcp_info() to check the given number of the given
> mptcp_info field.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>  - use '-D' option instead of '-i'.
> v3:
>  - add tests in endpoint_tests() instead.
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 42e3bd1a05f5..625d24d94576 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(..)

> @@ -3118,13 +3158,16 @@ endpoint_tests()
>  		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
>  
>  		wait_mpj $ns2
> +		chk_mptcp_info subflows_1

I forgot to look at the output when doing my previous review and it
seems this is printed before the title:

#                          mptcp_info subflows=1         [ ok ]
# 115 delete and re-add    after delete[ ok ]
#                          mptcp_info subflows=0         [ ok ]
#                          after re-add[ ok ]
#                          mptcp_info subflows=1         [ ok ]

Maybe we should have:

  (...)

  wait_mpj $ns2
  chk_subflow_nr needtitle "before delete" 2
  chk_mptcp_info subflows_1

  pm_nl_del_endpoint $ns2 2 10.0.2.2
  sleep 0.5
  chk_subflow_nr "" "after delete" 1
  chk_mptcp_info subflows_0

  (...)

What do you think?

Do you mind looking at that in a v4 (with the other comments) please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
