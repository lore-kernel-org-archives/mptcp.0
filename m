Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766380;
	b=qmrF24NB8ms0TJkI1P/FIEhvlKOuJWg94iPmwxQw6+hFSW0GnfY43WpKhwocMDQnQIN5
	 RrO2Q3Gr2uT3qJ80Sj+/+RNjhInYH9jn/b4QYvubOxy7VQ+zqoQboz4oJmcHCGcBaIwOk
	 FHXRFjnF5jzo9NGNsxGymRQa37ZJ9Et0WIZNPp+wPh34D4IquLwAplwADHVq3aEWPY4+/
	 Px5S4L2qjzjJvpQdj1rs18XzGpJSc08fI6HW8erdXDnBd93GZLIm33mLhDF2zphOsF0/5
	 w4wW0xmykkQbGnuYGSIEqmLgiJyuODejjhprcPSPvhVJfJge+xy/vCnBLTlTxYpzS2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=yH8TP4qnZjGEZc3NaKcKkQWE2fYLrpBH3QaIFKxCFBA=;
	b=DNJ9mfIztzHdAmIkpeV4SIE3uE0yTcSdtDIImiS3bkEW5UCcOyMxf61hq1yXht4DVtYr
	 SY7u7P0lHaRh3DqEHLI9ORKOctCKcZQZog4TyDw1pnEBRRncDXVdqilXTDIqOf+ovErtI
	 xSgXhs9VFK+IagbbcApr8SgIg3IG3zsGZosC3QUcSKHn25oqudPqUBBVDqPQAZbuRWr3j
	 bitVaw4GnquM+tCTSZzlmVcFKXRjxYKhvi4Icrfm4NsDS959X89X6GFjRwoUZXdfAyxpi
	 XDPjlDgoRBrd9BKmMY6fOiabto5ziZU9tfs+kyxN28uV8t8sOQQBvhx/pwWwNtlhs6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFqBiy40;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F0606A326
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 04:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFqBiy40
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c162febb9so3411306d6.3
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 20:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793766379; x=1794371179; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yH8TP4qnZjGEZc3NaKcKkQWE2fYLrpBH3QaIFKxCFBA=;
        b=mFqBiy40Tjnbw03ihwtpGcsBoww3sUh425uVjbSPUFYLEvr1vZzCCR8dFcMNQElKKl
         XJZZcLoOwPHAbnkq86Vl7A5NQZ093Z9ti5jcGF19k+KwF5JyNBpJUSUNNgX6vc7X+WEK
         BOBg2o8mMkHZqGAxe7Q5rU4OaEI/gP52GUbZ18V/EedV7S9woAOxhNfGFjMdqzYYata4
         fnpPOhL/vxnoX5F8Kuz8fu3bs7YsH69yHBENqTopK/Z/DxA0ZgkhFFyJptBQW/aGGToK
         LPqgdwRYLduKTc6dyji2A1NAURnkZLnRrDOws4zuAqr+tvypS35dtPv0y3Jh54rzvGiq
         07ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766379; x=1794371179;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yH8TP4qnZjGEZc3NaKcKkQWE2fYLrpBH3QaIFKxCFBA=;
        b=oMXr33QdgOFarQhFSn+La4T9zH8uLkuB5bDWnUlj0oF0JZLmprupqYC3phJPFuVdsO
         TO35T9FE8paXRhwuv58dneMFRKeYqFteTjFsdmiXOwd61q4/EgsGaUru8jkK5Yzjg4pG
         ihSx5gId3DzE+OuWulG8IpILXJBx1vVgHSnTUccjXIR4Cqr6n0prJ5+Fa6kvr5Stqx+W
         HDs4yhKSofhUwfMFXlig37l42VaNRJ+1JiPoGLvhaz/ceCQv3ylPLbmjGLG9AxQ2y5tI
         xjYIdg2/hF0CAVVRWpix8OVRj84C0gIXR3DVzIa7Y0217LtxIcuQ/72fUKkshkIvefgC
         emsQ==
X-Gm-Message-State: APuU4Z/nGp8wlFJOw5tyIzJerl5EWWBPAgyTqz3GjXJ3f0/oBJli8EbQ
	PXRRFpPk4/M/fdOGWdIJbzOZCWmx0plF6CZiDa9UKX2DjF3HiLj+m+133+YRnAxBXQ==
