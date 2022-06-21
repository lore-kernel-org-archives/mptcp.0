Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F71C0C
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 23:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655854578; x=1687390578;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Sl9t++i2u4pOPVk0GdsP9bR2WZZjOvEWgqcuVlb0ZGI=;
  b=kAUz2Er3gwDgEw4QhvWyGD+Wki3PqQQrYRDZkCObQk92e1JGMJRMohdM
   rCKr35IF3vINqN3csZree3SLprnvgp3wdGiw5CR1LvrmwVqA6jMagVNoe
   EZYU2qIVUecuXpsWbpkVw5t10eGDnKeYg3GHGoJItoTuPUtQXOaYNvbcF
   O6aRyvvWFSRzIEKSTSawPsy6Zs+KbwpJY9bL+KedEc/1vS87l0Cwj4DHl
   MfwyvGBgH+Jn/MEA3WnW3ySAbcUOIaQkPun6BURoxjOztVZ8VEn+B3FC3
   PwupJE0h6iYUDmezFn4gSHSVJo68gmmiKyj7VQwin9CRlZ/Arw8jiDDq5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="268984567"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="268984567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 16:36:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833814183"
Received: from vanehosx-mobl.gar.corp.intel.com ([10.251.13.241])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 16:36:17 -0700
Date: Tue, 21 Jun 2022 16:36:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-net 0/6] mptcp: mp_fail related fixes
In-Reply-To: <cover.1655829222.git.pabeni@redhat.com>
Message-ID: <54aafe5-1caf-cd52-13fb-bea3b56a24@linux.intel.com>
References: <cover.1655829222.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 21 Jun 2022, Paolo Abeni wrote:

> While cooking a follow-up for "mptcp: invoke MP_FAIL response when
> needed" I stumbled upon a few other MP_FAIL related issues hit my
> the self-tests while mangling the above.
>
> All the patches for for the -net tree, and should be applied in-order
> around to the squashed-to patch.
>
> v4 -> v5:
> - hopefully fix for real lockdep annotaiton in patch 6/6 (still mat)

Thanks Paolo, nested lock fix confirmed. For v5 of the series:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> v3 -> v4:
> - fix a couple of typos in 3/6, fix lockdep annotation in 6/6 (mat)
>
> v2 -> v3:
> - do not schedule mp_fail timeout on closed socket in patch 3/6 (mat)
>
> v1 -> v2:
> - take care of UaF in mptcp_worker with new patch 6/6
>
> Paolo Abeni (6):
>  mptcp: fix error mibs accounting
>  mptcp: introduce MAPPING_BAD_CSUM
>  Squash-to: "mptcp: invoke MP_FAIL response when needed"
>  mptcp: fix shutdown vs fallback race
>  mptcp: consistent map handling on failure
>  mptcp: fix race on unaccepted mptcp sockets
>
> net/mptcp/options.c  |   8 +--
> net/mptcp/pm.c       |   5 +-
> net/mptcp/protocol.c |  57 ++++++++++++++++----
> net/mptcp/protocol.h |  25 +++++++--
> net/mptcp/subflow.c  | 121 +++++++++++++++++++++++++++++++++++--------
> 5 files changed, 172 insertions(+), 44 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
