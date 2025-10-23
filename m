Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7872FABE7
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214727; cv=none; b=Wfo/wjUl7/wBIV9tv1cN5Hzpul7eqJOXvD5GTcRw+PsjNDbxmgYRh4fOzpvdAkCmi6sCTZor86juHTDgHctIJ5pJX9wlOVo3WFNz4dgfCujYjG4c7YyFwataeWcHCb0DVeLesixHcoPNHN8znSHxl7suyLfkcfZk0/AsOLTsaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214727; c=relaxed/simple;
	bh=VSlWVnkKS6AqcpROj4gNhqpk+RjaI5RZYdNcj5kPyX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXxcN3ruLJ1XWPxpM/87kD34Noy0aBbS73ngs2j7X1QL+LM4Pld9GUV7FtyZDFYAh/GPS+kIc0JjBer1MJAtBjuZ/QDQF272KB7Kn2IaoOuzkUHWxSRxgTAAHB6gS1PNesy28S0v30HKIE0DVSj9imqa0lQBY6CESg7nS0xyUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ain3tVBL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ain3tVBL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso1075925a12.0
        for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761214724; x=1761819524; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yg7N1eLYpXeNqlITcuenmZuFMj2qpjsYfuE4Coq/2M=;
        b=ain3tVBL+IAkXdA4BjTrLywSbov/3RJZmRm87zQfDH2Ma3/u4C6U31aAQFoTaIbrF4
         rudeBYbWrOajX8zGaigO84wTanjrPjkxbDYHakD6h+64LpYxTOVGcXm/R7HWQ8mGtFd/
         2yyK0ac71Ek3u9RKdcveOnZ3p1A2qOoT74btttGKRPHpqnsYiB7Rtkq7RvgU9vwibfx/
         fzsNffvEfg00F+8odPDOC2/lrJwK/j0KQmvQMMfuaQbor8SuoamHuDzdUJUAsfVhbcVa
         HzbEuXuRhnbVSmtVjXZtT2yO303N8zOag2ykuFjKbE8lVHkdqm+LoKtSEurZIOVSrYhb
         DT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214724; x=1761819524;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yg7N1eLYpXeNqlITcuenmZuFMj2qpjsYfuE4Coq/2M=;
        b=ZGtzJlVfLUOv0mZm7h1v7UQMRkemCmnnwWvMFe3tBKuHePT8C6zgDgkYO6jv8wKQNc
         5Sft9b9PK4Fv5t7ErBYMx7l3wTuD3+p1S/+pb4Ge1tBRCro4hw2hQDpnzqp4gv9czJGV
         ckXi21W2YW6HbzVZr98bCLNJbKgdc23yOXhjXO1wrCOxkTpvTtmlcCfyfciUVc2NJOeG
         4CmjwtKq43p5y3q1rcWT6SRLolpy9/ODbkSURZlRilVM0+vLYfbjPEE5Eumv7l1bM0HA
         aHQGGY8AB1B+Ub6Y4Z/fH0y5p6nwwqIwpqUexaQjhnUHXOn+zkSbcolH2UysxEhPnQt8
         5HCg==
X-Gm-Message-State: AOJu0YxUpN30p8HNHH+WNwByFQH2XVDLfw7tYU3bI0fY3OHc2G1X7Nss
	l++wvoV0AaoSXti15Nvh0OyM2/KcKXYyk6PXkYQthSUAndm2p5mlkCpCAiJANzYbUkk=
