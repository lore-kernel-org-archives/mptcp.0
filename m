Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255E17F
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 17:24:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202365663"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="202365663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 10:24:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="590207825"
Received: from pmccolga-mobl.amr.corp.intel.com ([10.212.139.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 10:24:37 -0700
Date: Wed, 11 Aug 2021 10:24:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: some self-tests fixup
In-Reply-To: <2b3daaa4-4a07-9b9b-8e48-0fd294e1ba1f@tessares.net>
Message-ID: <14b6929b-9ecf-e5ad-245e-6fd7cddea34a@linux.intel.com>
References: <cover.1628673891.git.pabeni@redhat.com> <2b3daaa4-4a07-9b9b-8e48-0fd294e1ba1f@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 11 Aug 2021, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 11/08/2021 11:25, Paolo Abeni wrote:
>> The 2 squash-to patches try to address issues/221, at least
>> for the root cause reported in the github tracker.
>
> I confirm that it is much better, thank you!
>
> Before the patches, it took me 2 attempts to have "mptcp_join.sh -l"
> failing with a debug kernel.
>
> With the patches, I have 30 successful runs so far!
>
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks for the patches Paolo, and thanks for testing Matthieu. Looks good 
to squash.

--
Mat Martineau
Intel
