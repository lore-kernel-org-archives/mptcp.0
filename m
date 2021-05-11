Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8B70
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 13:36:43 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lgSYs-0000Sl-Kn; Tue, 11 May 2021 15:36:34 +0200
Date: Tue, 11 May 2021 15:36:34 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 5/8] mptcp: setsockopt: handle SOL_SOCKET in
 one place only
Message-ID: <20210511133634.GG4038@breakpoint.cc>
References: <20210506102243.2390-1-fw@strlen.de>
 <20210506102243.2390-6-fw@strlen.de>
 <cef9b5-266f-ba1b-1c37-1758b8e211e2@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef9b5-266f-ba1b-1c37-1758b8e211e2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Thu, 6 May 2021, Florian Westphal wrote:
> > +	if (level == SOL_SOCKET)
> > +		return true; /* mptcp_setsockopt_sol_socket handles this */
> 
> I suggest not adding these two lines, and moving the call to
> mptcp_supported_sockopt() after the SOL_SOCKET handling at the beginning of
> mptcp_setsockopt(). What do you think?

I think thats better.  V2 coming in a second.
