Received: from rn-mailsvcp-ppex-lapp24.apple.com (rn-mailsvcp-ppex-lapp24.rno.apple.com [17.179.253.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05272
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 17:53:20 +0000 (UTC)
Received: from pps.filterd (rn-mailsvcp-ppex-lapp24.rno.apple.com [127.0.0.1])
	by rn-mailsvcp-ppex-lapp24.rno.apple.com (8.16.1.2/8.16.1.2) with SMTP id 14DFNPOl026531
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 08:41:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=20180706;
 bh=7aPVMX5CqVaNt9E0R3ITr0YtY5llW4AjbLx4Vp/qW3s=;
 b=Fum8hjx0uIrAPys5K7bgG2kiqaZMODVEPnFsJojiUldu11NNWkt37n8ol8cWY9LjxMca
 XfwPSinoPX/UydvL4/TbcbYROLL4op02miR7g8XJanig8yDDRVvbrPWV6Y3NSZssIV01
 l4dVozdx3i6qkLofCVAmwU2uem9kySvHmXSCqRlsz2meujU1mb7uuVzq+vlcwphxQZSN
 XHb6wOL72BI4gTDie5XfnLe0abiLTQZyISkrcYWMoDcZeFmC6iYMjGO8o7xnfdSdeQpr
 i/96E045LVSuvnUIMYZ9Pa2pC2HHC74w7SeQHrYd4YxniV6u5Rr6+GfmWzLeuKh+dICl xQ== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
	by rn-mailsvcp-ppex-lapp24.rno.apple.com with ESMTP id 38gssyyg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 08:41:53 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020)) with ESMTPS id <0QT100VOIY9TKVD0@rn-mailsvcp-mta-lapp01.rno.apple.com>
 for mptcp@lists.linux.dev; Thu, 13 May 2021 08:41:53 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020)) id <0QT100B00Y6LYG00@rn-mailsvcp-mmp-lapp01.rno.apple.com> for
 mptcp@lists.linux.dev; Thu, 13 May 2021 08:41:53 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d23c2f7b3ab3a47cbc778cafd57a49dc
X-Va-E-CD: 162831ee32e87bf44d2f14ce9f68efe6
X-Va-R-CD: 82d5e1bcbd024174d88dfa396f395f94
X-Va-CD: 0
X-Va-ID: 7c2f962b-b1e6-4bd6-a827-fa9742069ca7
X-V-A: 
X-V-T-CD: d23c2f7b3ab3a47cbc778cafd57a49dc
X-V-E-CD: 162831ee32e87bf44d2f14ce9f68efe6
X-V-R-CD: 82d5e1bcbd024174d88dfa396f395f94
X-V-CD: 0
X-V-ID: 08b61318-cfbb-49f6-8083-b200d38f9bb8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_08:2021-05-12,2021-05-13 signatures=0
Received: from localhost ([17.234.10.124])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020)) with ESMTPSA id <0QT100G0FY9SGO00@rn-mailsvcp-mmp-lapp01.rno.apple.com>
 for mptcp@lists.linux.dev; Thu, 13 May 2021 08:41:53 -0700 (PDT)
Date: Thu, 13 May 2021 08:41:52 -0700
From: Christoph Paasch <cpaasch@apple.com>
To: mptcp@lists.linux.dev
Subject: syzkaller config
Message-id: <YJ1IwGXK8aE2QCii@MacBook-Pro.local>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_08:2021-05-12,2021-05-13 signatures=0

Hello,

this is my syzkaller config:

{
        "target": "linux/amd64",
        "http": "127.0.0.1:56741",
        "workdir": "/home/cpaasch/gopath/src/github.com/google/syzkaller/workdir_kasan_net",
        "kernel_obj": "/mnt/tmp/build/",
        "kernel_src": "/mnt/tmp/mptcp_syzkaller/",
        "kernel_build_src": "/mnt/tmp/mptcp_syzkaller/",
        "image": "/home/cpaasch/syzkaller/tools/stretch.img",
        "sshkey": "/home/cpaasch/syzkaller/tools/stretch.id_rsa",
        "syzkaller": "/home/cpaasch/gopath/src/github.com/google/syzkaller",
        "disable_syscalls": ["perf_event_open", "syz_mount_image", "syz_read_part_table", "openat$ttyprintk", "mount", "mkdir", "openat$ptmx", "mq_open", "fsetxattr", "rt_tgsigqueueinfo", "ioctl$VT_RESIZE", "ioctl$TIOCVHANGUP", "get_robust_list", "openat$nullb", "ioctl$SCSI_IOCTL_SEND_COMMAND", "lremovexattr", "mknod$loop", "write$binfmt_script", "syz_open_dev$sg", "write$nbd", "prlimit64", "write$P9_RRENAMEAT", "fcntl$addseals", "finit_module", "ioctl$KDSETMODE", "write$FUSE_NOTIFY_STORE", "ioctl$TIOCL_SETVESABLANK", "fsmount", "socket$vsock_stream", "socketpair$unix", "socket$nl_audit", "connect$unix", "bind$unix"],
        "procs": 8,
        "type": "qemu",
        "vm": {
                "count": 24,
                "kernel": "/mnt/tmp/build/arch/x86/boot/bzImage",
                "cpu": 2,
                "mem": 4096
        }
}





The way I generate this list of disabled syscals is simply over time, when I
saw that syzkaller was spending all of its efforts in those syscalls, I
added it to the disable-list. That way now it is spending more time in
MPTCP/networking related code.


Christoph

