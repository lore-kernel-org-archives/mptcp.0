Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263673;
	b=uWiBihOUb7KQjiygyCcr/jwg2BZuUXt9U/Re9zKEFX3ZhrItj24vq+1Sii5RkuqRAEMs
	 E5SnOQUyxaCPSjpAkvpPidcvwpbmSEi8yndt5G5NWSkh75b9U6oiKPiaX47oF8H4ucoOS
	 s1TYeviib3sXhxx4DTLiv+4/7Sjkns8prMMTX/UyKbwh/w81yvYBraiCgG96DupYtNjVM
	 MtNwlifMbBye2Eq/0uzFX65Mle7OrfJ7WxaenJujnT4x447JgV5NWY0wK8e84nxm3RSuz
	 J5opSt8SyEnoAWRHHjjEr3c/Ye0NJQjqfOh/BajFY95SrQYkUdbGFhZULdmBNJVm2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=y90LqrGNI3o3wv31FtLSq2XSgI2FqcGz/Kp1dYYUhSQ=;
	b=OcKqCPzxTHGvkosbJHeBDJiho/AkiP4qpzIyEr4NFOqGBHgitRshtiZAjV5wTNAzdiFD
	 r7hxLSSmxdlTuY5afAthribJxxr/szZ/BjzoxUvig6WbgtPkiaAc5wqqhU+mOiCgx8J4A
	 +DOwA9tz+VEorBfhHprZWMI8pXo7SvYL1qTo+aAKdvLyh4nqohyn/8G3bbIN5vkFZ5pbE
	 vrztuS6lDk4LlaLZ7PnZ0rxhpOsWeHJa/dm/fWdiAD6A3wqbShzaXQM+11kPEnTK39Itj
	 KOfDoAjVLbfX3e7h7QMCLf+epTiNO7FV471P3C4ukK3of0ZAuUpp4QePQIQaQoVHKCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjP7ckUS;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D1606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 08:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 774D1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjP7ckUS
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8479f46ecd8so827308a34.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263671; x=1793868471; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y90LqrGNI3o3wv31FtLSq2XSgI2FqcGz/Kp1dYYUhSQ=;
        b=rjP7ckUSfYE3sAeq1ebJA9walsVwsWoOWKEbhK28xnUEjqa36kxJI+iFVoU+oDGVOk
         KERzlKf2t4DEN3Hsv/gSklXqbP5P3J3X//q92at1GrT8+yAY+jHRHyundPh1sh2Z51i9
         L3EOWhZ6b+Zjl6DpSXvM5kHSQDYAop2pySBFvTSoFUFBB9vX5BbMcnP1rht+4ME8d8Ne
         tZ8BajT4pZlb8S8yEUCZXI7dn9PtlLdwj/j4J/3WS2R7B17RXoJpPiPHD38za59fBINO
         vCSRODwwUewA53jlqstC/68q0zIl97c3wKZQn+pj7bSYAbTfTkLHofmKIfUH3uPBGH0S
         z44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263671; x=1793868471;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y90LqrGNI3o3wv31FtLSq2XSgI2FqcGz/Kp1dYYUhSQ=;
        b=eQ7fxia4gonLLKMGV1xcKPU9EZjuE16CQZby9c8zISN6xDepAHI/1qrBe9KxCbSw6N
         k8t42a4o+mV0RqHNx3DdTOcm1XYohxOvB1TP2JiFYywg6Qk1vAKvXZKGr6cgDRRLyNhV
         ikkMMLU5mifCMIOhx9hXGSa5/tFrsKQp4yccEpPkN+6GKP/Ds5qBmpqVgKk0q0msH655
         tVmRUEd62KAUYPMdR18t3pb2eP4vViQKHVtbd8aCFB3Aia4457fuLcyr8b0SNCdiDzAb
         lnCOr04bSj0I/PACd+LSoVCB90JDpX0Qe9u5tk8NVApinxAgWjavwxpynAPUBH2n5mLa
         YMbA==
X-Gm-Message-State: AFq9FYJgBBP/26dDUVs8R7piefvXBbWpJiBa7YZHYb+nsVtyu5YaRVPN
	FxNgoDooAzPC/W07lrYK6jXQ7px4hoMzWlHgQ/DKNpsRO3StHW6RCsXm5dJf
