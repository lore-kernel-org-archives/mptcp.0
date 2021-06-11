Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96B2F80
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 13:07:45 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lrgsv-0008Np-Gx; Fri, 11 Jun 2021 15:07:41 +0200
Date: Fri, 11 Jun 2021 15:07:41 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev,
	"Westphal, Florian" <fwestpha@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: Re: [PATCH v2 1/4] mptcp: fix warning in __skb_flow_dissect() when
 do syn cookie for subflow join
Message-ID: <20210611130741.GS20020@breakpoint.cc>
References: <ed5254b2-baa9-ea4c-df45-c61fa00622b9@163.com>
 <15a6b1e5c726b57359d08318545b83311f6e5f3f.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a6b1e5c726b57359d08318545b83311f6e5f3f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2021-06-10 at 17:28 +0800, Jianguo Wu wrote:
> > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > 
> > I got the following warning message while doing the test:
> > 
> The above codes uses spaces instead of tabs. More importantly you can
> directly use inet6_ehashfn(), since such function is already visible.
> 
> I'm unsure if we could directly use inet_ehashfn() here: it will
> require making such function visible, and could affect TCP performances
> (in a very minor way) as the compiler may refuse to inline such
> function once that is not 'static'
> 
> @Florian, @Mat, WDYT?!?

I think this is all massive over-engineering.
Probably its enough to do

  th->seq % ARRAY_SIZE(join_entries);

... without any hashing.

I'd suggest to go for

jhash_3words(th->seq, net_hash_mix(net), th->sport << 16| th->dport, &secret)

and ignore network headers altogether.
