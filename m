Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1B632
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363807; cv=none; b=ph62XwwV8GerEblDpfvdR5mkAle9xm9tAP9gx17vPe7Hdl9/q9UF7jIkxFjcThFjmvd+vG0TKnDYSAUqhicdjkuAY3Ni6K/gO4z5tCivgTmtiNBHdHvCeGUZ10NRG5XveYEGhBmT/kDXAwWYhKNAGcKnf7mWNaOzzttzOWVUT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363807; c=relaxed/simple;
	bh=x+QI3YYgLEgpOruIZAH4r7n/aX46cqUE/ofnj1qaqhU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VDSJq7RQ9Eo2T2nGlBgmwrxWqcEn1Da9pA0xVZRsXMk0Jk/V91vP4ox5GvYLNPXRvW5z/WN8lfbJ9DVacCHYJf9rFE5WL1grPTwjvy0/Dtb+pmZQUttHf1320tzQXlr9fc5VXpBPBWOc0lkOidfeMs8LO8i6SYQOAP73sPesY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcypI/nW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcypI/nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A869DC433F1;
	Sat,  6 Apr 2024 00:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363806;
	bh=x+QI3YYgLEgpOruIZAH4r7n/aX46cqUE/ofnj1qaqhU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BcypI/nW5Pjiqw8tBk1+mE4cqEtiogOjDKrRAGprVySKbmtUPXKRXSaggZAtEJMKS
	 HdYzutQ/zmQX0x1Xd6399+IJXJgoTHiJRkiDjXrJnCWF+Jq7cifqFSVDvhhTRfu+m0
	 SIJFdJUuapDuNp8yRFjZyIdIXwc6S6Vl3h/GvoSqevW0YLwD+cHaNfeDjKCuIlwsmR
	 P9mjlG3yUbQIrDY4g7tf+hygeEe4vsCilKngFZ5hkjo0tkxSTXwf2RFCKtPsWAOkLm
	 7qnRPrdu+tRuctoZrCEulUf7NJclXAS2DpX/i80nhWReEkjXrZXgoWXBRRX9gBfwxo
	 iqz9uGa6tQlUA==
Date: Fri, 5 Apr 2024 17:36:46 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 6/8] selftests/bpf: Add mptcp subflow
 example
In-Reply-To: <1d61922711dc017c4cd323199fc5341908a40b69.1712042529.git.tanggeliang@kylinos.cn>
Message-ID: <ca061adc-be94-b9a9-4c4c-72f8c311659f@kernel.org>
References: <cover.1712042529.git.tanggeliang@kylinos.cn> <1d61922711dc017c4cd323199fc5341908a40b69.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 2 Apr 2024, Geliang Tang wrote:

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

Hi Geliang -

I suggest updating Nicolas' phrasing here to instead say:

/* Set the mark of the subflow's socket based on appearance order */

"Apparition" means something different :)


Also, I couldn't get this series to apply to the export branch (or recent 
export tags) even with the referenced bpf-next series and "refactor mptcp 
bpf tests". When multiple series have dependencies, could you push a 
branch to git.kernel.org and reference that in the cover letter?

Thanks,

- Mat

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
