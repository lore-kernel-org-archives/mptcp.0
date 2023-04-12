Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD428A935
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 22:22:17 +0000 (UTC)
Date: Thu, 13 Apr 2023 00:22:12 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
Message-ID: <ZDcvFKLZJwdz0Qse@calendula>
References: <20230406092558.459491-1-pablo@netfilter.org>
 <ca12e402-96f1-b1d2-70ad-30e532f9026c@tessares.net>
 <20230412072104.61910016@kernel.org>
 <405a8fa2-4a71-71c8-7715-10d3d2301dac@tessares.net>
 <ZDbWi4dgysRbf+vb@calendula>
 <7405c14e-1fbe-c820-c470-36b0a50b4cae@tessares.net>
 <20230412123718.7e6c0b55@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412123718.7e6c0b55@kernel.org>

On Wed, Apr 12, 2023 at 12:37:18PM -0700, Jakub Kicinski wrote:
> On Wed, 12 Apr 2023 18:35:40 +0200 Matthieu Baerts wrote:
> > > Is this theoretical, or you think any library might be doing this
> > > already? I lack of sufficient knowledge of the MPTCP ecosystem to
> > > evaluate myself.  
> > 
> > This is theoretical.
> > 
> > But using it with socket's protocol parameter is the only good usage of
> > IPPROTO_MAX for me :-D
> 
> Perhaps. No strong preference from me. That said I think I can come up
> with a good name for the SO use: SO_IPPROTO_MAX (which IMHO it's better
> than IPPROTO_UAPI_MAX if Pablo doesn't mind sed'ing?)

SO_ is usually reserved for socket options.

> The name for a max in proto sense... I'm not sure what that would be.
> IPPROTO_MAX_IPPROTO ? IP_IPROTO_MAX ? IP_PROTO_MAX ? Dunno..
