Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7C2CA0
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 10:19:36 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1muXZA-0008Uj-5U; Tue, 07 Dec 2021 11:19:20 +0100
Date: Tue, 7 Dec 2021 11:19:20 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	netdev@vger.kernel.org, Maxim Galaganov <max@internet.ru>,
	davem@davemloft.net, matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 10/10] mptcp: support TCP_CORK and TCP_NODELAY
Message-ID: <20211207101920.GB30918@breakpoint.cc>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
 <20211203223541.69364-11-mathew.j.martineau@linux.intel.com>
 <20211206173023.72aca8f9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206173023.72aca8f9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri,  3 Dec 2021 14:35:41 -0800 Mat Martineau wrote:
> > +static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
> > +					    unsigned int optlen)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = (struct sock *)msk;
> > +	int val;
> > +
> > +	if (optlen < sizeof(int))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> > +		return -EFAULT;
> 
> Should we check that optval is not larger than sizeof(int) or if it is
> that the rest of the buffer is zero? Or for the old school options we
> should stick to the old school behavior?

My intent was to stick to tcp behaviour, i.e. no check on > sizeof(int)
or on "extra buffer" content.
