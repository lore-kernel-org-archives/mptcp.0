Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C572
	for <mptcp@lists.linux.dev>; Wed, 25 Aug 2021 17:56:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="197150555"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="197150555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 10:56:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="527422217"
Received: from jambrizm-mobl1.amr.corp.intel.com ([10.212.224.56])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 10:56:23 -0700
Date: Wed, 25 Aug 2021 10:56:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jiang Biao <benbjiang@gmail.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, davem@davemloft.net, 
    kuba@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    linux-kernel <linux-kernel@vger.kernel.org>, 
    Jiang Biao <benbjiang@tencent.com>, Jiang Biao <tcs_robot@tencent.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] ipv4/mptcp: fix divide error
In-Reply-To: <CAPJCdBmTPW5gcO6DO5i=T+R2TNypzbaA666krk=7Duf2mt1yBw@mail.gmail.com>
Message-ID: <f9b97b7f-cb48-f0bf-2dfb-a13bf1296b19@linux.intel.com>
References: <20210824071926.68019-1-benbjiang@gmail.com> <fe512c8b-6f5a-0210-3f23-2c1fc75cd6e5@tessares.net> <CAPJCdBmTPW5gcO6DO5i=T+R2TNypzbaA666krk=7Duf2mt1yBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Tue, 24 Aug 2021, Jiang Biao wrote:

> Hi,
>
> On Tue, 24 Aug 2021 at 15:36, Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Jiang,
>>
>> On 24/08/2021 09:19, Jiang Biao wrote:
>>
>> (...)
>>
>>> There is a fix divide error reported,
>>> divide error: 0000 [#1] PREEMPT SMP KASAN
>>> RIP: 0010:tcp_tso_autosize build/../net/ipv4/tcp_output.c:1975 [inline]
>>> RIP: 0010:tcp_tso_segs+0x14f/0x250 build/../net/ipv4/tcp_output.c:1992
>>
>> Thank you for this patch and validating MPTCP on your side!
>>
>> This issue is actively tracked on our Github project [1] and a patch is
>> already in our tree [2] but still under validation.
>>> It's introduced by non-initialized info->mss_now in __mptcp_push_pending.
>>> Fix it by adding protection in mptcp_push_release.
>>
>> Indeed, you are right, info->mss_now can be set to 0 in some cases but
>> that's not normal.
>>
>> Instead of adding a protection here, we preferred fixing the root cause,
>> see [2]. Do not hesitate to have a look at the other patch and comment
>> there if you don't agree with this version.
>> Except if [2] is difficult to backport, I think we don't need your extra
>> protection. WDYT?
>>
> Agreed, fixing the root cause is much better.
> Thanks for the reply.
>

Hi Jiang -

Could you try cherry-picking this commit to see if it eliminates the error 
in your system?

https://github.com/multipath-tcp/mptcp_net-next/commit/9ef5aea5a794f4a369e26ed816e9c80cdc5a5f86


Thanks!

--
Mat Martineau
Intel
