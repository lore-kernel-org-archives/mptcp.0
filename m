Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C18AD21
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 07:59:46 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso2685255e9.3
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684310385; x=1686902385;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TjavVjVdgSXpCKwwRnF7cUXJoQUI+5vHe8x9U3KzWI=;
        b=4eWi0fcj5hzlfMHpB6nFP1OU3SPfppeUEhSUerrdNeMvR3ivgMdVTxyR2lKxVOZ6hD
         UYGqt2rfP/hklHqdW8ZCUHrCEIOP83mZi3mtCTvbIyBXX4BpNPY6F31xuKADCfwxgBx3
         8ofn7GSafq6TCX5GH0Df72tb3XYh4CF00zxAg4E5uFUhaW4IROp2aGj75OgHsuQ/hSYC
         K+isrpBLEG6YO14Pjhm2pl8iS7O59NlxMxoKh7pLb7OPM/bVSyVVDX6j3ZD87Zxx9kT5
         DD6jT/CwfxdtuV/MM3iYTc6/CKNpVkWQzLr6lse3RlvP8BAy7MoelV730B2WRQ8uAHsU
         gPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684310385; x=1686902385;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TjavVjVdgSXpCKwwRnF7cUXJoQUI+5vHe8x9U3KzWI=;
        b=PnD0MpKu5IJKRbuNiK446yacwWWyupxzXHxn7mE2DvZBjomQfmDmo4wUmkHytyReL6
         Vda7yUpC0jPUx2QsKB1EcxUt7xt8QnUmjcm0of4vfMZAekNQrnJo2kaDRYtCFGWy9Bvk
         hyqqD3IrMu1OfdT37IxVJso0DdBve/P969Km9X0N7V3qp+2lHqEN9u75qfuR1WKE+eoY
         xEG8lOcvlExiPxJD7qVBewCfcdCxWtyO9drx+vBJ8YI1XsNw1oERonkrpanqQ0Tn3Mgb
         9z13lDbVF8Ft0rj03Y7U3cVsXBtA2YNnPS9p+EFq95OY1Qk5xsY23kt7uRbvEyjjJVss
         HlMw==
X-Gm-Message-State: AC+VfDwKYkrId6djMR0juZC2piEEZRHU5oZ5mizj59gwxicRzps9/duf
	7/jNhk8Xq6/2OIUH5AXrSXDuzbceG243GP6uVeBOlQ==
X-Google-Smtp-Source: ACHHUZ5v9S+2UDRF/dRmov+E460sZMvt7yAhMgcdplyPHEPiPzKDtdPCY8SKbCj+WNlYLBwg6UI/2g==
X-Received: by 2002:a1c:7210:0:b0:3f4:e850:64e4 with SMTP id n16-20020a1c7210000000b003f4e85064e4mr14605208wmc.37.1684310385043;
        Wed, 17 May 2023 00:59:45 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id f2-20020a1cc902000000b003f50237bd9csm1392837wmb.19.2023.05.17.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:59:44 -0700 (PDT)
Message-ID: <4aa90a22-c099-b405-7ec7-da492b282fc8@tessares.net>
Date: Wed, 17 May 2023 09:59:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: Add bpf_first
 test"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684297911.git.geliang.tang@suse.com>
 <5ddd82f8a26cd37805ad9fdc23d16d936ab71813.1684297911.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5ddd82f8a26cd37805ad9fdc23d16d936ab71813.1684297911.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 06:32, Geliang Tang wrote:
> Run mptcp sched test in a dedicated netns.

Thank you for looking at this!

I just have a few comments and ideas below (the last one is also valid
for the patches 2 to 4/4).

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 61 ++++++++++++++-----
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index de8b6c68fc30..c6fd5c2449f3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -271,42 +271,69 @@ static void send_data(int lfd, int fd)
>  #define ADDR_1	"10.0.1.1"
>  #define ADDR_2	"10.0.1.2"
>  
> -static void sched_init(char *flags, char *sched)
> +static struct nstoken *sched_init(char *flags, char *sched)
>  {
> +	struct nstoken *nstoken = NULL;
>  	char cmd[64];
>  
> -	system("ip link add veth1 type veth peer name veth2");
> -	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
> +	SYS(fail, "ip netns add %s", NS_TEST);
> +	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +
> +	nstoken = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto fail;
> +
> +	snprintf(cmd, sizeof(cmd), "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
> +	system(cmd);

While at it, should you not use here and below:

  SYS(fail, "...", ...);

... instead of snprintf() + system()?

With that, we will be able to catch issues with the commands here and below.

(also, cmd[64] might be too small, in SYS(), they use 1024)

> +	snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
> +	system(cmd);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s link set veth1 up", NS_TEST);
> +	system(cmd);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>  	system(cmd);
> -	system("ip link set veth1 up");
> -	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s link set veth2 up", NS_TEST);
>  	system(cmd);
> -	system("ip link set veth2 up");
>  
> -	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
>  	system(cmd);
> -	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
> +	snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s",
> +		 NS_TEST, sched);
>  	system(cmd);
> +
> +fail:
> +	return nstoken;
>  }
>  
> -static void sched_cleanup(void)
> +static void sched_cleanup(struct nstoken *nstoken)
>  {
> -	system("sysctl -qw net.mptcp.scheduler=default");
> -	system("ip mptcp endpoint flush");
> -	system("ip link del veth1");
> +	char cmd[64];
> +
> +	snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp.scheduler=default",
> +		 NS_TEST);
> +	system(cmd);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint flush", NS_TEST);
> +	system(cmd);
> +	snprintf(cmd, sizeof(cmd), "ip -net %s link del veth1", NS_TEST);
> +	system(cmd);
> +
> +	if (nstoken)
> +		close_netns(nstoken);
> +	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");

Is it not enough to just destroy the netns? So just the two last steps.

>  }
>  
>  static int has_bytes_sent(char *addr)
>  {
>  	char cmd[64];
>  
> -	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
> +	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
> +		 NS_TEST, addr);

Do you not need a larger size for 'cmd'? Maybe safer to bump it to 128
(or more) because the following is 65 bytes long (including the \0 at
the end):

  ip netns exec mptcp_ns ss -it dst 10.0.1.1 | grep -q bytes_sent:


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
> @@ -320,7 +347,10 @@ static void test_first(void)
>  		return;
>  	}
>  
> -	sched_init("subflow", "bpf_first");
> +	nstoken = sched_init("subflow", "bpf_first");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init"))

It might be good to add the name of the test in the error not to have
the same error for all subtests, no?

  if (!ASSERT_OK_PTR(nstoken, "sched_init: bpf_first"))

(same for the other tests)

> +		goto fail;
> +
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
>  	client_fd = connect_to_fd(server_fd, 0);
>  
> @@ -330,7 +360,8 @@ static void test_first(void)
>  
>  	close(client_fd);
>  	close(server_fd);
> -	sched_cleanup();
> +fail:
> +	sched_cleanup(nstoken);
>  	bpf_link__destroy(link);
>  	mptcp_bpf_first__destroy(first_skel);
>  }

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
