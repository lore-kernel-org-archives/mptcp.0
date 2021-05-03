Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BE71
	for <mptcp@lists.linux.dev>; Mon,  3 May 2021 20:09:58 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ldetA-0008Bh-K2; Mon, 03 May 2021 22:09:56 +0200
Date: Mon, 3 May 2021 22:09:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] mptcp: fix splat when closing unaccepted socket
Message-ID: <20210503200956.GJ975@breakpoint.cc>
References: <20210503100224.22433-1-fw@strlen.de>
 <5d40b9cc-991d-40f7-ba51-6a11dc3e705d@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d40b9cc-991d-40f7-ba51-6a11dc3e705d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> Thanks Paolo and Florian. Patch looks good - should go to -net right?

Yes, this needs to go to -net.

Thanks!