X-Gm-Gg: AYBFou1s8reqUJdeTn+IbQD0pclA6J+tDZCPZE7j2f42fiu+kpYq8hAEUeXkj1QtO8C
	fLw04BPewyz2IPnhDZgn5fyAdXM1qnD7kxmnkzQlfjDUfA7BDgIRdvdc+hQLIdBL4t9jJQjaQvY
	2FPULlL1jzZZPVV+O/blYjfIGDdd+slRbaPaD/QY5lhlAFuaG5TAvEVs61smnR+3bmqdppoq9uJ
	xDxO69b2sOcezPNa95tv9ZC7Vdc7ZIvN1/K2Rqtq2QxnLdifCAW+DAW/b7hNFwLBxxItM88sUXa
	q8BNhAtFIRH1SEdu/cstOTyBxxuISvlfMyp7ZEHkQjHld97Noak3+7flzD3v/i1JA7C+FuB6Oj9
	ORJm97Xn1dhFfZDfzkpBazyh20VPhHd/thYne1icVACbLjUCRO1bj8d0yjg1qxHX18rgzmabemK
	uGf+dfHRWT8BQGU7J6DXq1GKhHOE6FoCPskzDK6OY4VsU5Jn59/atCuuOTTL75kzrRv934NxooN
	rjqCIJ6fFvBW91g8xFb89xOaVz6j8zKG35BBVgtr/INf1eJLfSLFeuqqLD8lAzBUBmoPHiY9drQ
	F2Jf4eduZTtt18Ztc8zWTJml24Hszquu/ifGGYr6Kg==
X-Received: by 2002:a05:620a:838b:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-944217c8512mr2416925185a.63.1793766379163;
        Tue, 03 Nov 2026 20:26:19 -0800 (PST)
