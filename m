Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7F3FCE
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643233535; x=1674769535;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zUdKOX7Iq+xpDBxPhv/lcg+/WjMIAhObTFfOtzP9A4U=;
  b=lqlrF8tKaRBwmMfN3dnbdpePtnnmBrBJD241RVeO2Nu90uHa/7LzQnI5
   kOVvtHfL1B6FlVv3dGyNopeMh6O3Bkf0qqFQna90OKP8Nd3MN9uhLdef0
   3nVtrgtZi0zk6PqqU3NT/FtEoH3LM4eY42ernjTL3FXfhjYR5C8uCzno5
   6HKfWAswvZgnj1JHm2KkTNFmX2G3sDfPhWoEdRXr9cyZsMVPxkeo1Jsp0
   ntt4hjqRUDSyifkH2wf5RSS901LQaN0SgE2CUjdf3EUBzbTUV4CzMgiNM
   QE9bLUsoFYbbGb/qtzdD5w5vI2cK2pU5kL8D6MdMZob1YsFYuSCWRtb9X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230232069"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="230232069"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:45:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="535347713"
Received: from dhurwitz-mobl.amr.corp.intel.com ([10.209.79.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:45:35 -0800
Date: Wed, 26 Jan 2022 13:45:34 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/2] add the id argument for set_flags
In-Reply-To: <cover.1643165468.git.geliang.tang@suse.com>
Message-ID: <d03a927-5489-66f8-f137-45a8d1c332ab@linux.intel.com>
References: <cover.1643165468.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 26 Jan 2022, Geliang Tang wrote:

> v5:
> v4:
> - update the output of pm_netlink.sh
>

Thanks for updating, patches look good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> v3:
> - update the usage of set_flags in #1
> - check more of the intermediate states with "pm_nl_ctl dump" in #2
>
> v2:
> - make standalone patches, instead of squash-to ones.
> - add test cases in pm_netlink.sh, instead of mptcp_join.sh
>
> Add the id argument for 'pm_nl_ctl set', and allow to use the port keyword
> with the non-signal flags for the setting flags in 'ip mptcp endpoint
> change', more commands can be used to set the address flags:
>
> pm_nl_ctl set 10.0.2.1 flags backup port 10100
> pm_nl_ctl set id 1 flags backup
> ip mptcp endpoint change id 1 backup
> ip mptcp endpoint change 10.0.2.1 backup port 10100
>
> Geliang Tang (2):
>  selftests: mptcp: add the id argument for set_flags
>  selftests: mptcp: add set_flags tests in pm_netlink.sh
>
> .../testing/selftests/net/mptcp/pm_netlink.sh | 18 ++++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 63 ++++++++++++-------
> 2 files changed, 60 insertions(+), 21 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
