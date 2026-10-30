Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369202;
	b=1DuswjyTgCm3t5xdT20s+vt5qC7uu/fVaWmHUjH14OKL/GeKrcHCEQ9M/3TFzHO1YAwa
	 qVZv4NBlcMXF4XYL7hRhjmeXC2L8YBmAHlIOzq8kwve62ho+ccm6C08pnEvcrYQAFWMsD
	 xyU2J2p+CIGof8vR/NuxY6qdSYh9n4yHwgaRu3WFj42LmcB/xy1k/2PSTez5LkmPBg7bk
	 PzE/6d0rmZUYn4QAbDucTmf9AfZzwGuQZclEN2TxTkkuW2jvHDhdfkDXeGbr50iWGue8d
	 6A/dmZVjjvp/meAMSBLcXF/1Wxy73+HpLzu0NgkosCJP5Dgs9heMpEvACwKyAfaVGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=zS4bi7hgVprdasquTY4ceT+IKsZqYVy/lTxBkStPEeM=;
	b=cg3x9vwlOYc0C6fI+IWc1MM6bcQ1lOcqUpY4ibhWWjVlo1HO46ZYdWjW1Lc3ELoyjKGG
	 ECCbyoig432hyn6xyflsyJ0iGS5ktKox463zvqJBzCvgWiCAc2mG5VJeZD5dVjuT8yK0Z
	 ZojE8zJNtz7LhHAV2R/rFz+L8TcoEcTbNwb+2oLGXMrWGd6AEZT8R0dbdvQuCLewicvK7
	 vXdy6IRPTi9xLA/bEVDMDxdbk966FtcYGMVZDt0zQG3toIVueyfHdSsOhaU7S7Bmghcp+
	 SJny7fZmgcQuRvYSRQS6gAx7ZF2vYygTg4iCswbgdCkd5Tom3FDofypIKWv8YgVrVDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1wlhb0i;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F0606A336
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7F0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1wlhb0i
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53397554beaso9375681cf.3
        for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369201; x=1793974001; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zS4bi7hgVprdasquTY4ceT+IKsZqYVy/lTxBkStPEeM=;
        b=u1wlhb0izIE7IdeSvMjpG0tniKo1DDcPESU/osaRo68d/OOB5DvnYvY4YnQVgJaZmA
         O1MBdSuu4+W80eR7q1VebvjF5ef8QU2QBP6bb30w1Lp7zBJt7xZoUsF5vIikS63BvRhp
         Sjk4MBjIurkuhbXY8xS/EL0COaOcJwGpx7VIWxASG6+TZP4ois5bRHYQwN00mmLOTdSP
         czXexpNX/Wik4UTa+FtR/ePxTzKi2k+2xLhfgeZS3XrhwfzotsF98tqW3RQmSGGAAPBb
         9Cx4mz7tmj9hdQSQYpF/ExfpeTgKMIH4H+p081776RA9ku7A2qeblOgNZVGfmkwEA/Ik
         6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369201; x=1793974001;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zS4bi7hgVprdasquTY4ceT+IKsZqYVy/lTxBkStPEeM=;
        b=BBKT03M3QdvrRxgg6Zzt9rXB0DmLfMfnt3uAMdA0diuTXy4NOuZe4hc9GXod0v7Cpa
         fSBKBjJej/O69F40h0epLUcpd1iCzor6qz0PlALvKmNlmhs4VznBX3su/SYIDQejvmeH
         rnDAyYCaA3+SJodGlNq98AeF9eH2+PfuThSdpQXuatIgDsPuJJvQhXmWU0NptUf8bRVJ
         C5268O0uaa2bJVUBME/qzExAr9eDIvpjmhf+TSaMvC2SeUvD9PtMpmgbDNYrPfpxacyV
         M3BisLwN/WVoDJVwMTDytHaLv97l9pgEmtCo/++l9yzdL8RGEsbNMW0N5ZUpU21lrPne
         aUnw==
X-Gm-Message-State: AFq9FYK/aLFN4mAoYwfa0tOQw3Qa+FW6g2klo2lFlRr+Jt7PTB8rAoLi
	ybMbAn/OUzSTYsiWwuN5nuvGhut/IkAHzNYZeVZlY+/l4cucz51hHtWL642x
X-Gm-Gg: AYBFou03kAnPMWA0VdbG9oQpYo3t5Est+ZldlgS13tKF2KQmqDqv0nC6rzZ+XbdCOZ6
	EAO3PUOrvU9uaUuScq1bmcs/5FsxUKZAT4UZI6f3aJM6raKwdQVhOrklxUfsqO8a1VMRhdYBssH
	kE/XIhvv+zWyzqS13VuBN/q1olAEcvclg2I0YhtEBHqSxD6BMAjrL+emnc5htGto3clYvG9Eao7
	zul12OV79zI1L0ZnB0MOnYfGO9ScCjEZ2vhZeGYUSWsKnMUuGrVwM3YFV/P0w99HqnD3AhtHXWx
	0P773+B5MxhgfDJK5YND1wIS6kUgAwHIlE32HM35HHRCRNKAHHfvN9biNbpYnfJ5nWl5tfuEHcp
	y3cF4i8QUuPavzvYhKrK1cDliay2+z9HQ+RTLV1unSPFq4mj77ohTHGZUOJu84/Eujk5sK0A7JD
	OBerTVwu673+deXe/OEvSzIWR3XoKQJbIOr/AjW5yGP5zLm1XPBNlYgG9K3Nx9QHHNRUPrPJnNH
	Cd1BmWlBb/epZg+UpeQ/WlXYw6ru2A2x7KARjituE1k6MxcOpdDvPpWBeyPKB3UgUfDNorVoKt6
	mVYS5T7Nln7+/qZ+AZ/kWCdmJYU8bkj8evgMPHjS+Hg=
X-Received: by 2002:ac8:6f12:0:b0:52d:3ccc:968b with SMTP id d75a77b69052e-542b405ba15mr35665151cf.9.1793369200775;
        Fri, 30 Oct 2026 07:06:40 -0700 (PDT)
Received: from github.com ([172.214.44.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm14351841cf.10.2026.10.30.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:06:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v19 0/5] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <8d68becb-be97-b91b-666e-e65aae77c877@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 14:06:39 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41054949264

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b0f44e221b7b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1197128


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
