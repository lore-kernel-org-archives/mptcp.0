Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CA168
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 00:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641600704; x=1673136704;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=30OynkdKtaagJ+em2dOTPSYBxqZTB/vCk7C2IAlRFj0=;
  b=HbaWeiuNgX9OdWOwLeRCjT71oZseL/BdMQKP42cAl/A3t0qhpeGivGPI
   B92L4zzh6hsGtZlJOjEbY3lQTq9jA7Z0XfgsLuHqtYVE/olxRBtBysznm
   KFLIleH0OBmCva6AIgJw+OnHUMfsQMwUZj98fwsyhLqyoT2D94ToL3bh9
   UFSHPyGZCqsDgPbZPy9KP4Qk6keSx6OpLjzjnxGY3Ys8sGB9kNwIlWXfk
   XM/pQSC3vWkSnL6cm2KIxiA+GsJi6Yy2I5w4VdQHwcHPDiaM+T6QMlucJ
   0adwe1kwASP9c0k9LeYk2EjVWs8uY/2bEhmfWZc85CZyJFZTFC425zwmQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242916463"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242916463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:11:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="557427315"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:11:43 -0800
Date: Fri, 7 Jan 2022 16:11:43 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/3] more patches from pm_nl_ctl
In-Reply-To: <cover.1641289518.git.geliang.tang@suse.com>
Message-ID: <8de28feb-42ef-76d6-663c-32596eba1bc@linux.intel.com>
References: <cover.1641289518.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 4 Jan 2022, Geliang Tang wrote:

> This patched added id 0 address deleting, fullmesh flag and backup setting
> from pm_nl_ctl. With these patches, we can replace all pm_nl_ctl in the
> selftests with 'ip mptcp' command.
>
> Geliang Tang (3):
>  mptcp: add id check for deleting address
>  mptcp: add the addr flag fullmesh
>  mptcp: add the backup flag setting
>
> include/uapi/linux/mptcp.h |  2 ++
> ip/ipmptcp.c               | 31 +++++++++++++++++++++++++------
> 2 files changed, 27 insertions(+), 6 deletions(-)
>
> -- 
> 2.31.1

Hi Geliang -

I found that this doesn't apply to 
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git, but it 
does apply to iproute2.git

If you check iproute2-next, there's already a patch in there from Paolo 
that adds the fullmesh flag.

Can you rebase the other two patches on iproute2-next for v2?


Thanks,


--
Mat Martineau
Intel