X-Gm-Gg: ASbGncvl5EYaPSTDmLYT7jAbi2ZjJLtbf+ZXFAuogVphW1j5zgYv4Kit8MADUhhcxBp
	+sNNZHk62eKx3bUsomzxIxuVM2WP3EQllpmBK0138MxNHoELtzKLGayiXY5zJrXbaIFirwQ1PMR
	G5tMbNnliH50OcucY0c87HCN9YzfqhLWiKJLT3OeiXQH8jl8P8tnL7ehElS2hlTBAF0nlvlVoQw
	b08D7rDLxqrB3JZnfMmYBt9rbNVOmgygesOMUzo6dX3sn7mRNGbcLlqpId9PFFxdFONy8N7XyNd
	t0GGRq37COOLmdBwFiCtbt+Auawow9ZlW8/BEkrtCSaE9IvAHsawlAhVITFin01NyhGFrNVdb0m
	LHzGot72P8PX2wLE19wz38TaoGJv+wDveBxJrrCKh/WBKyZ/Wjbcqkn8x3zSlWPV2zvreN33Erw
	9x1FtPgX/TgnuMwg==
X-Google-Smtp-Source: AGHT+IGGrUZ+VVMpCvZMybd44OLBtACqmnVl06t9ARNOxcZxhBi1nSUsnpCbEnWD1158x71c60T+Jw==
X-Received: by 2002:a17:907:7ea6:b0:b3e:3c1c:d2f2 with SMTP id a640c23a62f3a-b6474940fc1mr3104761866b.36.1761214723959;
        Thu, 23 Oct 2025 03:18:43 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:7f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316b64sm1316953a12.22.2025.10.23.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:18:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  John Fastabend <john.fastabend@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] selftests/bpf: Add mptcp test with sockmap
In-Reply-To: <20251020060503.325369-4-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:48 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-4-jiayuan.chen@linux.dev>
Date: Thu, 23 Oct 2025 12:18:42 +0200
Message-ID: <87v7k5vs3h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> Add test cases to verify that when MPTCP falls back to plain TCP sockets,
> they can properly work with sockmap.
>
> Additionally, add test cases to ensure that sockmap correctly rejects
> MPTCP sockets as expected.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
>  .../selftests/bpf/progs/mptcp_sockmap.c       |  43 ++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index f8eb7f9d4fd2..54459b385439 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,11 +6,14 @@
>  #include <netinet/in.h>
>  #include <test_progs.h>
>  #include <unistd.h>
> +#include <error.h>
>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
> +#include "socket_helpers.h"
>  #include "mptcp_sock.skel.h"
>  #include "mptcpify.skel.h"
>  #include "mptcp_subflow.skel.h"
> +#include "mptcp_sockmap.skel.h"
>  
>  #define NS_TEST "mptcp_ns"
>  #define ADDR_1	"10.0.1.1"
> @@ -436,6 +439,137 @@ static void test_subflow(void)
>  	close(cgroup_fd);
>  }
>  
> +/* Test sockmap on MPTCP server handling non-mp-capable clients. */
> +static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
> +{
> +	int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
> +	int server_fd1 = -1, server_fd2 = -1, sent, recvd;
> +	char snd[9] = "123456789";
> +	char rcv[10];
> +
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "redirect:start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd1, "redirect:connect_to_fd"))
> +		goto end;
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	skel->bss->sk_index = 1;
> +	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd2, "redirect:connect_to_fd"))
> +		goto end;
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	/* test normal redirect behavior: the data sent by client_fd1 can be
> +	 * received by client_fd2
> +	 */
> +	skel->bss->redirect_idx = 1;
> +	sent = xsend(client_fd1, snd, sizeof(snd), 0);
> +	if (!ASSERT_EQ(sent, sizeof(snd), "redirect:xsend(client_fd1)"))
> +		goto end;
> +
> +	/* try to recv more byte to avoid truncation check */
> +	recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);
> +	if (!ASSERT_EQ(recvd, sizeof(snd), "redirect:recv(client_fd2)"))
> +		goto end;
> +
> +end:
> +	if (client_fd1 > 1)
> +		close(client_fd1);
> +	if (client_fd2 > 1)
> +		close(client_fd2);
> +	if (server_fd1 > 0)
> +		close(server_fd1);
> +	if (server_fd2 > 0)
> +		close(server_fd2);
> +	close(listen_fd);
> +}
> +
> +static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> +{
> +	int listen_fd = -1, server_fd = -1;
> +	int client_fd1 = -1, client_fd2 = -1;
> +	int err, zero = 0;
> +
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	client_fd1 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
> +		goto end;
> +	/* sockmap helper called from sockops prog should reject mptcp sk */
> +	if (ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
> +		goto end;

I'm confused. Should we bail out (goto end) if EOPNOTSUPP is *not*
returned? That is "if (!ASSERT_EQ(...))".

> +
> +	/* skip sockops prog */
> +	skel->bss->trace_port = -1;
> +	client_fd2 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd2, "connect_to_fd client_fd2"))
> +		goto end;
> +
> +	server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &server_fd, BPF_NOEXIST);
> +	if (ASSERT_EQ(err, -EOPNOTSUPP, "should reject"))
> +		goto end;

