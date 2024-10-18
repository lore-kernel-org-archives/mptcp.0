Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2A4E1C4
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215306; cv=none; b=J6xBgoQq8PV3Q7k0K81HE4YnPtuYzLkFh87KSqwZAh7+IEJYmJ3Sl/lA3xYK/4sQH7yXhu2o2/wN3yI8NyH7vGekMyqSq7LowRdUVLGvtDVUobiRKHrsLzapJWJhn2mNR+Ho53wz+Q9rNadihzdxI56X1+at7X2QbORDf5bQ40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215306; c=relaxed/simple;
	bh=O1lQgYTyA7tGizGl8zy3bj8nJHPDFeB40fZ5Thw7cNI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuIchGIPHOUtJjn8eltM0vWiqW4pNt0w+dp1bM5gfSMhroCkGFrNTbpEG4+75LlSH++q1oNieF8nsd+gGICvCELPwDw4Jm1bePgE5qENZSuZTmhh+R5fw5B50qtLg4sgi4YfvLKs5wVjWuTdh5JVPd9fy2YmptXHv9um2apT5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F724ea2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F724ea2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9D7C4CEC3;
	Fri, 18 Oct 2024 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729215305;
	bh=O1lQgYTyA7tGizGl8zy3bj8nJHPDFeB40fZ5Thw7cNI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=F724ea2lwSqcT/lJusXM9o9SnAYMBTiBb9M/PWn8oIFVnUKMXis7xUaMUv4Of5AAx
	 5BxPtfx9EZ0vROXZrDQJphcXP6GtxJgpKlKXydVzAdOHfaNHuc0sBlN2ybzZgM5uMJ
	 zcS2c03BvIBGh32qSzDGQEstKPxGJ7k14iUtISYGrvg1VSPFl6YpqTQonNiq4LVXSH
	 zkEeHZXwGTC3vr54QCo1m7HtaCeLyQ06sSaj3G7fzr/EAdjY6xiVSTaTLJmlhthtbG
	 TK2jJ3Y3z0Hl5DgHlLdIxIojCpUvZuHYN9z+TBPI7o1aHfP8iobIh3hbJaZ0Ayj2sI
	 GsD7bJN8dNnpA==
Message-ID: <b9fdf007c3bc1606d3ce3f9218f00e86af5dc323.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, Geliang
 Tang <tanggeliang@kylinos.cn>
Date: Fri, 18 Oct 2024 09:35:00 +0800
In-Reply-To: <c869bcb2-121d-49dc-9da4-199ad8f8a692@kernel.org>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
	 <30504191-4b5f-1a69-08a3-5ae0f444c802@gmail.com>
	 <953bf596-94e5-4829-adec-5997e1557487@kernel.org>
	 <c011f12106022a519cba25ce18d2a83a12dca184.camel@kernel.org>
	 <48326975-95fc-4255-80f2-8583749194e5@kernel.org>
	 <651738088acd25abefb3f20f4120d608a1ac3966.camel@kernel.org>
	 <c869bcb2-121d-49dc-9da4-199ad8f8a692@kernel.org>
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

On Tue, 2024-10-15 at 12:59 +0200, Matthieu Baerts wrote:
> On 15/10/2024 11:20, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, 2024-10-15 at 11:01 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > Thank you for your reply!
> > > 
> > > On 15/10/2024 09:27, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > Thanks for this review.
> > > > 
> > > > On Mon, 2024-10-14 at 18:08 +0200, Matthieu Baerts wrote:
> > > > > Hi Geliang,
> > > > > 
> > > > > On 09/10/2024 12:05, MPTCP CI wrote:
> > > > > > Hi Geliang,
> > > > > > 
> > > > > > Thank you for your modifications, that's great!
> > > > > > 
> > > > > > But sadly, our CI spotted some issues with it when trying
> > > > > > to
> > > > > > build
> > > > > > it.
> > > > > > 
> > > > > > You can find more details there:
> > > > > > 
> > > > > >  
> > > > > > https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11252652867
> > > > > 
> > > > > I was looking at applying this series, but there are some
> > > > > issues
> > > > > reported by the CI:
> > > > > 
> > > > >   warning: symbol 'bpf_*mptcp_*' was not declared. Should it
> > > > > be
> > > > > static?
> > > > > 
> > > > > Could it be possible to have a fix for that please before
> > > > > applying
> > > > > the
> > > > > series?
> > > > 
> > > > No fix is ​​needed, just ignore these warnings.
> > > 
> > > If possible, I would prefer not to ignore these warnings, because
> > > other
> > > CI might report the same issue. I didn't check, but can you not
> > > simply
> > > declare these new helpers as "static"? It looks like we can have
> > > kfunc
> > > declared as static, no?
> > 
> > No, "static" doesn't work.

