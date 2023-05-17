Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18B33D5
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:09:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f475366522so6334385e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684336182; x=1686928182;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZ9T0uzWL3GOQ3bsrCo2zbL+XoobnMO2jH0I23Ccoc4=;
        b=UZbPJzqxKDYTsjkWXr/SgUO0Ca3aW7wTjQ0zhLR3frFpWUcXhfAT0Y9tn0DlNIvQTq
         1Ej1daePYKtccj27uHV4kV1qTGItWMSR/JlvCalhTpvOQzpFqmJ+SVtjXMUymlDDlj0+
         Z3Wjyc3tMABsfSnsh9gByosNP08pM7GfzRSvU+bI4hv77uKFE2OEaTmAVbv1Wsq3fOWP
         gzBWo6ijYGWUgSpe6ZjCiECrdz+nBT8H+Ruq0jBi0wMskmRAaemMerJK7LsEnUoTgAki
         IHQ1Qgw1vHp8QqjEEO2Pv9Ih1fEEdmPgiO/+U95GU+2lw5OAq6nhuxYGwobDCdRAKAZe
         Gy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336182; x=1686928182;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ9T0uzWL3GOQ3bsrCo2zbL+XoobnMO2jH0I23Ccoc4=;
        b=QNVzVVdIZQ7160biFbqoIEWBkaXUforGr/RQ3eTyvxLJgO3V05yBPNNhcWzYtNz1H5
         RLEmn+H0jP0cnjc5opfCKm4V+LN7UPxYhKiv/gv7Ao1hctUZ9jE3RZNcevyidEy/d5UN
         Pt71CCOc2Czo1IsMEaljVQqvOtJp8X+TWU2ukr17VaAI1wRBhG0TfZsi63v00oZTosaR
         BZozxKorJHu0+xrzSyHGaH3PULaCKxat8slKAKAE0s012fitxnVbY1Qr2WhU3IjSapVa
         EiqBfRd3caRWUghUcBNv5/vttz0KZvLYuGzGN+YfeJ7kAW66LNkTm9V5tWbAqR8gla7k
         Nu4w==
X-Gm-Message-State: AC+VfDxJlFSKiqRmC1WSYWzOfnCysixN0Bts9aUdao0DnhuO4HSGocY+
	bxnAEPc198dxltE1jjD4Sr5NUw7yC+izDzo/mIs=
X-Google-Smtp-Source: ACHHUZ7r48frVfZT/PduqOTokOJcQVxuUdl3HSuBPRrmLeQtwrBJgrFnrb6/hLr0SkDWOddeUvfdHg==
X-Received: by 2002:a1c:7703:0:b0:3f4:2c8f:d2d3 with SMTP id t3-20020a1c7703000000b003f42c8fd2d3mr18920968wmi.20.1684336182323;
        Wed, 17 May 2023 08:09:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id s2-20020a1cf202000000b003f50876905dsm2521924wmc.6.2023.05.17.08.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:09:41 -0700 (PDT)
Message-ID: <bb54167e-d4e5-f030-02d8-6bb030dbe38f@tessares.net>
Date: Wed, 17 May 2023 17:09:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v3 3/6] Squash to "selftests/bpf: Add bpf_first
 test"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684331602.git.geliang.tang@suse.com>
 <72f004475c96f43fa3e194f1940e836a74eb1a32.1684331602.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <72f004475c96f43fa3e194f1940e836a74eb1a32.1684331602.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 15:57, Geliang Tang wrote:
> Run mptcp sched test in a dedicated netns.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 50 +++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index ca348bab0afe..210ab5c30962 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -284,42 +284,39 @@ static void send_data(int lfd, int fd)
>  #define ADDR_1	"10.0.1.1"
>  #define ADDR_2	"10.0.1.2"
>  
> -static void sched_init(char *flags, char *sched)
> +static struct nstoken *sched_init(char *flags, char *sched)
>  {
> -	char cmd[64];
> -
> -	system("ip link add veth1 type veth peer name veth2");
> -	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
> -	system(cmd);
> -	system("ip link set veth1 up");
> -	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
> -	system(cmd);
> -	system("ip link set veth2 up");
> -
> -	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
> -	system(cmd);
> -	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
> -	system(cmd);
> -}
> +	struct nstoken *nstoken;
>  
> -static void sched_cleanup(void)
> -{
> -	system("sysctl -qw net.mptcp.scheduler=default");
> -	system("ip mptcp endpoint flush");
> -	system("ip link del veth1");
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
> +		goto fail;
> +
> +	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
> +	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
> +	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> +	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
> +	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
> +
> +fail:

Same here, why not returning NULL in case of error to stop the test
earlier if it was not possible to setup the environment?

> +	return nstoken;
>  }
>  
>  static int has_bytes_sent(char *addr)
>  {
> -	char cmd[64];
> +	char cmd[128];
>  
> -	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
> +	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
> +		 NS_TEST, addr);
>  	return system(cmd);
>  }
>  
>  static void test_first(void)
>  {
>  	struct mptcp_bpf_first *first_skel;
> +	struct nstoken *nstoken = NULL;
>  	int server_fd, client_fd;
>  	struct bpf_link *link;
>  
> @@ -333,7 +330,9 @@ static void test_first(void)
>  		return;
>  	}
>  
> -	sched_init("subflow", "bpf_first");
> +	nstoken = sched_init("subflow", "bpf_first");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
> +		goto fail;
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
>  	client_fd = connect_to_fd(server_fd, 0);
>  
> @@ -343,7 +342,8 @@ static void test_first(void)
>  
>  	close(client_fd);
>  	close(server_fd);
> -	sched_cleanup();
> +fail:
> +	cleanup_netns(nstoken);
>  	bpf_link__destroy(link);
>  	mptcp_bpf_first__destroy(first_skel);
>  }

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
