Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F229CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644368062; x=1675904062;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=y92FSR89Ku8H46jJsazayFmLATngUq55aQVa3tHLLvo=;
  b=nyOJe6XXn0WqoiCxsjIbaDKCXAFjMbvP3odAjLDFIOaZ0e8OaQu3H72T
   HHJxBksEHnb1taUr9SiUSd8zpnTNxy4Z+8QYwRagAnFdrUldDxONtHTo3
   z1QCA6EkHrGoQAeYfGt1e1Kgkhq9vpt1Cm0XR+zEU/7lD2VtvVS26AK6A
   B6SxnuBdM8FgGmWPYeHknI8QPm51jqO5RzGstCOurmWUqIavP2T1AM8vK
   QZXIZmIl459duk/w+XTGWDRZfaBmpLEOoRJ7ASesfjfa8vlmGq3ps0m9j
   pLQdXochqOxGSQhlQxPls2AluBElcEnzSflX/f3CgicuuC3jjW3CXGrsy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249295561"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="249295561"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:54:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="540861510"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:54:17 -0800
Date: Tue, 8 Feb 2022 16:54:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 2/4] mptcp: fix race in incoming ADD_ADDR
 option processing.
In-Reply-To: <0fcbb69f-1e23-be3c-aea0-86bafb3a68fb@tessares.net>
Message-ID: <4bab507-7452-b973-279a-70a3e911906f@linux.intel.com>
References: <cover.1644346664.git.pabeni@redhat.com> <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com> <0fcbb69f-1e23-be3c-aea0-86bafb3a68fb@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1245182262-1644367732=:29478"
Content-ID: <e3c9cb16-6813-1ac3-8ceb-f150676f1b57@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1245182262-1644367732=:29478
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <40a0bb37-be8f-d2c6-75fd-3d142514ea8@linux.intel.com>

On Tue, 8 Feb 2022, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 08/02/2022 20:06, Paolo Abeni wrote:
>> If an MPTCP endpoint received moltiple consecutive incoming
>> ADD_ADDR options, mptcp_pm_add_addr_received() can overwrite
>> the current remote address value after the PM lock is released
>> in mptcp_pm_nl_add_addr_received() and before such address
>> is echoed.
>>
>> Fix the issue caching the remote address value a little earlier
>> and always using the cached value after releasing the PM lock.
>
> Thank you for looking at that!
>
> It seems really helping for me: 500 iterations without issues! I guess
> we can add:
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254
>
> (I guess we don't need Reported/Tested-by tags.)
>
> Not related to that but do you think we could have a similar issue with
> RM_ADDR (issues/225)?
>
>
> But one important thing: this series introduces a regression apparently:
> packetdrill ADD_ADDR tests are now failing because the port is missing
> in the echo packet:
>
> ---------- 8< ----------
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal:
>  - Unstable: 2 failed test(s): packetdrill_add_addr selftest_mptcp_join 🔴:
>  - Task: https://cirrus-ci.com/task/5025097999187968
>  - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5025097999187968/summary/summary.txt
>
> - KVM Validation: debug:
>  - Unstable: 1 failed test(s): packetdrill_add_addr 🔴:
>  - Task: https://cirrus-ci.com/task/4765935646015488
>  - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/4765935646015488/summary/summary.txt
>
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/34bad3e35cbc
> ---------- 8< ----------
>
> This seems to be due to this patch 2/4.
>
>>
>> Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/pm_netlink.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index fb8d4bfcfbd6..4b6aa89d45a5 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -660,6 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>>  	unsigned int add_addr_accept_max;
>>  	struct mptcp_addr_info remote;
>>  	unsigned int subflows_max;
>> +	bool reset_port;
>
> I'm very surprise the compiler doesn't complain about this line because
> reset_port can be used later while not having been set before. Is it
> normal with 'bool'?
>
>
> Setting it to false by default fixes the issue with packetdrill on my side:
>
> ---------- 8< ----------
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4b6aa89d45a5..98b485406afa 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -660,7 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct
> mptcp_sock *msk)
>        unsigned int add_addr_accept_max;
>        struct mptcp_addr_info remote;
>        unsigned int subflows_max;
> -       bool reset_port;
> +       bool reset_port = false;
>        int i, nr;
>
>        add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
> ---------- 8< ----------
>
> (I can fix the issue when applying the patch if it is easier)

With Matthieu's reset_port fix, it's working well for me too.


--
Mat Martineau
Intel
--0-1245182262-1644367732=:29478--
