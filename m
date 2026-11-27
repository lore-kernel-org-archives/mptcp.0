Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795820206;
	b=fJsCBbZyLMHduRoFo0V2JgnDZl10SpR32w/s9bbxzarbp7S7tkXAONDmHuVBWKRKV+e4
	 JLeytttVfaA1OknmBi1U81/I6lZKAJHSpytgRHPxebJdEvLxyMtE2f3IkUajLK2EguS3d
	 YSYlAuiFc9rHq1smpRcFNXMsz0bqFaqqLedMKEdzp5RM6fmH6/XlQCuVC/DbG9k0awt6u
	 FFf4sb0TNjKgFDCfnUbpv30xSR4n4d9YHGAZjSDHhl71P1YU3KxK1XbggbYbHMFZKz3zT
	 F6vyetr34k8B0nve2K9gPZJ2mBphvwOv7nwnTWLL2obJQ9HUvkxkx9op5qpi7UXxr2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=lgeX6PKn22dW7wxBtDnm35lI8ymwM7IJQdnAfDs8Etw=;
	b=nZ2kDPgdNbZvj07MKKk+7JEfKaTR8eEDTUzY4jFeiTI6TF4H66nWWGHZHbk3PHvw44kz
	 RSJT4YMPAOb/hCICVvqXcKxgQmyUkNe/SMHzDPhJNZpujR591sNtPHQsIX3Vz0kYE0jkh
	 gzaBHdezJR9I1S2ShMrbAgFR5t3oS/iQwmC0DLvNEffoamuxmFIz0N+nkp1Dy2lw1Kr33
	 TZZWSMmX1SiScuv8quSm0Nr/zkOuqxl6EuNKbldTD7P1i8m6w2EYz5DEEDmqtwThnlAM1
	 1Xh0T1rkpR/yaLsFEEIRQnjG4Sgga2qmvIaCBYdgz2XGoXH1m0X70UwrguEOJVrrJEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAerlKRi;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD100606A31E
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 22:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD100606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAerlKRi
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f046b0adc0so49182425ad.1
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795820205; x=1796425005; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lgeX6PKn22dW7wxBtDnm35lI8ymwM7IJQdnAfDs8Etw=;
        b=XAerlKRiU4H6m1AyzY2tykFUGjaDC5bbFxkxv9xt3p5CaavcxcXyouuHF1JhQxwJhH
         46PJuu522OU4I7+/mh2vGz9OumzIer3HV9abfkC9pHSpSm/Igq9YzbV7It1mhvaB2Ag8
         uIUvB6uoL9RZVyB/rUn7+2AwH+SxrcyQGpTVvoc5XOvkqd19eClGBI24xhbZ5tDl1XcF
         MPJkp0r5/Du4QjD2Rjmbpgj6QG9ujpuKGf9TX6z2l4V25JymU+ACE+5apiJyNdXZt62c
         /1gwvQSgoB+OcOjAecDUUfsB8u8A1CDlQ9KBUKpy0Jrv/z1BLkiy2TCumrrn8d8G/99N
         cO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795820205; x=1796425005;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgeX6PKn22dW7wxBtDnm35lI8ymwM7IJQdnAfDs8Etw=;
        b=uuXmtgOieSftnNms69jPUDPUzchgFuPlK/i3Tn7mS8neDrCB6IWt0QiZZd1gigdZx8
         CXhAVAso4CUwMg3MI4fVtvV4gegI3CVBPvEz6GCAhDXhKs1UQgLyGIB7zI/U3jbMFhp1
         SlD9noLVjKDsaZ63XR8GptmHcx52dxn5KBT/40zUUuTULCukd4uICNNmsZizW/WV6gOh
         6lXpKenESSZA1JzKNEQ+EhiGbfhl5Bh95SyL8CG1QzSdr/vV1ebyeyEVpQo5rkw6wEEg
         8G0bjkGWCHUyFOA7x+c78nkjfvEMJan/DfA/A4cAVuD85YT0H+P+1Sq/tP3qSacvygil
         J47g==
X-Gm-Message-State: APuU4Z+lW7qgu/PW80X+H4PE9MvOTKYaY617Zne4uCrOh283nzv45bwt
	JSrafSIpiNIFK9+LbPUkdtAftErPT82L0pw6xhP0x7mJWhKQbDcBsQU=
X-Gm-Gg: AZFdTZekjXAe5YGZ6HTgzx/b5bhLbXbgNISnLEDV8WOcKKNpkltv7PherlAQn9ofSDW
	1U0KIDUmFs0nAUvonmM7oQgmvGqytgFdl8DllEo3YuAD9QoV8VrTLMiK24VpRPL5SzQBB0YN7E0
	X2eRlnrFiT+09n1R1wj9/qgiv+gL7jnYuq8mCmDp1gXJrE2M5sb52gDhw+qto3bDG/+TF1Ram1N
	Mmidd8hzDWHD4Z1k2Fh8pyUkmVMO2TPrWhWHP+IFIZQpvrUSslG1taePX3nvpGTyDVnjhDJ+66a
	A6iklzo0rss6nGYbhpFzTCNyfKm6mhhjoUcPOxem2hmLcLQExAWdedqP9/89UpSBReZZ2EBPp7H
	pTiupQyyR9+/zjhid4W5ZWvX8xNAnzT6lzpS54Dc4lmayAkZc3HE73dmlVBksqk0ubrI/TMAA6/
	fpvT349c4GrHqAEmoC84AA3GQpzypdyvRi/FZ8m8GAweP2OFAtY8/2BEd/PboVIHWu40LF6k4sw
	DpiYM89HFHGg9zxBc0fFXmeyWxRBFfN50c8kvHDESauQyQDP2/YlfHwukmZL8wnHlVCK7rbjX5B
	Z3C0UoSyqEt5uUFpOunNrRlDaSazk5Y1tVvutX+KdICAmrClyL99R/abWloom4o8K5KgxRfmRA1
	vs0oEyp4uS0y1k6/zj0M=
X-Received: by 2002:a17:90b:3d92:b0:3b3:a74d:f848 with SMTP id 98e67ed59e1d1-3b41c8e1711mr20352810a91.15.1795820204947;
        Fri, 27 Nov 2026 14:56:44 -0800 (PST)
Received: from github.com (ec2-3-42-157-124.us-west-2.compute.amazonaws.com. [3.42.157.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm40873605a91.6.2026.11.27.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:56:44 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261127213756.4154872-1-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v10 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <4df2654d-2c13-6c12-3496-ca040aaa5648@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:56:43 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): regression:sched-serverlim =
=E2=9A=A0=EF=B8=8F  (1 improvements, 21 new outliers to review) | Unstable:=
 2 failed test(s): regression:sched-baseline regression:sched-clientlim =
=E2=9A=A0=EF=B8=8F  (10 new outliers to review) | Success! =E2=9C=85 (15 =
new outliers to review) | Success! =E2=9C=85 (7 new outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/460742=
16960

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/90f21f59512e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1224868


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
