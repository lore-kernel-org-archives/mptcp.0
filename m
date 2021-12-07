Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C992CA0
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 10:21:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1muXb3-0008Vi-8d; Tue, 07 Dec 2021 11:21:17 +0100
Date: Tue, 7 Dec 2021 11:21:17 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	davem@davemloft.net, matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211207102117.GC30918@breakpoint.cc>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
 <20211203223541.69364-4-mathew.j.martineau@linux.intel.com>
 <20211206171648.4608911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206171648.4608911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri,  3 Dec 2021 14:35:34 -0800 Mat Martineau wrote:
> > +		if (sk->sk_state == TCP_LISTEN)
> > +			return -EINVAL;
> > +
> > +		lock_sock(sk);
> > +		__mptcp_move_skbs(msk);
> > +		answ = mptcp_inq_hint(sk);
> > +		release_sock(sk);
> 
> The raciness is not harmful here?

Can you elaborate?  We can't prevent new data
from being queued after this, but it won't decrease
on its own either, i.e. we only guarantee that we have at
least answ bytes for read().
