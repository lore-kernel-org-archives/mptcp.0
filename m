Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79F2C9C
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 00:30:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="300634679"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="300634679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 16:30:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="519978571"
Received: from jasanch5-mobl1.amr.corp.intel.com ([10.212.247.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 16:30:18 -0800
Date: Fri, 17 Dec 2021 16:30:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] reuse __mptcp_make_csum in
 validate_data_csum
In-Reply-To: <cover.1639722883.git.geliang.tang@suse.com>
Message-ID: <4608398-50e1-d053-b11a-1d937bf12282@linux.intel.com>
References: <cover.1639722883.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 17 Dec 2021, Geliang Tang wrote:

> Two cleanup patches for the data checksum.
>
> Geliang Tang (2):
>  mptcp: change the parameter of __mptcp_make_csum
>  mptcp: reuse __mptcp_make_csum in validate_data_csum
>
> net/mptcp/options.c  |  8 ++++----
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 15 ++++++---------
> 3 files changed, 11 insertions(+), 13 deletions(-)
>
> -- 
> 2.31.1


Hi Geliang -

Thanks for the cleanup patches! The changes look good to me, and all the 
'mptcp_connect.sh -C' tests work on my system. I tested with only patch 1, 
or both patch 1 & 2, and since both the old and new validation code work 
we can be sure the behavior hasn't changed.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
