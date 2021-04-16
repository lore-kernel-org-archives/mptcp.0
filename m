Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348712F84
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 23:01:49 +0000 (UTC)
IronPort-SDR: iYAyIs5/xs7kcocs5ZThvtxYHViTUaMiGdvvF+4Ys/OPeZ3NR9BWVn6vqXpFlVEKkhWbUOAx2L
 tCJtx1X6YWkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195235493"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="195235493"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 16:01:48 -0700
IronPort-SDR: 4jdu70YoIj7yzx30Cn8HFPFhu145aYcpGAEytkr9aTKH8iSbFrz47aSVH0gy0MBMSqURFNj3SA
 FiKUT5eDEaVA==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="419285421"
Received: from lmfischx-mobl1.amr.corp.intel.com ([10.212.234.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 16:01:48 -0700
Date: Fri, 16 Apr 2021 16:01:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/3] mptcp: improve MSG_* flags handling
In-Reply-To: <cover.1618502178.git.pabeni@redhat.com>
Message-ID: <66565160-cf82-fcb2-b460-ac177c1d755f@linux.intel.com>
References: <cover.1618502178.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 15 Apr 2021, Paolo Abeni wrote:

> The current handling is a bit fuzzy. Sometimes we silently ignore,
> sometimes we bail on unsupported even on no-op ones.
>
> Let's silently provide a provide a reasonable implementation or
> bail (currently only for MSG_FASTOPEN) for the flags with user-visible
> side effects. Finally silently ignore the unsupported flags with no
> user visible side effects.
>
> Paolo Abeni (3):
>  mptcp: implement dummy MSG_ERRQUEUE support
>  mptcp: implement MSG_TRUNC support
>  mptcp: ignore unsupported msg flags
>
> net/mptcp/protocol.c | 29 ++++++++++++++++++-----------
> 1 file changed, 18 insertions(+), 11 deletions(-)
>
> -- 
> 2.26.2

Hi Paolo -

Thanks, series looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
