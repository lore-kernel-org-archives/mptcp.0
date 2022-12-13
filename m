Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04E323B
	for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670972774; x=1702508774;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0S20vf4Z61tHo8ltnQe3kFHwIs3VBfqKjYBOUatxIdk=;
  b=QlG1+rEXRvzxIcB33vcXNus48ggTe7cyxk4a3Cls0mWIMXHboc0Lw2m6
   TcPnqxMZAALfPzoEzx+m913kHVXU3UFNV6y1pxkNyaLTbKesjdOIMWkBA
   c/xLX9o6TLaemgxoF5Hg+fKV2KKNmvzdxMYkggW00OgE9S2afbjgmuaC8
   QYHxgokBRIaZRV8nLrbD2QhdktZt1eo5e42QSPvN0qYgagLLxHWGbgxhw
   gBe0Q/vvVRFhCxGrgxXblWbTIDYsc6PNQqtkmmeEQlfY8ssJlZ4vYzj+M
   CUmbLBf53OAZQKw/Z+ovxF3JxK56IpXnusbeeFT6ELZxZPHQD2LOaDczV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="380466890"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="380466890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:06:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="626500638"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="626500638"
Received: from ticela-or-060.amr.corp.intel.com ([10.209.103.237])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:06:13 -0800
Date: Tue, 13 Dec 2022 15:06:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] two small cleanups
In-Reply-To: <cover.1670575887.git.geliang.tang@suse.com>
Message-ID: <0cdbbb8d-9815-7091-03f3-d53fbe21e3e0@linux.intel.com>
References: <cover.1670575887.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Dec 2022, Geliang Tang wrote:

> Two small cleanups.
>
> Geliang Tang (2):
>  mptcp: use net instead of sock_net
>  mptcp: use local variable ssk in write_options
>
> net/mptcp/options.c    | 3 +--
> net/mptcp/pm_netlink.c | 5 ++---
> net/mptcp/protocol.c   | 4 ++--
> 3 files changed, 5 insertions(+), 7 deletions(-)
>

Hi Geliang -

Appreciate the cleanup, changes are good to merge:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
