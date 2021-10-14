Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC222C85
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 15:02:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227590343"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227590343"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 08:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="461214030"
Received: from mamayo-mobl1.amr.corp.intel.com ([10.212.227.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 08:02:09 -0700
Date: Thu, 14 Oct 2021 08:02:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack()
 static
In-Reply-To: <9a5aa1d0-a6f9-8eb4-e919-86856f2f03f5@tessares.net>
Message-ID: <c589302a-19d6-b2ee-f72c-b1fe1c561119@linux.intel.com>
References: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com> <4dd88f75-1671-69d1-fc85-ef7c18391273@tessares.net> <d40a139-9f3b-974d-31f-faa28099c527@linux.intel.com> <9a5aa1d0-a6f9-8eb4-e919-86856f2f03f5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 14 Oct 2021, Matthieu Baerts wrote:

> Hi Mat,
>
> On 07/10/2021 17:04, Mat Martineau wrote:
>> On Thu, 7 Oct 2021, Matthieu Baerts wrote:
>>
>>> Hi Mat,
>>>
>>> On 07/10/2021 02:06, Mat Martineau wrote:
>>>> This function is only used within pm_netlink.c now.
>>>
>>> Good catch, thank you for the patch!
>>>
>>> Do you think we need a "Fixes" tag? It looks like it has never been used
>>> outside pm_netlink.c.
>>>
>>> But maybe we don't want a "Fixes" tag because we don't want such patch
>>> to be backported to stable? Or maybe we want to minimise the differences
>>> by backporting "not risky" patches and ease future backports?
>>>
>>
>> I hadn't included the Fixes tag for these reasons :)
>>
>> I think it's better to leave it off, as it's such a minor thing.
>
> From what I got from "stable" maintainers, it looks like we should add
> the "Fixes" tag when something is fixed -- i.e. for all patches except
> for new features and related refactoring patches -- and they take the
> decision if backporting a patch would make sense for them or not.
>
> Do you mind if I add the "Fixes" tag and put the commit in the "net"
> section?
>

Don't mind at all, go ahead and add it.

--
Mat Martineau
Intel
