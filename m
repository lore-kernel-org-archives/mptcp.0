Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182E1DDC08
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985141; cv=none; b=Zhnw8jX5L02ArXX0UtAOShfpFr1PfD6jwUD9O4YhNeJ6yT+zogbsSWWZvapEk0BIX+3Q/wj9SRCGhQ0UKc6GCp/dtp3CNRQs4A2X717/LSTBdqH+frsU4X+88BxcUo2k0m8TVlZ8eJQbv/vFfrDN1YVZ0MQPhFe5KRYw0kC2BDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985141; c=relaxed/simple;
	bh=TE+n+VVDYrTjsqa9BsCXVyt14v8ylj4B7+kUlN0m57k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3RvPFrvKl2LLgTNwp9PwooTDUhkL9jJXfFSr/uD7Y4aS6pOIt1yWNiA6GQJrZrZtaPQMNbOdzGs3NUkWqT75Kec5sJ1bvJsTQFUCIziT0JkWLZ/Ix2Ekxl9HDCoMKyukKtq6oONHIOmPmpPMkPD3u2IrG4Q7w7nCcu4l86oOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdH1bdN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdH1bdN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE5AC4CEC6;
	Tue, 15 Oct 2024 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728985141;
	bh=TE+n+VVDYrTjsqa9BsCXVyt14v8ylj4B7+kUlN0m57k=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=AdH1bdN9qJDbus5gXWvTjmbDEL9lLsxS+wZTIjTk9Ktz9p/McH1NhgEYXhDY8guBm
	 iN/u0FIfu+xl4p+oVE/2fY8bGYNtNzeoFjUjHN7UvoLdogjtNG5vaiNdR0eJDcMDHs
	 rF2wPG2R9XxQ2a0vROWPT+ZeEOmiZMIurtLHGIugfUSsumRAhv7KjW474wGbS9A+uL
	 WwiqEcH4aTWmLxH5aPSvOAh7hFos2nBxYv7BY72mkqE71UmCRUjDtRPDU2ot/6CbAh
	 XiiBuSBBbGVXLvEcg7uSLMJfrBn+EoosnFC4oWPHzjBM5eyQT7n6bbh49prQllp4JR
	 oyyeELiWGGqRw==
Message-ID: <cae74d0b020f3f694d8e2f4892ca5121bbb07c67.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, Geliang
 Tang <tanggeliang@kylinos.cn>
Date: Tue, 15 Oct 2024 17:38:56 +0800
In-Reply-To: <48326975-95fc-4255-80f2-8583749194e5@kernel.org>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
	 <30504191-4b5f-1a69-08a3-5ae0f444c802@gmail.com>
	 <953bf596-94e5-4829-adec-5997e1557487@kernel.org>
	 <c011f12106022a519cba25ce18d2a83a12dca184.camel@kernel.org>
	 <48326975-95fc-4255-80f2-8583749194e5@kernel.org>
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

On Tue, 2024-10-15 at 11:01 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply!
> 
> On 15/10/2024 09:27, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this review.
> > 
> > On Mon, 2024-10-14 at 18:08 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 09/10/2024 12:05, MPTCP CI wrote:
> > > > Hi Geliang,
> > > > 
> > > > Thank you for your modifications, that's great!
> > > > 
> > > > But sadly, our CI spotted some issues with it when trying to
> > > > build
> > > > it.
> > > > 
> > > > You can find more details there:
> > > > 
> > > >  
> > > > https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11252652867
> > > 
> > > I was looking at applying this series, but there are some issues
> > > reported by the CI:
> > > 
> > >   warning: symbol 'bpf_*mptcp_*' was not declared. Should it be
> > > static?
> > > 
> > > Could it be possible to have a fix for that please before
> > > applying
> > > the
> > > series?
> > 
> > No fix is ​​needed, just ignore these warnings.
> 
> If possible, I would prefer not to ignore these warnings, because
> other
> CI might report the same issue. I didn't check, but can you not
> simply
> declare these new helpers as "static"? It looks like we can have
> kfunc
> declared as static, no?
> 
> > This error is also
> > reported in other places:
> > 
> > $ make C=1 -o net/socket.o
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   DESCEND bpf/resolve_btfids
> >   INSTALL libsubcmd_headers
> >   CC      net/socket.o
> >   CHECK   net/socket.c
> > net/socket.c:1704:21: warning: symbol 'update_socket_protocol' was
> > not
> > declared. Should it be static?
> 
> In this example, you are showing one symbol that has been added for
> MPTCP, maybe we forgot something :)
> 
> > It seems that it is because "-Wmissing-declarations" is not
> > recognized
> > by sparse
> 
> I don't see complains about that when introducing new kfunc, maybe we
> are supposed to do something else to avoid that?
> 
> > > I guess you are missing __bpf_kfunc_start_defs() and
> > > __bpf_kfunc_end_defs() around the declaration of the BPF
> > > dedicated
> > > kfunc, no?
> > 
> > No. __bpf_kfunc_start_defs() and __bpf_kfunc_end_defs() are indeed
> > used
> > in patch 2.
> 
> Thanks, I missed that.
> 
> > > Also, where should I apply these patches? Before "mptcp: add
> > > sched_data
> > > helpers"?
> > 
> > Yes, before "mptcp: add sched_data helpers", after "selftests/bpf:
> > Add
> > mptcp subflow subtest".
> 
> OK!
> 
> > > But then there should not be any dependences on the BPF
> > > scheduler work (and I think that would be better without this
> > > dependence, see my comment on patch 4/7)
> > 
> > This set doesn't have any dependence on the BPF packet scheduler
> > since
> > the selftest is added as a ftrace. It somehow depends on packet
> > scheduler since it invoke some packet scheduler functions such as
> > mptcp_subflow_active() and bpf_mptcp_subflow_tcp_sock().
> 
> OK, but if I insert the series just after "selftests/bpf: Add mptcp
> subflow subtest", it will not have access to mptcp_subflow_active().
> I
> still need to check your reply on the patch 4/7, but it would be
> easier
> if the test doesn't depend on "mptcp_subflow_active()": it's just a

Do you mean only drop "mptcp_subflow_active" and
"mptcp_subflow_set_scheduled" in the test or drop all the helpers,
include "bpf_mptcp_subflow_tcp_sock" and "bpf_mptcp_subflow_ctx"?

If it is the latter, the test is simplified like this, right?

        if (bpf_get_current_pid_tgid() >> 32 != pid)
                return 0;

        if (msk->pm.server_side || !msk->pm.subflows)
                return 0;

        ids = 0;

        msk = bpf_mptcp_sock_acquire(msk);
        if (!msk)
                return 0;
        bpf_for_each(mptcp_subflow, subflow, msk) {
                ids += subflow->subflow_id;
        bpf_mptcp_sock_release(msk);

        return 0;

To me both are fine, which one do you prefer? I can refactor the code
and send the squash-to patches. Or maybe a v10 is better?

Thanks,
-Geliang

> test
> in preparation to the packet scheduler, it is fine if it is not doing
> interesting for the moment I think.
> 
> Cheers,
> Matt

