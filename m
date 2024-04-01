Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CF4CE04
	for <mptcp@lists.linux.dev>; Mon,  1 Apr 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991188; cv=none; b=B7SWK63f3sC/qxklbFZWFVdJ6YapDJVxg78gf3oIOcFoyQJrw/dc5g1L3qDJTGzKsRobzTqgT3pJ8KgaMkaC6CI3MdNqz6g0RPkF5lHJ5qSnNLgy3UKFTcVCTc3Ah1kjAzaQKrCJaWVav6jv5gquX8SWUyCXWjh4njR0Jmi4gyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991188; c=relaxed/simple;
	bh=MFTVcAPNKRyLCGjQ/9JxO4VhWpNWRoItzGaWGHnMexE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sll1X9ySMk0mf0O3A/iRRPld+kPz1G1tuOZrVetKk3ZVO1FCHci5MNsev39A4upOEv+Qo/lO+VBVPQ21UGZDZneC/QqN9VF39z2OposYmzaR0clwwVjwHVtkMGQuF/i6DX5FfnDR+4R73nA+cmGhfbRideudYbqJuhBRqSLHTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnu91NMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnu91NMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF35C43390;
	Mon,  1 Apr 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711991188;
	bh=MFTVcAPNKRyLCGjQ/9JxO4VhWpNWRoItzGaWGHnMexE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Nnu91NMdeKpn2+P8fwfjySrLm1MVgijqprzrOGPlOBw5AjCyA1d4QruaR9XGgpCxa
	 chvlM+eZvTpddWq3S8RGCuTe0isw1NoIC8sYybnxafp2ExQGox815fOBI7SzSzCIgu
	 FHCKmn7R3o1qSmNvyqer/Z3NtYoEBR1mRapyvcuoM4uiUpiT1SLcx0/zwMS+TiMbN8
	 2QIJaBMvtXkI8SIT7J/SrJAylRl0U2hdGbMcTkH/1KBdsssynPXHtR9cU+sSCp/5gU
	 siTsWqcs63fKRHcqswyexTGmz3aBVP/fkq5Bfplu2DBCamTiy1ySDsQy6DLeIwXoQq
	 u9oWekPlLgndA==
Date: Mon, 1 Apr 2024 10:06:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 06/14] selftests/bpf: Add mptcp subflow
 example
In-Reply-To: <e74823731ffc54c1512611c251cc6f7aa30d5926.1711612876.git.tanggeliang@kylinos.cn>
Message-ID: <4843ee1e-5983-34be-31a6-02b358616613@kernel.org>
References: <cover.1711612876.git.tanggeliang@kylinos.cn> <e74823731ffc54c1512611c251cc6f7aa30d5926.1711612876.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 28 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Move Nicolas's patch into bpf selftests directory. This example added a
> test that was adding a different mark (SO_MARK) on each subflow, and
> changing the TCP CC only on the first subflow.
>
> This example shows how it is possible to:
>
>    Identify the parent msk of an MPTCP subflow.
>    Put different sockopt for each subflow of a same MPTCP connection.
>
> Here especially, we implemented two different behaviours:
>
>    A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
>    MPTCP connection. The order of creation of the current subflow defines
>    its mark. The TCP CC algorithm of the very first subflow of an MPTCP
>    connection is set to "reno".
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Hi Geliang -

This patch (and patch 07/14) are listed as "New" in patchwork, while the 
rest of the series is superseded by "refactor mptcp bpf tests".

Do patches 6 and 7 of this series still need review? Are there any 
dependencies on the "refactor bpf tests" series?


Thanks,
Mat


> ---
> .../selftests/bpf/progs/mptcp_subflow.c       | 73 +++++++++++++++++++
> 1 file changed, 73 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> new file mode 100644
> index 000000000000..9553099ffd5f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020, Tessares SA. */
> +/* Copyright (c) 2024, Kylin Software */
> +/* Author: Nicolas Rybowski */
> +
> +#include <sys/socket.h> // SOL_SOCKET, SO_MARK, ...
> +#include <linux/tcp.h>  // TCP_CONGESTION
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#ifndef SOL_TCP
> +#define SOL_TCP 6
> +#endif
> +
> +#ifndef TCP_CA_NAME_MAX
> +#define TCP_CA_NAME_MAX 16
> +#endif
> +
> +char cc[TCP_CA_NAME_MAX] = "reno";
> +
> +/* Associate a subflow counter to each token */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 100);
> +} mptcp_sf SEC(".maps");
> +
> +SEC("sockops")
> +int mptcp_subflow(struct bpf_sock_ops *skops)
> +{
> +	__u32 init = 1, key, mark, *cnt;
> +	struct mptcp_sock *msk;
> +	struct bpf_sock *sk;
> +	int err;
> +
> +	if (skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
> +		return 1;
> +
> +	sk = skops->sk;
> +	if (!sk)
> +		return 1;
> +
> +	msk = bpf_skc_to_mptcp_sock(sk);
> +	if (!msk)
> +		return 1;
> +
> +	key = msk->token;
> +	cnt = bpf_map_lookup_elem(&mptcp_sf, &key);
> +	if (cnt) {
> +		/* A new subflow is added to an existing MPTCP connection */
> +		__sync_fetch_and_add(cnt, 1);
> +		mark = *cnt;
> +	} else {
> +		/* A new MPTCP connection is just initiated and this is its primary
> +		 *  subflow
> +		 */
> +		bpf_map_update_elem(&mptcp_sf, &key, &init, BPF_ANY);
> +		mark = init;
> +	}
> +
> +	/* Set the mark of the subflow's socket to its apparition order */
> +	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
> +	if (err < 0)
> +		return 1;
> +	if (mark == 1)
> +		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
> +
> +	return 1;
> +}
> -- 
> 2.40.1
>
>
>
