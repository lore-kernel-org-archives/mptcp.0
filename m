Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727361;
	b=fBZOT5OJgj9LUE0uPcL1titQlCrwaoB93I2b9fuOXF3MjPuQoE7g62Wi9N2akyFYwBS8
	 D13OU+OeMUDwNBE75AdH2nY6HR/wQqVhfXz2OUKBBIoMvyPOFCvbL+gStWb1R3JxqZClS
	 oIdcIfUFRd4sYvrO9L0vqOAXYntZ7/+4utni3M5pOSDgpzD5NgMfG/nCHXZWazEn1rh9G
	 f4lfwm51RCt3RBWUPMw25+DV3vf5uCTVPTK11dA/Gl3T61lXupMpDGUC+7wBijQv5OdUr
	 D72fmlHMYuRRGQrtSL0+/tO/YpkcW7f/1/G2PaJrRFGMgWC/M9VjMGaPASIgnsUruig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=t+GFv/2yksi2f/DhmbxEOYxoEnCe/Gr94SO3bxZVFPA=;
	b=dhIrCj38oZdZKlUVJOKcps8nq0CeUjJ9SMUr9DSEnwEh+9OH5x8pitb9qG5TPLpQYU21
	 vbJaAAAYDa/VTRDxIO9xPK5sTnGLRWfKI4Pk4vSmZzuzqjcwlBm6QRgQWcPziKjVAgXvP
	 YZ3guVE8R9sxIld4fLMxzHaKYvL8y7DqYnuFFHbgtdnhqGcGMg2iHCEmYvbsHkiZv1q7O
	 5yxdjAUi2L5pyjLZT8eGPFU+y4LubWoAwdajSwDWlFk64uU2zPGGTHl6WTN1DONg3aZAe
	 FyEYsXM7jjD/s7YXFDJigpRzEyae3qNnb/KnhR49G2v4mWT1gx+5i44fDG3DMMYpkIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3cP1Cnz;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92A606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE92A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3cP1Cnz
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-702fd86d674so2972076eaf.2
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727359; x=1794332159; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t+GFv/2yksi2f/DhmbxEOYxoEnCe/Gr94SO3bxZVFPA=;
        b=m3cP1CnzXGzt0LWdUTLOfkjugIo8Wx3uecv7qxDp65OejBRDCPUkC0ZrI91pORbJwb
         yB17YA+jAPMhPZj90HAXwnf7DBnW9FPwgEBeeVefl89J1PGgQSyH0VV9Wq68Bf5Rrp5M
         0tbxdvEnzFK2aOsN0nCMpatVHV/az7Pjiux/ClDAViDXHLl2SiGZVBCnL4/E9Mc96NHP
         QfDklvtbUf1LjKD2yM+JrmEpxRo/ArmlLsRAvcXJVhqqB9heogGMxsC3LW3sRFreG/r4
         ED3Gj+asSta1pQNDZ9KZGRB0ryG8wsq02NSRDTTqDdJ+fn36TBm9PRV+FWcR9UBV/Dgu
         F1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727359; x=1794332159;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+GFv/2yksi2f/DhmbxEOYxoEnCe/Gr94SO3bxZVFPA=;
        b=wXHE6f8mfnFc0m6qkallCKMexmdsRoMrVxriPzKKvjADNLdCZmSHMVp2vJUxoLo7Fk
         AUYwaI5oVmFZTG7Sco0W1mmcai+5jSiPl6TD6zYCg213ekZGYi160a+kbTcNlc5UyFPK
         17pmjnXsCfiOf9glVoi6V2p5gZb0nFx08R1XSD2FWS1xQwLB4h/Z2POYU784VVNv2S2s
         zrERFZSrWUDfBuGyCB5TsWqJH38WENmOaZNYLxA4PnlHY89dHBX5gVTCRTJHfMKNLvzy
         z8AMmNpvdQpAZXTXc7+fdUWEeHLjZUE0xVeS2QTUPu/wl36a8x17cWONkThtFNt0gCNO
         8LOQ==
X-Gm-Message-State: APuU4Z8IPwZNFaht4tLnfDgygqeOZuTXYADMf6CFkBNnmwx/c7BBfkTC
	7B3xjPP/rn3WK+VdN8fDfO22+bwsC/+Ob4jMXNAvQ5wy8XFd8DsLVls=
X-Gm-Gg: AYBFou1LKbvWMhFpn9ptBYxUEqXDre0grXoFJNaOKtPVVeq1o4r9nUk/ZRxCeySRefk
	7pOYnVwQcNRhvBxmmcA9bq9PdiL0Dfs8BgIZBlk4iWpbOI5fD8mwMYKT+Mdc6t7hQJBI5DwYUVn
	PipHHTO0iGqQJ/cHBuJ51Trk8GEOj0d1AfokiN5lras2Z+0DQBP/XVnRggvlIIx1BCBnY73jiPb
	0jcuD9Bf6dMbQnDx8Paev/Z86nTnnT1R9QlWG624QsaQ9bGsxaFArL0xLkC3s2zLa7UP3cp1X5G
	pz4wSG5icXGtr3y2ZDSWD+HwUEIeUt1pH2CsYW6SuNdc8NU9cOgB0MHLomJ1JLaN71NAaFISR8N
	/3PDeeiCioXnd8A6JcZSF+k0TScpcFFRfNvCTEgwb8H3o9lvH4eMbaopiFAD56AT8JcVv96i4ZI
	N1JI594pi96mqbYk9za/WEaXfdT/TBI3/uBQCKP3HV0aaRKQW9mp67XB7KT1ypNcAhd6tQSe8vH
	IqdvpgbcSOq8jNobzIhoqDfvCAj7AgXemzpxjmK7ho3Bt0y22p1kkiHlMFcbHkgDqC0cEgE06dX
	pzsst9lRGeDnNqAn4VsUMGF+UMpBlwV9Gnb5FHvPkA==
X-Received: by 2002:a05:6820:7097:20b0:6b7:83c5:fde8 with SMTP id 006d021491bc7-714f240aab7mr5008930eaf.41.1793727359446;
        Tue, 03 Nov 2026 09:35:59 -0800 (PST)
Received: from github.com ([13.86.110.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e5b450sm11638707eaf.11.2026.11.03.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:35:58 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261103155506.534973-1-sashal@kernel.org>
References: <20261103155506.534973-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests: mptcp: pm_nl_ctl: print sizeof() with %zu
Message-ID: <5836bdb1-d1cc-5821-4a23-0b84990f30e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:35:58 +0000
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

Hi Sasha,

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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/416767=
58646

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e73b56681d5d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1200578


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
