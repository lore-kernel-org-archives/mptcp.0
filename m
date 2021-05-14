Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FD72
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:08:17 +0000 (UTC)
IronPort-SDR: iodeOmnxxcCE8Xu2s2LKhiFXwfxUxXHBb0hFoYs/zqvS1qdo29zJd1+BF6/fBxKa0uay7TeuxH
 Jrsw1eOolXBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197139576"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197139576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:08:17 -0700
IronPort-SDR: v+6oi3B7rBx9XJswslCvVB8sIft+il+GCVgVRp3W3uIoaRll5CT9LLS92bpQukHEtZkT8pGef9
 glTpNl+dp0Tg==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431827062"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:08:16 -0700
Date: Fri, 14 May 2021 12:08:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 4/7] mptcp: setsockopt: handle SOL_SOCKET
 in one place only
In-Reply-To: <20210514094857.10663-5-fw@strlen.de>
Message-ID: <dd12c9fa-5a5a-b0ba-e53e-64be34f4f4f@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-5-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 May 2021, Florian Westphal wrote:

> Move the pre-check to the function that handles all SOL_SOCKET values.
>
> At this point there is complete coverage for all values that were
> accepted by the pre-check.
>
> BUSYPOLL functions are accepted but will not have any functionality
> yet until its clear how the expected mptcp behaviour should look like.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/sockopt.c | 99 +++++++++++++--------------------------------
> 1 file changed, 29 insertions(+), 70 deletions(-)

Thanks for the updates and thanks Paolo for noticing the NAPI issue.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
