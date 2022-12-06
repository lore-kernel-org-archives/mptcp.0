Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A027713
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670347205; x=1701883205;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jXk2NH0jp/RY5rc8EnkhVrFiLgevPSEwfBS6FuLf+tQ=;
  b=NfG+Vh7WJfpklgD3UYHuDG4/AEOI/IS44MowSG3k95NcLuUddT61866U
   T8gut9SdfjEIj7rjzvaIxqnuns7UKfbSfO+8kKp1p66We6g6Ca9eyc3Xr
   WwNhlr31xiNcWV7JOL2S3m7dFGyISzf6WrWvPkZ5YseGujEUab+AjhUCB
   wBnvF5qD9upyLH+p+cNtZ0h85zi3Lkykoa4lW4CTyVBqNdzFzfskiSuSJ
   BqEGiPYfFXXqvl3u5J6ede6vuz3HNwjI7en9QyLbLX+3rOG5Eb8OYZRfY
   ahXa8b2FhA60/6jqrmAoaw4y8vMGL3dYuwbE0L7Us1R2fBvl+bQD2p9i3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="317821908"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="317821908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:20:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="639948516"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="639948516"
Received: from mjpenner-mobl2.amr.corp.intel.com ([10.209.71.159])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:20:04 -0800
Date: Tue, 6 Dec 2022 09:20:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN
 cookies
In-Reply-To: <54b8bf5a-a456-c2fb-6dec-95121fe4fab5@tessares.net>
Message-ID: <21087bb1-41e3-110d-e7c7-a211320d3f80@linux.intel.com>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net> <20221130094448.4119946-2-matthieu.baerts@tessares.net> <48d0aa62-276c-c23b-d49a-1d7e3a62fed5@linux.intel.com> <54b8bf5a-a456-c2fb-6dec-95121fe4fab5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 6 Dec 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 05/12/2022 22:52, Mat Martineau wrote:
>> On Wed, 30 Nov 2022, Matthieu Baerts wrote:
>>
>>> To ease the maintenance, it is often recommended to avoid having #ifdef
>>> preprocessor conditions.
>>>
>>> Here the section related to CONFIG_MPTCP was quite short but the next
>>> commit needs to add more code around. It is then cleaner to move
>>> specific MPTCP code to functions located in net/mptcp directory.
>>>
>>> Now that mptcp_subflow_request_sock_ops structure can be static, it can
>>> also be marked as "read only after init".
>>>
>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Hi Matthieu -
>>
>> I noticed today that there's no Fixes: tag for this commit, which the
>> netdev CI will check for. Like you say in the commit message, this patch
>> is a small bit of refactoring to prepare for the following patch(es) -
>> should it share Fixes: tags with those or just let the git dependencies
>> speak for themselves?
>
> I don't think we need to add a Fixes tag because as you said, it is
> mentioned this modification is needed for the next patch. I'm sure
> netdev maintainers will understand why it doesn't have a "Fixes" tag.
> But I guess we can also add it (even if it is not really a fix).
>
> We should probably Cc 'stable' ML on the 3 patches but we never really
> did before.
>
> Up to you, if you prefer, I can add it :)
>

I think it's ok to try without it, not every patch merged to -net has one.

Regarding cc: to stable, I've been trying to do that for patches we do 
want backported. We don't want that tag included when sending to mptcp-net 
on our ML as git-send-email would spam the stable list, so I've been 
adding them to the .patch files before upstreaming to netdev. Adding the 
Cc: stable tag in the export branch would probably be ok as long as we're 
careful in other cases where the patches are emailed (when not 
upstreaming).

--
Mat Martineau
Intel
