Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35368
	for <mptcp@lists.linux.dev>; Sat,  6 Nov 2021 00:27:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="218908665"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="218908665"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 17:27:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="532754589"
Received: from adhar1-mobl1.amr.corp.intel.com ([10.212.220.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 17:27:15 -0700
Date: Fri, 5 Nov 2021 17:27:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [RFC PATCH 0/3] mptcp: improve accept() and disconnect()
In-Reply-To: <cover.1636107361.git.pabeni@redhat.com>
Message-ID: <43c3392-ce28-f5e2-2d5d-accc79355734@linux.intel.com>
References: <cover.1636107361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 Nov 2021, Paolo Abeni wrote:

> As outlined in the public mtg, mptcp_accept() is currently quite
> suboptimal, both from performance and code complexity
>
> This series tries to clean it up, enforcing a wider lifetime for
> the initial subflow, so that we don't need to acquire additional
> references there.
>
> To reach such goal we need to properly define the disconnect()
> behavior, which is currently quite incomplete.
>
> Some additional self-tests is likely required,
>

Hi Paolo -

I don't have any changes to suggest right now except for the 
"msk->last_snd = 0" (vs NULL) that the CI found.

And this finally expunges MPTCP_DATA_READY too!

I agree that some kind of test that tries to close/destroy the msk while a 
listen() (or other calls) are pending would be very useful.

--
Mat Martineau
Intel
