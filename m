Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AF3FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 23:02:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203998649"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203998649"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 16:02:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="513101521"
Received: from ltbaker-mobl1.amr.corp.intel.com ([10.212.222.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 16:02:29 -0700
Date: Fri, 20 Aug 2021 16:02:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 0/2] mptcp: a couple of fix - almost
In-Reply-To: <cover.1629481305.git.pabeni@redhat.com>
Message-ID: <dcc47221-50b4-6c46-320-7231ba4a211f@linux.intel.com>
References: <cover.1629481305.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 20 Aug 2021, Paolo Abeni wrote:

> This are couple of changes poped-up while investigating
> issues/219. They does not address the mentioned issue,
> but the first one should fix an actual bug, the other
> is more a cleanup, so the target tree is undefined ;)
>
> Paolo Abeni (2):
>  mptcp: fix possible divide by zero
>  mptcp: make the locking tx schema more readable
>
> net/mptcp/protocol.c | 73 +++++++++++++++++++++-----------------------
> 1 file changed, 35 insertions(+), 38 deletions(-)
>
> -- 
> 2.26.3

So far my syzkaller setup hasn't seen the div-by-0 again, but it was 
typically taking days to show up. I'll leave that running over the 
weekend.

Changes look good to me - mptcp_push_release() is now only called from 
places where info->mss_now is non-zero.

Patch 1 for -net, patch 2 for net-next seems appropriate.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
