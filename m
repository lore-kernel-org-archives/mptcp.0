Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49972
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:05:35 +0000 (UTC)
IronPort-SDR: Vb9VCc3W0ZnFqHVwJkJ6Nq3R92UNUtw21r9Sd9jaBRcWEzW82YeMIgk8v6Ip9woPEk140qZL1O
 aXS2JRSqbPDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="264147433"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="264147433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:05:34 -0700
IronPort-SDR: pam43bU8A/GfwB2Al1f00Nqv1LL8hB2PsSHQT/anF/SGnRh3ElO3iXhSsgkLdy/P6b6+XA5ZE0
 fFwysBMcS2tA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431826583"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:05:34 -0700
Date: Fri, 14 May 2021 12:05:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/7] sock: expose so_timestamping options
 for mptcp
In-Reply-To: <20210514094857.10663-3-fw@strlen.de>
Message-ID: <e950205c-b3c2-1b6a-2881-a5dd2111c48@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-3-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> Similar to previous patch: expose SO_TIMESTAMPING helper so we do not
> have to copy & paste this into the mptcp core.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/sock.h |  2 ++
> net/core/sock.c    | 71 +++++++++++++++++++++++-----------------------
> 2 files changed, 38 insertions(+), 35 deletions(-)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
