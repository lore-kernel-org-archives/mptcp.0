Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993502C82
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 17:53:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="232969039"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="232969039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 09:53:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="495496760"
Received: from asalter-mobl.amr.corp.intel.com ([10.209.63.232])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 09:53:45 -0800
Date: Thu, 18 Nov 2021 09:53:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 1/4] mptcp: add TCP_INQ cmsg support
In-Reply-To: <20211116134804.30090-2-fw@strlen.de>
Message-ID: <cce8e2d8-7c88-bdac-9b34-5a37407b5e6@linux.intel.com>
References: <20211116134804.30090-1-fw@strlen.de> <20211116134804.30090-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 16 Nov 2021, Florian Westphal wrote:

> Support the TCP_INQ setsockopt.
>
> This is a boolean that tells recvmsg path to include the remaining
> in-sequence bytes in the cmsg data.
>
> v2: do not use CB(skb)->offset, increment map_seq instead (Paolo Abeni)
> v3: adjust CB(skb)->map_seq when taking skb from ofo queue (Paolo Abeni)

To follow up from the meeting discussion today, I thought about it some 
more and suggest that we leave the v2/v3 annotations as-is when applying 
to the export branch.

In the unlikely scenario where a "netdev v2" would be needed, we could 
clarify MPTCP vs netdev or just skip to v4 :)

>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/224
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 36 +++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.h |  1 +
> net/mptcp/sockopt.c  | 37 +++++++++++++++++++++++++++++++++++++
> 3 files changed, 73 insertions(+), 1 deletion(-)

--
Mat Martineau
Intel
