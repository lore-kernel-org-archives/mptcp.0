Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901A363
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651709066; x=1683245066;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=trhkBevykagDK0y7/W36ect98esudNBT3TBsgrCWa5M=;
  b=OKBNhOz9LkKF7R8sA5LVfWOAjfBaHJnlokLdFbZQUXXGF/D4ty/qrSlo
   W4nS7xDPs7bgUTBK3ZvZJwAtM73QkYvfSTsIx0cEXavuTzte5w1Ab6h8z
   iBqDJQ1DEI8K1aLIZcDECVG5+MxR33PSL3ZEp8hOYDIGMo2QKitVKZ8cE
   Hw0xU7H3mG2oKhX+icNx8FUB1U/nS8/4MQRrGECBYQmhsTJgxOOa+fw5O
   O7hqTec7gSREO6tn1E/iHmLbRV9US+/5LDT4AONf8Cv49qx6whLFz5aW6
   8f56olbgdGZRQqiK2Gi/2pfukLzzy1aX01JyHaImv9gdzff7im+5KIq1V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267821091"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267821091"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:04:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621041574"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:04:25 -0700
Date: Wed, 4 May 2022 17:04:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: add TCP_DEFER test case
In-Reply-To: <20220503213227.GC21053@breakpoint.cc>
Message-ID: <71d66319-92ab-2f6a-9b7-941142b7f3a4@linux.intel.com>
References: <20220502163641.6146-1-fw@strlen.de> <403af1b2-b34d-45f-c53-ae2f1e18225@linux.intel.com> <20220503213227.GC21053@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 3 May 2022, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>> On Mon, 2 May 2022, Florian Westphal wrote:
>>
>>> Check that value x can be set and retrieved.
>>>
>>
>> Hi Florian -
>>
>> I see the same error in this test with both my local test VM and when
>> running Matthieu's CI script on a different machine:
>>
>> # mptcp_sockopt: mptcp_sockopt.c:150: check_tcp_defer: Assertion `rv == value' failed.
>> # mptcp_sockopt: mptcp_sockopt.c:765: main: Assertion `e1 == 4' failed.
>
> seems like fix is to remove this test, kernel xlates value to
> number-of-retrainsmits so set and get may return different values.
>

Yeah, similar pass-through socket options aren't covered in the self tests 
either. Ok with me to drop this commit.

--
Mat Martineau
Intel
