Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975D614D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648060167; x=1679596167;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Z3o7PvO4CnuOKp4fEqA9tpdhTFDYPGjgF2Z79AaKU0=;
  b=itdSYaV3KJKDiYm5Vs5Sujs27IMm5WeHORSQ8bAkDjcesEDsg7pbraxW
   ImuEX+WvdTIdrOaeYQ9KlbS1/AHpkJvYF5EaFu48lHJmrsS4FFUNb33Hr
   YKtfAlp4haIGyV94vPdZYHBMV29WppVH61Mt0DlxWbda2r6WNvOTIwcPw
   ZP61pwcdkipN1e4Yatu2D8Il7vqU1FjuS7ELrG56AX28hd6FOcVg6lE+n
   snWlg2kEbw4UvDGmcy0hXrhFgrQ4m3HFhyRmgB4cxD9qlhxxYQswlz6xP
   OUFuDadDM4TXNiq6DhabqmHglyzWjpI1V3pDjz8Y8MVyMaNVMejGOYxwU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245671796"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="245671796"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:29:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649551823"
Received: from lmcarlo-mobl.amr.corp.intel.com ([10.212.175.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:29:26 -0700
Date: Wed, 23 Mar 2022 11:29:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 0/7] add skc_to_mptcp_sock
In-Reply-To: <3f864428-c3a1-d0b6-cf74-fb3210997dcc@tessares.net>
Message-ID: <6dae6db2-d4cb-8fc2-c1e4-d9dd8f38e62@linux.intel.com>
References: <cover.1648025307.git.geliang.tang@suse.com> <2a05164c-4247-af3f-a3d7-19153314a64a@tessares.net> <3f864428-c3a1-d0b6-cf74-fb3210997dcc@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 23 Mar 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 23/03/2022 13:48, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 23/03/2022 10:09, Geliang Tang wrote:
>>> v11:
>>>  - merge "check more values from mptcp_sock" series into this series.
>>>  - patch 2:
>>>    - rebased.
>>>  - patch 3:
>>>    - rebased.
>>>    - add 'Copyright' entry as Matt suggested in v9:
>>>    https://patchwork.kernel.org/project/mptcp/patch/d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com/
>>>  - patch 4:
>>>    - add test__start_subtest.
>>>    - add some 'Copyright' entries.
>>>  - patch 5:
>>>    - change monitor_log_path to static
>>>    - drop bpf_trace_printk()
>>>  - patch 6:
>>>    - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
>>>    - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.
>>
>> Thank you for the v11 and your patience!
>>
>> I already applied the two first patches because they have already been
>> reviewed before and they were causing conflicts with latest BPF changes:
>
> The new patches, the modifications compared to v10 and the Squash-to
> patch look good to me!
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> @Mat: also OK for you as you also reviewed the previous versions? :)

Yes, fine to add these to the export branch. If other changes are needed 
those could be squashed.

--
Mat Martineau
Intel
