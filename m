Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237C2C81
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 23:09:18 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mkwiP-0005DC-Hd; Thu, 11 Nov 2021 00:09:14 +0100
Date: Thu, 11 Nov 2021 00:09:13 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
Message-ID: <20211110230913.GI16363@breakpoint.cc>
References: <20211108105711.16200-1-fw@strlen.de>
 <20211108105711.16200-2-fw@strlen.de>
 <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com>
 <20211110101732.GE16363@breakpoint.cc>
 <9ac5fe56-ff93-613f-13a-8017b938ceb6@linux.intel.com>
 <ed6bb478-c85f-34e2-70c1-424dccb082a7@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6bb478-c85f-34e2-70c1-424dccb082a7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > Still trying here, modified the test to show the inq value in case that
> > helps debug.
> 
> Well, that was quick:
> 
> "tcp_inq=7ffffffe is larger than one mbyte"
> 
> At least it's the expected INT_MAX - 1 value... I'll instrument the kernel
> some more and try again.

Great, thanks.  I'll look at this tomorrow as well.

I will keep this test case as-is, but will add an extra test with
out-of-band channel that will inform receiver about exact number of sent
bytes so we can check reported inq hint vs. the (known) unread data value.
