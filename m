Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6D29CA
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 22:04:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202739745"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="202739745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:04:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="701311423"
Received: from nkhakpas-mobl.amr.corp.intel.com ([10.212.134.160])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:04:37 -0700
Date: Mon, 20 Sep 2021 15:04:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] mptcp: tx refactor update
In-Reply-To: <cover.1632158356.git.pabeni@redhat.com>
Message-ID: <cc5dafef-7974-1ab7-497f-c55669eac93a@linux.intel.com>
References: <cover.1632158356.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Sep 2021, Paolo Abeni wrote:

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
>
> include/net/tcp.h | 2 +-
> net/ipv4/tcp.c    | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>

Patches 1 & 2 are ok to squash, patch 3 has an issue (see separate reply).

--
Mat Martineau
Intel
