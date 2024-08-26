Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709519753F
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691276; cv=none; b=VXlQeEarDd5nqbsYBVoVmm38Sv9O0JMdmHaF6/U8DemC/dy3my4cUa6TurtUynI7HGDNoLkp6Lz97kZm5zL/eYcNewDb09G2f/BfotWGwLPyIyle4kJz6/hWeZmMTMqt78Xw8nQiJFBx9MgChSBfi8EWwCltVwFFNreeFWODvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691276; c=relaxed/simple;
	bh=m1xCCis076oPZ5ia4WQfMqMIIWca2sH6ptXf9ej3vRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHrT9h/jsyQKgERAJe7FRcRDkgahlcOCT1DA3j+sWyAa1eV6biwijoZOozB/jP73185kNKP0YYnxCqBPwzHsVJfRovNhFbQaPLc7hXgKuUFlM/tBI5TLabBn0v1uiTewJcKvtICBuLsL3ktrp8O3OLU88xuZdG+G3TtQBDnrPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az8ZC/3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az8ZC/3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6948C4E695;
	Mon, 26 Aug 2024 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691276;
	bh=m1xCCis076oPZ5ia4WQfMqMIIWca2sH6ptXf9ej3vRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=az8ZC/3UgokTrxkX0mgyj3pue6wrZxEIRx4CzEMbHxVjqWzdqbOJJcJgozacupPN6
	 c4dfzOQn8PBuEBHTpsykc7nWnqlQr2Um8VzZREohREraClUfKGZpEM5xrdFjjAmnzS
	 FTETiFSZnjTZKy/OOls11PzfS9xYu7aS98EGuus9yhF4Pr7nY2HxpffHWg4+1Rh4en
	 DRAqp/V17M+14LiPSy1y7fvPFSWDkFt0prYgfjJkD+25b04pQAPCesagrVSpF7sKzn
	 xbDLANB1H9Q2mJGHJvz/TuxLSgj6cqxRoqkhbzTCG/9HiCXa4nzbt3ZkPu8FhvOTpE
	 qGZNLeo32Atuw==
Message-ID: <26a19624-f042-487f-8227-a992ab786696@kernel.org>
Date: Mon, 26 Aug 2024 18:54:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
 <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/08/2024 14:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Drop ss_search() from run_subflow().
> 
> Now ss_search() are only used by bpf_sched tests. It will be dropped
> in next step.
> 
> Use the "cgroup/getsockopt" way to inspect the subflows.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 57 ++++++++++++-------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 73adc58cd776..ce464b1e0802 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -368,22 +368,13 @@ static int endpoint_init(char *flags)
>  	return -1;
>  }
>  
> -static int _ss_search(char *src, char *dst, char *port, char *keyword)
> -{
> -	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
> -			  NS_TEST, src, dst, port, PORT_1, keyword);
> -}
> -
> -static int ss_search(char *src, char *keyword)
> -{
> -	return _ss_search(src, ADDR_1, "dport", keyword);
> -}
> -
>  static void run_subflow(char *new)
>  {
> -	int server_fd, client_fd, err;
> +	int server_fd, client_fd, err, i;
>  	char cc[TCP_CA_NAME_MAX];
> +	unsigned int mark;
>  	socklen_t len;
> +	u8 subflows;
>  
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>  	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> @@ -393,17 +384,26 @@ static void run_subflow(char *new)
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
> +
> +	len = sizeof(mark);
> +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
> +	if (!ASSERT_OK(err || mark != 2, "getsockopt(client_fd, SO_MARK)"))

The mark should be 0 on the MPTCP socket, no?

Also, I don't think you can do this check:

  err || mark != 2

That will be converted to:

  (err || mark != 2) == 0

We need to check there was no error and the mark is 0.

You could use ASSERT_TRUE/ASSERT_FALSE instead, but I think it is better
to use two different assert: check 'err' is OK, then check the mark is
0, no?


> +		goto close_client;

Please see my previous comment on the v3:

It is not needed to stop earlier here, we should check everything we can
to give more info about the issue:

  err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
  ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
  ASSERT_EQ(mark, 0, "mark");

  err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
  ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");
  ASSERT_STREQ(new, cc, "cc");

> +
> +	len = sizeof(cc);
> +	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	ASSERT_OK(err || strcmp(cc, new), "getsockopt(client_fd, TCP_CONGESTION)");

(See above)

But after your modification in patch 1/3, 'cc' should be equal to
'/proc/sys/net/ipv4/tcp_congestion_control' (not 'new'). So you need to
get the value of the default CC first, then compare it to 'cc'. It
should be different from 'new' (except if 'new' == default cc from
/proc, so maybe enough to compare that 'cc' is the same as the default one).

>  
>  close_client:
>  	close(client_fd);
> @@ -416,6 +416,7 @@ static void test_subflow(void)
>  	int cgroup_fd, prog_fd, err;
>  	struct mptcp_subflow *skel;
>  	struct nstoken *nstoken;
> +	struct bpf_link *link;
>  
>  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
>  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> @@ -441,6 +442,11 @@ static void test_subflow(void)
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
> @@ -449,6 +455,7 @@ static void test_subflow(void)
>  	mptcp_subflow__destroy(skel);
>  close_cgroup:
>  	close(cgroup_fd);
> +	bpf_link__destroy(link);

That should be done just before 'close_netns' label, otherwise this will
be called with 'link' that has not been defined.

>  }
>  
>  static struct nstoken *sched_init(char *flags, char *sched)
> @@ -470,9 +477,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
>  	return NULL;
>  }
>  
> +static int ss_search(char *src, char *dst, char *port, char *keyword)

I guess this part should not be squashed in "selftests/bpf: Add mptcp
subflow subtest", but in a different patch ("selftests/bpf: Add bpf
scheduler test"), no?

If yes, and if you need to send a new version, please split that in a
separated patch, otherwise I might forget and apply this in
"selftests/bpf: Add mptcp subflow subtest" instead.

> +{
> +	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
> +			  NS_TEST, src, dst, port, PORT_1, keyword);
> +}
> +
>  static int has_bytes_sent(char *dst)
>  {
> -	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
> +	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
>  }
>  
>  static void send_data_and_verify(char *sched, bool addr1, bool addr2)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

