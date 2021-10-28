Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0D72
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 08:36:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mg0tO-0001Rm-H6; Thu, 28 Oct 2021 10:36:10 +0200
Date: Thu, 28 Oct 2021 10:36:10 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: add tproxy test case
Message-ID: <20211028083610.GA23954@breakpoint.cc>
References: <20211027143041.28449-1-fw@strlen.de>
 <20211027143041.28449-3-fw@strlen.de>
 <bd103756-17a0-a0b8-b235-1a82398f0e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd103756-17a0-a0b8-b235-1a82398f0e7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> Could you also update tools/testing/selftests/net/mptcp/config with the
> required kconfig values? My test kernel is definitely missing
> CONFIG_NFT_TPROXY, are others required too?

Probably

CONFIG_NFT_TPROXY=m
CONFIG_NFT_SOCKET=m
CONFIG_NF_TABLES_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y

Will send a v2.