X-Gm-Gg: AYBFou1k6E9rScLL3dFLskg4NNhvYFu29mL/9t9F3nyLhrD0hPCimZfvXs8L2dGwXhv
	kKMmHErdv2UsfzcocjgIVjgpgTwU722S8IYx2PYr1tlW1hM5ID0pUlPPJvXk4YK/8e2JnA9jZCf
	+ifysgJkKEHB7jWlEX9hCcNgG69HTQkU9HSRb4CVrl4egw0hsACrVs8fJDuIRx7SxhLgsOMNgxE
	tSzVCYzGnOH0ND+4uQJoL/aQbcpDhczLEDocGM++o8uHjdeIRi2uHBgqzLx8lR6845OjOJJH8dj
	+KQ/dZe0nHDuJLh9l/BxOKiIsffZ2j08IeGzSr4nXq3nAce6kCooPp9ZK/ke65IrsQ4NLutIHZV
	+h355Ju6RFX19DY+j2jcBWNvaCjJBGJuXA3HYogrOXNnUdwHSibxJouh8QU+T2ahd1+ZwI1NgAJ
	wFL/gPz+qG2ulIvYfo3kBruulrGzQDE6xpSLL79n4I5wTmvC2ntONd7h/5GRB7nGssMPxaoc27N
	Yx5I7Fkq4pUJa+2cPVqhpP68fgsIxPxYj1tCS3Jwo5lJzObqcqk/PDrKnKu2+aIj9MH684mwY1S
	mtuGaWb0v0/Tt5UR3i7py63C4aT07Q6cZeOVQphWYh4Y
X-Received: by 2002:a05:6830:6416:b0:81f:acdd:bd05 with SMTP id 46e09a7af769-85aba428a1bmr4254662a34.21.1793263671199;
        Thu, 29 Oct 2026 01:47:51 -0700 (PDT)
