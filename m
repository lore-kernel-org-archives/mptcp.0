Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F6168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 23:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641426804; x=1672962804;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U3ruq/hd3rmWgaDx/B/HejiyfYq17dlz1t2QJj3Skjw=;
  b=mKBTlSza81MWEQ9IL1RttUw4KEL6lyZLRFXFjLpKmTNdP0Z+v4XDh18d
   XgyX2dcJy47gI84u8KK/KGJA7jG50B+q0LhHWv1W5qoejpnE6XO3+jajc
   Ksrg7aGIEEjUHdpX27za/qJq9okg/tQM3y5cdTWmSbwCH7brS7tjuf/98
   q+JqXUTAL/XdFiX56orgm2uyKn0JIwoZEILXFqa1x+aLbslbBgVFE6Rmo
   CxuYhdLsbD+xoXuftcO8wbTTFSm+HVyWHQIQym7jmLR/CulHBd5Dvu2rB
   EHmXfji0Q/sNjzFADcxxtFD+tTNjS0TdCTlFRwxRxqphyruNMRDBNaES+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229370911"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229370911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 15:53:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="526751178"
Received: from rcamaril-mobl1.amr.corp.intel.com ([10.209.22.32])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 15:53:23 -0800
Date: Wed, 5 Jan 2022 15:53:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
cc: syzkaller-bugs@googlegroups.com, mptcp@lists.linux.dev, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
In-Reply-To: <Ycwo+++dToWQ1RMR@dhcp22.suse.cz>
Message-ID: <ae69b8c1-ce8f-5113-c5c-c7e296613534@linux.intel.com>
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

Well, given that the inline patch isn't working out, I'll try having 
syzbot directly access my git tree:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git syz-test-reclaim


--
Mat Martineau
Intel
