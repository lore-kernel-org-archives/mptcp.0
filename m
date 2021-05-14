Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282072
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:09:40 +0000 (UTC)
IronPort-SDR: s9wNXJcpHN32qYbA25ecbplAvGj/WB0fSk9QCDj1Jk5DkevK0uA0E7EFutb/kPoGUBgVnKSnMr
 dtn21MtLzYtQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="198271028"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="198271028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:09:37 -0700
IronPort-SDR: Ar+DR7DY7NR+ThOCiu9bJGmEnpYBOZQsf2mXuZ/43WL55ejjtPrdNQdLOTJ6OE94j3VIknzYxx
 I/FoD7HRd9ng==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431827297"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:09:37 -0700
Date: Fri, 14 May 2021 12:09:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 6/7] mptcp: receive path cmsg support
In-Reply-To: <20210514094857.10663-7-fw@strlen.de>
Message-ID: <b1a1165f-61a5-3183-a84a-9cb07706357@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-7-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> This adds support for SO_TIMESTAMP(NS).  Timestamps are passed to
> userspace in the same way as for plain tcp sockets.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
> 1 file changed, 25 insertions(+), 3 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
