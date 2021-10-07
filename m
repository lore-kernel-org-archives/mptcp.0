Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4572C88
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 08:53:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mYOp8-0006lm-5L; Thu, 07 Oct 2021 10:32:18 +0200
Date: Thu, 7 Oct 2021 10:32:18 +0200
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev, mathew.j.martineau@linux.intel.com
Subject: Re: [RFC PATCH 0/4] mptcp: Update netlink interface for userspace PM
Message-ID: <20211007083218.GA7333@breakpoint.cc>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007043656.261552-1-kishen.maloor@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> This patch series marks the beginning of an attempt to update the MPTCP
> netlink interface with commands to support the offloading of path management 
> decisions to userspace path managers.
> 
> Specifically, the commits in this series introduce the following commands:
> 
> * MPTCP_PM_CMD_ANNOUNCE: Issue an ADD_ADDR advertisement over the selected MPTCP
>   connection.

Looks like you guys are further ahead than me.
I've pushed my work here:

iproute2:
https://git.breakpoint.cc/cgit/fw/iproute2.git/log/?h=mptcp_sf_03

kernel:
https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/log/?h=netlink_cmd_07

I had planned to work on packetdrill tests next but to avoid
further duplicate work I will refrain from doing so.

Feel free to take what you need and/or mangle and discard this at will.
