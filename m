Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF013FC5
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 21:13:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223111284"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223111284"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 14:13:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="474219887"
Received: from wjwiegan-mobl.amr.corp.intel.com ([10.255.231.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 14:13:23 -0700
Date: Tue, 21 Sep 2021 14:13:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: tx refactor update
In-Reply-To: <cover.1632217366.git.pabeni@redhat.com>
Message-ID: <62acf4fe-5cb2-c7af-fe47-d39dcb95e6b@linux.intel.com>
References: <cover.1632217366.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Sep 2021, Paolo Abeni wrote:

> This are updates to the tx refactor patches as asked by Eric.
> Note that patch 3/3 should replace completely the existing
> 'Partially revert "tcp: factor out tcp_build_frag()"'
> patch. I opted for this solution as the git repo mangling looked
> easier this way; @matttbe: please tell me if other options are
> preferred instead.
>
> Additionally patch "chtls: rename skb_entail() to chtls_skb_entail()"
> should be dropped.
>
> v1 -> v2:
> - drop unintended chunk in patch 3/3 [mat]
> ---
> include/net/tcp.h | 2 +-
> net/ipv4/tcp.c    | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>

Thanks for the v2, these are ready to apply.

--
Mat Martineau
Intel
