Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114872
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:53:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="216542839"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="216542839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:53:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533067111"
Received: from ltbaker-mobl1.amr.corp.intel.com ([10.212.222.88])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:53:14 -0700
Date: Fri, 20 Aug 2021 10:53:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 1/2] mptcp: fix possible divide by zero
In-Reply-To: <286de8f451b32f60e75d3b8bcc4df515e186b930.1629481305.git.pabeni@redhat.com>
Message-ID: <cba97261-387-4bc-c453-478acab49a21@linux.intel.com>
References: <cover.1629481305.git.pabeni@redhat.com> <286de8f451b32f60e75d3b8bcc4df515e186b930.1629481305.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Fri, 20 Aug 2021, Paolo Abeni wrote:

> Florian noted that if mptcp_alloc_tx_skb() allocation fails
> in __mptcp_push_pending(), we can end-up invoking
> mptcp_push_release()/tcp_push() with a zero mss, causing
> a divide by 0 error.
>

I'll start running this in syzkaller now and then follow up later with 
review comments - thanks!


- Mat

> This change addresses the issue refactoring the skb allocation
> code so that skb allocation always happens after the call
> to tcp_send_mss() correctly initialize mss_now.
>
> As side bonuses we now fill the skb tx cache only when needed,
> and this also clean-up a bit the output path.
>
> Reported-by: Florian Westphal <fw@strlen.de>
> Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 63 ++++++++++++++++++++------------------------
> 1 file changed, 28 insertions(+), 35 deletions(-)

--
Mat Martineau
Intel
