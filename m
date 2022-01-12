Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D252C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 23:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642030397; x=1673566397;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DpIBuHrCGK+b25OLepS1iA4cQKFYqxA9Y0IodJeH8gg=;
  b=CxcEy3HPnUkKFcfu6oDy9riSBmiPRAVri6LZzkpPFI9OdKiE8E+T4BgM
   eCig7xfhcjFJlLqrd6qWAHhR2yDfb1wg3HIpAT4PxybR0pMycxKj7dj+o
   gEMAKHwYR+XwHjMyQBoa5DdfgC8CD3VNj+vMbO3jkjxOrmHUDncMyYBwM
   roGE7i/VVPKYHQY88qpNlmfYueJndvat0Zzab8WAoZdr1TXnBnaEXjbBn
   aTPwCSqMsqkr/BX/m/a3BB5siVULzZIY9JlFhhaZp7DyRcGry2U0DpPsM
   1LDWMpNqE14gikDk1Mb7RRDZ44uhNy0CjBZ+gtM63Ke/+5GE6d7iNYeTn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="223859132"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="223859132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:33:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670321953"
Received: from peterwri-mobl.amr.corp.intel.com ([10.209.106.113])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:33:16 -0800
Date: Wed, 12 Jan 2022 15:33:16 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 0/5] Clarify when options can be used
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
Message-ID: <35eaa787-f52a-7b0-5c99-f4ff38427ae@linux.intel.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 10 Jan 2022, Geliang Tang wrote:

> v9:
> - drop patch 1-3 in v8, they are accepted.
> - drop patch 6 in v8.
> - add a new patch "move the declarations of ssk and subflow" to avoid
>   the compiling errors when moving the mp_fail label.
> - update patch "reduce branching when writing MP_FAIL option" as Mat
>   suggested.
> - Change 'ADD+RM' from 'C' to 'P' in patch "clarify when options can
>   be used".

Hi Geliang -

I think patches 1-4 are ok for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


There are still some fixes we'll need to squash (or get from upstream) 
before updating the unit tests and upstreaming, see patch 5 comments for 
details.

>
> Geliang Tang (3):
>  mptcp: move the declarations of ssk and subflow
>  mptcp: print out reset infos of MP_RST
>  selftests: mptcp: add mp_fail testcases
>
> Matthieu Baerts (2):
>  mptcp: reduce branching when writing MP_FAIL option
>  mptcp: clarify when options can be used
>
> net/mptcp/options.c                           |  64 +++++++---
> tools/testing/selftests/net/mptcp/config      |   5 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
> 3 files changed, 152 insertions(+), 28 deletions(-)
>

--
Mat Martineau
Intel
