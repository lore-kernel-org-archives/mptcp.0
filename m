Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58851A4AA2
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227230; cv=none; b=Cs1iKPNWTsqQBFN0cUm8/FoyX9K6k1UK92Yfy4DYDimy9hwqCCCk1yRLu4WCZCZgOSpS0fvoXv1U6icHvO3jobommstlwdBZ9oqdz6jhOOD06l69eeM0mk7ehRfSv6u1xM6zsPiYkiy94B8K5eOOHxdF60ko2nj6EXlTr1VAN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227230; c=relaxed/simple;
	bh=FYvz0dSqq6jX2TcvjXhA7pATr0uV/iaRvnrWNftzE34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plKOc9jwVSVFX/IO1sNHPcedIeKR32B89mfO5Ir/wXuW26ydepKlhRmx2h/ZMnhrp0SBDpR6zsINsEOycsM3QT3sLhazqyuJP+0bNX3D1T21WjMJ9C2h4AWdOrtAdSqecAQ6RVyz3lvvv9lPF/n++PRkk6/9+v6ZpsifyD3fMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOYEb6SR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOYEb6SR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE94C32782;
	Wed, 21 Aug 2024 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724227229;
	bh=FYvz0dSqq6jX2TcvjXhA7pATr0uV/iaRvnrWNftzE34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XOYEb6SRMn1g4pyL/44uql5B1Oc82pL7SluxR/VnstCDDvgERS/xpLwE9u/UVCGPW
	 Enn+JuTHUmfOS7/byTNVGLu/K2NvOHFguC5qHE7NMI1aZmc55P6caWsCUpN0OKZP7s
	 TLt9di8L5s8aIzm4iZA+9m/G4qbzBzt2KmBZ+yw0mgNu/EzWUC/OeCcpOzZeqsoyqO
	 xYgK/NT/NwOzg8qF2ArOCErsccfhczdpUdcX7P+ZvtY3w8/smscQNNlYX0FloRC7kd
	 3hOXZaCsGmFh+95xnjVI1Q1SK33JrwwnJP4Zs7VjO3M+Ol7XNIIKAmD8NsM3xEwriG
	 41hJ5FYP2jhOw==
Message-ID: <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Date: Wed, 21 Aug 2024 16:00:23 +0800
In-Reply-To: <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
	 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
	 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
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

Hi Matt,

Thanks for the review.

On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for looking at that!
> 
> On 20/08/2024 10:44, Geliang Tang wrote:
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
> > bpf_rdonly_cast to cast a pointer to tcp_sock for readonly. It will
> > allow
> 
> Do you mean bpf_core_cast() instead of bpf_rdonly_cast()? Or is it
> indirectly used?

Yes, it should be "bpf_core_cast". Updated in v2.

> 
> > to inspect all the fields in a tcp_sock.
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 11 +++++++
> >  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 26 +++++++++++++++
> >  .../selftests/bpf/progs/mptcp_subflow.c       | 32
> > +++++++++++++++++++
> >  3 files changed, 69 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 69fdcb28249d..2178db94f764 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -383,6 +383,7 @@ static void run_subflow(char *new)
> >  {
> >  	int server_fd, client_fd, err;
> >  	char cc[TCP_CA_NAME_MAX];
> > +	unsigned int mark;
> >  	socklen_t len;
> >  
> >  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1,
> > 0);
> > @@ -407,6 +408,10 @@ static void run_subflow(char *new)
> >  	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> >  	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> 
> I guess the next steps is to remove these 'ss_search()', right?

We can keep it for double checks.

> 
> > +	len = sizeof(mark);
> > +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark,
> > &len);
> > +	ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
> > +
> >  	close(client_fd);
> >  fail:
> >  	close(server_fd);
> > @@ -417,6 +422,7 @@ static void test_subflow(void)
> >  	int cgroup_fd, prog_fd, err;
> >  	struct mptcp_subflow *skel;
> >  	struct nstoken *nstoken;
> > +	struct bpf_link *link;
> >  
> >  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> >  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup:
> > mptcp_subflow"))
> > @@ -442,6 +448,10 @@ static void test_subflow(void)
> >  	if (endpoint_init("subflow") < 0)
> >  		goto close_netns;
> >  
> > +	link = bpf_program__attach_cgroup(skel->progs._getsockopt,
> > cgroup_fd);
> > +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> 
> I don't know how it works: is this going to fail if the getsockopt
> program set 'ctx->retval = -1'?

