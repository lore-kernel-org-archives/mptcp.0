Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBB22EE5
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260295; cv=none; b=T4WfOs1rZHviz0/ulVLAcGMOmk9fWhWcMtyFQDn20ugxY4nQhG3gGymKtsxz0Ha+fDuFWOgiDbMTFiUL7PJJmjm3B+ZsKYBymmSASZ3mAxxoeRgoGD3xGcVltJ7rU9+okil7000pN9ZNge9cMaKOkPDRyMRzof2BD4w9jksM8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260295; c=relaxed/simple;
	bh=8JKumlhpn3A6+F2TOW0S+A/ODxTsyVdk0KcNlkVae4g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AtVAzyIoLm/ast3SuRbq9ewC01wB80LngWAwv+vJuwL4KKRQQdZ9mIPB5u3D/O4Yk5NAgF0o/+DCr8U0LejPLJsaQV+FrvRmg1tbd5QJAl3+kIEcqDc1oD0iA+cSw2gnFMqROhS0dbxfzRoMMRnAxIeLPOITIdsy/neKIDcKF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxIzBP2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxIzBP2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C18DC4CEE3;
	Tue, 18 Mar 2025 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742260295;
	bh=8JKumlhpn3A6+F2TOW0S+A/ODxTsyVdk0KcNlkVae4g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mxIzBP2klPScShG7DWWsLwgkNT/g5C4g+Fm/BCeOJkVH7Z5uqau2BTGRDmBajkfmp
	 HaVd4qkzkl3pK1DpMz33NWaCInPvfA0X/vAMpPTHPIEfBmCAhTEvzo8KzCM+gVjBdU
	 hc2xR16YYIb2p7YYGCBUNef3LzFcX6CgdZEBzED7JkF2x7U6j0RaXyQ87di7iKNH1/
	 IXQAKopGOpgRtPsfDk/mnrPRwptqVt5e1oT6pSA+7DhvF7F9DmcLydAddefDizsCsO
	 fleXDjvKuWzW0qytqBXbtPcUwBLAWTUKX9TpzDT7ZM4oG7QMSVmk642u8upH3fhGrK
	 wSjYUkf9jucNg==
Date: Mon, 17 Mar 2025 18:11:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 3/8] Squash to "selftests/bpf: Add bpf
 scheduler test"
In-Reply-To: <c02d0f8555c7427d58155d34709f2c8250c8ee2c.1741226722.git.tanggeliang@kylinos.cn>
Message-ID: <321b3cb7-2bbf-1e93-7f92-9893caee01a7@kernel.org>
References: <cover.1741226722.git.tanggeliang@kylinos.cn> <c02d0f8555c7427d58155d34709f2c8250c8ee2c.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 6 Mar 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> A cleanup, move netns_new() out of sched_init().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +++++++++----------
> 1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index ac6f6a6f7700..bd824b19ee13 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -562,23 +562,16 @@ static void test_iters_subflow(void)
> 	close(cgroup_fd);
> }
>
> -static struct netns_obj *sched_init(char *flags, char *sched)
> +static int sched_init(char *flags, char *sched)
> {
> -	struct netns_obj *netns;
> -
> -	netns = netns_new(NS_TEST, true);
> -	if (!ASSERT_OK_PTR(netns, "netns_new"))
> -		return NULL;
> -
> -	if (endpoint_init("subflow", 2) < 0)
> +	if (endpoint_init(flags, 2) < 0)
> 		goto fail;
>
> 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
>
> -	return netns;
> +	return 0;
> fail:
> -	netns_free(netns);
> -	return NULL;
> +	return -1;

A small thing: since there's now only the 'return' on this error path, I 
suggest removing the goto and directly returning -1 above. Matthieu do you 
want to do this when applying, or just leave it as-is?

- Mat

> }
>
> static int ss_search(char *src, char *dst, char *port, char *keyword)
> @@ -636,11 +629,16 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
> static void test_default(void)
> {
> 	struct netns_obj *netns;
> +	int err;
>
> -	netns = sched_init("subflow", "default");
> +	netns = netns_new(NS_TEST, true);
> 	if (!netns)
> 		goto fail;
>
> +	err = sched_init("subflow", "default");
> +	if (!ASSERT_OK(err, "sched_init"))
> +		goto fail;
> +
> 	send_data_and_verify("default", WITH_DATA, WITH_DATA);
>
> fail:
> -- 
> 2.43.0
>
>
>
