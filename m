Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9D168
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 20:16:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226609702"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="226609702"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 12:16:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="482541081"
Received: from jchanse1-mobl1.amr.corp.intel.com ([10.209.70.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 12:16:02 -0800
Date: Wed, 15 Dec 2021 12:16:02 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
In-Reply-To: <651df38d-49de-6f3d-fca9-b52ccab0c3a5@tessares.net>
Message-ID: <4bce77f-62f5-16ce-ec4f-51f53ebf9f2b@linux.intel.com>
References: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com> <651df38d-49de-6f3d-fca9-b52ccab0c3a5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-345769877-1639599362=:85429"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-345769877-1639599362=:85429
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 15 Dec 2021, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 15/12/2021 12:36, Paolo Abeni wrote:
>> MPTCP join self-tests are a bit fragile as they reply on
>> delays instead of events to catch-up with the expected
>> sockets states.
>>
>> Replace the delay with state checking where possible and
>> reduce the number of sleeps in the most complex scenarios.
>>
>> This will both reduce the tests run-time and will improve
>> stability.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Note: I still see frequent failures in "remove subflow and signal IPv6",
>> but that looks unrelated from this patch: sk lookup fails on the
>> client side for the MPJ syn-ack. Funnily enough, I can't reproduce
>> the failure with pcap capture on...
>
> Thank you for the new version!
>
> I'm trying it in a loop. So far, so good!
>

Looks ok here too - just seeing the same ipv6 failure as Paolo, and also 
that it always succeeds when trying to capture.

- Mat

>
> It looks like the CI didn't spot any issues in debug mode but different
> ones in non-debug mode:
>
> - KVM Validation: normal:
>  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>  - Task: https://cirrus-ci.com/task/6235909728239616
>  - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/6235909728239616/summary/summary.txt
>
> - KVM Validation: debug:
>  - Unstable: 1 failed test(s): selftest_diag 🔴:
>  - Task: https://cirrus-ci.com/task/4828534844686336
>  - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/4828534844686336/summary/summary.txt
>
>
> I guess it is not related to that.
>
>
>> +rm_addr_count()
>> +{
>> +	ns=${1}
>
> Small detail: it is not "local". I can fix that when applying the patch
> if it helps.
>
>> +# $1: ns, $2: old rm_addr counter in $ns
>> +wait_rm_addr()
>> +{
>> +	local ns="${1}"
>> +	local old_cnt="${2}"
>> +	local cnt
>> +	local i
>> +
>> +	for i in $(seq 10); do
>> +		cnt=$(rm_addr_count ${ns})
>> +		[ "$cnt" = "${old_cnt}" ] || break
>
> I was confused by this: why do you stop if it is the same??? But then I
> realised it was "||" and not "&&" :)
>
>    [ "$cnt" != "${old_cnt}" ] && break
>
>> +dump_stats()
>> +{
>> +	echo Server ns stats
>> +	ip netns exec $ns1 nstat -as | grep Tcp
>> +	echo Client ns stats
>> +	ip netns exec $ns2 nstat -as | grep Tcp
>> +}
>
> Good idea!
>
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
>

--
Mat Martineau
Intel
--0-345769877-1639599362=:85429--
