Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8A33F1
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665093241; x=1696629241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KN4W82ccmWk2054fzbTH6/ls+wot6N5AQ2nPisOCGOU=;
  b=gvp06jQaM4wblRoCY+uLYz4QbUZ+3wn30nbIvALlV7Kia25eF0f96NEZ
   Of1inXCkviTUdVw5dUyYTMhpqsWglDyq3bPuF7HogWFKd8KjNx++8MT31
   HFq1bRIdOHqTj4lmigIQsCashtsbF4TQ3O4ql05gJvS5VqFs6IEyLx0oX
   zqLxEnZCWYWqkB9agAkTFs+meRYUY4FwvbRRRUN9/AZlBiaWHE3rvYbm6
   SuownyiYd2io9+ZRasRo7jCADPcarvBi5i/r+0sT8VnqUj+8CaSoTyqIk
   VLApDV5QaUQlY39ehNXmEVLGT6xZHiedxRdlENlf5pW958syQwZE7bWv1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="389874199"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="389874199"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 14:54:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="750312453"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="750312453"
Received: from morristo-mobl.amr.corp.intel.com ([10.209.50.167])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 14:54:00 -0700
Date: Thu, 6 Oct 2022 14:54:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp-next v4 0/3] mptcp: add statistics for mptcp socket
 in use
In-Reply-To: <20221006061123.1474224-1-imagedong@tencent.com>
Message-ID: <b60b3786-482e-d308-12fa-4f3605301d46@linux.intel.com>
References: <20221006061123.1474224-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 6 Oct 2022, menglong8.dong@gmail.com wrote:

> From: Menglong Dong <imagedong@tencent.com>
>
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> use. And in the 3th patch, we add the testing for this commit.
>

Hi Menglong -

Thanks for the post. While your patches did apply cleanly to the export 
branch when you sent them, there's now a significant merge conflict 
because of this patch (applied today) that refactors 
mptcp_stream_connect():

https://lore.kernel.org/mptcp/c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com/

Sorry about that timing! Can you rebase and re-post?


- Mat


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
