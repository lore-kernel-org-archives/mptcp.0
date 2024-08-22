Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A2183CAB
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324221; cv=none; b=dA7OeMusRAM68rtEN9Dm6j7YOgdVmUNkCsL82IRmt/hpn1VAN4fbWU0agVG3c1dccQ14brPo0I/FD4Sm03p1ZtZeAM+1Uor+NW7DtFkiNfExxKuJnawyZQ6VQSfoHusEUEYQvUyEuDjuAznjpyv3cN71WVyHsBW6BNJ+X64hw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324221; c=relaxed/simple;
	bh=ww2luN3WXl4Q6pJ1rKsAMBi/lacLN4v7znRN8OGriOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cModpwc93jcox7cbgAFC4MWMsreEOHOrS3sM447A7ufzNG9Oe9Xaf7yshORhAbL+2/3xswRmnkWcCncIDv+ZndoEYN6KNX8ZyzIIAqP+rYX7Q9lBGNhxDwjdr17c28TeR4Q26fvJx3q1NSuN+QcF38S2GBnGZnqBuVlnBCmnfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXEXTOz6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXEXTOz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8123C32782;
	Thu, 22 Aug 2024 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724324221;
	bh=ww2luN3WXl4Q6pJ1rKsAMBi/lacLN4v7znRN8OGriOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EXEXTOz6FeWmx9/yl9e1okgd5vQO2RD1UPhSZciG01tLtaYXTo2CV/XKt+tl5Topp
	 GbmKfNVUqXTVVaEYvUsniybU9x4m324MqXgmezX2oy7IIZplSJzL//Gzy70KlSsbj3
	 IDRxolJGst8GKIl0Rmh4oPbCUznbYZejNpP6O+dwBI92H37+X87B7PJ66QfO+zQTqs
	 g+m/NU2s8adiILEqIHMuMwkiy2e5PxQwV7H/HVUsgQEhbD/bgwWNz2snzHRfL+LTur
	 LsgiFymUEn5unS9gWKTlBzOP8jocnl/ea8HFEBINfLTkqsLmDecyw+P4lT4HIKtw40
	 vlZEL7vjwK6jw==
Message-ID: <c70ef113-0168-44f0-8e4e-ac5d7c75131d@kernel.org>
Date: Thu, 22 Aug 2024 12:56:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
 <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the update!

On 22/08/2024 11:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a "cgroup/getsockopt" way to inspect the subflows of a
> mptcp socket.
> 
> mptcp_for_each_stubflow() and other helpers related to list_dentry are
> added into progs/mptcp_bpf.h.
> 
> Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and use
> bpf_core_cast to cast a pointer to tcp_sock for readonly. It will allow
> to inspect all the fields in a tcp_sock.

Should this not be squashed in "selftests/bpf: Add mptcp subflow
subtest" as well?
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 23 ++++++++
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++++
>  .../selftests/bpf/progs/mptcp_subflow.c       | 55 +++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index d4c5209fbfaf..143ed1c756e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -371,6 +371,10 @@ static int endpoint_init(char *flags)
>  static void run_subflow(void)
>  {
>  	int server_fd, client_fd;
> +	char cc[TCP_CA_NAME_MAX];
> +	unsigned int mark;
> +	socklen_t len;
> +	int err;
>  
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>  	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> @@ -382,6 +386,18 @@ static void run_subflow(void)
>  
>  	send_byte(client_fd);
>  
> +	sleep(0.1);

Why do you need a sleep here? To make sure the extra subflow has been
created? It sounds safer to wait for an event here, no? Maybe simply with:

  #ifndef SOL_MPTCP
  #define SOL_MPTCP 284
  #endif

  #ifndef MPTCP_INFO
  #define MPTCP_INFO 1
  #endif

  (...)

  u8 subflows;
  int i;

  (...)

  len = sizeof(subflows);

  /* Wait max 1 sec for new subflows to be created */
  for (i = 0; i < 10; i++) {
      err = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);

      if (!err && subflows > 0)
          break;

      sleep(0.1);
  }

WDYT? It might make sense to add this in a new helper:

  wait_for_new_subflows(client_fd);


Also, just to be sure, when does the BPF program set the socket options
per subflow? When the subflows are created? Just to be sure it is always
done before this call to 'getsockopt()', and only once.

> +
> +	len = sizeof(mark);
> +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
> +	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))

Should we also check the value of 'mark' here?

> +		goto close_client;

Maybe it is not needed to stop earlier here, we can also check the value
of the TCP CC and have info about the two checks? But maybe we need to
return an error if this getsockopt() fails, but not the next one.

  err = getsockopt(TCP_CONGESTION) || err;

> +	len = sizeof(cc);
> +	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");

