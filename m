Content-Type: multipart/mixed; boundary="===============1031943870282831500=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] INFO: task hung in lock_sock_nested
Date: Wed, 01 Apr 2020 14:55:06 -0700
Message-ID: <20200401215506.GA39236@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4124

--===============1031943870282831500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

another syzkaller on top of 6fe9a949d3fe with Florian's patch as well.

INFO: task syz-executor.4:22557 blocked for more than 143 seconds.
      Not tainted 5.6.0 #64
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D    0 22557   2905 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3380 [inline]
 __schedule+0x23c/0x5f0 kernel/sched/core.c:4080
 schedule+0x4a/0x100 kernel/sched/core.c:4154
 __lock_sock+0x80/0xd0 net/core/sock.c:2424
 lock_sock_nested+0x77/0x80 net/core/sock.c:2949
 lock_sock include/net/sock.h:1574 [inline]
 inet_stream_connect+0x27/0x60 net/ipv4/af_inet.c:718
 mptcp_stream_connect+0xad/0x130 net/mptcp/protocol.c:1658
 __sys_connect_file net/socket.c:1859 [inline]
 __sys_connect+0x140/0x180 net/socket.c:1876
 __do_sys_connect net/socket.c:1887 [inline]
 __se_sys_connect net/socket.c:1884 [inline]
 __x64_sys_connect+0x1e/0x30 net/socket.c:1884
 do_syscall_64+0x91/0x2f0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9


syzkaller-repro is:
# {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox:=
 Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:false NetDevic=
es:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN=
:false DevlinkPCI:false UseTmpDir:false HandleSegv:false Repro:false Trace:=
false}
r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
bind$inet(r0, &(0x7f00000013c0)=3D{0x2, 0x4e20}, 0x10)
listen(r0, 0x0)
r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
connect$inet(r1, &(0x7f0000000040)=3D{0x2, 0x4e20, @loopback}, 0x4d)
r2 =3D accept(r0, 0x0, 0x0)
connect$unix(r2, 0x0, 0x0)


I also created a github-issue just for easier tracking of these issues.

https://github.com/multipath-tcp/mptcp_net-next/issues/12


Cheers,
Christoph


--===============1031943870282831500==--
