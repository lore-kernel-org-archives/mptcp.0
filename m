Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94F3FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 11:35:50 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mNCuh-0001L4-Ix; Mon, 06 Sep 2021 13:35:47 +0200
Date: Mon, 6 Sep 2021 13:35:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit
 failure
Message-ID: <20210906113547.GE23554@breakpoint.cc>
References: <20210906060614.25217-1-fw@strlen.de>
 <20210906060614.25217-3-fw@strlen.de>
 <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
 <20210906075531.GD23554@breakpoint.cc>
 <c0fc73caa4f52bdfc639ea76b552b1bc255eab9b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fc73caa4f52bdfc639ea76b552b1bc255eab9b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Mon, 2021-09-06 at 09:55 +0200, Florian Westphal wrote:
> > Because I don't think it makes sense to re-try ASAP if we could
> > not find a ssk, and instead defer until next firing of rtx timer.
> 
> Ok
> > 
> > > Do we need something similar for __mptcp_subflow_push_pending(), too?
> > 
> > I don't think so, its thats not invoked from the mptcp-release cb; 
> 
> yup, right. To be clear, with "something similar" I also referred to
> ensuring the rtx timer is armed.

__mptcp_subflow_push_pending() is only called when we already have
pending xmit, i.e. the timer is already running and with the change in
this patch the timer is guaranteed to re-arm itself unless there is
nothing to transmit anymore.

__mptcp_push_pending is different because that is called when new data
is passed in via sendmsg, i.e. timer might not be running (yet).

Makes sense to you?

> > > I'm wondering if this will cause a sort of 'spinning'/busy loop on
> > > above condition inside mptcp_release_cb().
> > 
> > Hmm, right, that might indeed happen.
> > It should be sae to remove the above clause and unconditioally wait
> > for the reworked rtx timer to assert pending bit again.
> 
> +1 :) (assuming s/sae/safe/ :)

Yep, safe.  Test has been running for a few hours now with no failures,
will send v2 shortly.
