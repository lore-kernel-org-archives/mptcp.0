Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5F71
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 22:05:48 +0000 (UTC)
IronPort-SDR: KzCkvdodit2vW9CV9D9Ilo4EFsqJQnrEgjjrCkAJRqOVcs0bqoyV191F6CqxqpyWiFLM/HMaoW
 4HBCiI1t5obQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200117437"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200117437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:05:47 -0700
IronPort-SDR: fHmJt5FtpbqX7sgbEh1hcCmt+4tVOlRDlUyqdtZlPHFctAkkUYqz0stmCumppeLLjgjRKxNwWi
 wh773N4Uz69w==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="431447265"
Received: from tmpatoko-mobl.amr.corp.intel.com ([10.209.65.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:05:47 -0700
Date: Thu, 13 May 2021 15:05:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Christoph Paasch <cpaasch@apple.com>
cc: mptcp@lists.linux.dev
Subject: Re: syzkaller config
In-Reply-To: <YJ1IwGXK8aE2QCii@MacBook-Pro.local>
Message-ID: <df27e284-9542-c2c2-dfaa-2ab6995c2653@linux.intel.com>
References: <YJ1IwGXK8aE2QCii@MacBook-Pro.local>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 13 May 2021, Christoph Paasch wrote:

> Hello,
>
> this is my syzkaller config:
>
> {
>        "target": "linux/amd64",
>        "http": "127.0.0.1:56741",
>        "workdir": "/home/cpaasch/gopath/src/github.com/google/syzkaller/workdir_kasan_net",
>        "kernel_obj": "/mnt/tmp/build/",
>        "kernel_src": "/mnt/tmp/mptcp_syzkaller/",
>        "kernel_build_src": "/mnt/tmp/mptcp_syzkaller/",
>        "image": "/home/cpaasch/syzkaller/tools/stretch.img",
>        "sshkey": "/home/cpaasch/syzkaller/tools/stretch.id_rsa",
>        "syzkaller": "/home/cpaasch/gopath/src/github.com/google/syzkaller",
>        "disable_syscalls": ["perf_event_open", "syz_mount_image", "syz_read_part_table", "openat$ttyprintk", "mount", "mkdir", "openat$ptmx", "mq_open", "fsetxattr", "rt_tgsigqueueinfo", "ioctl$VT_RESIZE", "ioctl$TIOCVHANGUP", "get_robust_list", "openat$nullb", "ioctl$SCSI_IOCTL_SEND_COMMAND", "lremovexattr", "mknod$loop", "write$binfmt_script", "syz_open_dev$sg", "write$nbd", "prlimit64", "write$P9_RRENAMEAT", "fcntl$addseals", "finit_module", "ioctl$KDSETMODE", "write$FUSE_NOTIFY_STORE", "ioctl$TIOCL_SETVESABLANK", "fsmount", "socket$vsock_stream", "socketpair$unix", "socket$nl_audit", "connect$unix", "bind$unix"],
>        "procs": 8,
>        "type": "qemu",
>        "vm": {
>                "count": 24,

You're using a much bigger system than me :)

>                "kernel": "/mnt/tmp/build/arch/x86/boot/bzImage",
>                "cpu": 2,
>                "mem": 4096
>        }
> }
>
>
> The way I generate this list of disabled syscals is simply over time, when I
> saw that syzkaller was spending all of its efforts in those syscalls, I
> added it to the disable-list. That way now it is spending more time in
> MPTCP/networking related code.

I based the sample config in 
https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing#syzkaller on 
this (with a couple of adjustments and some anonymization). Thanks for 
sharing.

--
Mat Martineau
Intel
