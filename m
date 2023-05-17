Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B83D62
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:55:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-307c040797bso276953f8f.3
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684313705; x=1686905705;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4/hs+RjSUhgcvQoeSWzGkmpMM1YFhV03EE/u2wUuUM=;
        b=EqxJ5Mv/ofa/v1HdGxMrc+QpUuTJRecElooY+tNaDY4CzRlwn2XeQoBGSKLm3K3Ml7
         nhsUXAixxiYvwEn4lEb+FwOl+670u+ENRW7JnqWlLEPvzDJ36SPfgDho7a+YUa1ZH3h/
         mVdUw6m0wiaZ+JkOBQ4GWoh+Rz/hE/DqTcoCaKmgo/HOP8CiGz0Z2g0pv1Psr3BL1fDV
         yMnuXMJrUxnL4jFa3dlH9peCvEaFY/U0Urq8PxYBvamChPXt1gyv4obAJFlGB4YFvp2j
         /0siG/WQ7hEgzpxxH8C+06QrnlU2e7+3k8gmnTi/3HkcOeoerEAxFRhPcXBHL8T9TNRN
         0Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313705; x=1686905705;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4/hs+RjSUhgcvQoeSWzGkmpMM1YFhV03EE/u2wUuUM=;
        b=VN8HQEOpvGPGoehJED8rMbF4b1aakR4UOi5eqHyM1CB0nawxkIk7zn/TmWX8udnIUS
         CBuglAgWWeZwexUHQjxMfoE/E0dxSdq46wUrq5PNmDro7MgsRx4ER9ZPO5464KpJKxXa
         rbd3L/N0JB8QoL2esV0kKXMfzP+5Liyf1GKyuzO9nafb8fo16qNrS5+XGIKXqQqX7ZML
         3xzwTlEwR/DijfPh8Q8sQKNhjQsi8dekES8Z0RwHtNINxFHMQ1QFsTApSv1ZN/MLRwbk
         2//sW9OEJ4cIV6VwqM5c0mkSl05Gf9FvNIRnCcrxKKvguq/ZN55DCqQe9JfGmBNjBGtG
         9kZg==
X-Gm-Message-State: AC+VfDxy7TUqeSErvALKgl3Vw4xtqWffRPfca/npFVhYdX1dE3m4gph0
	vqAbNqfKYkWXWu1b2+ItlgvcoNh4/6RPHxG1A3kF7g==
X-Google-Smtp-Source: ACHHUZ6zIcxfUm1s0LNgDAUNgl0/oYd0NVHoIsuROXWRovJL2o3WvKb7IK4crHEJbs3uOkf8AppeJA==
X-Received: by 2002:a5d:6448:0:b0:307:8ca1:975a with SMTP id d8-20020a5d6448000000b003078ca1975amr40650wrw.41.1684313704968;
        Wed, 17 May 2023 01:55:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id c13-20020a7bc00d000000b003f4ddde398csm1529553wmb.21.2023.05.17.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:55:04 -0700 (PDT)
Message-ID: <0fc7f4d2-d00b-e6b3-9dfb-78863f80a674@tessares.net>
Date: Wed, 17 May 2023 10:55:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_first
 test"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
 <605ac80d58b4d089b74b6eedf003a43862c55b61.1684312597.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <605ac80d58b4d089b74b6eedf003a43862c55b61.1684312597.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 10:40, Geliang Tang wrote:
> Run mptcp sched test in a dedicated netns.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 50 ++++++++-----------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 77a6997fc82f..bea9c799a531 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -253,40 +253,34 @@ static void send_data(int lfd, int fd)
>  #define ADDR_1	"10.0.1.1"
>  #define ADDR_2	"10.0.1.2"
>  
> -static void sched_init(char *flags, char *sched)
> +static void sched_init(char *ns, char *flags, char *sched)

I think it is cleaner to use a new netns for each test: by doing that,
we are sure to start from a fresh and controlled environment just in
case something wrong happened with the previous test. No?

So in the sched_init(), the netns is created and in sched_cleanup(), the
netns is destroyed (and no need to do anything else I guess).

I guess you can also simply use a helper to create the netns and set
NS_TEST which would be a "global" variable. WDYT?

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
> +	SYS_NOFAIL("ip -net %s link add veth1 type veth peer name veth2", ns);
> +	SYS_NOFAIL("ip -net %s addr add %s/24 dev veth1", ns, ADDR_1);
> +	SYS_NOFAIL("ip -net %s link set dev veth1 up", ns);
> +	SYS_NOFAIL("ip -net %s addr add %s/24 dev veth2", ns, ADDR_2);
> +	SYS_NOFAIL("ip -net %s link set dev veth2 up", ns);
> +	SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", ns, ADDR_2, flags);
> +	SYS_NOFAIL("ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", ns, sched);

Why not using SYS() instead? By doing that, the test will be marked as
failed if one of these commands fails.

You just need to add:

  fail:
          return;

at the end I guess.

>  }
>  
> -static void sched_cleanup(void)
> +static void sched_cleanup(char *ns)>  {
> -	system("sysctl -qw net.mptcp.scheduler=default");
> -	system("ip mptcp endpoint flush");
> -	system("ip link del veth1");
> +	SYS_NOFAIL("ip netns exec %s sysctl -qw net.mptcp.scheduler=default", ns);
> +	SYS_NOFAIL("ip -net %s mptcp endpoint flush", ns);
> +	SYS_NOFAIL("ip -net %s link del veth1", ns);

Same here with SYS() to catch unexpected behaviours.

(but see above, maybe enough to just close nstoken and delete the netns)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