Received: from github.com ([172.169.253.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20219dc4sm4196546a34.22.2026.10.29.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:47:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <pm-mptcp-objects-candidate-0066-v6-36c93fb39222b9c59043@gmail.com>
References:
 <pm-mptcp-objects-candidate-0066-v6-36c93fb39222b9c59043@gmail.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: protect listener backlog reads in
 diagnostics
Message-ID: <cb08d726-fe14-bc96-1d59-f6e28a5d5204@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:47:49 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: mptcp-perf/01-Test_1/client.log: Global Timeout - =
Critical: mptcp-perf/01-Test_1/server.log: Global Timeout - Critical: =
sched-baseline/01-slow_primary/client.log: Global Timeout - Critical: =
sched-baseline/01-slow_primary/server.log: Global Timeout - Critical: =
sched-baseline/02-tiny_primary/client.log: Global Timeout - Critical: =
sched-baseline/02-tiny_primary/server.log: Global Timeout - Critical: =
sched-baseline/03-fast_both/client.log: Global Timeout - Critical: =
sched-baseline/03-fast_both/server.log: Global Timeout - Critical: =
sched-baseline/04-balanced/client.log: Global Timeout - Critical: =
sched-baseline/04-balanced/server.log: Global Timeout - Critical: =
sched-baseline/05-slow_near_primary/client.log: Global Timeout - Critical: =
sched-baseline/05-slow_near_primary/server.log: Global Timeout - Critical: =
sched-baseline/06-slow_secondary/client.log: Global Timeout - Critical: =
sched-baseline/06-slow_secondary/server.log: Global Timeout - Critical: =
sched-baseline/07-very_fast/client.log: Global Timeout - Critical: =
sched-baseline/07-very_fast/server.log: Global Timeout - Critical: =
sched-baseline/08-shallow_primary/client.log: Global Timeout - Critical: =
sched-baseline/08-shallow_primary/server.log: Global Timeout - Critical: =
sched-baseline/09-high_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/09-high_lat_primary/server.log: Global Timeout - Critical: =
sched-baseline/10-huge_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/10-huge_lat_primary/server.log: Global Timeout - Critical: =
sched-baseline/11-high_lat_secondary/client.log: Global Timeout - Critical:=
 sched-baseline/11-high_lat_secondary/server.log: Global Timeout - =
Critical: sched-baseline/12-huge_lat_secondary/client.log: Global Timeout -=
 Critical: sched-baseline/12-huge_lat_secondary/server.log: Global Timeout =
- Critical: sched-baseline/13-bloated_primary/client.log: Global Timeout - =
Critical: sched-baseline/13-bloated_primary/server.log: Global Timeout - =
Critical: sched-baseline/14-bloated_secondary/client.log: Global Timeout - =
Critical: sched-baseline/14-bloated_secondary/server.log: Global Timeout - =
Critical: sched-baseline/15-slow_primary_upload/client.log: Global Timeout =
- Critical: sched-baseline/15-slow_primary_upload/server.log: Global =
Timeout - Critical: sched-baseline/16-balanced_upload/client.log: Global =
Timeout - Critical: sched-baseline/16-balanced_upload/server.log: Global =
Timeout - Critical: sched-baseline/17-slow_primary_parallel_4/client.log: =
Global Timeout - Critical: sched-baseline/17-slow_primary_parallel_4/server=
.log: Global Timeout - Critical: sched-baseline/18-balanced_parallel_4/clie=
nt.log: Global Timeout - Critical: sched-baseline/18-balanced_parallel_4/se=
rver.log: Global Timeout - Critical: sched-bbr/01-slow_primary_bbr/client.=
log: Global Timeout - Critical: sched-bbr/01-slow_primary_bbr/server.log: =
Global Timeout - Critical: sched-bbr/02-balanced_bbr/client.log: Global =
Timeout - Critical: sched-bbr/02-balanced_bbr/server.log: Global Timeout - =
Critical: sched-bbr/03-slow_near_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/03-slow_near_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/04-high_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/04-high_lat_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/05-huge_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/05-huge_lat_primary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/06-high_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/06-high_lat_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/07-huge_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/07-huge_lat_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/08-slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/08-slow_secondary_bbr/server.log: Global Timeout - =
Critical: sched-bbr/09-very_fast_bbr/client.log: Global Timeout - Critical:=
 sched-bbr/09-very_fast_bbr/server.log: Global Timeout - Critical: =
sched-bbr/10-bloated_secondary_bbr/client.log: Global Timeout - Critical: =
sched-bbr/10-bloated_secondary_bbr/server.log: Global Timeout - Critical: =
sched-bbr/11-bloated_slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/11-bloated_slow_secondary_bbr/server.log: Global =
Timeout - Critical: sched-bbr/12-very_bloated_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/12-very_bloated_secondary_bbr/server.=
log: Global Timeout - Critical: sched-bbr/13-bad_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/13-bad_secondary_bbr/server.log: =
Global Timeout - Critical: sched-bbr/14-far_secondary_bbr/client.log: =
Global Timeout - Critical: sched-bbr/14-far_secondary_bbr/server.log: =
Global Timeout - Critical: sched-clientlim/01-slow_primary_bw_5/client.log:=
 Global Timeout - Critical: sched-clientlim/01-slow_primary_bw_5/server.=
log: Global Timeout - Critical: sched-clientlim/02-balanced_bw_5/client.=
log: Global Timeout - Critical: sched-clientlim/02-balanced_bw_5/server.=
log: Global Timeout - Critical: sched-clientlim/03-huge_lat_primary_bw_5/cl=
ient.log: Global Timeout - Critical: sched-clientlim/03-huge_lat_primary_bw=
_5/server.log: Global Timeout - Critical: sched-clientlim/04-slow_secondary=
_bw_5/client.log: Global Timeout - Critical: sched-clientlim/04-slow_second=
ary_bw_5/server.log: Global Timeout - Critical: sched-clientlim/05-slow_pri=
mary_bw_10/client.log: Global Timeout - Critical: sched-clientlim/05-slow_p=
rimary_bw_10/server.log: Global Timeout - Critical: =
sched-clientlim/06-balanced_bw_10/client.log: Global Timeout - Critical: =
sched-clientlim/06-balanced_bw_10/server.log: Global Timeout - Critical: =
sched-clientlim/07-huge_lat_primary_bw_10/client.log: Global Timeout - =
Critical: sched-clientlim/07-huge_lat_primary_bw_10/server.log: Global =
Timeout - Critical: sched-clientlim/08-slow_secondary_bw_10/client.log: =
Global Timeout - Critical: sched-clientlim/08-slow_secondary_bw_10/server.=
log: Global Timeout - Critical: sched-clientlim/09-slow_primary_bw_50/clien=
t.log: Global Timeout - Critical: sched-clientlim/09-slow_primary_bw_50/ser=
ver.log: Global Timeout - Critical: sched-clientlim/10-balanced_bw_50/clien=
t.log: Global Timeout - Critical: sched-clientlim/10-balanced_bw_50/server.=
log: Global Timeout - Critical: sched-clientlim/11-huge_lat_primary_bw_50/c=
lient.log: Global Timeout - Critical: sched-clientlim/11-huge_lat_primary_b=
w_50/server.log: Global Timeout - Critical: sched-clientlim/12-slow_seconda=
ry_bw_50/client.log: Global Timeout - Critical: sched-clientlim/12-slow_sec=
ondary_bw_50/server.log: Global Timeout - Critical: =
sched-cpu-preempt/01-shallow_primary/client.log: Global Timeout - Critical:=
 sched-cpu-preempt/01-shallow_primary/server.log: Global Timeout - =
Critical: sched-cpu-preempt/02-shallow_primary_cpu_hog/client.log: Global =
Timeout - Critical: sched-cpu-preempt/02-shallow_primary_cpu_hog/server.=
log: Global Timeout - Critical: sched-mem-pressure/01-bloated_slow_secondar=
y_receiver_tcp_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/01-bloated_slow_secondary_receiver_tcp_mem_parallel_1/se=
rver.log: Global Timeout - Critical: sched-mem-pressure/02-bloated_slow_sec=
ondary_receiver_tcp_mem_parallel_16/client.log: Global Timeout - Critical: =
sched-mem-pressure/02-bloated_slow_secondary_receiver_tcp_mem_parallel_16/s=
erver.log: Global Timeout - Critical: sched-mem-pressure/03-bloated_slow_se=
condary_receiver_tcp_mem_parallel_99/client.log: Global Timeout - Critical:=
 sched-mem-pressure/03-bloated_slow_secondary_receiver_tcp_mem_parallel_99/=
server.log: Global Timeout - Critical: sched-mem-pressure/04-very_bloated_p=
rimary_both_tcp_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/04-very_bloated_primary_both_tcp_mem_parallel_1/server.=
log: Global Timeout - Critical: sched-mem-pressure/05-slow_primary_both_tcp=
_mem_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/05-slow_primary_both_tcp_mem_parallel_1/server.log: =
Global Timeout - Critical: sched-mem-pressure/06-balanced_both_tcp_mem_para=
llel_1/client.log: Global Timeout - Critical: sched-mem-pressure/06-balance=
d_both_tcp_mem_parallel_1/server.log: Global Timeout - Critical: =
sched-mem-pressure/07-very_bloated_primary_both_tcp_mem_parallel_10/client.=
log: Global Timeout - Critical: sched-mem-pressure/07-very_bloated_primary_=
both_tcp_mem_parallel_10/server.log: Global Timeout - Critical: =
sched-mem-pressure/08-slow_primary_both_tcp_mem_parallel_10/client.log: =
Global Timeout - Critical: sched-mem-pressure/08-slow_primary_both_tcp_mem_=
parallel_10/server.log: Global Timeout - Critical: sched-mem-pressure/09-ba=
lanced_both_tcp_mem_parallel_10/client.log: Global Timeout - Critical: =
sched-mem-pressure/09-balanced_both_tcp_mem_parallel_10/server.log: Global =
Timeout - Critical: sched-rmem/01-slow_primary_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/01-slow_primary_rmem_200/server.log: Global =
Timeout - Critical: sched-rmem/02-balanced_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/02-balanced_rmem_200/server.log: Global =
Timeout - Critical: sched-rmem/03-huge_lat_primary_rmem_200/client.log: =
Global Timeout - Critical: sched-rmem/03-huge_lat_primary_rmem_200/server.=
log: Global Timeout - Critical: sched-rmem/04-bloated_primary_rmem_200/clie=
nt.log: Global Timeout - Critical: sched-rmem/04-bloated_primary_rmem_200/s=
erver.log: Global Timeout - Critical: sched-rmem/05-slow_primary_rmem_800/c=
lient.log: Global Timeout - Critical: sched-rmem/05-slow_primary_rmem_800/s=
erver.log: Global Timeout - Critical: sched-rmem/06-balanced_rmem_800/clien=
t.log: Global Timeout - Critical: sched-rmem/06-balanced_rmem_800/server.=
log: Global Timeout - Critical: sched-rmem/07-huge_lat_primary_rmem_800/cli=
ent.log: Global Timeout - Critical: sched-rmem/07-huge_lat_primary_rmem_800=
/server.log: Global Timeout - Critical: sched-rmem/08-bloated_primary_rmem_=
800/client.log: Global Timeout - Critical: sched-rmem/08-bloated_primary_rm=
em_800/server.log: Global Timeout - Critical: sched-rmem/09-slow_primary_rm=
em_2000/client.log: Global Timeout - Critical: sched-rmem/09-slow_primary_r=
mem_2000/server.log: Global Timeout - Critical: sched-rmem/10-balanced_rmem=
_2000/client.log: Global Timeout - Critical: sched-rmem/10-balanced_rmem_20=
00/server.log: Global Timeout - Critical: sched-rmem/11-huge_lat_primary_rm=
em_2000/client.log: Global Timeout - Critical: sched-rmem/11-huge_lat_prima=
ry_rmem_2000/server.log: Global Timeout - Critical: =
sched-rmem/12-bloated_primary_rmem_2000/client.log: Global Timeout - =
Critical: sched-rmem/12-bloated_primary_rmem_2000/server.log: Global =
Timeout - Critical: sched-rmem/13-slow_primary_rmem_6000/client.log: Global=
 Timeout - Critical: sched-rmem/13-slow_primary_rmem_6000/server.log: =
Global Timeout - Critical: sched-rmem/14-balanced_rmem_6000/client.log: =
Global Timeout - Critical: sched-rmem/14-balanced_rmem_6000/server.log: =
Global Timeout - Critical: sched-rmem/15-huge_lat_primary_rmem_6000/client.=
log: Global Timeout - Critical: sched-rmem/15-huge_lat_primary_rmem_6000/se=
rver.log: Global Timeout - Critical: sched-rmem/16-bloated_primary_rmem_600=
0/client.log: Global Timeout - Critical: sched-rmem/16-bloated_primary_rmem=
_6000/server.log: Global Timeout - Critical: sched-serverlim/01-slow_primar=
y_bw_5_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/01-slow_primary_bw_5_burst_10/server.log: Global Timeout - =
Critical: sched-serverlim/02-balanced_bw_5_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/02-balanced_bw_5_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/03-huge_lat_primary_bw_5_burst_1=
0/client.log: Global Timeout - Critical: sched-serverlim/03-huge_lat_primar=
y_bw_5_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/04-slow_secondary_bw_5_burst_10/client.log: Global Timeout =
- Critical: sched-serverlim/04-slow_secondary_bw_5_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/05-slow_primary_bw_5_burst_250/c=
lient.log: Global Timeout - Critical: sched-serverlim/05-slow_primary_bw_5_=
burst_250/server.log: Global Timeout - Critical: sched-serverlim/06-balance=
d_bw_5_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/06-balanced_bw_5_burst_250/server.log: Global Timeout - =
Critical: sched-serverlim/07-huge_lat_primary_bw_5_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/07-huge_lat_primary_bw_5_burst_2=
50/server.log: Global Timeout - Critical: sched-serverlim/08-slow_secondary=
_bw_5_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/08-slow_secondary_bw_5_burst_250/server.log: Global Timeout=
 - Critical: sched-serverlim/09-slow_primary_bw_10_burst_10/client.log: =
Global Timeout - Critical: sched-serverlim/09-slow_primary_bw_10_burst_10/s=
erver.log: Global Timeout - Critical: sched-serverlim/10-balanced_bw_10_bur=
st_10/client.log: Global Timeout - Critical: sched-serverlim/10-balanced_bw=
_10_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/11-huge_lat_primary_bw_10_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/11-huge_lat_primary_bw_10_burst_10/serv=
er.log: Global Timeout - Critical: sched-serverlim/12-slow_secondary_bw_10_=
burst_10/client.log: Global Timeout - Critical: sched-serverlim/12-slow_sec=
ondary_bw_10_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/13-slow_primary_bw_10_burst_250/client.log: Global Timeout =
- Critical: sched-serverlim/13-slow_primary_bw_10_burst_250/server.log: =
Global Timeout - Critical: sched-serverlim/14-balanced_bw_10_burst_250/clie=
nt.log: Global Timeout - Critical: sched-serverlim/14-balanced_bw_10_burst_=
250/server.log: Global Timeout - Critical: sched-serverlim/15-huge_lat_prim=
ary_bw_10_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/15-huge_lat_primary_bw_10_burst_250/server.log: Global =
Timeout - Critical: sched-serverlim/16-slow_secondary_bw_10_burst_250/clien=
t.log: Global Timeout - Critical: sched-serverlim/16-slow_secondary_bw_10_b=
urst_250/server.log: Global Timeout - Critical: sched-serverlim/17-slow_pri=
mary_bw_50_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/17-slow_primary_bw_50_burst_10/server.log: Global Timeout -=
 Critical: sched-serverlim/18-balanced_bw_50_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/18-balanced_bw_50_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/19-huge_lat_primary_bw_50_burst_=
10/client.log: Global Timeout - Critical: sched-serverlim/19-huge_lat_prima=
ry_bw_50_burst_10/server.log: Global Timeout - Critical: =
sched-serverlim/20-slow_secondary_bw_50_burst_10/client.log: Global Timeout=
 - Critical: sched-serverlim/20-slow_secondary_bw_50_burst_10/server.log: =
Global Timeout - Critical: sched-serverlim/21-slow_primary_bw_50_burst_250/=
client.log: Global Timeout - Critical: sched-serverlim/21-slow_primary_bw_5=
0_burst_250/server.log: Global Timeout - Critical: sched-serverlim/22-balan=
ced_bw_50_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/22-balanced_bw_50_burst_250/server.log: Global Timeout - =
Critical: sched-serverlim/23-huge_lat_primary_bw_50_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/23-huge_lat_primary_bw_50_burst_=
250/server.log: Global Timeout - Critical: sched-serverlim/24-slow_secondar=
y_bw_50_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/24-slow_secondary_bw_50_burst_250/server.log: Global =
Timeout - Critical: sched-serverlim/25-slow_primary_bw_10_burst_10_wmem_600=
0/client.log: Global Timeout - Critical: sched-serverlim/25-slow_primary_bw=
_10_burst_10_wmem_6000/server.log: Global Timeout - Critical: =
sched-serverlim/26-balanced_bw_10_burst_10_wmem_6000/client.log: Global =
Timeout - Critical: sched-serverlim/26-balanced_bw_10_burst_10_wmem_6000/se=
rver.log: Global Timeout - Critical: sched-serverlim/27-slow_primary_bw_50_=
burst_10_wmem_6000/client.log: Global Timeout - Critical: =
sched-serverlim/27-slow_primary_bw_50_burst_10_wmem_6000/server.log: Global=
 Timeout - Critical: sched-serverlim/28-balanced_bw_50_burst_10_wmem_6000/c=
lient.log: Global Timeout - Critical: sched-serverlim/28-balanced_bw_50_bur=
st_10_wmem_6000/server.log: Global Timeout - Critical: =
sched-weak-secondary/01-weak_secondary/client.log: Global Timeout - =
Critical: sched-weak-secondary/01-weak_secondary/server.log: Global Timeout=
 - Critical: sched-weak-secondary/02-bad_secondary/client.log: Global =
Timeout - Critical: sched-weak-secondary/02-bad_secondary/server.log: =
Global Timeout - Critical: sched-weak-secondary/03-far_secondary/client.=
log: Global Timeout - Critical: sched-weak-secondary/03-far_secondary/serve=
r.log: Global Timeout - Critical: sched-weak-secondary/04-bloated_secondary=
/client.log: Global Timeout - Critical: sched-weak-secondary/04-bloated_sec=
ondary/server.log: Global Timeout - Critical: sched-weak-secondary/05-bloat=
ed_slow_secondary/client.log: Global Timeout - Critical: =
sched-weak-secondary/05-bloated_slow_secondary/server.log: Global Timeout -=
 Critical: sched-weak-secondary/06-very_bloated_secondary/client.log: =
Global Timeout - Critical: sched-weak-secondary/06-very_bloated_secondary/s=
erver.log: Global Timeout - Critical: sched-weak-secondary/07-weak_secondar=
y_backup/client.log: Global Timeout - Critical: sched-weak-secondary/07-wea=
k_secondary_backup/server.log: Global Timeout - Critical: =
sched-weak-secondary/08-bad_secondary_backup/client.log: Global Timeout - =
Critical: sched-weak-secondary/08-bad_secondary_backup/server.log: Global =
Timeout - Critical: sched-weak-secondary/09-far_secondary_backup/client.=
log: Global Timeout - Critical: sched-weak-secondary/09-far_secondary_backu=
p/server.log: Global Timeout - Critical: sched-weak-secondary/10-bloated_se=
condary_backup/client.log: Global Timeout - Critical: =
sched-weak-secondary/10-bloated_secondary_backup/server.log: Global Timeout=
 - Critical: sched-weak-secondary/11-bloated_slow_secondary_backup/client.=
log: Global Timeout - Critical: sched-weak-secondary/11-bloated_slow_second=
ary_backup/server.log: Global Timeout - Critical: sched-weak-secondary/12-v=
ery_bloated_secondary_backup/client.log: Global Timeout - Critical: =
sched-weak-secondary/12-very_bloated_secondary_backup/server.log: Global =
Timeout =E2=9D=8C
- Task: https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/40833566301

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/70b5a2f58d=
ad
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195955


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
