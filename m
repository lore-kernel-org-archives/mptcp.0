Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35B3FC7
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 23:19:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277692159"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="277692159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 16:19:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="522644793"
Received: from seedmund-mobl.amr.corp.intel.com ([10.212.221.18])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 16:19:17 -0700
Date: Thu, 19 Aug 2021 16:19:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] selftest: wait before trasnmitting first data
 chunk
In-Reply-To: <dda5fa72-be05-cca2-6839-343b56644ab9@tessares.net>
Message-ID: <571b2e3a-cd36-368a-4184-8cf42eb33b5@linux.intel.com>
References: <20210819130040.30228-1-fw@strlen.de> <dda5fa72-be05-cca2-6839-343b56644ab9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 19 Aug 2021, Matthieu Baerts wrote:

> Hi Florian,
>
> On 19/08/2021 15:00, Florian Westphal wrote:
>> Squashto: selftests: mptcp: add mptcp getsockopt test cases
>>
>> Mathieu reports spurious failure of the selftest:
>>  mptcp_sockopt.c:362: do_getsockopt_tcp_info: Assertion `ti.ti[0].tcpi_bytes_received == r' failed.
>>  mptcp_sockopt.c:330: do_getsockopt_mptcp_info: Assertion `s-&gt;mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt' failed.
>>
>> This is because client and server are racing.
>> The first getsockopt() for (MP)TCP_INFO might be called when some data
>> was already received, but the mptcpi_rcv_nxt assertion relies on the
>> initial call to fetch a 'start sequence number'.
>>
>> Extend the pipe (that was used to unblock the 'connect process' when
>> the server had bound a socket), it now tells when to connet and when
>> to send the first chunk of data.
>>
>> In addition, its remote chance, but possible, that tx is slower
>> than expected so allow tcpinfo to wait a bit for more data to arrive.
>>
>> After this, 20k invocations pass without failures.
>
> Thank you for this patch! It looks good to me!
>
> It is also passing multiple times without issues on my side with and
> without a debug kernel!
>

Looks good to me as well. Ok to squash with "selftests: mptcp: add mptcp 
getsockopt test cases"?

--
Mat Martineau
Intel
