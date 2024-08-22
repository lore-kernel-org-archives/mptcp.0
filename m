Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF81C9449
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333482; cv=none; b=cA2Ar74i18OWLNA2rXd3K8tDA2qN0B+KhtOQ5Y7xHTnn/X1AVtf0QDt0wo+04nM2JW0BkAMsh2u6OmxWJ8tFN31LjiY2VZvQoGJHX2+hm2o7cpcd76+ypkFZOqkqewOixhDLxYwfFZ2v9b0VhL7vsiuKqydEAB2aSLU8iqVD8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333482; c=relaxed/simple;
	bh=L/RDpmyFhvSh7FQDDFzS14CCmbh50Z1h8s+mJ+nxGc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S28RG+JU9HUgVvVpnwc48UOYvc7WeixjTiZB+E6lv3oNJDVCk0/lPrVQgcUCJ7xkA1feDsu3r+VW1ACCUm1a23gOgiQgMc+x5mTkDsjmZZsz6/yEtN8isQyee1DKIyQ790BQlVj0DQAn22+p2rCsaT0tL/sZk6DaW+fXkRnh7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afwnbaKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afwnbaKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A419C32782;
	Thu, 22 Aug 2024 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724333482;
	bh=L/RDpmyFhvSh7FQDDFzS14CCmbh50Z1h8s+mJ+nxGc0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=afwnbaKopewQzZqTAek46axkx6zAQOq/jiSs4eWq7oG+d7DjjJeRF1eCU/4mnVcog
	 /tSBUwQ1weHkIHd48eJv0/3SC2Elky9dAFwkSLhSRTvr1O0dXwqtNAG+dON/ykIWCF
	 lluZCGmcYomY7lzNsduE0HR6WUGvzVUTav1pB21/Q/AK0eche5yJKL9lR349wqxf2K
	 59E9dkF5uTbRJvF4QKTzZciCNdBle+AEt+IJ0w09iJ1GmvEOF4hG89DmvXfTF5LCuM
	 L+Qag4fNREd/4WDLr8KiYGlBuEEnVhWX4PbqAYFqheJTfB1J6E0/GkDTpN/LZ/zldT
	 3n8PHO3Cu99Lg==
Message-ID: <1cfb8506929db74e0494966b3599ced60c58e51e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/2] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Date: Thu, 22 Aug 2024 21:31:16 +0800
In-Reply-To: <c70ef113-0168-44f0-8e4e-ac5d7c75131d@kernel.org>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
	 <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
	 <c70ef113-0168-44f0-8e4e-ac5d7c75131d@kernel.org>
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

