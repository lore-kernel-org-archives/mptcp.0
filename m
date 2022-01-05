Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC1173
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641342909; x=1672878909;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q1adclFMobcbfN30m29NNNceBX0aT5NdSoFN8+aP5xE=;
  b=BW33NQBNFHID5ftbDQGk3J47y0dbiTopzCOSGYTtLSK0qBIGqFnhlx1A
   EEmDsNbdzoLrTy+x6X7oujawaq0QogD15Pqsqngd7Q1r+TIuHCfsqHI3q
   GIMtXnpBHGhgDnu1N9iePG8zakxkeUvj2g4b9K5gtUw6yyqOTKIkmqgvQ
   PWiviU35Lfq9rPl25lX07TipsISU18GGoIc5+QoMrugt9ryLFovgsF1qw
   wLfOkOlaoVlSY58ZvdFZit3GaCZWj4ePprxSucu1LEvpSZZfJSqmTQkMc
   Y/+/M4TlIJo8RINZAZN2dnNW64VQ2NV7LPDvN43HqWa8SzSMMODPFADlc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241155418"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="241155418"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:35:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="512711775"
Received: from marcquat-mobl.amr.corp.intel.com ([10.212.247.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:35:09 -0800
Date: Tue, 4 Jan 2022 16:35:08 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
cc: syzkaller-bugs@googlegroups.com, mptcp@lists.linux.dev, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
In-Reply-To: <Ycwo+++dToWQ1RMR@dhcp22.suse.cz>
Message-ID: <a5afc6d7-fb4b-fed0-bb66-444b11fb680@linux.intel.com>
References: <00000000000021bb9b05d14bf0c7@google.com> <000000000000f1504c05d36c21ea@google.com> <20211221155736.90bbc5928bcd779e76ca8f95@linux-foundation.org> <Ycwo+++dToWQ1RMR@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index df5a0cf431c1..7ed86e81181e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -975,7 +975,9 @@ static void __mptcp_mem_reclaim_partial(struct sock 
*sk)

         lockdep_assert_held_once(&sk->sk_lock.slock);

-       __mptcp_rmem_reclaim(sk, reclaimable - 1);
+       if (reclaimable >= SK_MEM_QUANTUM )
+               __mptcp_rmem_reclaim(sk, reclaimable - 1);
+
         sk_mem_reclaim_partial(sk);
  }


--
Mat Martineau
Intel
