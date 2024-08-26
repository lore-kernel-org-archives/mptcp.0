Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD9BE6F
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641067; cv=none; b=P2o1XlzDVpW6gt1owkSQy5vZWvrHP5cNXVFkfepdJl/X6Y/uXCbJ22F7f58RZFkdqHVKLSfd1UzbpVmmhRspI7LFjNnEtToNEykscQHTSBCplRSR3yBaiubThyFCi2qzr+U4LVOCYi745YN5mzhxe95tuAsaGYi0Pyk8eFPdcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641067; c=relaxed/simple;
	bh=fs1/Ahnxy99UlTUvCm97aQij93M//RReGVvJcRPl7Xs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtUDIDRGv0mQsZ4IBWN7/XZjqDNO1K6cRoCcnWA5hYpptaEhFa9HT5XE4ilz/Mu1cqezYsKj/XYK2EDPURdE6aCzhaNXpaf0/kCkdswvNRQTmVJZSno12vsqgI78IjgsieB5+DJtbdFXGASQh63FIMxsCypiGXMEAUQI+5gVzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XndNlVCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XndNlVCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B941C4AF54;
	Mon, 26 Aug 2024 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724641067;
	bh=fs1/Ahnxy99UlTUvCm97aQij93M//RReGVvJcRPl7Xs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XndNlVCx2wEd7FIZvoq0eK7aBhT8oGpGIAB1sCOXkK4+/L6hejpHBByBVAay98M/B
	 g6oek2Bg+xbbMr70QOYeDm/Q2m1j5k7+gUTLWj8z27FBsKJHqjt6Ijw4ewLu6YCMc/
	 VsVKZc16IgCSrwJ+Hmhy4m8hwvr7aWBbmzCs2uXwvqK/d2VZUs+g8g4w77vMHtxIZ4
	 uagLJcsXxG97CtM7ggjE1HOuycu+SiJNieOFDoo10ur8x6mL9NUO1DM14vjqxD++IA
	 YUZeoZW1a71CF3W8G2gCq/g7GIDQ+9uYHjkuLtn8KddMnk8Yb6ue3wMT/AodD8a/1/
	 7AhIdhvjSswDg==
Message-ID: <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@kernel.org>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Mon, 26 Aug 2024 10:57:41 +0800
In-Reply-To: <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
	 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
	 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
	 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
	 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
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

Hi Martin, Matt,

