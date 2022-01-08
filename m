Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EB2C9C
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641604793; x=1673140793;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7fniW7Cgs8BOLmeFzL5RjFmExZxoUAjHfBxJGwAi9C0=;
  b=m4nhYgr4MXOnGYbCC2mrvfTtDQDx5r+EJp4Iu77PnyWdfhqV6wSezYXh
   S7K4VQT1HGcTo4V52uxY+zKP+XAg+XGFiy1giB8rsbntEURGwldTT6RGr
   3njuhVTgiTzru2EeBsZ0sDCs09o2w02dY9cyhg40QXkIzfZloqvASYKxh
   xRvH83Ae0D/UK372E/bne0Q958kfGyBjQII9oBMPtiCGLIZgV5v5RtCMw
   1QQCg6Yj6/ab9bNpvAqThAKCxytrQnXRfVfBwmt1iHovBuDyokISlhmG2
   EUeaMhyn4ZdwhJtf4mJimH6P4WN5e5eM/6inF/uiazQmvU1sl6K/W9Z8F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242923655"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242923655"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:19:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="612352574"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:19:52 -0800
Date: Fri, 7 Jan 2022 17:19:52 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliangtang@gmail.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
In-Reply-To: <fc3b17c5-6d28-8a38-65c8-a85ab735b9e2@tessares.net>
Message-ID: <7cd39667-8b85-75e9-4c92-faed93c928e@linux.intel.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net> <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com> <fc3b17c5-6d28-8a38-65c8-a85ab735b9e2@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 Jan 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 06/01/2022 03:58, Geliang Tang wrote:
>> Hi Matt,
>>
>> Thank you so much for this new version. Good catch on patch 2. It works on
>> my test and all looks good to me...
>>
>> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>
>
> Great, thank you for having checked that!
>
>> ... except patch 6.
>>
>> I thinks we'd better to drop patch 6 ("mptcp: allow sending both ADD_ADDR
>> and RM_ADDR"). Since ADD_ADDR suboption is too big, we had made a lot of
>> efforts to let ADD_ADDR not to be sent with other subopthins. I thinks it's
>> better not to let ADD_ADDR sent with others by ourselves.
>
> ADD_ADDR suboption can be too big in some cases but not all the time.
> If I remember well, we decided to have a dedicated ACK to simplify the
> code: not having the ADD_ADDR removing the DSS options in some cases but
> not all, also simplifying packetdrill tests.
>
> Here, the idea is to add the RM_ADDR if asked and if there is room, just
> like what we do in mptcp_write_options().
>
>> On the other hand, I'm not sure our code can deal with ADD_ADDR and RM_ADDR
>> together correctly, it's not tested.
>
> Good point, we need a test validating that.
>

Sounds like a job for packetdrill!

> I'm not even sure we can have a test because each netlink command will
> cause the corresponding option to be sent: depending on the timing, when
> the next packet is sent, we might have one or two options to be sent.
>
> If we drop patch 6, we need to replace it with a patch updating the new
> comment at the beginning of mptcp_write_options() and not allowing
> ADD_ADDR to be sent with RM_ADDR + MP_PRIO as we currently do.
>

I think it would be good to drop patch 6 and updating the comment as 
Matthieu says.

I'm still seeing the file content mismatch with the "MP_FAIL, multiple 
subflows" test, which doesn't seem right. Will try to look into what's 
going on there next week.

--
Mat Martineau
Intel
