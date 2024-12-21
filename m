Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA917C68
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744525; cv=none; b=jnSqFLxxydAhXE6+tL6oSEyc1qY7/MxBaEAUtCH6l/ofQVVl1mpdlz0pCUZmihr8BojDe5uIM2xWOKWbUGz/GeDsBkQVSv7zSua3B8w4S2azIepIBwim5mZ88kIjp/Od9ROIIUF93aI4HJmcqvBoIyFsoFsmHxL5ExPFwm34TOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744525; c=relaxed/simple;
	bh=m4xcxa1OKJkKtC9XlVCPYv5RYtu7xhoj8TefD+VOb1o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vApG0vdSrt2fW2SBp8+pTlCsHIKLUcpvOiO6C5/+v7+bMUAeVWkNsdwJ8oX8djDAW2YZwBvmhpN9VYwM0Tsebe4Hepvn7+XLSs5J+DfqzVuMCWtT89wig865f5FhTKL8DxsKlNZoWCCTRWfNopKwPvACX2RIbjDoNRhCqdoJr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIP+lh+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIP+lh+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C92C4CECD;
	Sat, 21 Dec 2024 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734744524;
	bh=m4xcxa1OKJkKtC9XlVCPYv5RYtu7xhoj8TefD+VOb1o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bIP+lh+zwcFlvoj1Xu1+SXMKiBNNXptnd26TXifM2DjfEEkir6wdm9uwdSMg4Es6U
	 ruHODBKGgVCPcVz6HJLq+FcmCcR0W4CtyGDYhAEqRg50jZCCoXKhZkT/sZDBcLbhlC
	 GzNjoFN5NJGkKO/4/PZNwIb4nElTxbMskQHJt5VcQkahqzS/MUROLBW/qF2ZbWNqkN
	 3sD1G8uFNx+KdRr/NEO7ZUn6dEGnzlrbG5+5I3vhANwIz/wc8XcROVyBtce1LNfQbY
	 4o3zH3qGIEV36JvNxDLpo9ttpPO1C4W0hpHas0+Lj4JTUc6Bod8/h4yj2U24w/xw02
	 TwANSbqTGSPww==
Date: Fri, 20 Dec 2024 17:28:43 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, baohua@kernel.org, 
    Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 2/8] Squash to "selftests/bpf: Add bpf_first
 scheduler & test"
In-Reply-To: <e57ac76105430bab4bbc5ac4f62c77e883dd7f29.1732153672.git.tanggeliang@kylinos.cn>
Message-ID: <b5ca9ddf-77a9-dd73-e485-71ec6f354054@kernel.org>
References: <cover.1732153672.git.tanggeliang@kylinos.cn> <e57ac76105430bab4bbc5ac4f62c77e883dd7f29.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 21 Nov 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Split get_subflow() interface into two: get_send() and get_retrans().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../selftests/bpf/progs/mptcp_bpf_first.c     | 24 +++++++++++++++----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> index d57399b407a7..36bf9adffb2c 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -16,18 +16,32 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
> {
> }
>
> -SEC("struct_ops")
> -int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> -	     struct mptcp_sched_data *data)
> +static int bpf_first_get_subflow(struct mptcp_sock *msk,
> +				 struct mptcp_sched_data *data)
> {
> 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
> 	return 0;
> }
>
> -SEC(".struct_ops")
> +SEC("struct_ops")
> +int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
> +	     struct mptcp_sched_data *data)
> +{
> +	return bpf_first_get_subflow(msk, data);
> +}
> +
> +SEC("struct_ops")
> +int BPF_PROG(bpf_first_get_retrans, struct mptcp_sock *msk,
> +	     struct mptcp_sched_data *data)
> +{
> +	return bpf_first_get_subflow(msk, data);
> +}

Hi Geliang -

If my suggestion in patch 1 (use get_send for retransmit scheduling if 
get_retrans is NULL) doesn't seem like clear enough behavior for BPF 
scheduler authors, this code and the following patches could be simplified 
by removing the duplicate _retrans function above...

> +
> +SEC(".struct_ops.link")
> struct mptcp_sched_ops first = {
> 	.init		= (void *)mptcp_sched_first_init,
> 	.release	= (void *)mptcp_sched_first_release,
> -	.get_subflow	= (void *)bpf_first_get_subflow,
> +	.get_send	= (void *)bpf_first_get_send,
> +	.get_retrans	= (void *)bpf_first_get_retrans,

... and setting get_retrans like this:
 	.get_retrans	= (void *)bpf_first_get_send,

Then there would be example code for BPF scheduler programmers to see that 
it's ok to use the same function pointer in both fields.

- Mat

> 	.name		= "bpf_first",
> };
> -- 
> 2.43.0
>
>
>