On Wed, 2024-08-21 at 11:37 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply!
> 
> On 21/08/2024 10:00, Geliang Tang wrote:
> > On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
> > > On 20/08/2024 10:44, Geliang Tang wrote:
> 
> (...)
> 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > index 69fdcb28249d..2178db94f764 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > @@ -383,6 +383,7 @@ static void run_subflow(char *new)
> > > >  {
> > > >  	int server_fd, client_fd, err;
> > > >  	char cc[TCP_CA_NAME_MAX];
> > > > +	unsigned int mark;
> > > >  	socklen_t len;
> > > >  
> > > >  	server_fd = start_mptcp_server(AF_INET, ADDR_1,
> > > > PORT_1,
> > > > 0);
> > > > @@ -407,6 +408,10 @@ static void run_subflow(char *new)
> > > >  	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> > > >  	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default
> > > > cc");
> > > 
> > > I guess the next steps is to remove these 'ss_search()', right?
> > 
> > We can keep it for double checks.
> 
> I would not mind, even if 'ss | grep' is used in other BPF tests, but
> I
> understood from Martin he prefers not to depend on external tools as
> much as possible. It should indeed ease the maintenance.
> 
> > > > +	len = sizeof(mark);
> > > > +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK,
> > > > &mark,
> > > > &len);
> > > > +	ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
> > > > +
> > > >  	close(client_fd);
> > > >  fail:
> > > >  	close(server_fd);
> > > > @@ -417,6 +422,7 @@ static void test_subflow(void)
> > > >  	int cgroup_fd, prog_fd, err;
> > > >  	struct mptcp_subflow *skel;
> > > >  	struct nstoken *nstoken;
> > > > +	struct bpf_link *link;
> > > >  
> > > >  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> > > >  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup:
> > > > mptcp_subflow"))
> > > > @@ -442,6 +448,10 @@ static void test_subflow(void)
> > > >  	if (endpoint_init("subflow") < 0)
> > > >  		goto close_netns;
> > > >  
> > > > +	link = bpf_program__attach_cgroup(skel-
> > > > >progs._getsockopt,
> > > > cgroup_fd);
> > > > +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> > > 
> > > I don't know how it works: is this going to fail if the
> > > getsockopt
> > > program set 'ctx->retval = -1'?
> > 
> > Yes. ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)") will fail if
> > the
> > getsockopt program set 'ctx->retval = -1'.
> 
> Good, thank you!
> 
> > > > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > index 782f36ed027e..2086170e7379 100644
> > > > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > > > @@ -7,6 +7,32 @@
> > > >  
> > > >  #define MPTCP_SUBFLOWS_MAX 8
> > > >  
> > > > +static inline int list_is_head(const struct list_head *list,
> > > > +			       const struct list_head *head)
> > > > +{
> > > > +	return list == head;
> > > > +}
> > > > +
> > > > +#define list_entry(ptr, type,
> > > > member)					\
> > > > +	container_of(ptr, type, member)
> > > > +
> > > > +#define list_first_entry(ptr, type,
> > > > member)				\
> > > > +	list_entry((ptr)->next, type, member)
> > > > +
> > > > +#define list_next_entry(pos,
> > > > member)					\
> > > > +	list_entry((pos)->member.next, typeof(*(pos)), member)
> > > > +
> > > > +#define list_entry_is_head(pos, head,
> > > > member)				\
> > > > +	list_is_head(&pos->member, (head))
> > > > +
> > > > +#define list_for_each_entry(pos, head,
> > > > member)				\
> > > > +	for (pos = list_first_entry(head, typeof(*pos),
> > > > member);	\
> > > > +	     !list_entry_is_head(pos, head,
> > > > member);			\
> > > > +	     pos = list_next_entry(pos, member))
> > > 
> > > Out of curiosity, are these generic helpers not defined
> > > elsewhere? Is
> > > it
> > > OK not to use the '_safe' version where the deletion of elements
> > > is
> > > supported?
> > 
> > It's read only in this test, so list_for_each_entry is enough. I
> > added
> > the '_safe' version in v2 too for future use.
> 
> OK! (but I don't think you defined list_for_each_entry_safe(). Or is
> it
> defined elsewhere?)
> 
> > > > +
> > > > +#define mptcp_for_each_subflow(__msk,
> > > > __subflow)			\
> > > > +	list_for_each_entry(__subflow, &((__msk)->conn_list),
> > > > node)
> > > > +
> > > >  extern void mptcp_subflow_set_scheduled(struct
> > > > mptcp_subflow_context *subflow,
> > > >  					bool scheduled)
> > > > __ksym;
> > > >  
> > > > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > > index bc572e1d6df8..c41418ab8db4 100644
> > > > --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > > @@ -4,6 +4,7 @@
> > > >  
> > > >  /* vmlinux.h, bpf_helpers.h and other 'define' */
> > > >  #include "bpf_tracing_net.h"
> > > > +#include "mptcp_bpf.h"
> > > >  
> > > >  char _license[] SEC("license") = "GPL";
> > > >  
> > > > @@ -57,3 +58,34 @@ int mptcp_subflow(struct bpf_sock_ops
> > > > *skops)
> > > >  
> > > >  	return 1;
> > > >  }
> > > > +
> > > > +SEC("cgroup/getsockopt")
> > > > +int _getsockopt(struct bpf_sockopt *ctx)
> > > 
> > > This name seems too generic while what is done here is specific
> > > to
> > > the
> > > 'subflow' test. Maybe: _check_getsockopt_subflows()?
> > 
> > Changed it to _getsockopt_subflow in v2.
> > 
> > > 
> > > (or _check_getsockopt_subflows_mark() and
> > > _check_getsockopt_subflow_cc()
> > > see below)
> > > 
> > > > +{
> > > > +	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
> > > > mptcp_sock);
> > > 
> > > What happens if the 'sk' is not an 'msk'?
> > > Does it check that the sk is indeed an MPTCP one? (how?)
> > 
> > Also check msk->token in v2.
> 
> Mmh, I'm not sure if this is enough: the offset of 'token' in the msk
> structure could point to something unrelated but non-null in another
> socket structure, or out of bound. I guess BPF is doing extra checks
> not
> to crash here. But maybe that's OK because it is only reading stuff?
> 
> > > > +	struct mptcp_subflow_context *subflow;
> > > > +	int i = 0;
> > > > +
> > > > +	if (!msk || ctx->level != SOL_SOCKET || ctx->optname
> > > > !=
> > > > SO_MARK)
> > > > +		return 1;
> > > 
> > > Would it not be clearer to split the two checks? One dedicated to
> > > the
> > > mark, when getsockopt(SO_MARK) is used, and one for the CC, when
> > > the
> > > getsockopt(TCP_CONGESTION) is used? By doing that, we would know
> > > which
> > > one had an issue, if any, not just "something wrong with
> > > getsockopt()"?
> > 
> > Done in v2.
> 
> Thanks!
> 
> > > > +
> > > > +	mptcp_for_each_subflow(msk, subflow) {
> > > 
> > > (might be better to use this helper in our WIP MPTCP BPF packets
> > > scheduler examples, instead of converting them to a fixed array)
> > 
> > Yes, but there are still some access permission issues that need to
> > be
> > resolved.
> 
> OK, because structures cannot be modified I suppose.

No, it seems the subflow cast by bpf_core_cast() can't be passed to a
kernel function, regardless of whether this function modifies the
subflow or not. An "arg#0 is untrusted_ptr_ expected ptr_" error
occurs.

For example, mptcp_subflow_active() is a kernel function, and pass the
subflow to it in progs/mptcp_bpf_first.c like this:

'''
... ...
extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
__ksym;

... ...
SEC("struct_ops")
int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
             struct mptcp_sched_data *data)
{
        struct mptcp_subflow_context *subflow, *tmp;

        mptcp_for_each_subflow(msk, tmp) {
                subflow = bpf_core_cast(tmp, struct
mptcp_subflow_context);
                if (!mptcp_subflow_active(subflow))
                        continue;
        }
        return 0;
}

'''

An "arg#0 is untrusted_ptr_ expected ptr_" error occurs:

'''
; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
21: (e5) may_goto pc+1
22: R1=2488 R2=2488 R6=trusted_ptr_mptcp_sock(off=2488) R7=0
R8=trusted_ptr_mptcp_sock(off=2488) R9=0 R10=fp0
; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
22: (05) goto pc-14
9: (79) r6 = *(u64 *)(r6 +0)          ; R6_w=ptr_list_head()
10: (1f) r6 -= r7                     ; R6_w=ptr_list_head() R7=0
11: (bf) r1 = r6                      ; R1_w=ptr_list_head()
R6_w=ptr_list_head()
12: (0f) r1 += r7                     ; R1=ptr_list_head() R7=0
13: (1d) if r1 == r8 goto pc+9        ; R1=ptr_list_head()
R8=trusted_ptr_mptcp_sock(off=2488)
; subflow = bpf_core_cast(tmp, struct mptcp_subflow_context); @
mptcp_bpf_first.c:28
14: (bf) r1 = r6                      ; R1_w=ptr_list_head()
R6=ptr_list_head()
15: (18) r2 = 0x6d14                  ; R2_w=27924
17: (85) call bpf_rdonly_cast#159867          ;
R0_w=untrusted_ptr_mptcp_subflow_context()
; if (!mptcp_subflow_active(subflow)) @ mptcp_bpf_first.c:29
18: (bf) r1 = r0                      ;
R0_w=untrusted_ptr_mptcp_subflow_context()
R1_w=untrusted_ptr_mptcp_subflow_context()
19: (85) call mptcp_subflow_active#111397
arg#0 is untrusted_ptr_ expected ptr_ or socket
processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 2
peak_states 2 mark_read 2
-- END PROG LOAD LOG --
'''

How can I fix this? I need your advice.

Thanks,
-Geliang

> 
> > > 
> > > > +		struct inet_connection_sock *icsk;
> > > > +		struct sock *ssk;
> > > > +
> > > > +		ssk =
> > > > mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > > > +							  
> > > > struct
> > > > mptcp_subflow_context));
> > > > +		icsk = bpf_core_cast(ssk, struct
> > > > inet_connection_sock);
> > > > +
> > > > +		if (ssk->sk_mark != i + 1)
> > > > +			ctx->retval = -1;
> > > > +		if (ssk->sk_mark == 1 &&
> > > > +		    __builtin_memcmp(icsk->icsk_ca_ops->name,
> > > > cc,
> > > > TCP_CA_NAME_MAX))
> > > > +			ctx->retval = -1;
> > > > +
> > > > +		if (i++ >= MPTCP_SUBFLOWS_MAX)
> > > > +			break;
> > > 
> > > I guess this part is needed for the verifier, right?
> > > Somehow related to "cond_break" explained in this link?
> > > 
> > >   https://lwn.net/Articles/964381/
> > > 
> > 
> > Change this as "cond_break" in v2.
> 
> Note that you could also modify list_for_each_entry() to add this
> 'cond_break' (+bpf_experimental.h?), not to have to deal with that
> each
> time mptcp_for_each_subflow is used.
> 
> Cheers,
> Matt

