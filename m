Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADED168
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641490767; x=1673026767;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QD5brcfB403pgI7NXXT4dBfpre2/knz1m1BE6HqWIMY=;
  b=RVnGLykdkFYFiWvlDc/er6uyxjlxGFCii6uswCTUWX2acbEhcXDcAWqa
   Kh5al6WGMk1P1jV2rfmTE/Y4dpIqbTQHheA0NUktIv+lKLK+qFUiIrZuC
   kCXB2ZR4vasfeagQa0khSlIEuN6ei/s44+/Sk7FIRE0wzLPKexMcSYUUx
   h6hngUedoEWWQd0ys5MEldw6iGCytJktYCDoPQnmlQ0xrGkmB5PF1/wG2
   5HVLJBXIddI/hP6BDq3FSNkqZwQCCfvOdK5IuHvRkNmxWEGrr04PQjF5W
   VUWc6jUT4TI0V6UUjnaA2g7rPKTwd+3LesxG3vu3NC12zd+WyQ+oKVCNq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223386742"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="223386742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:39:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="513482606"
Received: from rahamme-mobl.amr.corp.intel.com ([10.252.138.196])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:39:26 -0800
Date: Thu, 6 Jan 2022 09:39:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliangtang@gmail.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
In-Reply-To: <8f6c0ebc-a9e7-e007-fa84-a49abfbffda2@tessares.net>
Message-ID: <e86c2216-1b7b-c12a-af45-e1d4a4693095@linux.intel.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net> <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com> <8f6c0ebc-a9e7-e007-fa84-a49abfbffda2@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 Jan 2022, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 06/01/2022 03:58, Geliang Tang wrote:
>> Hi Matt,
>>
>> Thank you so much for this new version. Good catch on patch 2. It works on
>> my test and all looks good to me...
>>
>> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>
>
> As discussed in another thread on the ML, I just applied the 3 first
> patches:
>
> - 62aa763b1676: "squashed" patch 1/8 in "mptcp: implement fastclose xmit
> path"
> - 5c6f43e1c2c0: "Signed-off-by" + "Co-developed-by"
> - Results: 720eaaa70083..02e9b8087979
>
> - 55c56c19c276: mptcp: fix opt size when sending DSS + MP_FAIL
> - 025c1fcd8fa3: mptcp: fix a DSS option writing error
> (- 73463b55be2a: mptcp: Check reclaim amount before reducing allocation)
> - Results: 02e9b8087979..d500488d62db
>

Thanks for applying these to the export branch so they could get tested 
(results look ok), that will help with getting them upstream this week.

> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220106T114429
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

--
Mat Martineau
Intel
