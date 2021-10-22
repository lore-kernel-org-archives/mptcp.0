Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2772
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 18:26:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="315562962"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="315562962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:26:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="663278429"
Received: from yyang-mobl1.amr.corp.intel.com ([10.254.9.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:26:36 -0700
Date: Fri, 22 Oct 2021 11:26:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Dmytro Shytyi <dmytro@shytyi.net>
cc: mptcp <mptcp@lists.linux.dev>
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
In-Reply-To: <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
Message-ID: <b3fe9e5-cdc8-547d-f9b8-4565cd3b03e@linux.intel.com>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net> <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 22 Oct 2021, Matthieu Baerts wrote:

> Hi Dmytro,
>
> (without netdev ML and net maintainers)
>
> On 22/10/2021 07:15, Dmytro Shytyi wrote:
>> This set of patches will bring "Fast Open" Option support to MPTCP.
>> The aim of Fast Open Mechanism is to eliminate one round trip
>> time from a TCP conversation by allowing data to be included as
>> part of the SYN segment that initiates the connection.
>>
>> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
>>
>> [PATCH v1] includes "client" partial support for :
>> 1. send request for cookie;
>> 2. send syn+data+cookie.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>
> Again, thank you for looking at that!
>

Thanks for covering the patch submission and formatting guidelines, 
Matthieu.

Dymtro, it will also be important to add some 'fast open' coverage to the 
kernel self tests in this directory of the kernel source tree:

tools/testing/selftests/net/mptcp/

There's a short guide to running these tests at 
https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing#kselftest


We appreciate your work to add this feature to MPTCP in the Linux kernel!

--
Mat Martineau
Intel
