Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A61363
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 21:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648849735; x=1680385735;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nPnu7Oi4UZsn3lS+6m+aATh4fFXTKuxQIzFOTEK952Q=;
  b=hjhD8/ZI2nuSNBdRltjFYgIY/hpDXz4kGHX3sqXCEcX/9q1MfJr3Hynu
   pjDdAIon+Ar0waCFlvEUah8SlTKYPkGSjq0mFx+58ng/Kh3EfusPRbta0
   fU53ndHgcwXCyVJc/AqPi8zLuD9u8OgaP/FfdExESm0EZKJJ44fV27+qP
   vJkZEC98Vzu7Ee6NPQTzdfBtONgpC42MeW8frEVl/b7B9UH7bKxNzHf+9
   yOd7K8tE+GcrXCH+iN23lv0Xx+nPXSW80j13Sy+XXMjilD8DDN58aLObR
   lNhntK0X1kGmt4xUAbegquaCuZM+Us2iOCTfBUa1j3i7/pxDd1yBT8N71
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259938323"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="259938323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:48:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="640669199"
Received: from jbride-mobl.amr.corp.intel.com ([10.209.86.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:48:54 -0700
Date: Fri, 1 Apr 2022 14:48:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v9 0/6] mptcp: fixes and enhancements related
 to path management
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
Message-ID: <1c5d9b3e-8bda-497d-88a-2591751de8a@linux.intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Mar 2022, Kishen Maloor wrote:

> This patch series incorporates fixes and enhancements related to
> path management over MPTCP connections, particularly in support of
> userspace PMs. The changes ensure that the required bits of
> information are conveyed through MPTCP netlink events which
> would be consumed by the path manager in making its decisions.
> Further it adds flexibility in establishing paths and from
> both ends of MPTCP connections.
>
> v6:
> -Dropped framework and functionality around the use of kernel
> listening sockets for receiving MPJs.
>

Thanks Kishen. This first series looks good to me, and Paolo acked too. 
The second series needs a rebase and a few more tweaks.


For this series:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


Matthieu, I sent two additional selftest-only patches so that the behavior 
implemented in this series (which is correct: don't send ADD_ADDR echoes 
if there's no userspace daemon) is correctly tested. They're pretty short 
and simple, hopefully you can review and apply with Kishen's series. As I 
mentioned in 
https://lore.kernel.org/mptcp/20220401193714.10268-1-mathew.j.martineau@linux.intel.com/ 
:

   If you could add the squash-to patch at the beginning of [the] series to
   revert the bad test, and add the new self test commit after "mptcp:
   bypass in-kernel PM restrictions for non-kernel PMs" I think that
   addresses the test problem.


Mat

> v7:
> -Fixed bug caught by the CI build.
>
> v8:
> -Fixed logic to achieve the desired outcome of not responding to
> address advertisements when a userspace PM is offline.
> -Factored out minor changes to mptcp_pm_is_userspace() to be
> squashed into an earlier commit.
>
> v9:
> -Removed an explicit 'struct inet_sock *' cast in a patch which was
> not necessary.
>
> Kishen Maloor (6):
>  Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
>  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
>  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
>  mptcp: reflect remote port (not 0) in ANNOUNCED events
>  mptcp: establish subflows from either end of connection
>  mptcp: expose server_side attribute in MPTCP netlink events
>
> include/uapi/linux/mptcp.h |  1 +
> net/mptcp/options.c        |  4 ++--
> net/mptcp/pm.c             | 21 +++++++++++++++++----
> net/mptcp/pm_netlink.c     | 24 +++++++++++++++++++++---
> net/mptcp/protocol.c       |  5 +----
> net/mptcp/protocol.h       | 22 ++++++++++++++++------
> net/mptcp/subflow.c        |  5 ++++-
> 7 files changed, 62 insertions(+), 20 deletions(-)
>
>
> base-commit: 8e1fca01ac83e646133bd647abdae74d6d6449ba
> --
> 2.31.1
>
>

--
Mat Martineau
Intel
