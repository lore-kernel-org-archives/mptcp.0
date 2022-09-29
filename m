Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B77B
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664492059; x=1696028059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dM8Q78+cCEtLn0Rn1sAwFh+4ECWR4DePP3E4i5wmT8I=;
  b=cwjnWGom2OP3zMqTlGoiIWy4gNFc3T6tXOHA7e2YquwdKQWvxj6nCO+q
   /JldyVtLPZJVa+CPTxvmxMzqMgMy5U9BZHMNpp4xMXVdCYb06g2/T7bNl
   7pZUE64Sibkw6cHMzLeBZIkwqirUAvtZnAhUUDgdRwB7ePxkRbftEMKMa
   XutdsOjgxlSiiW9UIztmu8yO7e1wRShJ7/2s7/qllrnzeMxO2chbHP246
   Rbh9FycdF7XbEW2So0dfWZAaF9DERGZWeYTST3r9CA2qAIJ6SJbn2mY3I
   Q9usA13g1jU5Uiv0phCBD/1Dv9uhZ9dUc6e99VmbG9RGlNrI6/VB3g09C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303535037"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303535037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:54:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="653312651"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="653312651"
Received: from kisungle-mobl.amr.corp.intel.com ([10.209.49.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:54:19 -0700
Date: Thu, 29 Sep 2022 15:54:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: MPTCP upstreaming, week of 26-Sept-2022
In-Reply-To: <0a6a01130bc558691a0fcd8dab0f2ac77fda199f.camel@redhat.com>
Message-ID: <397e0988-7a03-3073-ea12-4845a44b85b7@linux.intel.com>
References: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>  <2d24f789-9fc1-0229-4b37-ff570c4be080@tessares.net> <0a6a01130bc558691a0fcd8dab0f2ac77fda199f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2083699861-1664492059=:10178"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2083699861-1664492059=:10178
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 27 Sep 2022, Paolo Abeni wrote:

> On Tue, 2022-09-27 at 10:07 +0200, Matthieu Baerts wrote:
>> Hi Mat, Paolo,
>>
>> On 27/09/2022 02:10, Mat Martineau wrote:
>>>
>>>     - Features for net-next:
>>>
>>>         - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
>>>         - [885cab8b5203] mptcp: use fastclose on more edge scenarios
>>> (Paolo Abeni)
>>>         - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose
>>> test-cases (Paolo Abeni):
>>>             - can wait a bit, Paolo would like to have a look at the
>>> modification on packetdrill side
>>>
>>>
>>> The net-next patches are slightly more complicated:
>>>
>>>  * They were updated with a squash-to patch today
>>>  * Need to wait until fastopen patches are merged
>>
>> We should at least wait for the fastopen patches to be applied I suppose.
>>
>>>  * There is a minor conflict with the -net patches (just diff context)
>>>    in "mptcp: use fastclose on more edge scenarios".
>>>
>>>
>>> Regarding the conflict, I could wait until Friday for a likely
>>> net/net-next sync.
>>>
>>> Another option is to modify the patch slightly by moving
>>> mptcp_check_readable() before __mptcp_check_send_data_fin(), it doesn't
>>> make the diff any larger and avoids the -net conflict. What do you think?
>>
>> We can also add a note in the commit and explain how to fix this
>> conflict. I think the function is at the right place but it can also be
>> moved if it eases stuff.
>
>
> I think there is no rush for that patches. If the net patches will land
> upstream soon, they will be likely merged by EoW. If there will be
> another RC, we can rebase the net-next and send out still for 6.1,
> othewise the fastclose patches can wait IMHO a few more weeks.
>

Thanks Paolo.

With the net and net-next patches for MPTCP just merged today, and the 
backlog in netdev patchwork, I'll wait on the fastclose changes:

ee1e43f10dc5 mptcp: update misleading comments.
d1c02fee7732 selftests: mptcp: update and extend fastclose test-cases
61fc1bc2edeb mptcp: use fastclose on more edge scenarios
20af637811c9 mptcp: propagate fastclose error

And the recent TCP_FASTOPEN_NO_COOKIE changes:

de98c67ae3a9 mptcp: add TCP_FASTOPEN_NO_COOKIE support
a05c21ad4572 mptcp: sockopt: make 'tcp_fastopen_connect' generic
(plus "mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT" that's still 
in patchwork).


It sounds like rc8 is unlikely 
(https://lore.kernel.org/lkml/CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com/) 
but I can revisit next week if there isn't a final 6.0 on Sunday.

Thanks,

--
Mat Martineau
Intel
--0-2083699861-1664492059=:10178--
