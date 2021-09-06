Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C133FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:55:34 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mN9TX-0000Rp-Ie; Mon, 06 Sep 2021 09:55:31 +0200
Date: Mon, 6 Sep 2021 09:55:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit
 failure
Message-ID: <20210906075531.GD23554@breakpoint.cc>
References: <20210906060614.25217-1-fw@strlen.de>
 <20210906060614.25217-3-fw@strlen.de>
 <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > +	/* Set PENDING again in case we found an ssk
> > +	 * that could not accept more data
> > +	 */
> > +	if (unlikely(copied == 0) &&
> > +	    READ_ONCE(msk->snd_una) == msk->snd_nxt && ssk)
> > +		mptcp_check_and_set_pending(sk);
> 
> @Florian: Why we need to check for ssk != NULL?

Because I don't think it makes sense to re-try ASAP if we could
not find a ssk, and instead defer until next firing of rtx timer.

> Do we need something similar for __mptcp_subflow_push_pending(), too?

I don't think so, its thats not invoked from the mptcp-release cb; also:

> I'm wondering if this will cause a sort of 'spinning'/busy loop on
> above condition inside mptcp_release_cb().

Hmm, right, that might indeed happen.
It should be sae to remove the above clause and unconditioally wait
for the reworked rtx timer to assert pending bit again.
