Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E272C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 23:55:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227897937"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227897937"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:55:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="525587545"
Received: from jwbates1-mobl1.amr.corp.intel.com ([10.212.131.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:55:49 -0700
Date: Fri, 15 Oct 2021 16:55:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/3] net: introduce
 sk_forward_alloc_get()
In-Reply-To: <944348e29bd564a3e45d7ab6683c4e64ef48aec1.1634312286.git.pabeni@redhat.com>
Message-ID: <cdbfec25-6766-b776-2f42-94651ada56d1@linux.intel.com>
References: <cover.1634312286.git.pabeni@redhat.com> <944348e29bd564a3e45d7ab6683c4e64ef48aec1.1634312286.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Oct 2021, Paolo Abeni wrote:

> A later patch will change the mptcp memory accounting schema
> in such a way that MPTCP sockets will encode total amount of
> forward allocated memory in two separate fields (one for tx
> and one for rx).
>
> MPTCP sockets will use their own helper to provide the accurate
> amount of fwd alloced memory.
>
> To allow the above, this patch adds a new, optional, sk method to
> fetch the fwd memory, wrap the call in a new helper and use it
> where apprioriate.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This schema was suggested long time ago by Eric in a completely
> different context:
>
> https://marc.info/?l=linux-netdev&m=147516056204838&w=2
>
> I'm unsure if that is still applicable/valid.

Thanks for the historical context!

> ---
> include/net/sock.h   | 11 +++++++++++
> net/ipv4/af_inet.c   |  2 +-
> net/ipv4/inet_diag.c |  2 +-
> net/sched/em_meta.c  |  2 +-
> 4 files changed, 14 insertions(+), 3 deletions(-)


Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
