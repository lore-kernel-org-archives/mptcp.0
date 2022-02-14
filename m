Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA28C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644871496; x=1676407496;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6ZqFkIyXRVT/IngA00RCfFSfhmNkPlEn8Zki/utB6nI=;
  b=oDQXriwO6XShcd8DZr5GDdBIoWZkvPd10lN5aW6gPnxt1GkAvM0vGGIX
   K0IW/jOIwQPot/20mQsCaBC8yewjO4uQalHWwl3yOT7ZWOXuFepsAr6eD
   is0AseLH1lNWy2xHx/KyGywtaq71TFAUYJGcLYRfRO6O2/4Sgitx2HQJm
   JGNGaNfrLalXrN5zolkMpvCmB07TESsNclyN/TB4+50ItKRwDCFxIDqi6
   LR9Uv5nwQ1/YkYF0J6xolEYw5vGwW6EqDB71LPJ12TOjxkDmI8GoLlyaE
   nsJSHeEJUbLVI3kuhgDk77zHZz7ffxSO1VFlVvykKO8V2IIQut6SXzG8R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249928989"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249928989"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:44:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="538823107"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:44:55 -0800
Date: Mon, 14 Feb 2022 12:44:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: iio: accel: add ADXL367 driver: Build Failure
In-Reply-To: <054ab41c-3cdb-88dd-cd69-f43ac5e19d78@gmail.com>
Message-ID: <a6e3b6c6-bed1-866b-40be-7ff119ee6dcc@linux.intel.com>
References: <20220214073810.781016-6-cosmin.tanislav@analog.com> <fb02a7ec-0880-45cd-d6fd-5289391dac9d@gmail.com> <054ab41c-3cdb-88dd-cd69-f43ac5e19d78@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, Cosmin Tanislav wrote:

> I wonder what's up with this?
>
> It seems to have failed at the Notifications step.
>
> URL not found: 'null' 
> 'https://patchwork.kernel.org/api/1.2/patches/?project=mptcp&msgid=20220214073810.781016-2-cosmin.tanislav@analog.com'
>
> + more similar.
>
> On 2/14/22 22:35, MPTCP CI wrote:
>> Hi Cosmin,
>> 
>> Thank you for your modifications, that's great!
>> 
>> But sadly, our CI spotted some issues with it when trying to build it.
>> 
>> You can find more details there:
>>
>>    https://patchwork.kernel.org/project/mptcp/patch/20220214073810.781016-6-cosmin.tanislav@analog.com/
>>    https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843131885
>> 
>> Status: failure
>> Initiator: MPTCPimporter
>> Commits: 
>> https://github.com/multipath-tcp/mptcp_net-next/commits/8ad435df3a10
>>

Hi Cosmin -

It looks like there was a glitch with patchew.org where patches that were 
not on our mailing list got applied to our repo, triggering our build 
automation.

Hopefully patchew has straightened this out! Doesn't appear to be anything 
you or a few other senders did.

For now, I'm working to cancel any other running github actions.

--
Mat Martineau
Intel
