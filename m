Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AE2C9C
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 00:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641341329; x=1672877329;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JepRpJLYzlSaO6plfJUd7N28rd7f8sx/+iAnJFEy6K0=;
  b=PKp1jsK4HHlukWhpwk5aywW3/GPhAcMo3diJ47yUJt1m+tgnsp6PKzgt
   n8Eu/XKpk1xi7iTPhVP7J/9Pigk/8Kt3E1EgYweg0kV5jyReo1U40Nc2u
   n72xdfxRr2ha0q03W/3bKvGgeq1YoHaGrlOJhI6P3jrbTu/6ImOANIOmN
   dFFVYExWYAb7ITNbm1sQU5Wferc16L/2C5S6iOkzkL62EkGdjP4lMD64o
   hL6GBtptFnvHvBNzCDO9BbkZpaFHgWf9dQBHhfQRFi14ad2j4vj6pX/1X
   yQuhMyEPQRD1/hgyOjpMzTgdViqcXmaXXbvWerNcqzmwDbnPO4ebIjvxN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303084584"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="303084584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:08:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="611267959"
Received: from marcquat-mobl.amr.corp.intel.com ([10.212.247.3])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:08:48 -0800
Date: Tue, 4 Jan 2022 16:08:47 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>
cc: syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    syzkaller-bugs@googlegroups.com, mptcp@lists.linux.dev, 
    netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
In-Reply-To: <Ycwo+++dToWQ1RMR@dhcp22.suse.cz>
Message-ID: <2bc36f6f-e1e5-52-e62-15adf696bdc@linux.intel.com>
References: <00000000000021bb9b05d14bf0c7@google.com> <000000000000f1504c05d36c21ea@google.com> <20211221155736.90bbc5928bcd779e76ca8f95@linux-foundation.org> <Ycwo+++dToWQ1RMR@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Dec 2021, Michal Hocko wrote:

> On Tue 21-12-21 15:57:36, Andrew Morton wrote:
>> On Sat, 18 Dec 2021 06:04:22 -0800 syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com> wrote:
>>
>>> syzbot has found a reproducer for the following issue on:
>>>
>>> HEAD commit:    fbf252e09678 Add linux-next specific files for 20211216
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1797de99b00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7fcbb9aa19a433c8
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135d179db00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113edb6db00000
>>
>> Useful to have that, thanks.
>>
>> I'm suspecting that mptcp is doing something strange.
>
> Yes.
>
>> Could I as the
>> developers to please take a look?
>>

Andrew -

Yes, we'll get a fix in to net-next soon - thanks for adding the mptcp & 
netdev lists.

>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com
>>>
>>> R13: 00007ffdeb858640 R14: 00007ffdeb858680 R15: 0000000000000004
>>>  </TASK>
>>> ------------[ cut here ]------------
>>> page_counter underflow: -4294966651 nr_pages=4294967295
>
> __mptcp_mem_reclaim_partial is trying to uncharge (via
> __sk_mem_reduce_allocated) negative amount. nr_pages has overflown when
> converted from int to unsigned int (-1). I would say that
> __mptcp_mem_reclaim_partial has evaluated
> 	reclaimable = mptcp_sk(sk)->rmem_fwd_alloc - sk_unused_reserved_mem(sk)
> to 0 and __mptcp_rmem_reclaim(sk, reclaimable - 1) made it -1.

Thanks for the analysis Michal.

--
Mat Martineau
Intel
