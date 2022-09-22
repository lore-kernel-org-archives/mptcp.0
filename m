Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D17B
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663805059; x=1695341059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gm8zX0mUqiicRDAQmE17Li+quyaH6nwdXncw1yXgbCw=;
  b=RnNS79YLo7IiudhktyYD0Vi/kv9D6aLYFSDpvW/+hLJokVucqr+J9/Mk
   9D4cXaZq3qJTb08lF8aynOGU3B9BFBnmYHfqfFJD5j+3ABTWxc8Sedi0c
   X0h44VGrJHhLo5phDOOgi4ui+h5w4vZZZQ/CVHw0Ju8OhMvuRO1j5IObA
   pbAltEANn6IK6RdP74yWpobzm4dfkszSfuh66VStIELPpVA2P1P/e6hFv
   95cjimSJHqX6VlM1ZQ7lIm0VUnATojuC+EDokgJA0ENlU2EmXZzMW0Ori
   vJneUqnYhaJTxHMZlDapdJBmacmcq0bg7MTHIXoQ+6KdD+8wPisFhbyHt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280527896"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="280527896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:04:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="745173302"
Received: from mesixta-mobl.amr.corp.intel.com ([10.255.229.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:04:19 -0700
Date: Wed, 21 Sep 2022 17:03:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: add statistics for mptcp socket
 in use
In-Reply-To: <20220921120442.320727-1-imagedong@tencent.com>
Message-ID: <ca982b91-22b7-48c0-bf01-6ce05394632b@linux.intel.com>
References: <20220921120442.320727-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 21 Sep 2022, menglong8.dong@gmail.com wrote:

> From: Menglong Dong <imagedong@tencent.com>
>
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> use.
>
> Changes since v1:
> - split the code cleanup into the 1th patch.
> - decrease the statistics for listening mptcp socket inuse with
>  mptcp_listen_inuse_dec()
> - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
>  called on the msk. For fallback case, we need to decrease the
>  statistics only once, and mptcp_destroy_common() can be called
>  more than once.
>

Hi Menglong -

Thanks for the v2. Other than Matthieu's request about MPTCP_DESTROYED, 
could you also add a selftest patch to confirm the counter is updated 
correctly?

This test script:

tools/testing/selftests/net/mptcp/diag.sh

already creates a large number of simultaneous sockets, so it might work 
well to modify the wait_msk_nr() function to also confirm the protocol 
inuse counter, and then check that the counter returns to zero after the 
sockets are closed.

> Menglong Dong (2):
>  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
>  mptcp: add statistics for mptcp socket in use
>
> net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++-------
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  3 +++
> 3 files changed, 31 insertions(+), 7 deletions(-)
>
> -- 
> 2.37.2
>
>

--
Mat Martineau
Intel