Here as well, we could check that 'cc' is the same as 'skel->data->cc',
because MPTCP will return the value from the first subflow.

Or, we change the BPF test to set a different TCP CC only on the second
subflow, then we compare this getsockopt() with the default value from
there:

  /proc/sys/net/ipv4/tcp_congestion_control

The validation in BPF will then check the value of the second subflow
and it should be 'reno'.


> +
> +close_client:
>  	close(client_fd);
>  close_server:
>  	close(server_fd);
> @@ -392,6 +408,7 @@ static void test_subflow(void)
>  	int cgroup_fd, prog_fd, err;
>  	struct mptcp_subflow *skel;
>  	struct nstoken *nstoken;
> +	struct bpf_link *link;
>  
>  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
>  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> @@ -417,6 +434,11 @@ static void test_subflow(void)
>  	if (endpoint_init("subflow") < 0)
>  		goto close_netns;
>  
> +	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
> +					  cgroup_fd);
> +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> +		goto close_netns;
> +
>  	run_subflow();
>  
>  close_netns:
> @@ -425,6 +447,7 @@ static void test_subflow(void)
>  	mptcp_subflow__destroy(skel);
>  close_cgroup:
>  	close(cgroup_fd);
> +	bpf_link__destroy(link);
>  }
>  
>  static struct nstoken *sched_init(char *flags, char *sched)
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 782f36ed027e..70d9f5888976 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -4,9 +4,44 @@
>  
>  #include <vmlinux.h>
>  #include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
>  
>  #define MPTCP_SUBFLOWS_MAX 8
>  
> +static inline int list_is_head(const struct list_head *list,
> +			       const struct list_head *head)
> +{
> +	return list == head;
> +}
> +
> +#define list_entry(ptr, type, member)					\
> +	container_of(ptr, type, member)
> +
> +#define list_first_entry(ptr, type, member)				\
> +	list_entry((ptr)->next, type, member)
> +
> +#define list_next_entry(pos, member)					\
> +	list_entry((pos)->member.next, typeof(*(pos)), member)
> +
> +#define list_entry_is_head(pos, head, member)				\
> +	list_is_head(&pos->member, (head))
> +
> +#define list_for_each_entry(pos, head, member)				\
> +	for (pos = list_first_entry(head, typeof(*pos), member);	\
> +	     !list_entry_is_head(pos, head, member);			\

I guess you cannot add 'cond_break' in the condition, because that's the
equivalent of 'break', right?

Also, just to be sure: can this 'cond_break' be used on all
architectures? If not, maybe best to have a "list_for_each_entry"
version that is specific to MPTCP subflows, with a "i < MPTCP_SUBFLOWS_MAX".

> +	     cond_break, pos = list_next_entry(pos, member))
> +
> +#define list_for_each_entry_safe(pos, n, head, member)			\
> +	for (pos = list_first_entry(head, typeof(*pos), member),	\
> +		n = list_next_entry(pos, member);			\
> +	     !list_entry_is_head(pos, head, member);			\

Same here for 'cond_break'.

> +	     cond_break, pos = n, n = list_next_entry(n, member))
> +
> +#define mptcp_for_each_subflow(__msk, __subflow)			\
> +	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
> +#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)		\
> +	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
> +
>  extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  					bool scheduled) __ksym;
>  
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> index bc572e1d6df8..e8cc157278d2 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -4,6 +4,7 @@
>  
>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>  #include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
> @@ -57,3 +58,57 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  
>  	return 1;
>  }
> +
> +static int _check_getsockopt_subflows_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +
> +		if (ssk->sk_mark != ++i)
> +			ctx->retval = -1;
> +	}

I think you should check here that 'i == 2', otherwise we are not
checking all the expected subflows.

> +
> +	return 1;
> +}
> +
> +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct inet_connection_sock *icsk;
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
> +
> +		if (ssk->sk_mark == 1 &&
> +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX))
> +			ctx->retval = -1;
> +	}

Same here, you should check the number of subflows that have been looked
at (2), otherwise the check might succeed, while not doing any or half
of the validation.

I think here it is better if the CC is modified on the second subflow,
so we iterate at least 2 times, and expect to find the modified CC. WDYT?

> +
> +	return 1;
> +}
> +
> +SEC("cgroup/getsockopt")
> +int _getsockopt_subflow(struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct mptcp_sock);
> +
> +	if (!msk || !msk->token)

Instead of checking the token, should you not check that

  sk->sk_protocol == IPPROTO_MPTCP

no?

Just checking if there is something written at "*msk + token offset"
looks a bit random to me, and not safe.

> +		return 1;
> +
> +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> +		return _check_getsockopt_subflows_mark(msk, ctx);
> +	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
> +		return _check_getsockopt_subflow_cc(msk, ctx);
> +
> +	return 1;
> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

