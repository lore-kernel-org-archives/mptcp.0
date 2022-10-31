Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009C7E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667232517; x=1698768517;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K0YUR7q3k/2QhoZ3zXI/HmXVv2R4BGnA+AiI44NWV0Y=;
  b=mqIQ3ycgm4ieiK3BBn5fqtb4S+OkQH5T7Z+Znoa+4K7M9MrvBST5bTpT
   SRi7vJkm32U5aURCxThU/FlwxrRWzhyIJw9lI+2spvgR0LegrPIppDdgB
   pEdAOr1aGw/MnUPZT1DHr+HeGXyNTR9SV+x5jkc/0HBjYc9LkhMpxcLSW
   NIUdUzI9cpnLoMJLGdodq15JjAx+aJsU1H85OfFkVRNFQoZs90rQKaQ1P
   T8bHjIUhcPyUlkdhYXiLra+NkJIOK9rowEyXwHGw0rh7WXcjAA87r4JHp
   Ro+SNnkPWkPJ1GOwSaknbpn5H6/bBUB1CBfOqX6/JFMfywYV6E4lVLi+E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373147796"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373147796"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 09:08:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611539471"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="611539471"
Received: from jblosfi-mobl1.amr.corp.intel.com ([10.255.229.117])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 09:08:37 -0700
Date: Mon, 31 Oct 2022 09:08:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/4] selftests: mptcp: run mptcp_sockopt from
 a new netns
In-Reply-To: <aaad626e-a646-f2a7-fb8b-158b459b73ea@tessares.net>
Message-ID: <d183722a-b41c-57b4-38e7-356a263d313b@linux.intel.com>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net> <20221019161940.3178393-2-matthieu.baerts@tessares.net> <CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com> <aaad626e-a646-f2a7-fb8b-158b459b73ea@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1025703298-1667232516=:4437"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1025703298-1667232516=:4437
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 31 Oct 2022, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 23/10/2022 11:28, Geliang Tang wrote:
>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年10月20日周四 00:20写道：
>>>
>>> Not running it from a new netns causes issues if some MPTCP settings are
>>> modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
>>> addresses are available and added to the MPTCP path-manager, etc.
>>>
>>> In these cases, the created connection will not behave as expected, e.g.
>>> unable to create an MPTCP socket, more than one subflow is seen, etc.
>>>
>>> A new "sandbox" net namespace is now created and used to run
>>> mptcp_sockopt from this controlled environment.
>>>
>>> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> index 0879da915014..80d36f7cfee8 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> @@ -35,8 +35,9 @@ init()
>>>
>>>         ns1="ns1-$rndh"
>>>         ns2="ns2-$rndh"
>>> +       ns_sbox="ns_sbox-$rndh"
>>
>> Hi Matt, how about clearly defining ns_sbox (as well as ns1, ns2) as a
>> global variable at the beginning of this file, and then assign values
>> here, as the same as in mptcp_connect.sh and mptcp_join.sh?
>
> Thank you for the idea, it would be clearer.
>
> @Mat: Because this patch is for -net, would it not be better to do that
> in an additional patch for net-next? Patch 2/4 is also for net-next and
> depends on patch 1/4.
>
> Or maybe it is OK to do that in -net because it is in the selftests? I
> would prefer to split but I'm fine to do that if we prefer.

Oh - I missed that the series was a mix of net and net-next!

Sure, fine to split it.

--
Mat Martineau
Intel
--0-1025703298-1667232516=:4437--
