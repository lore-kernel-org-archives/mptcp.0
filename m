Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B62C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 15:07:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225043904"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="225043904"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:04:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="458820449"
Received: from lobomatt-mobl.amr.corp.intel.com ([10.212.225.175])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:04:04 -0700
Date: Thu, 7 Oct 2021 08:04:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack()
 static
In-Reply-To: <4dd88f75-1671-69d1-fc85-ef7c18391273@tessares.net>
Message-ID: <d40a139-9f3b-974d-31f-faa28099c527@linux.intel.com>
References: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com> <4dd88f75-1671-69d1-fc85-ef7c18391273@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 7 Oct 2021, Matthieu Baerts wrote:

> Hi Mat,
>
> On 07/10/2021 02:06, Mat Martineau wrote:
>> This function is only used within pm_netlink.c now.
>
> Good catch, thank you for the patch!
>
> Do you think we need a "Fixes" tag? It looks like it has never been used
> outside pm_netlink.c.
>
> But maybe we don't want a "Fixes" tag because we don't want such patch
> to be backported to stable? Or maybe we want to minimise the differences
> by backporting "not risky" patches and ease future backports?
>

I hadn't included the Fixes tag for these reasons :)

I think it's better to leave it off, as it's such a minor thing.

> If we want one, I would suggest:
>
>  Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
>


--
Mat Martineau
Intel
