Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721C8BE5
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 15:05:44 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-988a076a7d3so194640766b.3
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687187143; x=1689779143;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU0QSaoC61OF2BG35PwY/nRcQLnWzEfk/vTSwZvVNto=;
        b=tCPERYPbz0IVJwx+2cbvvgF9fI5OlO98L9mSXYhOJoNd3GstHhMvAaESaB1jj4Zrw8
         K0cavtx4qemVim5TOPdhl9ujs9uSfT3swoNpqWvtSy+UGLssFz3JsAVRx3YJ3IudxaBP
         Skg9oG3AAsqS5LTA19JxRv+KKFAAQRyLkPX9vtL9bBmL+HFzR5G59UssiRF16wmd7E+q
         hN2dmdcQ/lzEJW9Gd0q1se3xlLLYp0ppfYVsc4M6ln2DKfiZ8WrBNNc+9IsRNxgw9+P7
         8P4n6kAz+tst5fbqdgHMsQXn8DGEaM2W6VUbjjnWHDp7FVzYstQax3GbnX1xpvzWI6xe
         aauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187143; x=1689779143;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU0QSaoC61OF2BG35PwY/nRcQLnWzEfk/vTSwZvVNto=;
        b=UyN0Bz4I9E5yTLa4r1RE0WLfUkAd4mMju7ypKu/8p2Wo8omYThzg8TjDXCsclazGrM
         4CEG6aAsJW9mQenEvTV0DoM3PpJQe2rKCCcnLDOE/3oBJzCXirNsUosswhEzasKLvI5t
         qK20XoMwOAmdfVu9jYtcA6XlSVg2+gA6qvOcaBRLqQJExuA3HhkutdvlqyOpcVsCun+e
         IHTSOKZPJhwEkRKeFR44tUZh6DSnty4ij+UGeCOgsCOCnqcZkXj30mYrU6Mfy4u5Afcx
         tJ/qMAxbVvwmXWwmKJoJmqU6jgU2LxXiLVA0cbSXq5WtqgEU7oLU/U+RRqksrNFTwJ2d
         TLRQ==
X-Gm-Message-State: AC+VfDzSise3U5/Ra9S7s2WpfGUhQ/M1fg5Dz5hJffA20JnRIt0AQatI
	B+7IIypWGWXi4D2xUwXxrND3T05MmcElPPUDUj4=
X-Google-Smtp-Source: ACHHUZ75mHlyjesYP8SY2UoFso3r3wUFvpQCEv8Suwa26aU0Cf95fgfOe/cOu5Y0Zb6SKYJPxlWs4Q==
X-Received: by 2002:a17:907:e87:b0:974:5487:6037 with SMTP id ho7-20020a1709070e8700b0097454876037mr10792792ejc.36.1687187142878;
        Mon, 19 Jun 2023 08:05:42 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906259100b00969f44bbef3sm15073933ejb.11.2023.06.19.08.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:05:42 -0700 (PDT)
Message-ID: <47b2f53c-50c1-b9b3-6ad0-32fb573404ac@tessares.net>
Date: Mon, 19 Jun 2023 17:05:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v20 10/10] selftests: mptcp: set endpoint out
 of transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686900596.git.geliang.tang@suse.com>
 <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/06/2023 09:31, Geliang Tang wrote:
> This patch adds a new flag set_endpoint_outside to control whether
> endpoints are set in do_transfer().
> 
> Add a new function run_tests_bg(), in it run tests in the background
> and set endpoint outside do_transfer().
> 
> Many tests can use this run_tests_bg() instead of run_tests().

Thank you for the patch but I'm not sure to see the benefits of it. Do
you mind explaining why it is interesting to do that? Is it to
accelerate/stabilise some tests?

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++-------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 89379815b619..f5a79a88131e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -54,6 +54,7 @@ export test_linkfail=0
>  export addr_nr_ns1=0
>  export addr_nr_ns2=0
>  export sflags=""
> +export set_endpoint_outside=0

Note that all these new variables above could be set where we need them,
just with

  local set_endpoint_outside=${set_endpoint_outside:-0}

>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>  #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> @@ -1086,7 +1087,9 @@ do_transfer()
>  	fi
>  	local cpid=$!
>  
> -	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
> +	if [ $set_endpoint_outside -eq 0 ]; then
> +		pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
> +	fi
>  
>  	wait $cpid
>  	local retc=$?
> @@ -1203,6 +1206,22 @@ run_tests()
>  	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
>  }
>  
> +run_tests_bg()
> +{
> +	local listener_ns="$1"
> +	local connector_ns="$2"
> +	local connect_addr="$3"
> +	local speed="${4:-fast}"
> +	local wait_join="${5:-0}"

You could also call the function with an env var:

  wait_join=1 \
      run_tests_bg (...)

In this case, run_tests_bg() will take the same arguments as run_tests()
and you could do:

  set_endpoint_outside=1 \
      run_tests "${@}" &

(maybe you don't even need an extra function and do such modifications
in run_tests() directly, no? maybe it is just that I didn't understand
why you want to do such modifications :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
