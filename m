Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0437E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 16:29:02 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nPoJy-0002J5-3C; Thu, 03 Mar 2022 17:28:54 +0100
Date: Thu, 3 Mar 2022 17:28:54 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 5/4] mptcp: handle join requests early
Message-ID: <20220303162854.GA6454@breakpoint.cc>
References: <20220224155010.23676-5-fw@strlen.de>
 <20220302094527.12212-1-fw@strlen.de>
 <bf2a68e3-e373-754-cea2-d3a32bb74f5a@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2a68e3-e373-754-cea2-d3a32bb74f5a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > This means subflow to TCP-only listener will fail to establish, but that
> > could be resolved by having a 'reserve the port' approach (mptcpd?) in
> > the tooling that adds the required netlink commands.
> > 
> 
> I'm not sure what this would look like? Seems like a bit of kernel work in
> itself. Not sure if you want to explain here on this list or cover it in the
> meeting.

I meant something really crude^W simple, i.e. socket+bind before telling kernel
that we can receive subflows on x:y.