"static" works. I would have thought it would depend on
CONFIG_KALLSYMS_ALL, which is not included in
tools/testing/selftests/bpf/config. Looks like I was wrong. I added
"static" for all bpf kfuncs in v10.

> 
> Could we declare them in protocol.h? Or is it not enough?
> 
> > > > This error is also
> > > > reported in other places:
> > > > 
> > > > $ make C=1 -o net/socket.o
> > > >   CALL    scripts/checksyscalls.sh
> > > >   DESCEND objtool
> > > >   INSTALL libsubcmd_headers
> > > >   DESCEND bpf/resolve_btfids
> > > >   INSTALL libsubcmd_headers
> > > >   CC      net/socket.o
> > > >   CHECK   net/socket.c
> > > > net/socket.c:1704:21: warning: symbol 'update_socket_protocol'
> > > > was
> > > > not
> > > > declared. Should it be static?
> > > 
> > > In this example, you are showing one symbol that has been added
> > > for
> > > MPTCP, maybe we forgot something :)
> > 
> > Do you mean we should name it as "mptcp_update_socket_protocol"? No
> > need. It's a public hook for any protocol.
> 
> No sorry, I just wanted to say that it is probably not a good
> example,
> because this helper has been introduced by you, 
> and we have maybe missed
> something to avoid the warning.

Other helpers have these warnings too:

$ make C=1 -o kernel/bpf/helpers.o -j8

  CC      kernel/bpf/helpers.o
  CHECK   kernel/bpf/helpers.c

