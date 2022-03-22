Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C47365
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647908569; x=1679444569;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sFEO33nZk2wG/AwWXmsP59aDK0eUO2AfVL/ChVSq44U=;
  b=Vw9nKXNadPkHlnLYn58SqMfXKPhrnPMhv5871iQk2JaU4uCl8jr4FKs+
   p0DWER937w8njNsNfHvTA1FG1oILqB4b8q0d+6gq29Sd56IKfrX7IMqb+
   pbf1r7KrJqzrOjf2OP+xo7oECvxQJGkGJSdaC993tv96kDM613mnY+WzG
   zOOW92dIywC9ar6RB+MGrtqOOGDANEcK1BiC3+Abe4RlYDQacMCOyCPmJ
   b58GZjzagCszMocFyKF7zUys5Di6+WbGjq3bzDqm6hoIgRyQ7hBiY7Lwb
   NRJ8FqFRTzJKblHcIEToVuMjv9C1B87tWh8N8FSPZV1/buWmUBZBN0snF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344111468"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="344111468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560112437"
Received: from danieljm-mobl.amr.corp.intel.com ([10.252.129.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:48 -0700
Date: Mon, 21 Mar 2022 17:22:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp:  reset the packet scheduler on
 PRIO change
In-Reply-To: <067656fe2d3628c219f7fcc4b4d99d6b5d6005c0.1647601548.git.pabeni@redhat.com>
Message-ID: <7695e1ed-bf32-5612-55d5-62e55e9e798a@linux.intel.com>
References: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com> <067656fe2d3628c219f7fcc4b4d99d6b5d6005c0.1647601548.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Mar 2022, Paolo Abeni wrote:

> Similar to the previous patch, for priority changes
> requested by the local PM.
>
> Reported-and-suggested-by: Davide Caratti <dcaratti@redhat.com>
> Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 2 ++
> 1 file changed, 2 insertions(+)
>

Looks good, thanks:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c1f4befb1e45..10a73898c8db 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -727,6 +727,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 		if (!addresses_equal(&local, addr, addr->port))
> 			continue;
>
> +		if (subflow->backup != bkup)
> +			msk->last_snd = NULL;
> 		subflow->backup = bkup;
> 		subflow->send_mp_prio = 1;
> 		subflow->request_bkup = bkup;
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
