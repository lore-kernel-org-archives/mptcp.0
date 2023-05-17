Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96C33D5
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:09:57 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-307c040797bso613618f8f.3
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684336195; x=1686928195;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCUYYnJmx1eGSmLLLDB1IZB2GZb779wADMZbmy2y84c=;
        b=uJn+V0GxbeLEq0lPuYSP1z+LbKTzpNaoNxSMeGYiSEqmQCHfsi/W1n8A3CEME3Lnca
         So7q+esPvypAP2dMMzkIjQnEW1JO5x+Ccuo4CZS50RkZ0/y8FHC3IhDqJM+ZnsqulDX0
         u84BuMNoBPZdhq4WQa1pVkt4N6ehpFJjreerKhLA/fYCiOdaL/maAs0LyM6wvuNF2mSu
         4RuIPGGz0348fGgYkWa1zHI1EdMFCM5we75IMt9f2m8huDb8XZWwVb/Sm+sdVA5MqCUH
         rOLqLsPz9ElXVB7ZY33qjBHss9LIHWCL08DRPSvq3FSAVOtM1vl1y9xieHR+RKmqgEZP
         jnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336195; x=1686928195;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCUYYnJmx1eGSmLLLDB1IZB2GZb779wADMZbmy2y84c=;
        b=Q+T6+DrqNyV1J1eNlrt3DmePW+m6gjSBNze1WvecADHjyi1MmfKrstlXstlUCFlciy
         lu6r1Rsl6af+xsvMmX/N+R47OU37Kx0X5JZwFlayEp9xKnbW6EZdmeiCCE+Z77RS/0RP
         ayaqi+qibu81/7M03XeXnfINArKcXw703tq2dN46lL9XGW6gN8c8/un2S4gnBXoy6Wa7
         /W2Tv89StgecvywsR+qAn+Jde9CXlVjfHML2M1L4B/RY8S3fQFv5M5xyr7DbL6U/r/QA
         yMyLSYAjY2xgR5qpXbLWe2Lgl5SCTMiljLomobAnN3qkBO5OcKpHTevRiG0TTG41DTJD
         4jfw==
X-Gm-Message-State: AC+VfDxUtzcg+NlbFzvoxXiscPVlrY3lDAjvt20nKz9USiS7byxgUMcq
	MSDbLd4XMqPZazm5TX153L0RoM0/0swsMYCnF6M=
X-Google-Smtp-Source: ACHHUZ6q+4OUPbG5FV6QsIYF8s/fXH6E7D97we22KOEquO26kBEyqq0f/vkClPC0ziPgtUU6r0VbRg==
X-Received: by 2002:adf:eb0a:0:b0:309:35d3:2e8b with SMTP id s10-20020adfeb0a000000b0030935d32e8bmr954876wrn.2.1684336195388;
        Wed, 17 May 2023 08:09:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4088000000b0030647d1f34bsm3148218wrp.1.2023.05.17.08.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:09:55 -0700 (PDT)
Message-ID: <8fe9e12c-9b97-2129-513b-60910d952a26@tessares.net>
Date: Wed, 17 May 2023 17:09:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v3 5/6] Squash to "selftests/bpf: Add bpf_rr
 test"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684331602.git.geliang.tang@suse.com>
 <c4185c460f20695b085b9bf841e3e56c4cd0e167.1684331602.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c4185c460f20695b085b9bf841e3e56c4cd0e167.1684331602.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 15:57, Geliang Tang wrote:
> Run mptcp sched test in a dedicated netns.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 88bef3dff24e..912457da88eb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -385,6 +385,7 @@ static void test_bkup(void)
>  
>  static void test_rr(void)
>  {
> +	struct nstoken *nstoken = NULL;
>  	struct mptcp_bpf_rr *rr_skel;
>  	int server_fd, client_fd;
>  	struct bpf_link *link;
> @@ -399,7 +400,9 @@ static void test_rr(void)
>  		return;
>  	}
>  
> -	sched_init("subflow", "bpf_rr");
> +	nstoken = sched_init("subflow", "bpf_rr");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:rr"))

Small detail if you have to send a v4: can you add the "bpf_" prefix
like with the others?

  sched_init:bpf_rr

Cheers,
Matt

> +		goto fail;
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
>  	client_fd = connect_to_fd(server_fd, 0);
>  
> @@ -409,7 +412,8 @@ static void test_rr(void)
>  
>  	close(client_fd);
>  	close(server_fd);
> -	sched_cleanup();
> +fail:
> +	cleanup_netns(nstoken);
>  	bpf_link__destroy(link);
>  	mptcp_bpf_rr__destroy(rr_skel);
>  }

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