kernel/bpf/helpers.c:1883:29: warning: symbol
'bpf_get_current_task_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1884:29: warning: symbol
'bpf_get_current_task_btf_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1885:29: warning: symbol
'bpf_probe_read_user_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1886:29: warning: symbol
'bpf_probe_read_user_str_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1887:29: warning: symbol
'bpf_probe_read_kernel_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1888:29: warning: symbol
'bpf_probe_read_kernel_str_proto' was not declared. Should it be
static?
kernel/bpf/helpers.c:1889:29: warning: symbol 'bpf_task_pt_regs_proto'
was not declared. Should it be static?
kernel/bpf/helpers.c:2116:18: warning: symbol 'bpf_obj_new_impl' was
not declared. Should it be static?
kernel/bpf/helpers.c:2130:18: warning: symbol 'bpf_percpu_obj_new_impl'
was not declared. Should it be static?
kernel/bpf/helpers.c:2161:18: warning: symbol 'bpf_obj_drop_impl' was
not declared. Should it be static?
kernel/bpf/helpers.c:2169:18: warning: symbol
'bpf_percpu_obj_drop_impl' was not declared. Should it be static?
kernel/bpf/helpers.c:2175:18: warning: symbol
'bpf_refcount_acquire_impl' was not declared. Should it be static?
kernel/bpf/helpers.c:2220:17: warning: symbol
'bpf_list_push_front_impl' was not declared. Should it be static?
kernel/bpf/helpers.c:2230:17: warning: symbol 'bpf_list_push_back_impl'
was not declared. Should it be static?
kernel/bpf/helpers.c:2263:34: warning: symbol 'bpf_list_pop_front' was
not declared. Should it be static?
kernel/bpf/helpers.c:2268:34: warning: symbol 'bpf_list_pop_back' was
not declared. Should it be static?
kernel/bpf/helpers.c:2273:32: warning: symbol 'bpf_rbtree_remove' was
not declared. Should it be static?
kernel/bpf/helpers.c:2329:17: warning: symbol 'bpf_rbtree_add_impl' was
not declared. Should it be static?
kernel/bpf/helpers.c:2339:32: warning: symbol 'bpf_rbtree_first' was
not declared. Should it be static?
kernel/bpf/helpers.c:2352:32: warning: symbol 'bpf_task_acquire' was
not declared. Should it be static?
kernel/bpf/helpers.c:2363:18: warning: symbol 'bpf_task_release' was
not declared. Should it be static?
kernel/bpf/helpers.c:2368:18: warning: symbol 'bpf_task_release_dtor'
was not declared. Should it be static?
kernel/bpf/helpers.c:2381:27: warning: symbol 'bpf_cgroup_acquire' was
not declared. Should it be static?
kernel/bpf/helpers.c:2393:18: warning: symbol 'bpf_cgroup_release' was
not declared. Should it be static?
kernel/bpf/helpers.c:2398:18: warning: symbol 'bpf_cgroup_release_dtor'
was not declared. Should it be static?
kernel/bpf/helpers.c:2411:27: warning: symbol 'bpf_cgroup_ancestor' was
not declared. Should it be static?
kernel/bpf/helpers.c:2431:27: warning: symbol 'bpf_cgroup_from_id' was
not declared. Should it be static?
kernel/bpf/helpers.c:2451:18: warning: symbol 'bpf_task_under_cgroup'
was not declared. Should it be static?
kernel/bpf/helpers.c:2494:27: warning: symbol 'bpf_task_get_cgroup1'
was not declared. Should it be static?
kernel/bpf/helpers.c:2511:32: warning: symbol 'bpf_task_from_pid' was
not declared. Should it be static?
kernel/bpf/helpers.c:2552:18: warning: symbol 'bpf_dynptr_slice' was
not declared. Should it be static?
kernel/bpf/helpers.c:2637:18: warning: symbol 'bpf_dynptr_slice_rdwr'
was not declared. Should it be static?
kernel/bpf/helpers.c:2670:17: warning: symbol 'bpf_dynptr_adjust' was
not declared. Should it be static?
kernel/bpf/helpers.c:2689:18: warning: symbol 'bpf_dynptr_is_null' was
not declared. Should it be static?
kernel/bpf/helpers.c:2696:18: warning: symbol 'bpf_dynptr_is_rdonly'
was not declared. Should it be static?
kernel/bpf/helpers.c:2706:19: warning: symbol 'bpf_dynptr_size' was not
declared. Should it be static?
kernel/bpf/helpers.c:2716:17: warning: symbol 'bpf_dynptr_clone' was
not declared. Should it be static?
kernel/bpf/helpers.c:2732:18: warning: symbol 'bpf_cast_to_kern_ctx'
was not declared. Should it be static?
kernel/bpf/helpers.c:2737:18: warning: symbol 'bpf_rdonly_cast' was not
declared. Should it be static?
kernel/bpf/helpers.c:2742:18: warning: symbol 'bpf_rcu_read_lock' was
not declared. Should it be static?
kernel/bpf/helpers.c:2747:18: warning: symbol 'bpf_rcu_read_unlock' was
not declared. Should it be static?
kernel/bpf/helpers.c:2776:18: warning: symbol 'bpf_throw' was not
declared. Should it be static?
kernel/bpf/helpers.c:2795:17: warning: symbol 'bpf_wq_init' was not
declared. Should it be static?
kernel/bpf/helpers.c:2809:17: warning: symbol 'bpf_wq_start' was not
declared. Should it be static?
kernel/bpf/helpers.c:2826:17: warning: symbol
'bpf_wq_set_callback_impl' was not declared. Should it be static?
kernel/bpf/helpers.c:2840:18: warning: symbol 'bpf_preempt_disable' was
not declared. Should it be static?
kernel/bpf/helpers.c:2845:18: warning: symbol 'bpf_preempt_enable' was
not declared. Should it be static?
kernel/bpf/helpers.c:2878:1: warning: symbol 'bpf_iter_bits_new' was
not declared. Should it be static?
kernel/bpf/helpers.c:2930:17: warning: symbol 'bpf_iter_bits_next' was
not declared. Should it be static?
kernel/bpf/helpers.c:2957:18: warning: symbol 'bpf_iter_bits_destroy'
was not declared. Should it be static?
kernel/bpf/helpers.c:2981:17: warning: symbol 'bpf_copy_from_user_str'
was not declared. Should it be static?

