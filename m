Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558D72
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 17:15:51 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lrNma-0002J9-Il; Thu, 10 Jun 2021 18:43:52 +0200
Date: Thu, 10 Jun 2021 18:43:52 +0200
From: Florian Westphal <fw@strlen.de>
To: Maxim Mikityanskiy <maximmi@nvidia.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Patrick McHardy <kaber@trash.net>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Young Xiao <92siuyang@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net v2 1/3] netfilter: synproxy: Fix out of bounds when
 parsing TCP options
Message-ID: <20210610164352.GQ20020@breakpoint.cc>
References: <20210610164031.3412479-1-maximmi@nvidia.com>
 <20210610164031.3412479-2-maximmi@nvidia.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610164031.3412479-2-maximmi@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
> The TCP option parser in synproxy (synproxy_parse_options) could read
> one byte out of bounds. When the length is 1, the execution flow gets
> into the loop, reads one byte of the opcode, and if the opcode is
> neither TCPOPT_EOL nor TCPOPT_NOP, it reads one more byte, which exceeds
> the length of 1.
> 
> This fix is inspired by commit 9609dad263f8 ("ipv4: tcp_input: fix stack
> out of bounds when parsing TCP options.").

Reviewed-by: Florian Westphal <fw@strlen.de>
