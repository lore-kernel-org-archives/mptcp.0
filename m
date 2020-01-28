Content-Type: multipart/mixed; boundary="===============0884670824059359080=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] KASAN: slab-out-of-bounds Read in
 subflow_syn_recv_sock
Date: Mon, 27 Jan 2020 22:04:11 -0800
Message-ID: <20200128060411.GD19649@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 3531

--===============0884670824059359080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

another one, with C-repro. On top of net-next plus the two other pending
patches:


Syzkaller hit 'KASAN: slab-out-of-bounds Read in subflow_syn_recv_sock' bug.

TCP: request_sock_subflow: Possible SYN flooding on port 20002. Sending coo=
kies.  Check SNMP counters.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in subflow_syn_recv_sock+0x451/0x4d0 net/mpt=
cp/subflow.c:191
Read of size 1 at addr ffff8881167bc148 by task syz-executor099/2120

CPU: 0 PID: 2120 Comm: syz-executor099 Not tainted 5.5.0-rc7 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:639
 subflow_syn_recv_sock+0x451/0x4d0 net/mptcp/subflow.c:191
 tcp_get_cookie_sock+0xcf/0x520 net/ipv4/syncookies.c:209
 cookie_v6_check+0x15a5/0x1e90 net/ipv6/syncookies.c:252
 tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1123 [inline]
 tcp_v6_do_rcv+0xff7/0x1290 net/ipv6/tcp_ipv6.c:1448
 tcp_v6_rcv+0x2c8e/0x31f0 net/ipv6/tcp_ipv6.c:1659
 ip6_protocol_deliver_rcu+0x2f7/0x14a0 net/ipv6/ip6_input.c:432
 ip6_input_finish+0x81/0x160 net/ipv6/ip6_input.c:473
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_input+0xcf/0x3d0 net/ipv6/ip6_input.c:482
 dst_input include/net/dst.h:442 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
 ip6_rcv_finish+0xce/0x1c0 net/ipv6/ip6_input.c:66
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ipv6_rcv+0xf8/0x3f0 net/ipv6/ip6_input.c:306
 __netif_receive_skb_one_core+0x10c/0x1c0 net/core/dev.c:5148
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5262
 process_backlog+0x202/0x750 net/core/dev.c:6094
 napi_poll net/core/dev.c:6532 [inline]
 net_rx_action+0x3f1/0xe60 net/core/dev.c:6600
 __do_softirq+0x223/0x924 kernel/softirq.c:292
 do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1082
 </IRQ>
 do_softirq.part.0+0x3d/0x40 kernel/softirq.c:337
 do_softirq arch/x86/include/asm/preempt.h:26 [inline]
 __local_bh_enable_ip+0x164/0x190 kernel/softirq.c:189
 local_bh_enable include/linux/bottom_half.h:32 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:706 [inline]
 ip6_finish_output2+0x1265/0x2320 net/ipv6/ip6_output.c:117
 __ip6_finish_output+0x44c/0xae0 net/ipv6/ip6_output.c:142
 ip6_finish_output net/ipv6/ip6_output.c:152 [inline]
 NF_HOOK_COND include/linux/netfilter.h:296 [inline]
 ip6_output+0x242/0x820 net/ipv6/ip6_output.c:175
 dst_output include/net/dst.h:436 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_xmit+0xd68/0x1e50 net/ipv6/ip6_output.c:279
 inet6_csk_xmit+0x33b/0x610 net/ipv6/inet6_connection_sock.c:135
 __tcp_transmit_skb+0x19a9/0x3680 net/ipv4/tcp_output.c:1234
 tcp_transmit_skb net/ipv4/tcp_output.c:1250 [inline]
 tcp_write_xmit+0xeaf/0x59f0 net/ipv4/tcp_output.c:2513
 __tcp_push_pending_frames+0xaa/0x330 net/ipv4/tcp_output.c:2689
 tcp_send_fin+0x121/0xcd0 net/ipv4/tcp_output.c:3235
 tcp_close+0xbd0/0x1220 net/ipv4/tcp.c:2425
 inet_release+0xe9/0x1f0 net/ipv4/af_inet.c:427
 inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:470
 __sock_release+0xd2/0x290 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1283
 __fput+0x2da/0x850 fs/file_table.c:280
 task_work_run+0x144/0x1c0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0xb3d/0x2b30 kernel/exit.c:801
 do_group_exit+0x125/0x340 kernel/exit.c:899
 __do_sys_exit_group kernel/exit.c:910 [inline]
 __se_sys_exit_group kernel/exit.c:908 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:908
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f6ce32da618
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0 =
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff f=
f 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffebaee5228 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ce32da618
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007f6ce35b78e0 R08: 00000000000000e7 R09: ffffffffffffff98
R10: 00007f6ce37d9260 R11: 0000000000000246 R12: 00007f6ce35b78e0
R13: 00007f6ce35bcc20 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 2120:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:486
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slub.c:2759 [inline]
 slab_alloc mm/slub.c:2767 [inline]
 kmem_cache_alloc+0xd8/0x2e0 mm/slub.c:2772
 reqsk_alloc include/net/request_sock.h:84 [inline]
 inet_reqsk_alloc+0x93/0x6f0 net/ipv4/tcp_input.c:6483
 cookie_v6_check+0x724/0x1e90 net/ipv6/syncookies.c:173
 tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1123 [inline]
 tcp_v6_do_rcv+0xff7/0x1290 net/ipv6/tcp_ipv6.c:1448
 tcp_v6_rcv+0x2c8e/0x31f0 net/ipv6/tcp_ipv6.c:1659
 ip6_protocol_deliver_rcu+0x2f7/0x14a0 net/ipv6/ip6_input.c:432
 ip6_input_finish+0x81/0x160 net/ipv6/ip6_input.c:473
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_input+0xcf/0x3d0 net/ipv6/ip6_input.c:482
 dst_input include/net/dst.h:442 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
 ip6_rcv_finish+0xce/0x1c0 net/ipv6/ip6_input.c:66
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ipv6_rcv+0xf8/0x3f0 net/ipv6/ip6_input.c:306
 __netif_receive_skb_one_core+0x10c/0x1c0 net/core/dev.c:5148
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5262
 process_backlog+0x202/0x750 net/core/dev.c:6094
 napi_poll net/core/dev.c:6532 [inline]
 net_rx_action+0x3f1/0xe60 net/core/dev.c:6600
 __do_softirq+0x223/0x924 kernel/softirq.c:292

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8881167bc000
 which belongs to the cache request_sock_TCPv6 of size 328
