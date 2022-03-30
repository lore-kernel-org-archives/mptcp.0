Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD86366
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 00:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648601846; x=1680137846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=569NAkugXKinxETe8BmxJq1njtD1TGJhnp1jVwtJ6cc=;
  b=gqxo4MgklNOfbDJhCpzw0yBvQE+LUPJV6SPDcXnTMhcCkJRYvcLDQNP0
   +2GgvgZ0ETllHcOA6T7mYb/MlOkt177Lkleo8pydQfriy4kqsO7efAyXK
   0uZCV+lY3hvGilnrVkgBhlVgtJmd+AnVPPY9sEkz93yUjqIreA9LoV+X4
   rWxZe73vi/9taVfvhE0utx7PN95v/1t+j68XFxtqlwVzDhOEk4pVbtReu
   ttvCXPRE15RPLCWi4v1CKVs9xRFOg026rSYUdwrOGrnEst6b3IWRn4kH3
   /mbx/NA+7KLzduPafQaVd+/wQximQCe2M8j+p46lHw0jygoHl67n7jZOf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284318773"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="284318773"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 17:57:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="653430848"
Received: from lnlam-mobl.amr.corp.intel.com ([10.252.130.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 17:57:25 -0700
Date: Tue, 29 Mar 2022 17:57:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/4] mptcp: inet diag listen dump support
In-Reply-To: <20220329113523.19793-1-fw@strlen.de>
Message-ID: <ad2fe1c-5e46-a13-8ecc-79da118cc2dd@linux.intel.com>
References: <20220329113523.19793-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 29 Mar 2022, Florian Westphal wrote:

> Changes in v3: fix intendation, fix uninitialised var (Mat)
> 	       extend mptcp diag tests

Thanks for adding the tests. Series looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> Changes in v2: drop patch 4 and prefer msk->first (Paolo Abeni)
>
> Done in a not-very-elegant way:
> Iterate over tcp listen hash, then pick out the tcp sockets
> with mptcp-ctx structure attached, then take the conn->sk for dumping.
>
> First patch is preparation/cleanup.
> Second patch gets rid of locking to avoid a lockdep splat.
> If the socket lock is really needed (I don't see where) I can workaround
> this by dropping locks temporarily when iterating the listen hash table,
> but its a bit more awkward.
>
> Sample output:
> ss -Mil
> State        Recv-Q Send-Q Local Address:Port  Peer Address:Port
> LISTEN       0      20     127.0.0.1:12000     0.0.0.0:*
>         subflows_max:2
>
> Florian Westphal (4):
>  mptcp: diag: switch to context structure
>  mptcp: remove locking in mptcp_diag_fill_info
>  mptcp: listen diag dump support
>  selftests/mptcp: add diag listen tests
>
> net/mptcp/mptcp_diag.c                    | 105 +++++++++++++++++++++-
> net/mptcp/sockopt.c                       |   6 --
> tools/testing/selftests/net/mptcp/diag.sh |  38 ++++++++
> 3 files changed, 140 insertions(+), 9 deletions(-)
>
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
