Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98677362
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 05:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FF6C34114;
	Fri, 10 Jun 2022 05:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654840777;
	bh=YbfypFmuQC43lxzwogq0gMu+VD4tHkQZ1HN6nIGwKSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGjJhV9hDJ4aXc9i5SuX6yhdIsHcmUbFrm+evjsLkgZp4UcK7EV800PYqUxdTJhGs
	 jwi0je8NiTe1BjSd6+//fKCdIDFfoMypPPFBLs/wXl/HsSOixAPM5HibV3Ewl8DcEp
	 x64UYhirXJ/gYGRk8gVA5hdjEhkVAsTTDT99IIqmSfIk9rj0DoE5tFpbl7p9W/Xmtk
	 Evc0voIl9GG6rlKS57ceUDqVVNh0AuGmFv2oUV03eUuaqe3+kJIBEvRm0CtZauZwtk
	 mm9VSqlisJ69lQT+abTc2jC/pwf1GpDBb7shjIAsZ0c9XxAJTQFV3Rzh4V1o4f2Ojb
	 26ZqPyiroBUtw==
Date: Thu, 9 Jun 2022 22:59:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Ossama Othman <ossama.othman@intel.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] mptcp: fix conflict with <netinet/in.h>
Message-ID: <20220609225936.4cba4860@kernel.org>
In-Reply-To: <20220608191919.327705-2-mathew.j.martineau@linux.intel.com>
References: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
	<20220608191919.327705-2-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jun 2022 12:19:18 -0700 Mat Martineau wrote:
> From: Ossama Othman <ossama.othman@intel.com>
> 
> Including <linux/mptcp.h> before the C library <netinet/in.h> header
> causes symbol redefinition errors at compile-time due to duplicate
> declarations and definitions in the <linux/in.h> header included by
> <linux/mptcp.h>.
> 
> Explicitly include <netinet/in.h> before <linux/in.h> in
> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
> compatibility logic in <linux/libc-compat.h> is enabled when including
> <linux/mptcp.h> in user space code.
> 
> Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")

What does it break, tho? The commit under Fixes is in net, if it's
really a fix it needs to go to net. If it's just prep for another
change we don't need to fixes tag.
