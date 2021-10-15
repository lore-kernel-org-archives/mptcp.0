Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C507629CA
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 23:54:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="251456481"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="251456481"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:54:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="525587224"
Received: from jwbates1-mobl1.amr.corp.intel.com ([10.212.131.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:54:38 -0700
Date: Fri, 15 Oct 2021 16:54:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/3] tcp: define macros for a couple reclaim
 thresholds
In-Reply-To: <0d3f747f3a1dcdc67e71fc93cc1d64eee9e6b803.1634312286.git.pabeni@redhat.com>
Message-ID: <a87992f-c98a-1e36-d845-f1b7395b7f46@linux.intel.com>
References: <cover.1634312286.git.pabeni@redhat.com> <0d3f747f3a1dcdc67e71fc93cc1d64eee9e6b803.1634312286.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Oct 2021, Paolo Abeni wrote:

> A following patch is going to implment for the MPTCP protocol
> a similar reclaim schema, with different locking.
>
> Let's define a couple of macros for the used thresholds, so
> that the latter code will be more easily maintainable.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/net/sock.h | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
