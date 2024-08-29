Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A41B011C
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942301; cv=none; b=EO+hH1GAE5TqlUMdMpLWCd2YXwdi9T1gxca635LXCR8JcKZvY+QwPquC7MWsZWmEiQx5JSIWHH6OOtL40ej11ohF9hNy1aLNanZYqUVRs32rrj5+8M/2sZO10mgMoL3+Jo0UwegAJZ8eLsOA1ECvcjDBXrEjrZzsXFyzAQo7k+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942301; c=relaxed/simple;
	bh=46EyeMtewIixkA74bRZrllFrs/OyULmllufDFAaUa2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKJ86CiCGfN387wMO9HgtSeNUifnzS9a35/0VU5LiJh/srk2QhrUM2Rss30ha5e6HSRKSf/6meOMqPSKcj6KSIpxiZCOgP9lWhQ31HBvT2jBuMv/U87HTTkxdCeoEh55p8hRoAACv/W4OnSnD+WfwoxjM9TTXP5dXw+N4nCWlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6IhsvW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6IhsvW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C6C4CEC1;
	Thu, 29 Aug 2024 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942300;
	bh=46EyeMtewIixkA74bRZrllFrs/OyULmllufDFAaUa2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q6IhsvW+0BVEE2uXVtqG0NLko8sGQ8nnat8TjifDDmxCjbjRckCFvNe6/mViLeMOk
	 p2+GUlK74H/xiORfuWkwvhhjiTJxcJGyH5HhIKciKcJOIoeoVnpm6VFCiuvQFvoYn8
	 3UtImI+jXp3OinSeOU810INXKEQIRLZqnPMXGSyQxf2Hv6faP5qEoqjT083m8w2lYQ
	 UZyE773SxThHkvoilRCVr2jpUIrmz8KjcmuQOuTwq0JFdcNKCcBgyjK5pbz8op/oqi
	 dyoiiCASFbyRe6z1306Pp024S07yB+lScsourQqsro+7TIi2YjuB7UlqedhS4uBqae
	 43EiSjpN1xU0g==
Message-ID: <03c7af5b-5fc6-46be-a863-dd7801cfa61f@kernel.org>
Date: Thu, 29 Aug 2024 16:38:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 2/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
 <5cbf9b5c1ec58619e78f713f87ede6805d7c264d.1724899785.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5cbf9b5c1ec58619e78f713f87ede6805d7c264d.1724899785.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the update.

On 29/08/2024 04:53, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Drop ss_search() from run_subflow().
> 
> Use the "cgroup/getsockopt" way to inspect the subflows.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 52 +++++++++++--------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 73adc58cd776..85883515c67b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

(...)

> @@ -393,17 +384,29 @@ static void run_subflow(char *new)
>  	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
>  		goto close_server;
>  
> -	len = sizeof(cc);
> -	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> -	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)"))
> -		goto close_client;
> -
>  	send_byte(client_fd);
>  
> -	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
> -	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
> -	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> -	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> +	len = sizeof(subflows);
> +	/* Wait max 1 sec for new subflows to be created */
> +	for (i = 0; i < 10; i++) {
> +		err = getsockopt(client_fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);
> +		if (!err && subflows > 0)
> +			break;
> +
> +		sleep(0.1);
> +	}

(detail: it might be better to have that in a new helper, but up to you,
maybe easier to keep it here for the moment).

> +
> +	len = sizeof(mark);
> +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
> +	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
> +		goto close_client;

You still don't need this 'goto close_client': it is better to do as
many checks as possible. If needed, you can do something like:

  if (ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
          ASSERT_EQ(mark, 0, "mark");

But it is better to also check the TCP_CC, to better understand what
went wrong.

> +	ASSERT_EQ(mark, 0, "mark");
> +
> +	len = sizeof(cc);
> +	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	if (!ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)"))
> +		goto close_client;

Same here.

> +	ASSERT_STREQ(cc, new, "cc");

Did you drop the first patch of the v4 to ease the check here, and not
to have to look at the default value? I suppose that's OK.

>  close_client:
>  	close(client_fd);
> @@ -416,6 +419,7 @@ static void test_subflow(void)
>  	int cgroup_fd, prog_fd, err;
>  	struct mptcp_subflow *skel;
>  	struct nstoken *nstoken;
> +	struct bpf_link *link;
>  
>  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
>  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> @@ -441,6 +445,11 @@ static void test_subflow(void)
>  	if (endpoint_init("subflow") < 0)
>  		goto close_netns;
>  
> +	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
> +					  cgroup_fd);
> +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> +		goto close_netns;
> +
>  	run_subflow(skel->data->cc);
>  
>  close_netns:
> @@ -448,6 +457,7 @@ static void test_subflow(void)
>  skel_destroy:
>  	mptcp_subflow__destroy(skel);
>  close_cgroup:
> +	bpf_link__destroy(link);

Mmh, I see you moved it, but I don't think it is OK to have here, right?

I should be placed just before the 'close_netns' label, not to call it
with an undefined 'link' variable, no?

>  	close(cgroup_fd);
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

