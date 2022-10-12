Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A5191
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 00:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665535999; x=1697071999;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ylRzlWEicl4kPIAwCETYHDgPjnGrxE6g/4y0N/EKUtc=;
  b=eH4SmY25aqSSsVSoKIymfbU3fcgwP2d+Ur2tkyuoPbvsR4ZetPqXhWop
   ni9ATuHuKCJoYIApLh5/JzK7k9TfNCe2efet5abAregiOEq9SwLr21/vh
   d1498ZW7887+723GmNqEnq+Qzf2pLptc6Dh7NLFOGOpnfrtUGy+WS6XqW
   ghvlHJCRcqZ94gjGxiVu045jQ4KWYLC24wEBZEd37VGlATUGMUfvhBQX5
   lbgPj+4Lv94UiJWbjxqPBvI9KWu/g9MMVE2uBhtqjn9pXNQqEW8kcE2uX
   w44gj9yv3sbzz4mFkdgh6qm39eJluIKqjhKgUTyeAUVK4AawbtRoIXOtB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="390969525"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="390969525"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:53:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="955552809"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="955552809"
Received: from sgzinzer-mobl.amr.corp.intel.com (HELO klee13-mobl1.amr.corp.intel.com) ([10.212.187.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:53:18 -0700
Date: Tue, 11 Oct 2022 17:53:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket
 in use
In-Reply-To: <20221007092922.13169-1-imagedong@tencent.com>
Message-ID: <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:

> From: Menglong Dong <imagedong@tencent.com>
>
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> use. And in the 3th patch, we add the testing for this commit.
>

I think v5 looks ok for the export branch - we can get more test coverage 
there and update if needed.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Changes since v4:
> - rebase to solve merge conflict
>
> Changes since v3:
> - rename MPTCP_DESTROIED to MPTCP_DESTROYED in the 2th patch
>
> Changes since v2:
> - add testing
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
> Menglong Dong (3):
>  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
>  mptcp: add statistics for mptcp socket in use
>  selftest: mptcp: add test for mptcp socket in use
>
> net/mptcp/protocol.c                      | 35 ++++++++++++++++++-----
> net/mptcp/protocol.h                      |  1 +
> net/mptcp/subflow.c                       |  3 ++
> tools/testing/selftests/net/mptcp/diag.sh | 28 ++++++++++++++++++
> 4 files changed, 60 insertions(+), 7 deletions(-)
>
> -- 
> 2.37.2
>
>

--
Mat Martineau
Intel
