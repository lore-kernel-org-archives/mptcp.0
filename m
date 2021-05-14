Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6D72
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:08:57 +0000 (UTC)
IronPort-SDR: 9DdmbbqNyvUyjomEbdRiIME3xMdhZMfS7Xn2ICBsJo9R5rcl7wY3SrYicoWjRA2aKGx9I9C58i
 ODCU0egAe1Ig==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="261462162"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="261462162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:08:57 -0700
IronPort-SDR: 9Q0hGiwz5J0CXcwekMeQ+uIDdlIx+6JIwmxSnVKxSuXUdz6w36nZfEhyhjkS7Gb4es03KE8xC1
 xnplAUm7kLnA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431827178"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:08:57 -0700
Date: Fri, 14 May 2021 12:08:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 5/7] tcp: export timestamp helpers for
 mptcp
In-Reply-To: <20210514094857.10663-6-fw@strlen.de>
Message-ID: <dfa2d84-32a2-84b4-c73e-1c2a5c8f70c9@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-6-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> MPTCP is builtin, so no need to add EXPORT_SYMBOL()s.
>
> It will be used to support SO_TIMESTAMP(NS) ancillary
> messages in the mptcp receive path.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/tcp.h |  4 ++++
> net/ipv4/tcp.c    | 10 ++++------
> 2 files changed, 8 insertions(+), 6 deletions(-)
>

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
