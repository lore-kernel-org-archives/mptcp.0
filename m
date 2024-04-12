Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA239FD5
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965983; cv=none; b=EIPESGO4pm69UVh4xHDJ6YO5wp7niFG2/rkFwwPMoICmnIsz9s81poilOsLOESrz5UNY5o6Oo5NfJZqasA5fEY6wTcuoTnSomMVkIDSbiKsdCjcD+mkxHx03EFVwSnsAGfMzlxn6RXpI57y+mECSMVcagm+EKf/9oyXEzwXAtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965983; c=relaxed/simple;
	bh=pN8PgqLD3pYv5Zj4r+wFUar4Gn2/Xwgmp4hMfv3La8E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ErLuf/gPhrodHncciMN5a+8cvwj5mycNK9Fn/c5b8kX2XhCVuXx6JEDlBVKUghspWZ7CxtSq0JUCW8LZysy0OzaERh31TBUr+8gL8DIEOPWF75SWDtDpzER5xd8yCm01sfVCY107FMVeweUOh8f8Ars5Uw4W/XcLe/p7tNgImQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe9reW2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe9reW2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF305C113CC;
	Fri, 12 Apr 2024 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965982;
	bh=pN8PgqLD3pYv5Zj4r+wFUar4Gn2/Xwgmp4hMfv3La8E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Oe9reW2yTH5RWGRDqJk1H1nzP4MKHGVmVK9dkH/jN+vw7oLEavUeKQ59/6mfEB65x
	 p7A7iq+o/ae137LTHZYNiv3Tr+QAhPrhGK/ZjjLaxyPPeVms4wd/qa9rkiUiO3JRmX
	 Qen2DTUzbkCcpvmeLYkAT6DZYIIyvQIAxF/Lsp3YP1CVkTnlPRBP7/SQ/TeOdqt8JZ
	 mkT/nDimDm0A2Kv1t2jGylE4fX03XVsFjNwGU1ZI8WndnO+wq/dGh8D1TxUQwLA4S1
	 272Ihw6KAeeb29w32qfDSFtSiTCE+G6ktRF0cQFbvwMBqphdLkWxTcZu96IeHG3qKp
	 RNqQK2OBntYPA==
Date: Fri, 12 Apr 2024 16:53:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 1/5] selftests/bpf: Add mptcp subflow
 example
In-Reply-To: <c53b80dff1b034d60b2e1d59eecab31b114a07c3.1712571740.git.tanggeliang@kylinos.cn>
Message-ID: <a86ffbcb-74d9-e17e-6c89-ec2f3fc1f594@kernel.org>
References: <cover.1712571740.git.tanggeliang@kylinos.cn> <c53b80dff1b034d60b2e1d59eecab31b114a07c3.1712571740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 8 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>

Hi Geliang -

For proper attribution could you update the git metadata to add Nicolas as 
the git "Author" and add a "Co-authored-by" tag with your name?

I think it would also be good to note that the code comes from commit 
4d120186e4d67cf6ee798ef9b97175b16863583d in our 
https://github.com/multipath-tcp/mptcp_net-next repo (the "scripts" 
branch)

Thanks,
Mat

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
> ---
> .../selftests/bpf/progs/mptcp_subflow.c       | 71 +++++++++++++++++++
> 1 file changed, 71 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> new file mode 100644
> index 000000000000..9bdafc0930f1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -0,0 +1,71 @@
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
> +		/* A new MPTCP connection is just initiated and this is its primary subflow */
> +		bpf_map_update_elem(&mptcp_sf, &key, &init, BPF_ANY);
> +		mark = init;
> +	}
> +
> +	/* Set the mark of the subflow's socket based on appearance order */
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