Yes. ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)") will fail if the
getsockopt program set 'ctx->retval = -1'.
> 
> > +		goto close_netns;
> > +
> >  	run_subflow(skel->data->cc);
> >  
> >  close_netns:
> > @@ -450,6 +460,7 @@ static void test_subflow(void)
> >  	mptcp_subflow__destroy(skel);
> >  close_cgroup:
> >  	close(cgroup_fd);
> > +	bpf_link__destroy(link);
> >  }
> >  
> >  static struct nstoken *sched_init(char *flags, char *sched)
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > index 782f36ed027e..2086170e7379 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > @@ -7,6 +7,32 @@
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
> > +	     pos = list_next_entry(pos, member))
> 
> Out of curiosity, are these generic helpers not defined elsewhere? Is
> it
> OK not to use the '_safe' version where the deletion of elements is
> supported?

It's read only in this test, so list_for_each_entry is enough. I added
the '_safe' version in v2 too for future use.

> 
> > +
> > +#define mptcp_for_each_subflow(__msk,
> > __subflow)			\
> > +	list_for_each_entry(__subflow, &((__msk)->conn_list),
> > node)
> > +
> >  extern void mptcp_subflow_set_scheduled(struct
> > mptcp_subflow_context *subflow,
> >  					bool scheduled) __ksym;
> >  
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > index bc572e1d6df8..c41418ab8db4 100644
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
> > @@ -57,3 +58,34 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
> >  
> >  	return 1;
> >  }
> > +
> > +SEC("cgroup/getsockopt")
> > +int _getsockopt(struct bpf_sockopt *ctx)
> 
> This name seems too generic while what is done here is specific to
> the
> 'subflow' test. Maybe: _check_getsockopt_subflows()?

Changed it to _getsockopt_subflow in v2.

> 
> (or _check_getsockopt_subflows_mark() and
> _check_getsockopt_subflow_cc()
> see below)
> 
> > +{
> > +	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
> > mptcp_sock);
> 
> What happens if the 'sk' is not an 'msk'?
> Does it check that the sk is indeed an MPTCP one? (how?)

Also check msk->token in v2.

> 
> > +	struct mptcp_subflow_context *subflow;
> > +	int i = 0;
> > +
> > +	if (!msk || ctx->level != SOL_SOCKET || ctx->optname !=
> > SO_MARK)
> > +		return 1;
> 
> Would it not be clearer to split the two checks? One dedicated to the
> mark, when getsockopt(SO_MARK) is used, and one for the CC, when the
> getsockopt(TCP_CONGESTION) is used? By doing that, we would know
> which
> one had an issue, if any, not just "something wrong with
> getsockopt()"?

Done in v2.

> 
> > +
> > +	mptcp_for_each_subflow(msk, subflow) {
> 
> (might be better to use this helper in our WIP MPTCP BPF packets
> scheduler examples, instead of converting them to a fixed array)

Yes, but there are still some access permission issues that need to be
resolved.

> 
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
> > +		if (ssk->sk_mark != i + 1)
> > +			ctx->retval = -1;
> > +		if (ssk->sk_mark == 1 &&
> > +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
> > TCP_CA_NAME_MAX))
> > +			ctx->retval = -1;
> > +
> > +		if (i++ >= MPTCP_SUBFLOWS_MAX)
> > +			break;
> 
> I guess this part is needed for the verifier, right?
> Somehow related to "cond_break" explained in this link?
> 
>   https://lwn.net/Articles/964381/
> 

Change this as "cond_break" in v2.

Regards,
-Geliang

> 
> > +	}
> > +
> > +	return 1;
> > +}
> 
> Cheers,
> Matt

