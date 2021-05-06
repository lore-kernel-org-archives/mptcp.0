Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AC72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 20:11:57 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lekLj-0004Ou-1S; Thu, 06 May 2021 22:11:55 +0200
Date: Thu, 6 May 2021 22:11:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
Message-ID: <20210506201155.GE12364@breakpoint.cc>
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> We can't use tcp_set_congestion_control() on an mptcp socket, as
> such function can end-up accessing a tcp-specific field -
> prior_ssthresh - causing an OOB access.

Nice find.

> To allow propagating the correct ca algo on subflow, cache the ca
> name at initialization time.

Ok, this removes the problem of setting the right icsk_ca_ops on the
mptcp socket.

Thanks for fixing this!
