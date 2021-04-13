Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327070
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 14:58:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lWKUQ-0006ZX-Vt; Tue, 13 Apr 2021 16:58:07 +0200
Date: Tue, 13 Apr 2021 16:58:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 02/10] mptcp: tag sequence_seq with socket state
Message-ID: <20210413145806.GD14932@breakpoint.cc>
References: <20210408184936.6245-1-fw@strlen.de>
 <20210408184936.6245-3-fw@strlen.de>
 <ab943483882219110f0bcb79efd1629b9512102b.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab943483882219110f0bcb79efd1629b9512102b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > +	list_for_each_entry(subflow, &msk->join_list, node) {
> > +		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
> >  
> > +		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
> > +		if (READ_ONCE(msk->setsockopt_seq) != sseq)
> > +			ret = true;
> 
> I'm a bit lost WRT 'ret' scope. I don't see where it's initialized.
> Does the compiler emit a warning here?

Did not see one, but it looks broken.

> Perhaps moving the 'ret' variable definition to this patch will makes
> the things clearer?!?

Done.

> > -	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
> > +	if (msk->setsockopt_seq &&
> > +	    !test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
> >  		mptcp_schedule_work((struct sock *)msk);
> 
> It's not obvious to me why the 'msk->setsockopt_seq' check is needed
> here (and in the below chunk) ???
> 
> Perhaps a comment would help?

Perhaps:
+static bool setsockopt_was_called(const struct mptcp_sock *msk)
+{
+       return msk->setsockopt_seq > 0;
+}
+

if (setsockopt_was_called(msk) && ..

?