We can send our "static" version to bpf-next and see their feedback.

Thanks,
-Geliang

> 
> > > > It seems that it is because "-Wmissing-declarations" is not
> > > > recognized
> > > > by sparse
> > > 
> > > I don't see complains about that when introducing new kfunc,
> > > maybe we
> > > are supposed to do something else to avoid that?
> > 
> > I have no idea yet. You can listen to the opinions of BPF
> > maintainers
> > when you are in upstream.
> 
> I will try to get an answer before, just not to have to modify the CI
> to
> ignore all these cases if there is no need to.
> 
> > > > > I guess you are missing __bpf_kfunc_start_defs() and
> > > > > __bpf_kfunc_end_defs() around the declaration of the BPF
> > > > > dedicated
> > > > > kfunc, no?
> > > > 
> > > > No. __bpf_kfunc_start_defs() and __bpf_kfunc_end_defs() are
> > > > indeed
> > > > used
> > > > in patch 2.
> > > 
> > > Thanks, I missed that.
> > > 
> > > > > Also, where should I apply these patches? Before "mptcp: add
> > > > > sched_data
> > > > > helpers"?
> > > > 
> > > > Yes, before "mptcp: add sched_data helpers", after
> > > > "selftests/bpf:
> > > > Add
> > > > mptcp subflow subtest".
> > > 
> > > OK!
> > > 
> > > > > But then there should not be any dependences on the BPF
> > > > > scheduler work (and I think that would be better without this
> > > > > dependence, see my comment on patch 4/7)
> > > > 
> > > > This set doesn't have any dependence on the BPF packet
> > > > scheduler
> > > > since
> > > > the selftest is added as a ftrace. It somehow depends on packet
> > > > scheduler since it invoke some packet scheduler functions such
> > > > as
> > > > mptcp_subflow_active() and bpf_mptcp_subflow_tcp_sock().
> > > 
> > > OK, but if I insert the series just after "selftests/bpf: Add
> > > mptcp
> > > subflow subtest", 
> > 
> > "selftests/bpf: Add mptcp subflow subtest" has been upstreamed. It
> > should be before "mptcp: add sched_data helpers".
> > 
> > > it will not have access to mptcp_subflow_active().
> > 
> > The access to mptcp_subflow_active() is added in patch 1 "bpf:
> > Register
> > mptcp common kfunc set" in this set.
> 
> Ah OK, I didn't know I had to include them in patch 1: the commit
> message mentions them, but it was not clear to me that I had to
> import
> them from another patch when resolving the conflicts.
> Next time, don't hesitate to add a squash-to patch before, removing
> the
> code from one commit (even if it is going to be placed after), and
> mention the order ;)
> 
> 
> > 
> > The whole order is (from bottom to top):
> > 
> > selftests/bpf: Add bpf scheduler test
> > bpf: Add bpf_mptcp_sched_kfunc_set
> > bpf: Add bpf_mptcp_sched_ops
> > mptcp: add sched_data helpers
> > selftests/bpf: Add mptcp_subflow bpf_iter subtest
> > Squash to "selftests/bpf: Add bpf scheduler test"
> > selftests/bpf: More endpoints for endpoint_init
> > selftests/bpf: Add mptcp_subflow bpf_iter test prog
> > bpf: Add mptcp_sock acquire and release helpers
> > bpf: Add mptcp_subflow bpf_iter
> > bpf: Register mptcp common kfunc set
> > selftests/bpf: Add mptcp subflow subtest
> > selftests/bpf: Add getsockopt to inspect mptcp subflow
> > selftests/bpf: Add mptcp subflow example
> 
> Thanks, that's clearer!
> 
> Cheers,
> Matt

