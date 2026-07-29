Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E21A682A
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334881; cv=pass; b=HDofmEY9Qanq6IV//AIip3VuZ8n+hcLORqpz43v/bm0rE9PmbSwKApurYjbrCijKT/y6I+fjRMbU/9S8FTqlm38it7rR14vH+V5+REAE8Jw/4xoVKqNqOBMh5evZvYHLLvm2x2OJj7nJ/RrsxBclzL+pbc9C66i3FmQXPeZh0Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334881; c=relaxed/simple;
	bh=V3TtLAGmQlfcCnbugVYuYAwlhDcUkcB452p4EfYMSG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sspq8Kbo57UwuNWgu8P9yxkEQbmvLTEg9+oLq142S556LFNeU1h6G+r/vbz7qZsF/Kgv6lh7ogtjmlss3tmBHdLKOge0YZRAzse3asYqFm0/F5hv4hQaL8O4le01bGv2lSgJK6YZzzsDx6S5Dn2ONa1JByFiqy+qqGa783ux1vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=GTKx8tSE; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="GTKx8tSE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so10065891fa.1
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 07:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334877; cv=none;
        d=google.com; s=arc-20260327;
        b=gOSSQbgLJniA7TleV3EmH3WQyuGoT++eiU7/1Ak8Xz1Nrp5UekIMtpWitr9vImN7XA
         ZMGvZ/tReYf2BP21s+Hg5jbDA//Hy4CeNkaxDJrwtHU512kITs40ctVoc0uUM4JiRTH7
         5FS6xFzjyJ6oDtXq3O21AFcOh8EDEo9ns/DvCl6oOPw2lUxvpYUs9mYD5GMSd8sCghVe
         ZHG2XoHiVnafq+o1EYzzd5S17I+tmwN5CSCwxbPsKDOX/0UB2fWZyuNyb6DnZa7fAQRP
         UChau4HEXHu5ax8JBfNBU1YVlVIKpRLTTXMxXyn26uG6cxVPuqF7BDEC9bRVNfB27Qxd
         sAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        fh=nTGjEy7RYKSFIxk2SzDSYj8fYDsywa9cCxhkw+bVDHY=;
        b=Oz70bqWC422rO8Vh5UWVwX8ciJpAMvY5NYp/hKoo8YfROXNGM29UY66eDqMee4JBQp
         Q5x8xV1fkzhBYqPjF+MCFybcCDA8zFmkD+nsEugBorXQE4HyPIm06K8Km6TcYBYAP+UL
         LWwywVYeIPF5kKam9pmyeUG4qVHPu72y/36eqfNci9aVpIh4FBPuywLMywvlUPWqR5HQ
         VOiQg5t/YvZ6UFgp03Q76Us71M/NDBvNoPuyCceWxvpAf+rnnznu5JwH5b4uujBcER4Y
         K0U57HTuzFKuO5XCneZ3lbpdBNgEWFTeavGN+bwHPdSMivElDCq1PkXliBmihLD0ocWE
         SFAg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785334877; x=1785939677; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        b=GTKx8tSE6Ky5C5qo88qAGlcUnDc7mfle4TXvnbDMKlawk1a7v9FPYhWHnJY8VKIufu
         nQowa3ati36FG1t1GWGdbxocRQAa6EGcI1HbtJ8rlR5unLUuSrAaoiclRvPeE8VdRnRt
         43I9gCnnGvKEwZey3/rlLT0KxMBf0876VpXFAEdFzT6uNzdN2dczgZLHbjQa8co+uvzN
         SRafxzJxMINHHcQ98SQrVdmwB8FObEdKs+4QwpAtOvVkPY5mn/SQ12GA9SSQ4TZP27A9
         PCbXYuGBbC5jfnXA3cdL8hZYhfqKIw+7aMB0G3D1+vmBJz+QWPAXAwwV+rMuNzl20W2H
         57jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334877; x=1785939677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9U+yBXZNydRZ4aLB5sQnQ5jKVySq/ApFlqzcSLrMp4Y=;
        b=KrW0Xc/dYyhocXllrCeoIfffs5w7jn75I6/FRtiG41+58w9XQ/X+VDLTGeUu0XIJYv
         EqVgmyS6FaccMwFgfsseyC1WMmW//8wQ0iAeZbOFJTmC5GZ7yJr1B+dsmXhLWpTd62Sh
         yNxa4UYMTG9iaHu41Ck3e+0VmA4llbN9YzVP2kOFBiecSmcYjpdI2wuzaSiXqHcA1Lqf
         fROtVXPpXbCZjolTQBQl1hYuVkRdC9LxfY/EkzpE937Vrf00mOrbiCAy0rUeh3KYVEtx
         Gp3QK6Mec47oXBlLwkVu0XnVVVX6sKOgZByTLOOlUrZvuYS4Qi+Uuz6vqKdFiwqBaaNX
         vdvg==
