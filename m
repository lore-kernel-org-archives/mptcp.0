Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE584C68
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645218677; x=1676754677;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=49l+h9GGDgxCNq05ZKomwkRuE3d7P7AafHeX/aW9WC4=;
  b=gCWIViGEekBZVvuzHh6KWanDnUOZdQ1dSp+wmyp75UvGSmPeDxlfGhD8
   WfnJgUwEJHGYJ6NR7SfP5d+9Rn2BHFQyh1UlLRFOcQDPUAYdQ3KU6kq6r
   OFRPlRb+kP86+SWOPtL4H3dtU15eZo0/RU57WnD0xfxUOjjnxvg9OND93
   VAq1QsLvQzlE4bjJRmRDWWhESvSzVC3QYSyaj2GjrVjfScYz4Mxu5yJKM
   rKqCB8o/w23Irl+4p2aKkM68iCgLM4cxY/0F5aDW492yJi62eTwrmcKHs
   0LJqo4nrc0fWMafn8qDnqFFIhygG+OLns37qgfmty38tOvrnKTkENqUS1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231193104"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231193104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:11:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="778112574"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:11:16 -0800
Date: Fri, 18 Feb 2022 13:11:15 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/2] mptcp: fix ioctl on fallback
In-Reply-To: <cover.1645196974.git.pabeni@redhat.com>
Message-ID: <287ee9a7-e9a8-3e7e-87da-c03c5c87cf1@linux.intel.com>
References: <cover.1645196974.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Feb 2022, Paolo Abeni wrote:

> The first patch fixes the issue, hopefully closing:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/260
>
> the 2nd patch is self-test cleanup
>
> Paolo Abeni (2):
>  mptcp: accurate SIOCOUTQ for fallback socket
>  selftests: mptcp: do complete cleanup at exit
>
> net/mptcp/protocol.c                               | 11 +++++++++++
> tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 ++--
> 2 files changed, 13 insertions(+), 2 deletions(-)
>
> -- 
> 2.34.1

Looks good for the export branch, thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
