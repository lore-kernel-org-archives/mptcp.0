Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC621FD3
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 07:29:33 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nKxhq-00007I-Ml; Fri, 18 Feb 2022 08:29:30 +0100
Date: Fri, 18 Feb 2022 08:29:30 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] tcp: add mptcp join demultiplex hooks
Message-ID: <20220218072930.GB30383@breakpoint.cc>
References: <20220217142538.7849-1-fw@strlen.de>
 <20220217142538.7849-4-fw@strlen.de>
 <f99582a630cdb54490462277f06dfaac204e9f86.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99582a630cdb54490462277f06dfaac204e9f86.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> If I read correctly, subflow_syn_recv_sock() will filter the incoming
> packets vs the annonced list, but only if the incoming packet's
> destination port is different from the listener port.

Same as today, if it hit listener port then no issue...?
The listener port isn't in the announced list, so the check would fail.

> - incoming request targeting a bad address and/or port will reach the
> syn-ack before being rejected.

Yes.

> - incoming request targeting port 0 will likely be always accepted.

No, port 0 is illegal, there is an explicit check that prevents
such port from being wired up to the magic listener.

> What about moving the anno_list check in __mptcp_handle_join()? Should
> address the 2 above points and keep the anno_list traversals to the
> bare minimum.

I can have a look.
