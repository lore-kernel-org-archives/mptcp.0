Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263959;
	b=imlBQt5evr8LhkyO566qJbT4Anb1mmY8YhB0R0qWnOvc1y/PTAE1mWU1G4seEFhGvkD7
	 m6H+AzfUQDIaoboBQ4C2FSQ52Hqm0HuQCQFPsP85/tAEZBc7GopN1zUvae7Pnlzj+mtJO
	 V9WOU7+tCNXrecaJ3m5NyMw/xvAoGjUG1dyM8VHyg14bRYPk0kmvJXpM/lWVVKAuAPzbL
	 wsgVIFtwhjrlNgY2oPdSG7UAiOuuCJKOEcorbHAkrJ6pMIaaXg9JmGmJ0htRIWmWYyKk8
	 6HAjRRdFquwmP4R6LczuKJu56FdHAfqt3yB3QufU8P1HrqSXCnePsCGclx1TJZeHA0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=RjXvpislXJQ2Gc054tDpaZHXSAuDT7Nd0hMiT3oH3V8=;
	b=0ck79BBgoG8dIyzO/FmNxaUq25vQgOfmmZu7MML4TSqg8LaVss6X4ZWaez74jKOkbeGj
	 DTuVNaLxGw8UG3rhjqCzk77cbvm+M07/3oCdkTk7TW2rV7mkzHb4v4NqFK4MGhiATLwf8
	 jbXyfFNZL1D6N4ojCC5yI7FQYbI5Cn3U5ziMe5GFAl3WV2X7JPmRLEHR/e20fGo2jhT+B
	 SgK/R+32I7tFXDA0yo5ZkMeDL1V38286jD96NJaO5vHQg5b8TDSVQIBARRGV7d2Mv340f
	 dCJiph0cguns3Lmhu7zGKkXjd/NfWBmrj527C57LSmebjNV5h6ttvNZkWKoGMD3skDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwfiMwBU;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9691606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 08:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9691606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwfiMwBU
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1512284a91.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263958; x=1793868758; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RjXvpislXJQ2Gc054tDpaZHXSAuDT7Nd0hMiT3oH3V8=;
        b=gwfiMwBU5vzfO15ivqPTIXR6Th5uUZJtzr3txlqQ31Nvl6NpfHr11wAdY1zFi4jmbO
         Iqkag3NKef1pMBAMuX4HuvWgdi1ZZ0mAC6hbzvOUqkBMMIE5F3Ov1V5vNoU/zqXqLHGX
         PCLMydeBuWBXEDp6SeQDDSah3wJyhmUeyhrCYZ6XNrEmjO6b5koh4qBKe3rHaFZFO8vG
         cZNwd71AtqwO/TgWUxlVsqQuGK8RoUVOrCDE+mUrlBi4nrFrS2VDsUr65I2nwuVCorox
         1VRlrFc0TYse8HVXVwkdIp5zexKDRR48+Chnkl26vSqbwm/ucvDZ5CifhlVQSZVRlpSF
         /GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263958; x=1793868758;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjXvpislXJQ2Gc054tDpaZHXSAuDT7Nd0hMiT3oH3V8=;
        b=fs4WrclK8HPACjS2bpDW+IIEEz+6B6MrPMoelnwMEf+heLwnOI1LhcrfbNXe28anfo
         ghdxRPYk3mm90wjWUufkPLc5hkQTrZoHA2RQXxRJpzFzoYxvI6T0kZ+2BsCEF0PmcA1o
         m+G6wDoCxZepDcUGBzoR7YI+oGiScIYWYynaNl2SaTdZDkY0UYS54/vWVqCYrjrmgPAa
         rsgk3YoMM78eDgiBYhxVx+KeqZHduenpE9oqT9LgeRupWOhx4XCBBU1N73maCHguaKyN
         QtealVgVaLnZMGzWS3Zx1kB+MacptKZlM7NiIh74yOq4FfpyuQaaYpYisvIsgPs4MIHe
         4rxg==
X-Gm-Message-State: AFq9FYLUyplwzVKuciqcUwxvadZ0AYQeySWpZ3D0ARG8eUv4qgnX6Pjv
	8KuehQQFAD5AJ5qVqit0jOvi//+1nwTcYM0lKKk4ehSqfwdE5GOBv2nn74/u
X-Gm-Gg: AYBFou3UsaztsqpTATgkoMhWdPgXkRelrwbuTa+t93/F/6g4yvohv1mtNJq2XGVInj1
	dhqBcSqopSejZgGihxSAYccwn0LufrAgwIq4OUEyUrhnZ0K913PdqtjpqR2bVJnRsR7+JYqjJ8m
	LmWdbNEm/cR3sTzBd77EeTpwxh+JD27rkyXK84p7l6cd88zMMgJJwGd9vnpniDLdLyMJwFchynW
	yX4kxvoE6W50BoJxtxNS+Ajw1RhcUFFLHLfN2qIvwcyU8d5q1Mo7J+vBrHv/iIWvaW+y8qFongr
	khAu3Q//O5oG4pQ8Bo0SP2nsxY9mXDDLqBfPpQm/CuIIxckUTHuU24JokjECYa2HLE9Q9PNvClX
	dCuTYe2uAozgt8p6FG8CklltNAgwbTp1e3NlBsVBgt5hVCpZKxYgQMtEd83ZAi4y6ANieZ3c6Se
	wrtOCkFusT/bRl/lQ8xGDwuyM369E/J8m4uYwdRcrjJsROy4Dh70Nbp4mVMLMt2tHZHSiWDYHW8
	R/Uz81+Pna5VuiLO/tw4WUVDvtCk68Uh/+whGsltwXrCYbXrmeV3Bw8wBXnA9YCpjEDBKpdbWxw
	Gay/CXHt1sN4w53VsHx00y8sjmLRq79D/2VvLLRVIul7
X-Received: by 2002:a17:90b:1845:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3ae580a02b0mr3843968a91.31.1793263958185;
        Thu, 29 Oct 2026 01:52:38 -0700 (PDT)
Received: from github.com ([172.184.209.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6454a37sm31386325ad.3.2026.10.29.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:52:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <pm-mptcp-objects-candidate-0010-v4-f64139fe98063730da45@gmail.com>
References:
 <pm-mptcp-objects-candidate-0010-v4-f64139fe98063730da45@gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: free delegated subflow contexts
 only after they are dequeued
Message-ID: <d5f80908-0f9a-41f2-9d8a-9d09ec8d5de0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:52:36 +0000
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
ctions/runs/40833663572

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/28aeb037d7=
d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195956


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
