Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933E173
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 11:07:51 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mE8Yv-0006lp-NZ; Thu, 12 Aug 2021 13:07:49 +0200
Date: Thu, 12 Aug 2021 13:07:49 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/5] mptcp: add SOL_MPTCP getsockopt support
Message-ID: <20210812110749.GY607@breakpoint.cc>
References: <20210811131523.6339-1-fw@strlen.de>
 <0a040c70d57ce758a37f92cb214ee332656b3057.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a040c70d57ce758a37f92cb214ee332656b3057.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> >  8 files changed, 869 insertions(+), 29 deletions(-)
> >  create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> 
> The patches LGTM! I have just a couple of minor curiosity. 
> 
> In some helper the argument that carries the option length from user
> space is named '_u_optlen', any special reason for that? Encoding the
> argument attribute into the user name looks really win32 style from the
> early 2000, afaik ;))) [no offense intended!!!]

Ok, I'll rename it to 'int __user *optlen' in v2.

> I don't see how the mptcp_subflow_addrs is going to change/increase the
> size with time... do you have some possible ideas/guess?

No idea. IPv8?  I added struct sockaddr_storage into the union so it will
hopefully be enough but who knows, this API might well live on for decades
and I'd rather have a small back door that allows to increase this if
needed.
