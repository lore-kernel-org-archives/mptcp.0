Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745B6030
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657061822; x=1688597822;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZT3JANlzc7EKuwz8Dxlw039y7wNEx5ZoNXdGQbgUsAI=;
  b=SZjzWRcM+6rsdExk4DJXRcbtkTsteWx65qBOXnhhetl2GhhJPGc4Prky
   LWD+qCPnNKZ6fIiqzN8Us+KDiHMNqkfX1qUTv7YYbddJIBEAyI7xyE9Fb
   rcs7gC5QLwlzKpUwNQ7O4xs9NXu8CTsLbe56PTj0QE8NaJBDyHoI8Mg4u
   9Wn7HixhcYoQlUkdv/mszXA1oGuyPUd5Bw4ajCno2W8/k/aCfBhfDXhqD
   9i6I8mVKn55DL3JTZa6Bnn3UN99/TTFmjVj4ZM8LZgTkl7dRZh4nkMNvV
   xzKua8yVRC5thonJmoIJWY9zxTB8AUVWrblA3u+TGdV0njnPZ5VLfEUF6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266583030"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266583030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:57:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="682682928"
Received: from atongsak-mobl1.amr.corp.intel.com ([10.209.113.116])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:57:01 -0700
Date: Tue, 5 Jul 2022 15:57:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 0/5] mptcp: support for MPC prio exchange
In-Reply-To: <cover.1656925387.git.pabeni@redhat.com>
Message-ID: <10352b75-bb72-9521-7684-bd4942cf7eb9@linux.intel.com>
References: <cover.1656925387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 4 Jul 2022, Paolo Abeni wrote:

> This series introduces the ability to control the MPC subflow for
> the in kernel PM.
>
> patch 1 && 2 refactor a bit the endpoint lookup and MP_PRIO generation
> code, to simplify the next patch.
>
> patch 3 introduces the new feature quering the backup status of the
> endpoint used by the MPC subflow and eventually generating the needed
> MP_PRIO option.
>
> Patch 4 is a related cleanup.
>
> v1 -> v2:
>  - rebased, and omitted old patch 1 which should go through -net
>

Thanks Paolo, v2 looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Paolo Abeni (5):
>  mptcp: introduce and use mptcp_pm_send_ack()
>  mptcp: address lookup improvements
>  mptcp: allow the in kernel PM to set MPC subflow priority
>  mptcp: more accurate MPC endpoint tracking
>  selftests: mptcp: add MPC backup tests
>
> net/mptcp/pm_netlink.c                        | 128 ++++++++++--------
> net/mptcp/protocol.c                          |   2 +-
> net/mptcp/protocol.h                          |   2 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh |  30 ++++
> 4 files changed, 104 insertions(+), 58 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
