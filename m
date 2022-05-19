Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633391FAA
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652920732; x=1684456732;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=cFC8jcO78qA01RntGmU573DM5JIcBhHlyGrN8UMrGVQ=;
  b=A5mWgpua+e47Qm0igzJQ19/j47jKaqfg7/aDyzsr/DsfREW5JRptZOy3
   mYWuR6L0/zfLiQIyAql3elb5oslZf/RZ9k+niGHQVuKDnM2Hm+rfugK7l
   eUnX2ocOJRwQRdTDVCQzrcD9vNABI0ndeGxP/7Ym1+S3LX54Hc6tN1wk+
   6dT9gVIHntgoqppkl1ysPlLFxQRUUnEEDdRnYdwxHd4o8ouiwuivW9J2e
   jOkZOPNAkdgBtbiXTHEEyszfLn9wOuPgzKnDMFq8e66KBEx4uloXgPPWg
   Q/KJHkG7+RSXRi1UmnRTF62agN0drmKnU/b989AJ7GkEHrT+kxOOzqMVG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="254003541"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="254003541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 17:38:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="569839606"
Received: from asova-mobl.amr.corp.intel.com ([10.209.69.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 17:38:43 -0700
Date: Wed, 18 May 2022 17:38:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc: Geliang Tang <geliangtang@gmail.com>, Martin KaFai Lau <kafai@fb.com>, 
    Geliang Tang <geliang.tang@suse.com>, Networking <netdev@vger.kernel.org>, 
    bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, 
    Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: add bpf_skc_to_mptcp_sock_proto
In-Reply-To: <CAADnVQJ8V-B0GvOsQg1m37ij2nGJbzemB9p46o1PG4VSnf0kSg@mail.gmail.com>
Message-ID: <cb2c23b0-a41a-bbf6-1440-69bbc58f8e8b@linux.intel.com>
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com> <20220513224827.662254-2-mathew.j.martineau@linux.intel.com> <20220517010730.mmv6u2h25xyz4uwl@kafai-mbp.dhcp.thefacebook.com> <CA+WQbwvHidwt0ua=g67CJfmjtCow8SCvZp4Sz=2AZa+ocDxnpg@mail.gmail.com>
 <CAADnVQJ8V-B0GvOsQg1m37ij2nGJbzemB9p46o1PG4VSnf0kSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-537796903-1652920296=:30893"
Content-ID: <c1438e4c-6efd-6295-a7cb-dd36271ac169@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-537796903-1652920296=:30893
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <a0455cf1-f672-f24a-a2ae-95e7aa48e76b@linux.intel.com>

On Tue, 17 May 2022, Alexei Starovoitov wrote:

> On Mon, May 16, 2022 at 10:26 PM Geliang Tang <geliangtang@gmail.com> wrote:
>>
>> Martin KaFai Lau <kafai@fb.com> 于2022年5月17日周二 09:07写道：
>>>
>>> On Fri, May 13, 2022 at 03:48:21PM -0700, Mat Martineau wrote:
>>> [ ... ]
>>>
>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>> index 8b1afd6f5cc4..2ba09de955c7 100644
>>>> --- a/include/net/mptcp.h
>>>> +++ b/include/net/mptcp.h
>>>> @@ -284,4 +284,10 @@ static inline int mptcpv6_init(void) { return 0; }
>>>>  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
>>>>  #endif
>>>>
>>>> +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
>>>> +struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
>>> Can this be inline ?
>>
>> This function can't be inline since it uses struct mptcp_subflow_context.
>>
>> mptcp_subflow_context is defined in net/mptcp/protocol.h, and we don't
>> want to export it to user space in net/mptcp/protocol.h.
>
> The above function can be made static inline in a header file.
> That doesn't automatically expose it to user space.
>

True, it's not a question of userspace exposure. But making this one 
function inline involves a bunch of churn in the (non-BPF) mptcp headers 
that I'd rather avoid. The definitions in protocol.h are there because 
they aren't relevant outside of the mptcp subsystem code.

Does making this one function inline benefit BPF, specifically, in a 
meaningful way? If not, I'd like to leave it as-is.

--
Mat Martineau
Intel
--0-537796903-1652920296=:30893--
