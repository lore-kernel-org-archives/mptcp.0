Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263346;
	b=DpG7z3eZ3d83GY5Mgdd7olHX1+884aFQhnqSkVicqGzuvC0u1YYF1P1lsBsvOtGjx30Y
	 dHNqUO/GKykxQR1u5BRKDOShlFqhGMvjw1UiDIQDWF/UQ9erA7FZb3SpqPNSVzqPpQGUU
	 BnjmtCtaBOg0Lgecp1HnCZ0Zx9V9V6sTRtLXj0SrfpHaehHeDPGjPznmOO5Fy2pOMtjPJ
	 GZ8bEQhYG5tNM6O+Hk2WMkyvR8R0TANwjLPHx8wrH8Kktx8JVgm+Eb+wAOccc/UtaY32K
	 irkQOCCu3jhMGWDW6m9eP3J2JZgCOg2zOYV1YSbu6kzP8AwcnOrMdQLTc/9fsF72cKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ChhMg/p3nyhrT34sk9P2Iu7AwhG6435U3SG8CsHiISM=;
	b=hBL4BIJ6bz6dNe5GyJjrNRH8gzLlAtVOYmYYMIPmSDb42yup3NUMI6x32iFJ7S7bF6kS
	 /9fwQzGt7aaCFCewpJWK3xswJyXKpnmDMcCNDv5B0UV9dFHUfmf23Jm/iT0qCiMqLvKUt
	 vE4/08JGkBTcy3NPKXZ8dYT+nCR57zdrBjvVBcko0y+JmFPxip/kDo1Y4OKrScZ8IOgaW
	 GVKo1UR/ZXaL/J8xrTXzDrbWVzJy6/qGix5w1Cx2iHDw3RJU4klVugrSRp8XqfIJXJF8b
	 Lw3//Iz+OV4B9+aFt3qhXahvHYk1mSgUnAWcLbgHJHufqwJufBHbp1nnljDBjSWYxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kpaoEc/a";
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF1606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 08:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpaoEc/a
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-7143451981fso892115eaf.3
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263344; x=1793868144; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ChhMg/p3nyhrT34sk9P2Iu7AwhG6435U3SG8CsHiISM=;
        b=kpaoEc/ajZ6nwQSJBfIvJjR67FcZm+CScLXazU3xnuC9DrIHC/A1KTASrJC8OEFDx7
         V88/VVyTLA2MCa+54OHV7I70xWs1PZBmIW8jKj2hsShf2Ps5mqAibedkZ5AtiodOVxd6
         BusIazgZWGPqBtxOWpAJh/3qcMlCgA6jRSci5KRpGXa8XCTJ3VWPhIKVt+YmYhOFIyuN
         /hBVuaHk3ybLUhdHd8utxABExOeBdL721ILEfvYNVZv4hCxcP7sWjXr2X0baaHJpSFLc
         9oIfPgJvmzFE6Whk5rU+Jty77j+ZattgiDDoN22+awhPxHFfKtCPX1lCn34YptYSrUjJ
         rtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263344; x=1793868144;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChhMg/p3nyhrT34sk9P2Iu7AwhG6435U3SG8CsHiISM=;
        b=MQiaoA+wq4OeQ9fzcKAhZK7eht0Zvfoqu6qPmGUME1FCjY1NvA1qtwBSzYINLIzXpJ
         2NA1olzOjTkBDqM8lyj1Ad4PU+zs1AegAYbPtXOFnOf3WauOnJ9W8Qi5slRF1SUf4rvX
         gu7aLZul9zuod/u5dsDeZfx1tgKtNShpN7978g0HIQUr/vOpps+vRRA03uf5ezKgV+zz
         ow5fFOtTKXtthXy9qh/D3Kea6VK9MqoUNd969Y51NYh4iLqFiYQLYJLJLhqEQuWchtf0
         1L3ZdrAWo6hmh7LuXAGndO3TdxUpBFIX8guXCD1pYVPimE/EK9R9/FSQeVpd1pVjs3xW
         ZeRw==
X-Gm-Message-State: AFq9FYLUpaJJIEAn0n8HfN1IX8KZBidX1CtlTpzkgP0sq/XBsIjug3TL
	QNlsc2duQr7CaN4KHNdF8oxhYFcjVwc0OM3J7vLHuk60mWrMS82G4Bw=
X-Gm-Gg: AYBFou3EB8tE8aFwZal5ueI4HX5N48NqoJZP55IwDYqrmNpHyu4suFEoTFgX4D63pcS
	xhrr2kogeMR7PfQ5HKKsgMLfFbJouz2Orpf8QJLjSsLOyD2BOzy8i2HNs8Rgdd5H9TQ7Rv1xBue
	Q8n4mULaCW86apENKk7hV00XaWh/gwrZnUI85d/KrCi6y2eW0RgYnhRpovsXzx7qshxDAXeMOBq
	CllvoxMTwjmF8rwgGSZ0wECNHtJ5ykIp2l9yBhik6h40FAiAeyAB0ob9jZiV91fOkyhljFQjtCF
	ERLuo0dZIdhOEGvWnDUf2CFNBSAU6dUFeSzJb7lR9vf8R8y+oNSrT7y6F8lsJZoxceVAZMGauPv
	yMnV28Amq9olQvEYbpwNvxaFLZ33EveAoy//ypSGMqS70+nmvkKwSJWZfSsTnIFkyU6bCblxHSc
	FK0fyYUOUXyPVfODIIiDddDaATQ2oeWPZJId9LIrZ2yxYUsCGISachexocWmUQaSDKcLYA5NJpy
	pA+gT23irAp/7ttXCRHSA1CqpUffdVBQjoM894x+ShT52GolYppFAjFX7o4KhK7OExW4ixHfyPy
	nhyoxLB8w/eJvz3SvfB+1LEOYmDbG1bhYmyGnysO
X-Received: by 2002:a05:6820:1c81:b0:6b1:6636:e919 with SMTP id 006d021491bc7-713eb554b6amr2989586eaf.11.1793263344337;
        Thu, 29 Oct 2026 01:42:24 -0700 (PDT)
Received: from github.com ([20.84.246.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71426f16f66sm3414924eaf.0.2026.10.29.01.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:42:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793255126.git.tanggeliang@kylinos.cn>
References: <cover.1793255126.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v16 0/4] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <57574db2-4070-9aff-cfab-0a8d5c31da46@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:42:22 +0000
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

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_syscalls selftest_mptcp_sockopt =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): validation: - Critical: =
mptcp-perf/01-Test_1/client.log: Global Timeout - Critical: =
mptcp-perf/01-Test_1/server.log: Global Timeout - Critical: =
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
ctions/runs/40833457021

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/50ce0a995d=
da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195957


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
