Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416B71
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 22:00:23 +0000 (UTC)
IronPort-SDR: YtIAMwWwrLMhMUJgCTmskH4J14NKrcbfBFru2wLIOT0gX/2aP/CyiKlipLZ0nfTdMGX1FOgYNM
 KZtoS/Su0Khg==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="261305011"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261305011"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:00:22 -0700
IronPort-SDR: 3cwqguPdozZRu2vdRRURYYYZ/iwR9L7fNwOCvtY9dSjT14thVRimmVN6l8cel6ALuKX7XVlXOH
 yb1tHGkIVtDg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="431444610"
Received: from tmpatoko-mobl.amr.corp.intel.com ([10.209.65.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:00:21 -0700
Date: Thu, 13 May 2021 15:00:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 13th of May 2021
In-Reply-To: <84426992-d161-ce7a-28c2-c578f521a96a@tessares.net>
Message-ID: <a01ed4a2-2b4-3df-42e4-34f422d46560@linux.intel.com>
References: <84426992-d161-ce7a-28c2-c578f521a96a@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1152779374-1620943221=:78300"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1152779374-1620943221=:78300
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Thu, 13 May 2021, Matthieu Baerts wrote:

> Extra tests:
>    - news about Syzkaller? (Christoph):
>        - no new issues
>        - Mat is running a new Syzkaller instance for when Christoph is
> not available
>        - some syscalls are ignored:
>            - "disable_syscalls": ["perf_event_open", "syz_mount_image",
> "syz_read_part_table", "openat$ttyprintk", "mount", "mkdir",
> "openat$ptmx", "mq_open", "fsetxattr", "rt_tgsigqueueinfo",
> "ioctl$VT_RESIZE", "ioctl$TIOCVHANGUP", "get_robust_list",
> "openat$nullb", "ioctl$SCSI_IOCTL_SEND_COMMAND", "lremovexattr",
> "mknod$loop", "write$binfmt_script", "syz_open_dev$sg", "write$nbd",
> "prlimit64", "write$P9_RRENAMEAT", "fcntl$addseals", "finit_module",
> "ioctl$KDSETMODE", "write$FUSE_NOTIFY_STORE", "ioctl$TIOC
>                - *@Christoph* will send the rest on the ML
>            - not all debug options needs to be turned on otherwise it
> is too slow → share ideal .config?
>            - Could be good to have a dedicated Wiki page about that

I added a 'Testing' page to our wiki with information about kselftests, 
syzkaller, and packetdrill:

https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing

There's a lot more information there about syzkaller than the other tools, 
but syzkaller is more complex to set up so I suppose that's natural. It's 
a wiki so we can add more information as needed!

--
Mat Martineau
Intel
--0-1152779374-1620943221=:78300--