The buggy address is located 0 bytes to the right of
 328-byte region [ffff8881167bc000, ffff8881167bc148)
The buggy address belongs to the page:
page:ffffea000459ef00 refcount:1 mapcount:0 mapping:ffff888115d5aa00 index:=
0x0 compound_mapcount: 0
raw: 0200000000010200 dead000000000100 dead000000000122 ffff888115d5aa00
raw: 0000000000000000 0000000080140014 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881167bc000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881167bc080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881167bc100: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                              ^
 ffff8881167bc180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881167bc200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Syzkaller reproducer:
# {Threaded:false Collide:false Repeat:true RepeatTimes:0 Procs:8 Sandbox: =
Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:false NetDevice=
s:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:=
false DevlinkPCI:false UseTmpDir:false HandleSegv:false Repro:false Trace:f=
alse}
r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
bind$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4e22, 0x0, @loopback}, 0x1c)
listen(r0, 0x0)
r1 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
sendmmsg$inet6(r1, &(0x7f000000bd40)=3D[{{&(0x7f0000000140)=3D{0xa, 0x4e22,=
 0x0, @empty}, 0x1c, 0x0}}], 0x1, 0x20024084)


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char *file, const char *what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] =3D 0;
  int len =3D strlen(buf);
  int fd =3D open(file, O_WRONLY | O_CLOEXEC);
  if (fd =3D=3D -1)
    return false;
  if (write(fd, buf, len) !=3D len) {
    int err =3D errno;
    close(fd);
    errno =3D err;
    return false;
  }
  close(fd);
  return true;
}

