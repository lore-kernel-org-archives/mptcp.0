Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFE72
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 21:44:55 +0000 (UTC)
IronPort-SDR: byxVtmkb6XjFOC2lKOK7Zw3tcl2MR+g2LyeEc3ZQ0dNdBXWZiMvf801bW05rSNp0k/NgWbInf7
 IYnkLOOAcQlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188237772"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="188237772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:44:53 -0700
IronPort-SDR: CMTz+RyH6qMR6y/tZ4P/opM4J+qTIdLLDLqSmczkWNEv83iwssxUgtaOqeNwWdc2SxB3NCm3iq
 MSOMzTUKSLMg==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473160945"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:44:53 -0700
Date: Tue, 18 May 2021 14:44:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: avoid error message on infinite
 mapping
In-Reply-To: <3254d58a6dabd03533816388bd6dcb04f8078e6a.1621358167.git.pabeni@redhat.com>
Message-ID: <dd2f558d-49f-efb6-f7b1-522c58f96227@linux.intel.com>
References: <3254d58a6dabd03533816388bd6dcb04f8078e6a.1621358167.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Paolo Abeni wrote:

> Another left-over. Avoid flooding dmesg with useless text,
> we already have a MIB for that event.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/subflow.c | 1 -
> 1 file changed, 1 deletion(-)

Thanks for the patch.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9befe9fe7bca..02b1ff06c741 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -951,7 +951,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>
> 	data_len = mpext->data_len;
> 	if (data_len == 0) {
> -		pr_err("Infinite mapping not handled");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> 		return MAPPING_INVALID;
> 	}
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
