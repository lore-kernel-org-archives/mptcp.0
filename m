Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E4168
	for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 23:53:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215963597"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="215963597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 16:53:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="448939596"
Received: from dpjohns1-mobl1.amr.corp.intel.com ([10.252.141.83])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 16:53:57 -0700
Date: Mon, 16 Aug 2021 16:53:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: ADD_ADDR and fully_estab
In-Reply-To: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
Message-ID: <4c6a722-d7c6-64d8-ddf-cb8d869c342c@linux.intel.com>
References: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 16 Aug 2021, Matthieu Baerts wrote:

> This is the v2 of "mptcp: full fully established support after ADD_ADDR"
> but now we also make sure the HMAC bit is present (patch 1/2, as
> suggested by Mat, thanks!).
>
> Matthieu Baerts (2):
>  mptcp: check for HMAC presence in ADD_ADDR
>  mptcp: full fully established support after ADD_ADDR
>
> net/mptcp/options.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
> -- 
> 2.32.0

Thanks for the v2.

I'd prefer that these are squashed, I don't think it's important to change 
the single line in patch 1 that just gets deleted in patch 2. It wasn't my 
intent to ask for two patches in my previous review, if that was a factor.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