On Thu, 2024-08-22 at 12:56 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the update!
> 
> On 22/08/2024 11:22, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds a "cgroup/getsockopt" way to inspect the subflows
> > of a
> > mptcp socket.
> > 
> > mptcp_for_each_stubflow() and other helpers related to list_dentry
> > are
> > added into progs/mptcp_bpf.h.
> > 
> > Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list
> > and use
> > bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
> > allow
> > to inspect all the fields in a tcp_sock.
> 
> Should this not be squashed in "selftests/bpf: Add mptcp subflow
> subtest" as well?
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 23 ++++++++
> >  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++++
> >  .../selftests/bpf/progs/mptcp_subflow.c       | 55
> > +++++++++++++++++++
> >  3 files changed, 113 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index d4c5209fbfaf..143ed1c756e1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -371,6 +371,10 @@ static int endpoint_init(char *flags)
> >  static void run_subflow(void)
> >  {
> >  	int server_fd, client_fd;
> > +	char cc[TCP_CA_NAME_MAX];
> > +	unsigned int mark;
> > +	socklen_t len;
> > +	int err;
> >  
> >  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1,
> > 0);
> >  	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> > @@ -382,6 +386,18 @@ static void run_subflow(void)
> >  
> >  	send_byte(client_fd);
> >  
> > +	sleep(0.1);
> 
> Why do you need a sleep here? To make sure the extra subflow has been
> created? It sounds safer to wait for an event here, no? Maybe simply
> with:
> 
>   #ifndef SOL_MPTCP
>   #define SOL_MPTCP 284
>   #endif
> 
>   #ifndef MPTCP_INFO
>   #define MPTCP_INFO 1
>   #endif
> 
>   (...)
> 
>   u8 subflows;
>   int i;
> 
>   (...)
> 
>   len = sizeof(subflows);
> 
>   /* Wait max 1 sec for new subflows to be created */
>   for (i = 0; i < 10; i++) {
>       err = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);
> 
>       if (!err && subflows > 0)
>           break;
> 
>       sleep(0.1);
>   }
> 
> WDYT? It might make sense to add this in a new helper:
> 
>   wait_for_new_subflows(client_fd);
> 
> 
> Also, just to be sure, when does the BPF program set the socket
> options
> per subflow? When the subflows are created? Just to be sure it is
> always
> done before this call to 'getsockopt()', and only once.
> 
> > +
> > +	len = sizeof(mark);
> > +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark,
> > &len);
> > +	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
> 
> Should we also check the value of 'mark' here?
> 
> > +		goto close_client;
> 
> Maybe it is not needed to stop earlier here, we can also check the
> value
> of the TCP CC and have info about the two checks? But maybe we need
> to
> return an error if this getsockopt() fails, but not the next one.
> 
>   err = getsockopt(TCP_CONGESTION) || err;
> 
> > +	len = sizeof(cc);
> > +	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc,
> > &len);
> > +	ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");
> 
> Here as well, we could check that 'cc' is the same as 'skel->data-
> >cc',
> because MPTCP will return the value from the first subflow.
> 
> Or, we change the BPF test to set a different TCP CC only on the
> second
> subflow, then we compare this getsockopt() with the default value
> from
> there:
> 
>   /proc/sys/net/ipv4/tcp_congestion_control
> 
> The validation in BPF will then check the value of the second subflow
> and it should be 'reno'.
> 
> 
> > +
> > +close_client:
> >  	close(client_fd);
> >  close_server:
> >  	close(server_fd);
> > @@ -392,6 +408,7 @@ static void test_subflow(void)
> >  	int cgroup_fd, prog_fd, err;
> >  	struct mptcp_subflow *skel;
> >  	struct nstoken *nstoken;
> > +	struct bpf_link *link;
> >  
> >  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> >  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup:
> > mptcp_subflow"))
> > @@ -417,6 +434,11 @@ static void test_subflow(void)
> >  	if (endpoint_init("subflow") < 0)
> >  		goto close_netns;
> >  
> > +	link = bpf_program__attach_cgroup(skel-
> > >progs._getsockopt_subflow,
> > +					  cgroup_fd);
> > +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> > +		goto close_netns;
> > +
> >  	run_subflow();
> >  
> >  close_netns:
> > @@ -425,6 +447,7 @@ static void test_subflow(void)
> >  	mptcp_subflow__destroy(skel);
> >  close_cgroup:
> >  	close(cgroup_fd);
> > +	bpf_link__destroy(link);
> >  }
> >  
> >  static struct nstoken *sched_init(char *flags, char *sched)
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > index 782f36ed027e..70d9f5888976 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > @@ -4,9 +4,44 @@
> >  
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_core_read.h>
> > +#include "bpf_experimental.h"
> >  
> >  #define MPTCP_SUBFLOWS_MAX 8
> >  
> > +static inline int list_is_head(const struct list_head *list,
> > +			       const struct list_head *head)
> > +{
> > +	return list == head;
> > +}
> > +
> > +#define list_entry(ptr, type,
> > member)					\
> > +	container_of(ptr, type, member)
> > +
> > +#define list_first_entry(ptr, type,
> > member)				\
> > +	list_entry((ptr)->next, type, member)
> > +
> > +#define list_next_entry(pos,
> > member)					\
> > +	list_entry((pos)->member.next, typeof(*(pos)), member)
> > +
> > +#define list_entry_is_head(pos, head,
> > member)				\
> > +	list_is_head(&pos->member, (head))
> > +
> > +#define list_for_each_entry(pos, head,
> > member)				\
> > +	for (pos = list_first_entry(head, typeof(*pos),
> > member);	\
> > +	     !list_entry_is_head(pos, head,
> > member);			\
> 
> I guess you cannot add 'cond_break' in the condition, because that's
> the
> equivalent of 'break', right?

Hi Matt,

This confuses me.

I used this in v2:

	mptcp_for_each_subflow(msk, subflow) {
		... ...

		cond_break;
	}

And you suggested to add "cond_break" into list_for_each_entry().

Do you mean that I should go back to v2?

Regards,
-Geliang

> 
> Also, just to be sure: can this 'cond_break' be used on all
> architectures? If not, maybe best to have a "list_for_each_entry"
> version that is specific to MPTCP subflows, with a "i <
> MPTCP_SUBFLOWS_MAX".
> 
> > +	     cond_break, pos = list_next_entry(pos, member))
> > +
> > +#define list_for_each_entry_safe(pos, n, head,
> > member)			\
> > +	for (pos = list_first_entry(head, typeof(*pos),
> > member),	\
> > +		n = list_next_entry(pos,
> > member);			\
> > +	     !list_entry_is_head(pos, head,
> > member);			\
> 
> Same here for 'cond_break'.
> 
> > +	     cond_break, pos = n, n = list_next_entry(n, member))
> > +
> > +#define mptcp_for_each_subflow(__msk,
> > __subflow)			\
> > +	list_for_each_entry(__subflow, &((__msk)->conn_list),
> > node)
> > +#define mptcp_for_each_subflow_safe(__msk, __subflow,
> > __tmp)		\
> > +	list_for_each_entry_safe(__subflow, __tmp, &((__msk)-
> > >conn_list), node)
> > +
> >  extern void mptcp_subflow_set_scheduled(struct
> > mptcp_subflow_context *subflow,
> >  					bool scheduled) __ksym;
> >  
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > index bc572e1d6df8..e8cc157278d2 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > @@ -4,6 +4,7 @@
> >  
> >  /* vmlinux.h, bpf_helpers.h and other 'define' */
> >  #include "bpf_tracing_net.h"
> > +#include "mptcp_bpf.h"
> >  
> >  char _license[] SEC("license") = "GPL";
> >  
> > @@ -57,3 +58,57 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
> >  
> >  	return 1;
> >  }
> > +
> > +static int _check_getsockopt_subflows_mark(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	int i = 0;
> > +
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk;
> > +
> > +		ssk =
> > mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +							   struct
> > mptcp_subflow_context));
> > +
> > +		if (ssk->sk_mark != ++i)
> > +			ctx->retval = -1;
> > +	}
> 
> I think you should check here that 'i == 2', otherwise we are not
> checking all the expected subflows.
> 
> > +
> > +	return 1;
> > +}
> > +
> > +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> > +{
> > +	struct mptcp_subflow_context *subflow, *tmp;
> > +
> > +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> > +		struct inet_connection_sock *icsk;
> > +		struct sock *ssk;
> > +
> > +		ssk =
> > mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +							   struct
> > mptcp_subflow_context));
> > +		icsk = bpf_core_cast(ssk, struct
> > inet_connection_sock);
> > +
> > +		if (ssk->sk_mark == 1 &&
> > +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
> > TCP_CA_NAME_MAX))
> > +			ctx->retval = -1;
> > +	}
> 
> Same here, you should check the number of subflows that have been
> looked
> at (2), otherwise the check might succeed, while not doing any or
> half
> of the validation.
> 
> I think here it is better if the CC is modified on the second
> subflow,
> so we iterate at least 2 times, and expect to find the modified CC.
> WDYT?
> 
> > +
> > +	return 1;
> > +}
> > +
> > +SEC("cgroup/getsockopt")
> > +int _getsockopt_subflow(struct bpf_sockopt *ctx)
> > +{
> > +	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
> > mptcp_sock);
> > +
> > +	if (!msk || !msk->token)
> 
> Instead of checking the token, should you not check that
> 
>   sk->sk_protocol == IPPROTO_MPTCP
> 
> no?
> 
> Just checking if there is something written at "*msk + token offset"
> looks a bit random to me, and not safe.
> 
> > +		return 1;
> > +
> > +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> > +		return _check_getsockopt_subflows_mark(msk, ctx);
> > +	if (ctx->level == SOL_TCP && ctx->optname ==
> > TCP_CONGESTION)
> > +		return _check_getsockopt_subflow_cc(msk, ctx);
> > +
> > +	return 1;
> > +}
> 
> Cheers,
> Matt