Same here. The check seems backward.

> +end:
> +	if (client_fd1 > 0)
> +		close(client_fd1);
> +	if (client_fd2 > 0)
> +		close(client_fd2);
> +	if (server_fd > 0)
> +		close(server_fd);
> +	close(listen_fd);
> +}
> +
> +static void test_mptcp_sockmap(void)
> +{
> +	struct mptcp_sockmap *skel;
> +	struct netns_obj *netns;
> +	int cgroup_fd, err;
> +
> +	cgroup_fd = test__join_cgroup("/mptcp_sockmap");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_sockmap"))
> +		return;
> +
> +	skel = mptcp_sockmap__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_sockmap"))
> +		goto close_cgroup;
> +
> +	skel->links.mptcp_sockmap_inject =
> +		bpf_program__attach_cgroup(skel->progs.mptcp_sockmap_inject, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.mptcp_sockmap_inject, "attach sockmap"))
> +		goto skel_destroy;
> +
> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.mptcp_sockmap_redirect),
> +			      bpf_map__fd(skel->maps.sock_map),
> +			      BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
> +		goto skel_destroy;
> +
> +	netns = netns_new(NS_TEST, true);
> +	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_sockmap"))
> +		goto skel_destroy;
> +
> +	if (endpoint_init("subflow") < 0)
> +		goto close_netns;
> +
> +	test_sockmap_with_mptcp_fallback(skel);
> +	test_sockmap_reject_mptcp(skel);
> +
> +close_netns:
> +	netns_free(netns);
> +skel_destroy:
> +	mptcp_sockmap__destroy(skel);
> +close_cgroup:
> +	close(cgroup_fd);
> +}
> +
>  void test_mptcp(void)
>  {
>  	if (test__start_subtest("base"))
> @@ -444,4 +578,6 @@ void test_mptcp(void)
>  		test_mptcpify();
>  	if (test__start_subtest("subflow"))
>  		test_subflow();
> +	if (test__start_subtest("sockmap"))
> +		test_mptcp_sockmap();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sockmap.c b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> new file mode 100644
> index 000000000000..d4eef0cbadb9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_tracing_net.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int sk_index;
> +int redirect_idx;
> +int trace_port;
> +int helper_ret;
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 100);
> +} sock_map SEC(".maps");
> +
> +SEC("sockops")
> +int mptcp_sockmap_inject(struct bpf_sock_ops *skops)
> +{
> +	struct bpf_sock *sk;
> +
> +	/* only accept specified connection */
> +	if (skops->local_port != trace_port ||
> +	    skops->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
> +		return 1;
> +
> +	sk = skops->sk;
> +	if (!sk)
> +		return 1;
> +
> +	/* update sk handler */
> +	helper_ret = bpf_sock_map_update(skops, &sock_map, &sk_index, BPF_NOEXIST);
> +
> +	return 1;
> +}
> +
> +SEC("sk_skb/stream_verdict")
> +int mptcp_sockmap_redirect(struct __sk_buff *skb)
> +{
> +	/* redirect skb to the sk under sock_map[redirect_idx] */
> +	return bpf_sk_redirect_map(skb, &sock_map, redirect_idx, 0);
> +}
