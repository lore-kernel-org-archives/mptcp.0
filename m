Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64D4AEE6
	for <mptcp@lists.linux.dev>; Wed,  4 Sep 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445227; cv=none; b=O3X8/B4ETcLSfIwRVh76/XcMXgmFhT19a3JVVRcsYy90sWLRX+2rAMFqu/xlqOW058c+mPWhHBmSFaKNN9xFHgta3I0E5yXHNtKi6YBvgEHHBuw/xCImaZN6q6xyxJ51M/B/oYrsmcSVoTnOnUn9qerdk+vwSYYrtBAaf7L6LZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445227; c=relaxed/simple;
	bh=hOL0UJZs3hk1ZM83mVw0khPPHWGYNcGmrFD8jLO5oUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxam3fjt605EHiSXGV6lcWNTGUTVIhF4+y6k1XFgSztjRk8oVZ9jIZaaDJmSQwIoDIt2R8vwTU5pS4YByXQ9iFdg8o3CT/x8At2cLMBs9POIPz6uMA8Q5nnSDkrOP+l456znSj2sG69UIzkwgeuT3AJgWmtBzSO1LGnmFEpc4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyi2TFsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyi2TFsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B494C4CEC2;
	Wed,  4 Sep 2024 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445227;
	bh=hOL0UJZs3hk1ZM83mVw0khPPHWGYNcGmrFD8jLO5oUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jyi2TFshBPnw3GSQvEmICY0muZuZVOzYJ96AgqJDKqm2D4a99bMyWO6qMzdafe5li
	 1EwdZtMSq1HTomssYhg+JPGVXcnF9PEnBg/Fzfh6erM9KtSwA/2lwJOj3z2jscw6w0
	 sjY9lOacT8LlYkhzMZRMoO2YSSeypxHqmc+TMFcJ9umbI1Jtee6uUdFuT3vQxX2ZYg
	 whqyoKrVxRAutai68U19ay7ejDxSXzuoyTPjYCj7VqOqjAK+uD03e0694c3aHAUl7o
	 fh4iamQYOEdVw226MG2CNZ+0Xe1hOQf9oAjLzbzh/vYX2KoIvvwU3vNnOpc4mqEcgv
	 Xr7d/86XjOoqw==
Message-ID: <4d97e1f2290f5dba5832cd0ad287588693f341e1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev, Martin
 KaFai Lau <martin.lau@kernel.org>
Date: Wed, 04 Sep 2024 18:20:21 +0800
In-Reply-To: <54ce6f90-e86c-4921-b1e0-423fcd655d32@linux.dev>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
	 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
	 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
	 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
	 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
	 <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
	 <547fdd31-a052-4274-a59e-d7177887dbbe@kernel.org>
	 <010b2338434b7df67ac418ad7063543e91c946b9.camel@kernel.org>
	 <54ce6f90-e86c-4921-b1e0-423fcd655d32@linux.dev>
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

On Mon, 2024-08-26 at 22:22 -0700, Martin KaFai Lau wrote:
> On 8/26/24 2:24 AM, Geliang Tang wrote:
> > > I'm not an expert in this, but I guess it means you cannot use
> > > 'mptcp_subflow_active()', because it can modify the 'subflow'
> > > structure
> > > that you got with bpf_core_cast() for a read-only usage.
> > 
> > A read-only function will get the same error.
> > 
> > I added a read-only function mptcp_subflow_get_scheduled() for
> > testing:
> > 
> > bool mptcp_subflow_get_scheduled(struct mptcp_subflow_context
> > *subflow)
> > {
> >          return subflow->scheduled;
> > }
> > 
> > And invoke it from BPF in mptcp_for_each_subflow() loop:
> > 
> > int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> >               struct mptcp_sched_data *data)
> > {
> >          struct mptcp_subflow_context *subflow, *tmp;
> > 
> >          mptcp_for_each_subflow(msk, tmp) {
> >                  subflow = bpf_core_cast(tmp, struct
> > mptcp_subflow_context);
> >                  mptcp_subflow_get_scheduled(subflow);
> >          }
> >          return 0;
> > }
> > 
> > The same "arg#0 is untrusted_ptr_ expected ptr_ or socket" occurs.
> > 
> > Hope Martin can give us a solution for this issue.
> 
> I don't know the context for this list walking + modify-by-kfunc
> usage, so the 
> following could be a grain of salt.
> 
> It seems like fitting the bpf_iter use case. Take a look at some
> recent bpf_iter 
> additions, e.g. bpf_iter_{task,css}_next(). Also the bpf_for_each
> macro usage in 
> selftests. There may be some secondary things that need to consider,
> e.g. how 
> the walked subflow is protected, rcu, refcnt...etc.

Great! Thanks. bpf_iter works well for MPTCP BPF scheduler.

I added a new bpf_iter type named "mptcp_subflow" in net/mptcp/bpf.c
like this:

'''
__bpf_kfunc_start_defs();

__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
bpf_iter_mptcp_subflow *it,
                struct mptcp_sock *msk, unsigned int flags)
{
        struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;

        kit->msk = msk;
        kit->pos = &msk->conn_list;
        spin_lock_bh(&msk->pm.lock);

        return 0;
}

__bpf_kfunc struct mptcp_subflow_context *
bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
{
        struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
        struct mptcp_subflow_context *subflow;
        struct mptcp_sock *msk = kit->msk;

        subflow = list_entry((kit->pos)->next, struct
mptcp_subflow_context, node);
        if (list_entry_is_head(subflow, &msk->conn_list, node))
                return NULL;

        kit->pos = &subflow->node;
        return subflow;
}

__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct
bpf_iter_mptcp_subflow *it)
{
        struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
        struct mptcp_sock *msk = kit->msk;

        spin_unlock_bh(&msk->pm.lock);
}

__bpf_kfunc_end_defs();
'''

And use "bpf_for_each(mptcp_subflow)" like this in
progs/mptcp_bpf_burst.c:

'''
        i = 0;
        bpf_rcu_read_lock();
        bpf_for_each(mptcp_subflow, subflow, msk, 0) {
                bool backup = subflow->backup || subflow->request_bkup;

                if (i++ > MPTCP_SUBFLOWS_MAX)
                        break;

                ssk = mptcp_subflow_tcp_sock(subflow);
                if (!mptcp_subflow_active(subflow))
                        continue;

                nr_active += !backup;
                pace = subflow->avg_pacing_rate;
                if (!pace) {
                        /* init pacing rate from socket */
                        subflow->avg_pacing_rate = ssk->sk_pacing_rate;
                        pace = subflow->avg_pacing_rate;
                        if (!pace)
                                continue;
                }

                linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32,
pace);
                if (linger_time < send_info[backup].linger_time) {
                        send_info[backup].subflow_id = i;
                        send_info[backup].linger_time = linger_time;
                }
        }
        bpf_rcu_read_unlock();
'''

With this mptcp_subflow bpf_iter, we can get rid of the subflows array
"contexts" in struct mptcp_sched_data:

'''
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c3d0ea07cf0c..a739f917b054 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,8 +104,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
        bool    reinject;
-       u8      subflows;
-       struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
'''

I'll send out these patches for review soon, with Martin's "Suggested-
by" tags.

Thanks,
-Geliang

