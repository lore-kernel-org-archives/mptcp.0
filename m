Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2572
	for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 17:37:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="216151270"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="216151270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 10:37:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="427182663"
Received: from jhanbaba-mobl.amr.corp.intel.com ([10.212.224.121])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 10:37:28 -0700
Date: Fri, 27 Aug 2021 10:37:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 26th of August 2021
In-Reply-To: <4723f4cc-c9f8-26c6-9f26-35f6c2ef2975@tessares.net>
Message-ID: <1c2d3145-62e-71e7-fdb-a56e3194a125@linux.intel.com>
References: <4723f4cc-c9f8-26c6-9f26-35f6c2ef2975@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1940920588-1630084534=:97722"
Content-ID: <e1317f43-3ff0-2a3c-fbd0-ab2d644c52ce@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1940920588-1630084534=:97722
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <26b3dbe0-8bac-ef64-7b1b-a98cfad2b1@linux.intel.com>


On Thu, 26 Aug 2021, Matthieu Baerts wrote:

> Patches to send to netdev:
>    → https://github.com/multipath-tcp/mptcp_net-next/commits/export
>    - net:
>        - mptcp: fix possible divide by zero:
>            - might be good to have feedback from syzkaller
>            - and the guy from Tencent
>            - We can send it tomorrow if we don't have negative feedback

syzkaller tests are still looking ok. Haven't heard from Jiang @ Tencent 
about test results yet. Unless I see negative tests/feedback in the next 
several hours I will send this patch and the selftest fix.

>        - selftests: mptcp: clean tmp files in simult_flows:
>            - can be sent with the other one
>        - mptcp: Only send extra TCP acks in eligible socket states:
>            - still need to wait
>
>    - net-next:
>        - MPTCP_INFO:
>            - better to send with the next version to have more time to
> fix exposed UAPI (not at the end of a release cycle)
>        - optimise incoming opt:
>            - it doesn't change any API visual aspect so it should be
> fine to send it now (or wait if we prefer)

The incoming option patches have been merged to net-next.


--
Mat Martineau
Intel
--0-1940920588-1630084534=:97722--