X-Forwarded-Encrypted: i=1; AHgh+RpN4MlUG62m1R3+YwYwkqHXpWBBev0JSQhbEkvHUKpJGr4WgoWXuDR9lDn2sci02eDM/Jy7Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk3Dmn0L3lZTzjL7EtEowX4kACp9ilhtWEgHJTi76T1kAl6v3d
	oFWr4tM1IXyT/SX+oEj0kW9LzKNxj7qvAvn6lOD2YOoNV5FwWLR14kS5U/a/+SNUCtCPS7wb4E9
	0uNu9sdGlR2ps9/+Hk4kcBLrosLMbfE5dBjFAPb2T0Lg=
X-Gm-Gg: AR+sD13if9P5OkmeKwHfjsrXFGzXfpjDrHSr2dVo3/KAZ+hYj5ccq98VsNYwTi8ERjZ
	hJHO3+WiuR0U/n4V+ybGbIKNmZQWuP1Ykmoer5Gwj+XznSl9z2NpcdfEy1w58GCgJ9cJct/H6cI
	t49pq0ZtUBTgjPrgOTuHLv5OwBZmWXjCBFoQHuDXCJPCmtLleTBwLC3j0dMGGbMCrH4c9XpiNtg
	D6vAxSKK8Um017fkz+C/MWJ4yjCHgtC3EBNiTVGfp/Y9MCccQ90OGiOZE43dtS3cjf+9Qk2Xj8t
	EPYX92GhUvmEzAY+xe3tlrOJaQH+h4yULOJ1ackqCzE=
X-Received: by 2002:a2e:bc12:0:b0:39c:956e:77de with SMTP id
 38308e7fff4ca-39f605be8ddmr6515871fa.6.1785334877102; Wed, 29 Jul 2026
 07:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai> <3b55d602-f9ce-464a-896c-8d89af572f6a@linux.dev>
