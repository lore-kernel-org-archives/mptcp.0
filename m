Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE2595
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654884029; x=1686420029;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6WdFI4PvS8j1UyMW0Jg9q81CkYLyJ4GaOi0va+3wXTw=;
  b=ljeG1i86E3ByQHoOnlxb+7QUg7coII79Q0zMhuT9RlI7fYTybC2E6uX1
   ZTgYlijaVODlVO432ryb2ATVj0+2xD0vkCPB86oMJMYVvvVrrmtOgJFGU
   joPK2OKnhBeQSYVoA0Gzx3WbqECQ6kOP65ekMmMOOHTysIuXOotP0zKNx
   Ud9I4x28Qh9p117QAWBLpTSb+BvbYOWj7YquUHA2YcxjRhr2r+Mzk62oS
   C5hDA+Q11eUmjD+DXHfb17IqaCXMijQhIPqI6ima28eHYAOZvUT0PwaBA
   7v3O1EBL+1wRILuBue/kSeolyuZw8AiOKGBpq6TTeNvu25lNCFvbwK8cW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266468318"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="266468318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 11:00:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="828356239"
Received: from efbarbud-mobl1.amr.corp.intel.com ([10.212.104.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 11:00:28 -0700
Date: Fri, 10 Jun 2022 11:00:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, Ossama Othman <ossama.othman@intel.com>, 
    davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
    matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] mptcp: fix conflict with <netinet/in.h>
In-Reply-To: <20220609225936.4cba4860@kernel.org>
Message-ID: <d4c74484-da9-8af3-e25b-93de29443840@linux.intel.com>
References: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com> <20220608191919.327705-2-mathew.j.martineau@linux.intel.com> <20220609225936.4cba4860@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Jun 2022, Jakub Kicinski wrote:

> On Wed,  8 Jun 2022 12:19:18 -0700 Mat Martineau wrote:
>> From: Ossama Othman <ossama.othman@intel.com>
>>
>> Including <linux/mptcp.h> before the C library <netinet/in.h> header
>> causes symbol redefinition errors at compile-time due to duplicate
>> declarations and definitions in the <linux/in.h> header included by
>> <linux/mptcp.h>.
>>
>> Explicitly include <netinet/in.h> before <linux/in.h> in
>> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
>> compatibility logic in <linux/libc-compat.h> is enabled when including
>> <linux/mptcp.h> in user space code.
>>
>> Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
>
> What does it break, tho? The commit under Fixes is in net, if it's
> really a fix it needs to go to net. If it's just prep for another
> change we don't need to fixes tag.
>

Hi Jakub -

This is a minor "fix" to be sure, which I thought did not meet the bar for 
net and therefore submitted for net-next. It's not prep for another 
change, it's something Ossama and I noticed when doing code review for a 
userspace program that included the header. There's no problem with kernel 
compilation, and there's also no issue if the userspace program happens to 
include netinet/in.h before linux/mptcp.h


If my threshold for the net branch is too high, I have no objection to 
having this patch applied there and will recalibrate :)

Do you prefer to have no Fixes: tags in net-next, or did that just seem 
ambiguous in this case?

--
Mat Martineau
Intel
