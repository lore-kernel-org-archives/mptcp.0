Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AF173
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 17:01:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220221806"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220221806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:01:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="568590906"
Received: from tnguy12-mobl1.amr.corp.intel.com ([10.252.132.90])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:01:25 -0800
Date: Thu, 16 Dec 2021 09:01:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
In-Reply-To: <4bce77f-62f5-16ce-ec4f-51f53ebf9f2b@linux.intel.com>
Message-ID: <5a4dcc82-a1d1-ac8-ff5a-5a1b42ed91@linux.intel.com>
References: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com> <651df38d-49de-6f3d-fca9-b52ccab0c3a5@tessares.net> <4bce77f-62f5-16ce-ec4f-51f53ebf9f2b@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Dec 2021, Mat Martineau wrote:

> On Wed, 15 Dec 2021, Matthieu Baerts wrote:
>
>> Hi Paolo,
>> 
>> On 15/12/2021 12:36, Paolo Abeni wrote:
>>> MPTCP join self-tests are a bit fragile as they reply on
>>> delays instead of events to catch-up with the expected
>>> sockets states.
>>> 
>>> Replace the delay with state checking where possible and
>>> reduce the number of sleeps in the most complex scenarios.
>>> 
>>> This will both reduce the tests run-time and will improve
>>> stability.
>>> 
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> Note: I still see frequent failures in "remove subflow and signal IPv6",
>>> but that looks unrelated from this patch: sk lookup fails on the
>>> client side for the MPJ syn-ack. Funnily enough, I can't reproduce
>>> the failure with pcap capture on...
>> 
>> Thank you for the new version!
>> 
>> I'm trying it in a loop. So far, so good!
>> 
>
> Looks ok here too - just seeing the same ipv6 failure as Paolo, and also that 
> it always succeeds when trying to capture.
>

As discussed in the meeting today:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