In-Reply-To: <3b55d602-f9ce-464a-896c-8d89af572f6a@linux.dev>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 29 Jul 2026 22:21:02 +0800
X-Gm-Features: AUfX_mzGUlyZYlslhjWe0i5zHKVZnSYHoT6z4HjQyhgwd_5SBNN0jtS3a72-a0Q
Message-ID: <CAANe3eSDxw=r4OYo5Ch-2+u24wbC7tKyML-arrSd5VfV7zgiUw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, kees@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, fw@strlen.de, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:55=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 7/29/26 7:28 PM, Zihan Xi wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated a issue in net/ipv4/tcp_diag.c and
> > net/mptcp/mptcp_diag.c. The bug is reachable by a
> > non-root user via user and net namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > inet_diag TCP dumps currently execute attacker-controlled
> > INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> > bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> > heavily populated and the bytecode is a large reject-all filter, the
> > dump path can spend an unbounded amount of time under the same bucket
> > lock while walking attacker-arranged sockets.
> >
> > The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> > one colliding listener bucket and then issues a NETLINK_SOCK_DIAG dump
> > request with 16380 INET_DIAG_BC_NOP instructions followed by a failing
> > INET_DIAG_BC_D_EQ test. Because every socket runs the full bytecode and
> > none reaches the reply fill path, skb backpressure does not terminate t=
he
> > walk early. On the unfixed kernel this triggers a watchdog soft lockup
> > and then a panic in inet_diag_bc_sk().
> >
> > The earlier batching fix direction was still too narrow: it only counte=
d
> > sockets that survived the cheap prefilters and reached the expensive du=
mp
> > path. An attacker can therefore populate one bucket with many sockets o=
r
> > listeners that fail the netns/family/port or MPTCP-specific prefilters,
> > causing the same bucket lock to be scanned far past the 16-entry batch
> > threshold before control is returned.
> >
> > The same root cause also exists in MPTCP listener dumping. The
> > MPTCP-specific mptcp_diag_dump_listeners() path reuses sk_diag_dump(),
> > which runs inet_diag_bc_sk() before filling the netlink reply, while th=
e
> > listener bucket lock is still held.
> >
> > We additionally profiled the MPTCP-specific path locally with a
> > separate debugging artifact. Because struct inet_diag_req_v2 stores
> > sdiag_protocol in an __u8 field, that request must keep
> > sdiag_protocol =3D IPPROTO_TCP and pass INET_DIAG_REQ_PROTOCOL =3D
> > u32(IPPROTO_MPTCP), otherwise 262 truncates back to TCP and never reach=
es
> > the MPTCP handler. With that corrected request, a 1-group run with 3276=
8
> > listeners and 16380 NOP bytecode steps took 2082.608 ms on the fixed
> > kernel versus 8.601 ms on the unfixed kernel, and kprobe profiling show=
ed
> > inet_diag_bc_sk() executing 32768 times on the fixed kernel but only 25=
6
> > times on the unfixed one. That 256-count is not a missed path: the
> > unfixed mptcp_diag_dump_listeners() reuses one counter both as the
> > in-bucket index and as the resume cursor, so each dump restart advances
> > in a triangular skip pattern and stops after approximately sqrt(2N)
> > bytecode executions. The inline reproducer and decoded crash log below
> > cover the TCP panic path; the MPTCP results above are included only as
> > supporting local validation for the second patch.
> >
> > This series fixes both sites by keeping bucket-locked sections limited =
to
> > raw socket collection and lifetime pinning, and moving all filtering,
> > inet_diag_bc_sk(), and socket filling work out of the locked regions so
> > the batch limit applies to raw bucket traversal itself. For TCP listene=
r,
> > bind, and ehash buckets, and for the MPTCP listener bucket, restarts no=
w
> > keep a referenced dump cursor so the next batch resumes after the
> > previous socket instead of rescanning the bucket head under the same
> > lock.
> >
> > For the TCP patch, the underlying root cause predates modern git histor=
y.
> > The Fixes tag therefore uses commit 1da177e4c3f4
> > ("Linux-2.6.12-rc2") as the earliest git-import boundary that still
> > anchors the pre-git bug in the current repository, rather than
> > incorrectly attributing it to a later helper or refactor commit. The
> > MPTCP patch uses the real introduction boundary, commit 4fa39b701ce9
> > ("mptcp: listen diag dump support").
> >
> > Reproducer:
> >
> >      gcc -O2 -static -o poc poc.c
> >      unshare -Urn ./poc
> >
> > For the reproduced panic log below, we enabled
> > softlockup panic sysctls and ran the local helper that executes:
> >
> >      ./poc --listen --groups 4 --stride 2048 --count 32768 --nops 16380
> >
> > We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> >
> > ------BEGIN poc.c------
> > #define _GNU_SOURCE
> >
> > #
> [...]
> > static size_t build_request(void *buf, bool listen_mode, bool with_atta=
ck,
> >                           unsigned int nops)
> > {
> >       size_t msg_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2));
> >       struct nlmsghdr *nlh =3D buf;
> >       struct inet_diag_req_v2 *req;
> >
> >       memset(buf, 0, msg_len);
> >       nlh->nlmsg_len =3D msg_len;
> >       nlh->nlmsg_type =3D SOCK_DIAG_BY_FAMILY;
> >       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;
> >       nlh->nlmsg_seq =3D 1;
> >
> >       req =3D NLMSG_DATA(nlh);
> >       req->sdiag_family =3D AF_INET;
> >       req->sdiag_protocol =3D IPPROTO_TCP;
> >       req->idiag_states =3D listen_mode ? TCPF_LISTEN : (1U << 12);
>
> 1U << 12
>
> 12 is TCP_NEW_SYN_RECV. Is TCP_BOUND_INACTIVE what you expected ?
>
Hi,

You're right, `1U << 12` is `TCP_NEW_SYN_RECV`, not
`TCP_BOUND_INACTIVE`.

The inline crash reproducer only exercised the `--listen` path, so this did
not affect the reproduced panic there, but the non-listener branch in the
PoC is indeed wrong.

The intended state there is:

    req->idiag_states =3D listen_mode ? TCPF_LISTEN : TCPF_BOUND_INACTIVE;

I'll include this PoC/cover-letter fix in the next reroll.

Thanks for catching this.

Best regards,
Zihan
>
> >       req->id.idiag_cookie[0] =3D INET_DIAG_NOCOOKIE;
> >       req->id.idiag_cookie[1] =3D INET_DIAG_NOCOOKIE;
