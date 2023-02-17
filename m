Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08386AA9
	for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 13:53:27 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id cz7so1130589edb.12
        for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ce2IYx1cxWdvUXB7PnSnCuxsADdC+K6046BpmKOpG94=;
        b=seBIsagoJ8tPlbwarL6IK7dTQ8bdIeAtcb8sVl/PqajH2Usgrfz4nH7bUA3OfMITzF
         opHBUl49CBhVpcaeTOa09ORmHIYXXi7eGSgGAZxRycw9GbI+rdmp5CP5Iz6irxs7VbLv
         RzFe94uKqQ4my1/g3ZSduvegrQw+yMyiTYKx4G1Yv/MR7fHCD+GOYm4sI7F20vjB52he
         VS1jzBdQ9qJTwOcTnROdeSqxFMa/JUdf4jfzc1Imza7Dy5XjFUlv7LwRCF+i/NGX80ZE
         bEYoZ8+SisfnQWJPDuKAP11p3jFhjTTcbRoyTbkjHL5pjh/ROU8vzVvMk6/yDss3W/AA
         lO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce2IYx1cxWdvUXB7PnSnCuxsADdC+K6046BpmKOpG94=;
        b=hg+OAkJ+hiWaWdHMYfaL0NZPYibT9vV2qM3vCYFC5IzmSJVPBKaI99+ZhjPpwzALy8
         qLDiXzLeOjJRkVIUXPW9AqA+puKZtOJsQmm3b26udzdU/owt7UunGcGMkPjFh4P4Ty/j
         PpC01aZES8kAbglX8ft1U9Egl9yKr/w7R2OjOnOflMf6zYe5gehJ9cqB8Ugeoll2I6R4
         Ie1Okx4FIY9m7PzB2wdR1BB0fXGvePycvbs27iHVr1sSTOSX4HJJIVsgi88qztP6L/0O
         ZK1TBpksUzOpMi8Ee8snc+IDqZ9HaTAZu0RS893BAqh9k1Yqo0dORXK4N0+guNUrS5xH
         fX2w==
X-Gm-Message-State: AO0yUKXC2uXbcvoG0fD6Jpz0vjpP1UZ2omWmxGQoZZ5MMWMoPtcoX140
	ojeFgE79wfxg5EcA7fCdIjfzsA==
X-Google-Smtp-Source: AK7set9tVfirY8bLk7/aMJ57J1i/x8s+zHF7SSjuGKrnf+v9zNwFHqGTNqjzxDP+LL3yeu6ogQso+A==
X-Received: by 2002:a17:906:f2d5:b0:8b2:7564:dfd5 with SMTP id gz21-20020a170906f2d500b008b27564dfd5mr1822108ejb.60.1676642005900;
        Fri, 17 Feb 2023 05:53:25 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e048:140f:ea30:d130? ([2a02:578:8593:1200:e048:140f:ea30:d130])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906849200b0087bd4e34eb8sm2131010ejx.203.2023.02.17.05.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 05:53:25 -0800 (PST)
Message-ID: <eb7bc302-8661-229b-f8b9-d5045bffbd19@tessares.net>
Date: Fri, 17 Feb 2023 14:53:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next] selftests/bpf: run mptcp in a dedicated netns
Content-Language: en-GB
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Felix Maurer <fmaurer@redhat.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230217082607.3309391-1-liuhangbin@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230217082607.3309391-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

(+cc MPTCP ML)

On 17/02/2023 09:26, Hangbin Liu wrote:
> The current mptcp test is run in init netns. If the user or default
> system config disabled mptcp, the test will fail. Let's run the mptcp
> test in a dedicated netns to avoid none kernel default mptcp setting.

Thank you for the patch!

I just have one request below if you don't mind:

(...)

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 59f08d6d1d53..8a4ed9510ec7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

(...)

> @@ -138,12 +148,20 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  
>  static void test_base(void)
>  {
> +	struct nstoken *nstoken = NULL;
>  	int server_fd, cgroup_fd;
>  
>  	cgroup_fd = test__join_cgroup("/mptcp");
>  	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
>  		return;
>  
> +	SYS("ip netns add %s", NS_TEST);
> +	SYS("ip -net %s link set dev lo up", NS_TEST);
> +
> +	nstoken = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto cmd_fail;
> +
>  	/* without MPTCP */
>  	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
>  	if (!ASSERT_GE(server_fd, 0, "start_server"))
> @@ -163,6 +181,12 @@ static void test_base(void)
>  
>  	close(server_fd);
>  
> +cmd_fail:
> +	if (nstoken)
> +		close_netns(nstoken);
> +
> +	system("ip netns del " NS_TEST " >& /dev/null");
> +
>  close_cgroup_fd:

If I'm not mistaken, this label should no longer be needed: after the
modification you did, the only 'goto close_cgroup_fd' used above should
be replaced by 'goto cmd_fail', no?

Apart from that, the rest looks good to me.

Cheers,
Matt

>  	close(cgroup_fd);
>  }

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
