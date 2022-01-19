Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C729CA
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642620920; x=1674156920;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t2x1MbSxvykp1w0z2TZESvMxIXIvv0xmPfPQnzWJq2Q=;
  b=YRXFfLj1qSaA6I+4/5OXnSIPC9fmUwHUsleAvT6p/p2mYqK3TPK8pHkl
   tK5W8aMHNOOXLocXqoVL2OAiyZKXyuejOSLbirbiNloCq0iFiL7+us+UI
   uVxs0s9Kjc6WVYN/z4g3jOPs94jOzdj3M1FQj418jLupi8O47EbWIZhuH
   HpI3wRsR0esq2VfhQhfIcNjPYh4RZbR+iu41Afj/E5Fq2yOmEPB3n7jPb
   ulPI/39ZnFGqQz7YVCCTT/ZwtMZb+LWA8gTpy4VmV8XQ56RNFpvbfFmQZ
   BLoPdRJvzMhpzK1DDu1h/P6R5idYwB3qI+Gy6EHufy+wIn6cRYarAWKvH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269564286"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="269564286"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:14:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="493147107"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:14:24 -0800
Date: Wed, 19 Jan 2022 11:14:24 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 07/21] mptcp: netlink: process IPv6 addrs
 in creating listening sockets
In-Reply-To: <e5b4f614-4b6c-84d3-8558-bcd707bc32ac@intel.com>
Message-ID: <41b4eb-b482-cac0-558d-16a09a0f4f7@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com> <20220112221523.1829397-8-kishen.maloor@intel.com> <489b1e836ec09b23cd9318f7fa8a404dec50e72b.camel@redhat.com> <911f2260-4694-cd5a-61d8-f094f0ab672b@linux.intel.com>
 <e5b4f614-4b6c-84d3-8558-bcd707bc32ac@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1000942382-1642619664=:18983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1000942382-1642619664=:18983
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 18 Jan 2022, Kishen Maloor wrote:

> On 1/14/22 2:09 PM, Mat Martineau wrote:
>> On Fri, 14 Jan 2022, Paolo Abeni wrote:
>>
>>> Hello,
>>>
>>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>>> This change updates mptcp_pm_nl_create_listen_socket() to create
>>>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>>>
>>
>> This tag -
>>
>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>>
>> would help with backporting to stable.
>>
>>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>>> ---
>>>>  net/mptcp/pm_netlink.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>> index 4c1895dbc2a5..779ec9d375f0 100644
>>>> --- a/net/mptcp/pm_netlink.c
>>>> +++ b/net/mptcp/pm_netlink.c
>>>> @@ -986,6 +986,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>>>                          struct mptcp_pm_addr_entry *entry,
>>>>                          struct socket **lsk)
>>>>  {
>>>> +    int addrlen = sizeof(struct sockaddr_in);
>>>>      struct sockaddr_storage addr;
>>>>      struct mptcp_sock *msk;
>>>>      struct socket *ssock;
>>>> @@ -1010,8 +1011,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>>>      }
>>>>
>>>>      mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>>>> -    err = kernel_bind(ssock, (struct sockaddr *)&addr,
>>>> -              sizeof(struct sockaddr_in));
>>>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>>> +    if (entry->addr.family == AF_INET6)
>>>> +        addrlen = sizeof(struct sockaddr_in6);
>>>> +#endif
>>>> +    err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
>>>>      if (err) {
>>>>          pr_warn("kernel_bind error, err=%d", err);
>>>>          goto out;
>>>
>>> This looks a bugfix for -net to me?
>
> Sure, we can record a bug and the fact that this commit fixes it.
>
>>>
>>> Possibly worthy additional an additional mp_join self-test for the ipv6
>>> case.
>>>
>>
>> I agree, this would be good for -net. Kishen can you add the suggested selftest too and repost separately for mptcp-net?
>>
>
> Actually, this path is currently exercised by self-tests in userspace_pm.sh through address
> advertisements from the namespace containing the MPTCP client, for which a listening
> socket is created to subsequently receive MPJs.

Ok, it's good that it's covered going forward. Re-reading Paolo's comment, 
maybe that was the main purpose of the requested test (rather than adding 
to self test coverage in -stable). Should be enough to have the kernel fix 
itself for the -net patch.

--
Mat Martineau
Intel
--0-1000942382-1642619664=:18983--
