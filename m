Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7623A0
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654558878; x=1686094878;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RWkPKpxp/UiaHbdFyLG2k9G0ujxnzxB9mqcBmJZ/jM4=;
  b=OrsRPVNjG32WRGX9UTH2iKZULnnLKEnF4YIP2CNhG7qvvu0qrWIlIw17
   tcn7f/K7jB0diuAkfOVvdGixJKkC0Jb8ZYVsB1cIaptAcvRFzENXluO2Y
   10+eCM+cJLRU38Ph3o2ND4rSE6lIKwldKXmMHQ86GCE/waZDwQwbn66fz
   DNWDKJ9qXaMBgKApeKHWyrs6PrN27F+sGB67c7bAZjjiureQ/ucqn9gal
   4kf1BXbsXwCo3+GOLzSDkh2opGWWb6+98XIdJIkZ15Imto/cflSgywL4n
   BlsKSVwEZEQTdV+xwMdQeQrBRtTNxDkIhUHjTtw9Ne9spbV8ZwA3pbgV1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277233277"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="277233277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 16:41:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="608959188"
Received: from mgudaram-mobl1.amr.corp.intel.com ([10.209.43.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 16:41:17 -0700
Date: Mon, 6 Jun 2022 16:40:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] cleanups for bpf sched selftests
In-Reply-To: <cover.1654507832.git.geliang.tang@suse.com>
Message-ID: <11ab52ca-55dc-ed9-db9f-33ce43678e53@linux.intel.com>
References: <cover.1654507832.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 Jun 2022, Geliang Tang wrote:

> do some cleanups for bpf sched selftests:
> - add one more veth net device.
> - use '10.0.1.1' to send data instead of use default '127.0.0.1'.
> - add a new helper has_bytes_sent().
> - update commit logs.
>
> Geliang Tang (3):
>  Squash to "selftests/bpf: Add bpf_first test"
>  Squash to "selftests/bpf: Add bpf_bkup test"
>  Squash to "selftests/bpf: Add bpf_rr test"
>
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 63 ++++++++++++-------
> 1 file changed, 41 insertions(+), 22 deletions(-)
>

Hi Geliang -

Thanks for these selftest enhancements. These 3 commits are ok to squash.


--
Mat Martineau
Intel
