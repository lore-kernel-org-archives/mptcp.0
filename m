Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8F2C9C
	for <mptcp@lists.linux.dev>; Wed,  2 Feb 2022 01:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643764710; x=1675300710;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iMzZl9SRvkVEndcB3HMgSFta6QrOaefDIcvge24z/vg=;
  b=WPFZMWQKqVuaZZdihAC28EmqY9SJZkb2e9D+xcuQh4pUvf026WEg0nuL
   MXSnw1x3sOod0vpd+PA16cmBVSx7Pd3PrvQAN7HLEOOIGfaH8JHZIoPD/
   Xpt2RsjsZTlXyJpxUqjh+Wlcb//T5LA42PuvVNtlMpjhSsl6XJutsa6FN
   gzDi7yljN4O5v3B1Ej5wL2JSqxjM0/SyLCCSpygGYv/16Fy8MmMA8AJD2
   QYIGEZdIdpw2dsJeIw84YYfSXxXg9XvXGmqljUakPOHYQqGGXLk6+oCA1
   t65LviWe3wPvU5uHtEJvEC2pX7Vknsfx9VoIG7rRcCJtb8ZfJBKn1Yf/4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228487338"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="228487338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 17:18:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="676297960"
Received: from ekebedex-mobl1.amr.corp.intel.com ([10.251.14.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 17:18:19 -0800
Date: Tue, 1 Feb 2022 17:18:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 7/8] mptcp: attempt to add listening sockets
 for announced addrs
In-Reply-To: <7f32b1f1-838e-dee8-0073-e59f59c46f95@intel.com>
Message-ID: <9c27f9d6-d0ef-f878-7193-16fdcde74977@linux.intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com> <20220128003812.2732609-8-kishen.maloor@intel.com> <2a4c2a567359b839aacd3d56d8a7734af5479747.camel@redhat.com> <1b10e9d2-cc63-efe9-2488-29a66ebaaaad@tessares.net>
 <7f32b1f1-838e-dee8-0073-e59f59c46f95@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1596481573-1643764699=:25542"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1596481573-1643764699=:25542
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 1 Feb 2022, Kishen Maloor wrote:

> On 2/1/22 9:25 AM, Matthieu Baerts wrote:
>> Hi Paolo, Kishen,
>>
>> On 01/02/2022 12:42, Paolo Abeni wrote:
>>> On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
>>>> When ADD_ADDR announcements use the port associated with an
>>>> active subflow, this change ensures that a listening socket is bound
>>>> to the announced addr+port in the kernel for subsequently receiving
>>>> MP_JOINs. But if a listening socket for this address is already held
>>>> by the application then no action is taken.
>>>>
>>>> A listening socket is created (when there isn't a listener)
>>>> just prior to the addr advertisement. If it is desired to not create
>>>> a listening socket in the kernel for an address, then this can be
>>>> requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
>>>> with the address.
>>>>
>>>> When a listening socket is created, it is stored in
>>>> struct mptcp_pm_add_entry and released accordingly.
>>>>
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
>>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>>> ---
>>>> v2: fixed formatting
>>>> v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
>>>> listening socket in the kernel during an ADD_ADDR request, use this flag
>>>> along the in-kernel PM flow for ADD_ADDR requests (Note: listening sockets
>>>> are always created for port-based endpoints as before), use the
>>>> lsk_list_find_or_create() helper
>>>
>>> I think it's better introducing the opposite flag (e.g.
>>> 'MPTCP_PM_ADDR_FLAG_LISTEN') otherwise this will change the default
>>> behavior
>>
>> Maybe it is fine to change the behaviour. Without changing the user
>> exposed API of course.
>>
>> I mean: it all depends if we consider the fact that when the userspace
>> closes the listening socket to accept new "MPTCP" connections, it is not
>> normal (bug) to close the possibility to create new subflows → socket
>> controlled by the user vs socket controlled by the PM. If we do consider
>> this as a "bug", then that's OK to change the default behaviour, no?
>>
>> I don't know if other people are sharing my view here.
>>
>> For me, if an app closes the listening socket after having accepted a
>> new connection, it is just not to receive new "main" connections on this
>> socket but it is OK to accept new subflows as they are part of existing
>> connections (and managed by the PM).
>> We would then avoid people hitting issues like #203. If you hit this
>> issue, it is not easy to find the answer I think.
>>
>
> I think Matthieu has clearly captured above my rationale that led to this change because
> I did consider this a "bug".
>
>> If people know they don't need/want the creation of a listening socket
>> only to accept new subflows, they can set the NO_LISTEN flag when adding
>> an address with "ip mptcp". But if the cost is minimal most of the time
>> because no additional listening sockets will be actually created, that's
>> fine to use a "NO_LISTEN" flag I think.
>>
>
> Yes, when the application is listening (which may be the majority of cases), no listening
> socket is created for address announcements reusing the subflow's port. If the application
> happens to not be listening, then a listener is established, so issues like #203 would be
> addressed by default. Further, if the user does not want (for any reason) a listener
> to be created, then they could supply the NO_LISTEN flag with the address.
>

I concur with Matthieu and Kishen here, I think the NO_LISTEN flag gives 
enough control that everyone will be able to get the behavior they need 
with the least surprising defaults. It seems like keeping exactly the same 
existing behavior in different special cases would be a less desirable 
tradeoff.

--
Mat Martineau
Intel
--0-1596481573-1643764699=:25542--
