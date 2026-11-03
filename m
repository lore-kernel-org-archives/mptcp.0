Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680728;
	b=IKZMtq50+SA1xGHgesVe2Ahqj4Y7iniSGjH8swtURNs8SaFyUu0k9ARMSsATO9U0+Ril
	 3LbkoXeco0V3fdgTfNImNik7u9n9okikEqu9MYonJE92uLmAjPWA+vizD1lY7TcpbwcY4
	 iV8t+opBQU5X1FOh4CmOMztBDhEqLG/RAE0F8v8uaRwwmZ/aYkPZcF8BmZyfUDGZmzxvn
	 5EStHwcEYqjJBXzj8uLSbbdY2oHUPvQwiWG/CWCak18JxxpnmBba8wAjmkZqdRzwNG8Rc
	 7Xan6vfMPSA/Ox2E2AO3jVf2UrctLSSgLlzSzUV7vi+T7B8bLA6iSlmkaIv+DvX4J7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=I1l43zrlcYvFnG06HjcByti1Byizihvt7R/TWRbYMAc=;
	b=LPxYzpQu+AOjGca1NXPQasasoNnjqvGbC6dlehyhGxQEnQQG/Yqm3I+Ou4Y4F6W1yntC
	 QKfd39xfRtiYVAzRQpm57SWdzhXyHGEtLORtAeCVaTDTgV/xBHKXIKlYXDCHTJJ+b14WS
	 TF3XsWLjZVli3m6d1swvbL1zGQrETRwG3tc3GgZUWD8NAM8G5Mz3rFzEIzdtKHn77FWKM
	 PxQ6ARVLbeQopKKIH6y+227WeX1LV22kijjEbV4T4lRvLZTR/zhC1p7tvFoGUAqYS000w
	 CjdIGW9FpPRMELfjb7Gn5r5ZK89NHiPonrUB1+dEPYUhDl858Bp7Iy1mVIclzwJyfDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzpwcybv;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD45606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 04:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD45606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzpwcybv
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-847ac7ccd85so2472698a34.3
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680727; x=1794285527; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I1l43zrlcYvFnG06HjcByti1Byizihvt7R/TWRbYMAc=;
        b=lzpwcybvNbgiNhB0qqdnhfdhzImGWjnFGfKAl7m+tTibftX3BQElxhk4PkFH6yUQy/
         +FpZSH1bw1qffkPOK22naEn0c311bndmxbLTm3zKK7Hx2KJd7rWpdpx0KWeGosbwEJiX
         oB9egltDtuxie5vtsdC5Fn28qIph3Je09lsWlV3pCDPRwZVjDr98SQKo7rMxZ6T6Qhoy
         YfvfBsKXMNIswMA6BESEfdjaZkcDoipEo0SSwiHi2CSZmybIQlk+P7eKT9HJjY97Pk7E
         ZDU8Px3xN8Mw1zCJeihcUegFTva3XqYCkQhpYGy0uWKSKhQPn5WLjt3BwpiNY4XO7Lii
         XiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680727; x=1794285527;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1l43zrlcYvFnG06HjcByti1Byizihvt7R/TWRbYMAc=;
        b=f8MYEN4U8ns1Pk3y6eofqlTXZe3I0nSJFAsDC/HebtKd6GX+4OFqHaMCXX4Vdi6vdI
         57wABcIGBezn2OcJq3bf15yu56N1i+bIRf04rrRitHuFAif+pYZPx5P0oJKrAwhCFrAm
         Xtt71wsgA94xTP3MR0+lBwWMgShFAf6Fr+9RYLDALu0OtYY9UB9Kb+vTOKQWQeWXcJBf
         5ZsjtWFJWeY2zR0kFNOwJ0DB8oIgDyGOQegoiXA70WtRwYlA1mdH3EYdbMDp2wYj6ANe
         712ak9zs/9MqAOnpYTHhgLkzj2SwsixTit3c3J5XMTDiEdVJS8bICQUr11KS58SlJH4t
         TaWw==
X-Gm-Message-State: AFq9FYIKpADlyjgmMC0jsKlphjXvM1E9vdyq4G6IbRO2NWIZgcCe37Rb
	Yk6sPQhP3DSBd1vSrcGVl4tmJ+1ytyzLSS1PRQqLS3yx5VC/KyNv5cnkcUAQiOM=
X-Gm-Gg: AYBFou1Yx0aQyCGRjQ1d8VmPKFcihG1CNdA/M3amBU+stBrB5crSjpnla3P7qy08PIk
	PDucQ2OJ4YabXgs2B54UhfcIJ1KLaJ1viK0SktCU8hutHkG+8nwUMH4GrdWD0zbq8Fm1AarTxsg
	UhCRjF1J/OsqD79iYLAejrOjgI4hgmZbxYp6JWOBPn+MQOJMFLWw2WeS5DiSvID13/AB0uOHlps
	EHpCdBkiOPBN4m99kkuasd30+1KZRDzoRoed9nb1mXF4l//a/gqcD0oPY6EexvBDXP7dwcVtQ8o
	o/wgFzl1Rct3FKvB5BxhYZiI9XVuXC32n/YW6Wlm9UK8Ubn0m+PqNtNQONUmZrnHWVSyihDkHxT
	NEGMDStHFneKJNIZM5STB8WnqTayHPyDHr5ZhmiGDPp2HtcJIX6iJcg4yP8t5bLWaH8qBVbyg8q
	7nkxqEzJzxJK/MyMITMGwGW22hw/C46Mkel4pKTnIKZFbMqXlXMrr8s86hi15/vS/QhOJ8D4knA
	GfeBce2KaE77e67giTo3qtNykhOWFzATC58RBe4unsrPVNII4Fvx+6A6rupjE+jq71kXdmvVt9w
	TlegkbST2GiZOi3DLUaxTsAF/AMAzotMwaURHzRAfQ==
X-Received: by 2002:a05:6830:3e03:b0:85c:4897:f2fa with SMTP id 46e09a7af769-85d3649025bmr8527800a34.28.1793680727093;
        Mon, 02 Nov 2026 20:38:47 -0800 (PST)
Received: from github.com ([13.89.127.133])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3549a2b4sm10781163a34.13.2026.11.02.20.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:46 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/7] prepare interfaces for kTLS and
 sockmap support
Message-ID: <3f8dfdd3-8922-7746-6f53-dc2c5b1a9c05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 04:38:45 +0000
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

Hi Geliang,

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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/415748=
50749

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2b9fa93dc527
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1199752


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
