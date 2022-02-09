Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015162F2C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644366110; x=1675902110;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uK5nFHzkSeDB5/0x2TIOWgm7+35ewec1Yzky7yCCKNo=;
  b=g2qwOM/qzCSZJ1vSpsWdDUsp+vH7hCZfbqOLS6P4AGZ+60Mw2u+921iJ
   6UafBtna7e/qzwU6yD4jeMkuPixkgS/rQwjL5SwuS83pKfHfCDoRBM1JN
   hu816SqQumEBY4dOxyq+H0hXEbYvFF/MkwrGLMY+B7fFxUr4N5MkTXGc8
   p65DJ/L3y+uOgOu9Ih4U47g5JNYsIBkGgH4LB16PqK7Cm/qF5jPpUI7w0
   RAESYU7EV0tyBxZYSM0IJKvn4FMZoPSoUmiDm0n4QmiNh8oHn6EmwKPbN
   fnSr0rjEATlRZkNTY1jGfUb2CZ7uFYimWLcvbQ0BYXmF55E7fajm8moB5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229053897"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="229053897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:21:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="482131447"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 16:21:49 -0800
Date: Tue, 8 Feb 2022 16:21:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] fix mptcp bpf selftest error
In-Reply-To: <cover.1644300192.git.geliang.tang@suse.com>
Message-ID: <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
References: <cover.1644300192.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 8 Feb 2022, Geliang Tang wrote:

> Fix the mptcp bpf selftest build break.
>
> Geliang Tang (2):
>  Squash to "bpf:selftests: add MPTCP test base"
>  mptcp: add SNDTIMEO setsockopt support
>
> net/mptcp/sockopt.c                            | 2 ++
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)
>
> -- 
> 2.34.1

These look good for the export branch.

We did talk about SO_SNDTIMEO about a year ago:
https://lore.kernel.org/mptcp/5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com/

But Paolo's concern there no longer applies, because the socket option 
changes since then will apply the sndtimeo value to the msk instead of the 
first subflow.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