static void kill_and_wait(int pid, int *status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  int i;
  for (i =3D 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
      return;
    usleep(1000);
  }
  DIR *dir =3D opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent *ent =3D readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd =3D open(abort, O_WRONLY);
      if (fd =3D=3D -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) !=3D pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter;
  for (iter =3D 0;; iter++) {
    int pid =3D fork();
    if (pid < 0)
      exit(1);
    if (pid =3D=3D 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status =3D 0;
    uint64_t start =3D current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5 * 1000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[2] =3D { 0xffffffffffffffff, 0xffffffffffffffff };

void execute_one(void)
{
  intptr_t res =3D 0;
  res =3D syscall(__NR_socket, 0xaul, 1ul, 0x106ul);
  if (res !=3D -1)
    r[0] =3D res;
  *(uint16_t *)0x20000080 =3D 0xa;
  *(uint16_t *)0x20000082 =3D htobe16(0x4e22);
  *(uint32_t *)0x20000084 =3D htobe32(0);
  *(uint64_t *)0x20000088 =3D htobe64(0);
  *(uint64_t *)0x20000090 =3D htobe64(1);
  *(uint32_t *)0x20000098 =3D 0;
  syscall(__NR_bind, r[0], 0x20000080ul, 0x1cul);
  syscall(__NR_listen, r[0], 0);
  res =3D syscall(__NR_socket, 0xaul, 1ul, 0ul);
  if (res !=3D -1)
    r[1] =3D res;
  *(uint64_t *)0x2000bd40 =3D 0x20000140;
  *(uint16_t *)0x20000140 =3D 0xa;
  *(uint16_t *)0x20000142 =3D htobe16(0x4e22);
  *(uint32_t *)0x20000144 =3D htobe32(0);
  *(uint8_t *)0x20000148 =3D 0;
  *(uint8_t *)0x20000149 =3D 0;
  *(uint8_t *)0x2000014a =3D 0;
  *(uint8_t *)0x2000014b =3D 0;
  *(uint8_t *)0x2000014c =3D 0;
  *(uint8_t *)0x2000014d =3D 0;
  *(uint8_t *)0x2000014e =3D 0;
  *(uint8_t *)0x2000014f =3D 0;
  *(uint8_t *)0x20000150 =3D 0;
  *(uint8_t *)0x20000151 =3D 0;
  *(uint8_t *)0x20000152 =3D 0;
  *(uint8_t *)0x20000153 =3D 0;
  *(uint8_t *)0x20000154 =3D 0;
  *(uint8_t *)0x20000155 =3D 0;
  *(uint8_t *)0x20000156 =3D 0;
  *(uint8_t *)0x20000157 =3D 0;
  *(uint32_t *)0x20000158 =3D 0;
  *(uint32_t *)0x2000bd48 =3D 0x1c;
  *(uint64_t *)0x2000bd50 =3D 0;
  *(uint64_t *)0x2000bd58 =3D 0;
  *(uint64_t *)0x2000bd60 =3D 0;
  *(uint64_t *)0x2000bd68 =3D 0;
  *(uint32_t *)0x2000bd70 =3D 0;
  *(uint32_t *)0x2000bd78 =3D 0;
  syscall(__NR_sendmmsg, r[1], 0x2000bd40ul, 1ul, 0x20024084ul);
}
int main(void)
{
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
  for (procid =3D 0; procid < 8; procid++) {
    if (fork() =3D=3D 0) {
      loop();
    }
  }
  sleep(1000000);
  return 0;
}


--===============0884670824059359080==--