Received: from github.com ([48.217.35.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm105809485a.3.2026.11.03.20.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:26:18 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <auqd0rAI95jDSMvu@v4bel>
References: <auqd0rAI95jDSMvu@v4bel>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix use-after-free of the subflow
 context on the delegated list
Message-ID: <3b3977d7-a1a4-a906-6254-f101a91c9ae9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:26:17 +0000
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

Hi Hyunwoo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 9 failed test(s): error:mptcp-perf =
error:sched-baseline(18) error:sched-bbr(14) error:sched-clientlim(12) =
error:sched-cpu-preempt(2) error:sched-mem-pressure(9) error:sched-rmem(16)=
 error:sched-serverlim(28) error:sched-weak-secondary(12) - Critical: =
mptcp-perf/01-Test_1/client.log: Global Timeout - Critical: =
sched-baseline/01-slow_primary/client.log: Global Timeout - Critical: =
sched-baseline/02-tiny_primary/client.log: Global Timeout - Critical: =
sched-baseline/03-fast_both/client.log: Global Timeout - Critical: =
sched-baseline/04-balanced/client.log: Global Timeout - Critical: =
sched-baseline/05-slow_near_primary/client.log: Global Timeout - Critical: =
sched-baseline/06-slow_secondary/client.log: Global Timeout - Critical: =
sched-baseline/07-very_fast/client.log: Global Timeout - Critical: =
sched-baseline/08-shallow_primary/client.log: Global Timeout - Critical: =
sched-baseline/09-high_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/10-huge_lat_primary/client.log: Global Timeout - Critical: =
sched-baseline/11-high_lat_secondary/client.log: Global Timeout - Critical:=
 sched-baseline/12-huge_lat_secondary/client.log: Global Timeout - =
Critical: sched-baseline/13-bloated_primary/client.log: Global Timeout - =
Critical: sched-baseline/14-bloated_secondary/client.log: Global Timeout - =
Critical: sched-baseline/15-slow_primary_upload/client.log: Global Timeout =
- Critical: sched-baseline/16-balanced_upload/client.log: Global Timeout - =
Critical: sched-baseline/17-slow_primary_parallel_4/client.log: Global =
Timeout - Critical: sched-baseline/18-balanced_parallel_4/client.log: =
Global Timeout - Critical: sched-bbr/01-slow_primary_bbr/client.log: Global=
 Timeout - Critical: sched-bbr/02-balanced_bbr/client.log: Global Timeout -=
 Critical: sched-bbr/03-slow_near_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/04-high_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/05-huge_lat_primary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/06-high_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/07-huge_lat_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/08-slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/09-very_fast_bbr/client.log: Global Timeout - Critical:=
 sched-bbr/10-bloated_secondary_bbr/client.log: Global Timeout - Critical: =
sched-bbr/11-bloated_slow_secondary_bbr/client.log: Global Timeout - =
Critical: sched-bbr/12-very_bloated_secondary_bbr/client.log: Global =
Timeout - Critical: sched-bbr/13-bad_secondary_bbr/client.log: Global =
Timeout - Critical: sched-bbr/14-far_secondary_bbr/client.log: Global =
Timeout - Critical: sched-clientlim/01-slow_primary_bw_5/client.log: Global=
 Timeout - Critical: sched-clientlim/02-balanced_bw_5/client.log: Global =
Timeout - Critical: sched-clientlim/03-huge_lat_primary_bw_5/client.log: =
Global Timeout - Critical: sched-clientlim/04-slow_secondary_bw_5/client.=
log: Global Timeout - Critical: sched-clientlim/05-slow_primary_bw_10/clien=
t.log: Global Timeout - Critical: sched-clientlim/06-balanced_bw_10/client.=
log: Global Timeout - Critical: sched-clientlim/07-huge_lat_primary_bw_10/c=
lient.log: Global Timeout - Critical: sched-clientlim/08-slow_secondary_bw_=
10/client.log: Global Timeout - Critical: sched-clientlim/09-slow_primary_b=
w_50/client.log: Global Timeout - Critical: sched-clientlim/10-balanced_bw_=
50/client.log: Global Timeout - Critical: sched-clientlim/11-huge_lat_prima=
ry_bw_50/client.log: Global Timeout - Critical: sched-clientlim/12-slow_sec=
ondary_bw_50/client.log: Global Timeout - Critical: =
sched-cpu-preempt/01-shallow_primary/client.log: Global Timeout - Critical:=
 sched-cpu-preempt/02-shallow_primary_cpu_hog/client.log: Global Timeout - =
Critical: sched-mem-pressure/01-bloated_slow_secondary_receiver_tcp_mem_par=
allel_1/client.log: Global Timeout - Critical: sched-mem-pressure/02-bloate=
d_slow_secondary_receiver_tcp_mem_parallel_16/client.log: Global Timeout - =
Critical: sched-mem-pressure/03-bloated_slow_secondary_receiver_tcp_mem_par=
allel_99/client.log: Global Timeout - Critical: sched-mem-pressure/04-very_=
bloated_primary_both_tcp_mem_parallel_1/client.log: Global Timeout - =
Critical: sched-mem-pressure/05-slow_primary_both_tcp_mem_parallel_1/client=
.log: Global Timeout - Critical: sched-mem-pressure/06-balanced_both_tcp_me=
m_parallel_1/client.log: Global Timeout - Critical: =
sched-mem-pressure/07-very_bloated_primary_both_tcp_mem_parallel_10/client.=
log: Global Timeout - Critical: sched-mem-pressure/08-slow_primary_both_tcp=
_mem_parallel_10/client.log: Global Timeout - Critical: =
sched-mem-pressure/09-balanced_both_tcp_mem_parallel_10/client.log: Global =
Timeout - Critical: sched-rmem/01-slow_primary_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/02-balanced_rmem_200/client.log: Global =
Timeout - Critical: sched-rmem/03-huge_lat_primary_rmem_200/client.log: =
Global Timeout - Critical: sched-rmem/04-bloated_primary_rmem_200/client.=
log: Global Timeout - Critical: sched-rmem/05-slow_primary_rmem_800/client.=
log: Global Timeout - Critical: sched-rmem/06-balanced_rmem_800/client.log:=
 Global Timeout - Critical: sched-rmem/07-huge_lat_primary_rmem_800/client.=
log: Global Timeout - Critical: sched-rmem/08-bloated_primary_rmem_800/clie=
nt.log: Global Timeout - Critical: sched-rmem/09-slow_primary_rmem_2000/cli=
ent.log: Global Timeout - Critical: sched-rmem/10-balanced_rmem_2000/client=
.log: Global Timeout - Critical: sched-rmem/11-huge_lat_primary_rmem_2000/c=
lient.log: Global Timeout - Critical: sched-rmem/12-bloated_primary_rmem_20=
00/client.log: Global Timeout - Critical: sched-rmem/13-slow_primary_rmem_6=
000/client.log: Global Timeout - Critical: sched-rmem/14-balanced_rmem_6000=
/client.log: Global Timeout - Critical: sched-rmem/15-huge_lat_primary_rmem=
_6000/client.log: Global Timeout - Critical: sched-rmem/16-bloated_primary_=
rmem_6000/client.log: Global Timeout - Critical: sched-serverlim/01-slow_pr=
imary_bw_5_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/02-balanced_bw_5_burst_10/client.log: Global Timeout - =
Critical: sched-serverlim/03-huge_lat_primary_bw_5_burst_10/client.log: =
Global Timeout - Critical: sched-serverlim/04-slow_secondary_bw_5_burst_10/=
client.log: Global Timeout - Critical: sched-serverlim/05-slow_primary_bw_5=
_burst_250/client.log: Global Timeout - Critical: sched-serverlim/06-balanc=
ed_bw_5_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/07-huge_lat_primary_bw_5_burst_250/client.log: Global =
Timeout - Critical: sched-serverlim/08-slow_secondary_bw_5_burst_250/client=
.log: Global Timeout - Critical: sched-serverlim/09-slow_primary_bw_10_burs=
t_10/client.log: Global Timeout - Critical: sched-serverlim/10-balanced_bw_=
10_burst_10/client.log: Global Timeout - Critical: sched-serverlim/11-huge_=
lat_primary_bw_10_burst_10/client.log: Global Timeout - Critical: =
sched-serverlim/12-slow_secondary_bw_10_burst_10/client.log: Global Timeout=
 - Critical: sched-serverlim/13-slow_primary_bw_10_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/14-balanced_bw_10_burst_250/clie=
nt.log: Global Timeout - Critical: sched-serverlim/15-huge_lat_primary_bw_1=
0_burst_250/client.log: Global Timeout - Critical: sched-serverlim/16-slow_=
secondary_bw_10_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/17-slow_primary_bw_50_burst_10/client.log: Global Timeout -=
 Critical: sched-serverlim/18-balanced_bw_50_burst_10/client.log: Global =
Timeout - Critical: sched-serverlim/19-huge_lat_primary_bw_50_burst_10/clie=
nt.log: Global Timeout - Critical: sched-serverlim/20-slow_secondary_bw_50_=
burst_10/client.log: Global Timeout - Critical: sched-serverlim/21-slow_pri=
mary_bw_50_burst_250/client.log: Global Timeout - Critical: =
sched-serverlim/22-balanced_bw_50_burst_250/client.log: Global Timeout - =
Critical: sched-serverlim/23-huge_lat_primary_bw_50_burst_250/client.log: =
Global Timeout - Critical: sched-serverlim/24-slow_secondary_bw_50_burst_25=
0/client.log: Global Timeout - Critical: sched-serverlim/25-slow_primary_bw=
_10_burst_10_wmem_6000/client.log: Global Timeout - Critical: =
sched-serverlim/26-balanced_bw_10_burst_10_wmem_6000/client.log: Global =
Timeout - Critical: sched-serverlim/27-slow_primary_bw_50_burst_10_wmem_600=
0/client.log: Global Timeout - Critical: sched-serverlim/28-balanced_bw_50_=
burst_10_wmem_6000/client.log: Global Timeout - Critical: =
sched-weak-secondary/01-weak_secondary/client.log: Global Timeout - =
Critical: sched-weak-secondary/02-bad_secondary/client.log: Global Timeout =
- Critical: sched-weak-secondary/03-far_secondary/client.log: Global =
Timeout - Critical: sched-weak-secondary/04-bloated_secondary/client.log: =
Global Timeout - Critical: sched-weak-secondary/05-bloated_slow_secondary/c=
lient.log: Global Timeout - Critical: sched-weak-secondary/06-very_bloated_=
secondary/client.log: Global Timeout - Critical: sched-weak-secondary/07-we=
ak_secondary_backup/client.log: Global Timeout - Critical: =
sched-weak-secondary/08-bad_secondary_backup/client.log: Global Timeout - =
Critical: sched-weak-secondary/09-far_secondary_backup/client.log: Global =
Timeout - Critical: sched-weak-secondary/10-bloated_secondary_backup/client=
.log: Global Timeout - Critical: sched-weak-secondary/11-bloated_slow_secon=
dary_backup/client.log: Global Timeout - Critical: sched-weak-secondary/12-=
very_bloated_secondary_backup/client.log: Global Timeout =E2=9D=8C
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/417659=
50382

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a266ac33c6a5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1201254


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
