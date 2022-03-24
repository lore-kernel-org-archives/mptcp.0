Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AC7E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648165528; x=1679701528;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2QPGNc9SrytDLttqOwQ30gXcBJtjjNVihlJHSq0YuVI=;
  b=hnpNYIzhmWzaadigvMzeFOYiy0kTbhD9Eaz0D6nR31/KHEI6ugi6DYrh
   l1Th6acZ9dxpVM0HIHjJcTKQhDFqrhXGUC2Qm2tZm92ZSmOs5TCODWxUk
   wSIGfJMxCba+nS+ovc3r30S9/eln5lYCflfly5pHdW6c+nmh29aj07WYR
   SnVkZbeK4NFsInEX4JTcWrAS8sqUQh0z0pEEMdLFNIHMtu+R0eNjn3pJN
   fWuZBEVsFqvJLp4L1RejPg52KkRlW4ndKsdc0WWeHAI7+JiyTQiu7s+1t
   MfnZ+FRHU3w3UE5Vt7xQvaWnGckWg2nXZ/QyKWhzHHMggftfdDDB+H+HX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="257342469"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="257342469"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:45:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="553043611"
Received: from lyang24-mobl.amr.corp.intel.com ([10.255.230.22])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:45:27 -0700
Date: Thu, 24 Mar 2022 16:45:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v2] mptcp: add pm_nl_pernet helpers
In-Reply-To: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
Message-ID: <1d93ac60-c7a0-8441-76c7-e1c8344dd566@linux.intel.com>
References: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 23 Mar 2022, Geliang Tang wrote:

> This patch added two pm_nl_pernet related helpers pm_nl_get_pernet() and
> pm_nl_get_pernet_from_msk(). Ues them instead of using net_generic()
> directly.
>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - add pm_nl_get_pernet_from_msk as Florian suggested.

v2 looks good to me, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
> 1 file changed, 24 insertions(+), 17 deletions(-)
>

--
Mat Martineau
Intel
