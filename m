Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE63D6E
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 23:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651707590; x=1683243590;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oMOG0/tCj6NEUMANlQRoG1HhUu6YC/+GpKbQ272Em98=;
  b=AqU8Si0sBctXdJxKkqe6P7MpUO9n9On7wkt2gd9Y2wfBOuLsWdmkRriz
   NxbbWvzLZDnENfpWBIcril1vNDLw8IWExvkTv98oX38SMzUZ58C+MHrp7
   s9Rof/2V6dxxzoTkvGtKK8kXlG6W186jMwZy3bEaVZByB1lTPDDjKmovu
   OxYROkU6IvaY3n7/9O/4+lO6TQO/rt7GTBTsa6oJy4O9U29bllZA0KJYp
   LTYfuWY5/QGPm53lMpDTFkNUJ4eW+gJctKv92u6S7rlISWTDpMyKKeoif
   xfRa2/rGvEdCQAk5IOi7yCFRS9NOfu4VACR4tUuPdYsp5cWiz+FY08q9p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248467303"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248467303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:39:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="562964715"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:39:49 -0700
Date: Wed, 4 May 2022 16:39:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL
 reset testcase" - cleanups
In-Reply-To: <65c6e3d4-795a-17e0-8a2-337da6e6cfac@linux.intel.com>
Message-ID: <978b9bb7-5a46-b756-288a-afc94ddda678@linux.intel.com>
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com> <20220504121429.GA18870@bogon.HOST> <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com> <CA+WQbwscUM8LJx=sye_QpNr-GAzgTdDE+NqXAHnvLOHGsvE31g@mail.gmail.com>
 <65c6e3d4-795a-17e0-8a2-337da6e6cfac@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-880136030-1651707380=:21003"
Content-ID: <9dc1ea38-7844-7e30-9aa6-ba496f72715@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-880136030-1651707380=:21003
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <7f4be847-a992-8811-4b2f-902e3dba8dda@linux.intel.com>

On Wed, 4 May 2022, Mat Martineau wrote:

> On Wed, 4 May 2022, Geliang Tang wrote:
>
>> Paolo Abeni <pabeni@redhat.com> 于2022年5月4日周三 21:04写道：
>>> 
>>> Hi Geliang,
>>> 
>>> On Wed, 2022-05-04 at 20:14 +0800, Geliang Tang wrote:
>>>> On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
>>>>> Two small cleanups for MP_FAIL reset test case:
>>>>> 
>>>>> Reduce the test files size from 1024 to 128, to make the test faster.
>>>> 
>>>> The original commit log needs to update too:
>>>>
>>>>  1024KB -> 128KB
>>>> 
>>>> '''
>>>> Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
>>>> reset case. Use the test_linkfail value to make 128KB test files.
>>>> 
>>>> ...
>>>> ...
>>>> '''
>>>> 
>>>>> With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.
>>>>> 
>>>>> Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
>>>>> extra checksum failures now, no need to add '+'s anymore.
>>>>> 
>>>>> Depends on Paolo's commits:
>>>>> [1] net/sched: act_pedit: really ensure the skb is writable
>>>>> [2] selftests: mptcp: fix MP_FAIL test-case
>>>>> 
>>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> 
>>> I noticed the the time increase. Unfortunatelly, it may be necessary to
>>> be reliable in all environment, comprising the slowers one.
>>> 
>>> Mat (M.) was able to reproduce some failure with b/w == 10Mbps and size
>>> == 1M. I think/guess he could hit the same failure even with 1Mbps and
>>> size == 128K.
>>> 
>>> We need at least some additional testing for this one.
>> 
>> If so, let's continue to use 1024k test file sizes.
>> 
>
> It's reliable for me at 128k so far. I'm fine with squashing the patch as-is, 
> we can increase the file size if CI (or humans) complain.
>

It did fail after 193 iterations (kernel with debug config):

002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          sum[ ok ] - csum  [ ok ]
                                          ftx[ ok ] - failrx[fail] got 0 MP_FAIL[s] RX expected 1

So 128k seems to be too small.

--
Mat Martineau
Intel
--0-880136030-1651707380=:21003--
