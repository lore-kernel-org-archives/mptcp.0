Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F9163
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665447160; x=1696983160;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1Jn/g2nA34WkPMGnLhkPZWZrg6n27fYGZDbvNuj0vjc=;
  b=GQ/NvOBMaY27HrCe8+q6EnRfgpqTHAAwfoTUiFv2thwOvqXPkgYG4SW8
   N8lJv76DNF/4iR7D03dknHxdlieEOHxQCcXVbidT7BDeAsjx0GgkcypDC
   ozMSNFQWgQVSepjc8v4y0c6VjnhLAo9ovmPljfiZOkQhwRU4CCqUxZDvg
   J+4HaJDYryiDSydyEyhJbbB0pHJO2Ur3nKuQ24KBh6RVMuvENPzfPI5hG
   gArbTUqP19NrzLCBevfBzsrGEuAMZKD3sW0pRsNWmIffIVzkmSOpABjA6
   aiLfpix2ifdz32vv09fnBPyWmQEUYtQPoG92AogeNmOTOTW/YXr1qP8yw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="330839284"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="330839284"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:12:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577240077"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="577240077"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:12:39 -0700
Date: Mon, 10 Oct 2022 17:12:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v5 00/11] refactor push pending
In-Reply-To: <CA+WQbwuVgAUSo=sP+gty0urNNWDC0JhG1MXBMzxzPxYvBj1OVg@mail.gmail.com>
Message-ID: <413a32e8-bbe3-7461-e81d-71a288aab434@linux.intel.com>
References: <cover.1665058388.git.geliang.tang@suse.com> <86e6c9a8-4361-ec40-56ee-98c270d8342a@linux.intel.com> <20221007090031.GA15380@bogon> <CA+WQbwuVgAUSo=sP+gty0urNNWDC0JhG1MXBMzxzPxYvBj1OVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-89229874-1665447159=:4105"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-89229874-1665447159=:4105
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Oct 2022, Geliang Tang wrote:

> Geliang Tang <geliang.tang@suse.com> 于2022年10月7日周五 16:59写道：
>>
>> On Thu, Oct 06, 2022 at 05:16:55PM -0700, Mat Martineau wrote:
>>> On Thu, 6 Oct 2022, Geliang Tang wrote:
>>>
>>>> v5:
>>>> - address Mat's comments in v4.
>>>
>>> Hi Geliang -
>>>
>>> Thanks for the v5. I haven't finished looking over all the patches in detail
>>> yet, but two things I do want to reply to right now:
>>>
>>>  * Thanks for explaining in patch 4 that last_snd is still useful for round
>>> robin. I had forgotten about that, and it looked like a "write-only"
>>> variable in the kernel code.
>>>
>>>  * In the meeting today Paolo suggested that a good test for the new
>>> scheduler loop would be to modify simult_flows.sh to use much larger files,
>>> then see if the modified code slowed down any of the simult_flows tests.
>>>
>>> He suggested making the test file 10x larger in simult_flows.sh:
>>>
>>> -     size=$((2 * 2048 * 4096))
>>> +     size=$((2 * 2048 * 4096 * 10))
>>>
>>> Can you compare the test times between the export branch and this series,
>>> with both of them using the larger file size?
>>
>> 10x larger failed in my tests with timeout. So I changed it to 5x
>> larger.
>>
>> Here's the patch:
>>
>> @@ -52,7 +52,7 @@ setup()
>>         sout=$(mktemp)
>>         cout=$(mktemp)
>>         capout=$(mktemp)
>> -       size=$((2 * 2048 * 4096))
>> +       size=$((2 * 2048 * 4096 * 5))
>>
>>         dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
>>         dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
>> @@ -210,13 +210,13 @@ do_transfer()
>>         fi
>>
>>         echo " [ fail ]"
>> -       echo "client exit code $retc, server $rets" 1>&2
>> -       echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
>> -       ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
>> -       echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
>> -       ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
>> -       ls -l $sin $cout
>> -       ls -l $cin $sout
>> +       #echo "client exit code $retc, server $rets" 1>&2
>> +       #echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
>> +       #ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
>> +       #echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
>> +       #ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
>> +       #ls -l $sin $cout
>> +       #ls -l $cin $sout
>>
>>         cat "$capout"
>>         return 1
>>
>> All logs are attached. "5x_10times_export.log" is for the export branch
>> and "5x_10times_refactor_v5.log" is for this series.
>
> I compared the two log data. The test time of this series is indeed
> longer than that of export, but the difference is very small.
>
> I removed the useless information in the two logs and only retained
> the running time and expected time. It looks like this:
>
>> cat 5x_export.log | head
> 36150 max 36005
> 36135 max 36005
> 36087 max 36005
> 36103 max 36005
> 18284 max 18227
> 18349 max 18227
>
> Add all running time and expected time:
>
>> awk '{ sum += $1 }; END { print sum }' 5x_export.log
> 2540920
>> awk '{ sum += $3 }; END { print sum }' 5x_export.log
> 2533820
>
> The ratio of the total running time to the total expected time is
> 1.00280209 (2540920/2533820).
>
> Use the same method to calculate data in 5x_10times_refactor_v5.log:
>
>> cat 5x_refactor_v5.log | head
> 36095 max 36005
> 36168 max 36005
> 36112 max 36005
> 36120 max 36005
> 18235 max 18227
> 18445 max 18227
>
>> awk '{ sum += $1 }; END { print sum }' 5x_refactor_v5.log
> 2546024
>> awk '{ sum += $3 }; END { print sum }' 5x_refactor_v5.log
> 2533820
>
> The ratio is 1.00481644.  It is 0.002 more than export data. I think
> this difference is acceptable.
>

Thanks for taking a look at the data Geliang. To me it seems like the 0.2% 
difference is well within the margin of error, so there doesn't seem to be 
a significant performance regression in your data.

Paolo, how does this performance look to you?


--
Mat Martineau
Intel
--0-89229874-1665447159=:4105--
