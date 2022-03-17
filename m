Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2B1FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647476427; x=1679012427;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H3uGmDhQtIS2brzv2OSNsWpa3zV3RWkQQDYJ6UZuZls=;
  b=IPFTQ3zt6LTlMx48kGjscpw2Kj2ePa+N/Qaiew/9X1iyXwvyX0eqjLjb
   uYvBA1+GWvdmZWSiSCa66DtiiP9PZmMNcxl+xYiJ0XEcEypEUKpiiESSx
   HTNikNHll2STkQKx/1H0Mcl43+QUcqAYZOfNVJ6beiy3lLG/hOM3QARjS
   0NKK44MP2pVft+9iiy44JugcjV1QKHFPA1iJWExOZ6FLz1APvVTgzWlZh
   WJMjb6LmPsg9Ll1qUaOIMYDRWQGe+sKCVtC0YDY49dUzK/b+IGfetQw42
   51N8x8H5+8l3Xj5pArWM9vkXEoj3qNyuszLY6KCFjPBtQvDkYy9/1dmnj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236692147"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236692147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:20:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513234382"
Received: from prl-mobl.amr.corp.intel.com ([10.209.78.201])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:20:26 -0700
Date: Wed, 16 Mar 2022 17:20:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/6] MP_FAIL echo and retrans
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
Message-ID: <2775913c-722b-65b9-13f4-cfdcd5217e36@linux.intel.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 15 Mar 2022, Geliang Tang wrote:

> v5:
> - re-check for TCP_CLOSE.
> - add a new helper mptcp_check_mp_fail_response().
> - add two timers cleanup patches.
>

Hi Geliang -

v5 is looking good to me so far, but I still need to run some tests.

Thanks,

Mat


> v4:
> - start and stop sk_timer instead of setting and clearing msk->flags.
> - add a new patch.
>
> v3:
> - use msk->sk_timer and a msk->flags bit.
> - use READ_ONCE/WRITE_ONCE for subflow->mp_fail_response_expect.
> - update selftest.
>
> v2:
> - don't clear mp_fail_response_expect flag.
> - add a helper mp_fail_response_expect_subflow to get the subflow,
>   instead of using msk->first.
> - add locks as Mat suggested.
> - add a selftest.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261
>
> Geliang Tang (6):
>  mptcp: use mptcp_stop_timer
>  mptcp: add data lock for sk timers
>  mptcp: add MP_FAIL response support
>  mptcp: reset subflow when MP_FAIL doesn't respond
>  selftests: mptcp: check MP_FAIL response mibs
>  selftests: mptcp: print extra msg in chk_csum_nr
>
> net/mptcp/pm.c                                | 18 +++++-
> net/mptcp/protocol.c                          | 64 ++++++++++++++++++-
> net/mptcp/protocol.h                          |  2 +
> net/mptcp/subflow.c                           | 13 ++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++++--
> 5 files changed, 139 insertions(+), 7 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
