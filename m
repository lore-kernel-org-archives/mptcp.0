Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033442A9B
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026599; cv=none; b=GQLGUrGR2MbAnF1oiqeobjyYGMtncBpCe67ppZwfQWW+rgO5c731TM1a2+tQtSLeA4cNEcuQtBMcb201qGMQJTM3UzA4isO7P8u7aWAtzf/DZtxKO44ZD1Ga1oZwyTJbXUqr62EijsVmlqn8zgrjSi2pNvn29eUhkNuHTy8mBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026599; c=relaxed/simple;
	bh=A9Nn1hluRjufWa+pbptpdXeIycgDQt4ghv5H/C95ce0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udJfcvlmxIFivFVbfrSGBpsI6CZGimXQWl6zkuFwQE/x8z5uBIOat0tkzvQaM8aLkrpcbvuRbK6/hd1vQVI6/lWdxR7a4Z7yI+2m3I5PKF26gI9c59HHDrSTNfHfAY9Mqc7m72/mW4wSa9a7Po1SmCAvR1VS59VgU5qUi6M5iHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anaUTbpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anaUTbpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436BBC4CEC5;
	Wed, 11 Sep 2024 03:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726026599;
	bh=A9Nn1hluRjufWa+pbptpdXeIycgDQt4ghv5H/C95ce0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=anaUTbpdM4kq9BZXEM7RPlW51GlDDXQTf8H3QjB6rMrRlniPOm4Atmidzz5v3pin8
	 W4p3NyGxDHZmzGDXDoRka2xTAuUkcvgUNHU3JZpR7yMpoeG7UzUb9hVb1MosIdPnMC
	 vv/KxXwwabAa9ppFFASlAokd5I1PM8yUZQd2KURvHpmqw13EbRjPeAv9noWd5Hyh48
	 zBxJGHyt1oyOekPzcqbZD6Gt1nRLsVoJa3o3fAfM7SwqwEpBNBfI6NlcNU5pgOwuXa
	 XsG+DL0Qtt37z6HyINGJskqqe4c5EPvlBOLTLtDEeklGafIbigRxvACH5rXYaYWpsN
	 UeVub2xWEradg==
Message-ID: <dfdcf43235a9520605a0540f87ab76e9e62f3b3c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf
 scheduler test" - drop has_bytes_sent
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 11 Sep 2024 11:49:53 +0800
In-Reply-To: <f27360078ccfc5c9324d2f2fbd3207e3bc553b3c.1725959373.git.tanggeliang@kylinos.cn>
References: 
	<f27360078ccfc5c9324d2f2fbd3207e3bc553b3c.1725959373.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-10 at 17:10 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Drop ss_search() and has_bytes_sent(), add a new bpf program to check
> the bytes_sent.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - address Matt's comments. (thanks)
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++++++-------
> --
>  .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 36 ++++++++++++++
>  2 files changed, 62 insertions(+), 22 deletions(-)
>  create mode 100644
> tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 2476f0a083bc..273039ecd7ac 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -10,6 +10,7 @@
>  #include "mptcp_sock.skel.h"
>  #include "mptcpify.skel.h"
>  #include "mptcp_subflow.skel.h"
> +#include "mptcp_bpf_bytes.skel.h"
>  #include "mptcp_bpf_first.skel.h"
>  #include "mptcp_bpf_bkup.skel.h"
>  #include "mptcp_bpf_rr.skel.h"
> @@ -489,56 +490,59 @@ static struct nstoken *sched_init(char *flags,
> char *sched)
>  	return NULL;
>  }
>  
> -static int ss_search(char *src, char *dst, char *port, char
> *keyword)
> -{
> -	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s
> %s %d | grep -q '%s'",
> -			  NS_TEST, src, dst, port, PORT_1, keyword);
> -}
> -
> -static int has_bytes_sent(char *dst)
> -{
> -	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
> -}
> -
>  static void send_data_and_verify(char *sched, bool addr1, bool
> addr2)
>  {
> +	int server_fd, client_fd, err;
> +	struct mptcp_bpf_bytes *skel;
>  	struct timespec start, end;
> -	int server_fd, client_fd;
>  	unsigned int delta_ms;
>  
> +	skel = mptcp_bpf_bytes__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load: bytes"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	err = mptcp_bpf_bytes__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach: bytes"))
> +		goto skel_destroy;
> +
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>  	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
> -		return;
> +		goto skel_destroy;
>  
>  	client_fd = connect_to_fd(server_fd, 0);
>  	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
> -		goto fail;
> +		goto close_server;
>  
>  	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
> -		goto fail;
> +		goto close_client;
>  
>  	if (!ASSERT_OK(send_recv_data(server_fd, client_fd,
> total_bytes),
>  		       "send_recv_data"))
> -		goto fail;
> +		goto close_client;
>  
>  	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
> -		goto fail;
> +		goto close_client;
>  
>  	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec
> - start.tv_nsec) / 1000000;
>  	printf("%s: %u ms\n", sched, delta_ms);
>  
>  	if (addr1)
> -		CHECK(has_bytes_sent(ADDR_1), sched, "should have
> bytes_sent on addr1\n");
> +		ASSERT_GT(skel->bss->bytes_sent_1, 0, "should have
> bytes_sent on addr1");
>  	else
> -		CHECK(!has_bytes_sent(ADDR_1), sched, "shouldn't
> have bytes_sent on addr1\n");
> +		ASSERT_EQ(skel->bss->bytes_sent_1, 0, "shouldn't
> have bytes_sent on addr1");
>  	if (addr2)
> -		CHECK(has_bytes_sent(ADDR_2), sched, "should have
> bytes_sent on addr2\n");
> +		ASSERT_GT(skel->bss->bytes_sent_2, 0, "should have
> bytes_sent on addr2");
>  	else
> -		CHECK(!has_bytes_sent(ADDR_2), sched, "shouldn't
> have bytes_sent on addr2\n");
> +		ASSERT_EQ(skel->bss->bytes_sent_2, 0, "shouldn't
> have bytes_sent on addr2");
>  
> +close_client:
>  	close(client_fd);
> -fail:
> +close_server:
>  	close(server_fd);
> +skel_destroy:
> +	mptcp_bpf_bytes__destroy(skel);
>  }
>  
>  static void test_default(void)
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> new file mode 100644
> index 000000000000..aa84b137f344
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024, Kylin Software */
> +
> +/* vmlinux.h, bpf_helpers.h and other 'define' */
> +#include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
> +
> +char _license[] SEC("license") = "GPL";
> +u64 bytes_sent_1 = 0;
> +u64 bytes_sent_2 = 0;
> +int pid;
> +
> +SEC("fexit/mptcp_sched_get_send")
> +int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;

Superseded. I prefer to add this check here:

	if (!msk->pm.server_side)
		return 0;

Update in v3.

Thanks,
-Geliang

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct tcp_sock *tp;
> +		struct sock *ssk;
> +
> +		subflow = bpf_core_cast(subflow, struct
> mptcp_subflow_context);
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		tp = bpf_core_cast(ssk, struct tcp_sock);
> +
> +		if (subflow->subflow_id == 1)
> +			bytes_sent_1 = tp->bytes_sent;
> +		else if (subflow->subflow_id == 2)
> +			bytes_sent_2 = tp->bytes_sent;
> +	}
> +
> +	return 0;
> +}

