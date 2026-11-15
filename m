Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794723761;
	b=BWfLhAgZ649BBhix5sjpxV5q8/AyvJrrQuLXsjNANki8pJMs0hudLoBrpISPJ/p0baPo
	 BA1PbMsMpMGTNFcKS7wUWH+aiS1hkYveafobEzDiFNszhoU6BjbFQGM07W3Omgc05NT0x
	 /Js3U5St0YVj1vPZgeqbzuGwBil71DFSM7rFCieDQTM07gFUeV0QfT/JXrPz13joQmz7f
	 69OppNE5BjCHBs/QRoyOkpOslYYsBR8L0CMZ+Ox+AvjVlBU/8IN7peLwR+PHxNX9stXRT
	 dd05CaHm2mrbEh5k4rn9YfLd1ztVtVNRN7WHNPNkTuvstuD8WHZhLVhwEQh+FGxM2hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794723761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=wEksqh3EByggfB6duZ8wS+MRXuqzcuAL07aQnxz75ac=;
	b=3N5crcs74opTsizMraqc/8cGQAAK+AXMSbHs3jlzacBiNHOwuYiUinAk1S5Q94xcod3l
	 Xtq4cEgdwHxK43hS/rkLnBOQx9c0b+u8eh5lTpGBHT5ddy0FpumJyD58l3i1wBJ/7Ncfl
	 LP15JYS8a9Sx6T80QRbGrr3NQZ8KL/Ziq63rKc3Pn43eH0VI6c2vzADdgO6MY7G0sfmVF
	 4gL6H8rFXLMj0In5p03gy3bLAYYN1+19sf+0uKnLn37zbHSbBw+L99caXhOq/PfDvC7zu
	 fkp9WgZ7q7NRGbIZN+qXF2ixchyyxTFBsogsRJqqTPNuSc23Rm5PVSqRvAJGQGie/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJpwhfTe;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1E606A323
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 06:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA1E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJpwhfTe
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so3124041eec.0
        for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 22:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794723760; x=1795328560; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wEksqh3EByggfB6duZ8wS+MRXuqzcuAL07aQnxz75ac=;
        b=QJpwhfTeEvFHswz2HPdBkaVv70Mqc5DcNqJwQRl9cnnp9N3jrIcBGybXtoHbB5N/IK
         9k7E83oFGJuky+HvPhkNKEmu6Ed1mjji65rS9othp8f+Id7m7B+AqkQPi36pEfzaRvF1
         iY1kr+JkoXrdi93tzKANo5LXYMuucraqutjrscL1TKmtUyeuXKB9qH7X0cctknWCPNy0
         SFR4igrXzmgfPH44dDhQ9NuhWx6oCbgpD3hMu4KPdhIxFJgxPeB3NaTgdOw99EzkOeQV
         pqYDoBORH8b2WVkhEJ4IvYOg7xIIjE8rFSWoG0JOh7EpTc5Pj29+k8e3oEHBrUI6NAmX
         zIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794723760; x=1795328560;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEksqh3EByggfB6duZ8wS+MRXuqzcuAL07aQnxz75ac=;
        b=XsNBtZ8GhoZQQwCQfmGLIrKeO2dd6EUYMnk5ryErBWM/JYEhV6WwK0F+YJZ1wVX/dm
         QzZwDdx4EE1HybxK3Us7Mp11Jcq2zZc0wrIlqlEFNh3MJnYsUDFlwEqcCgjt+h+xCxvd
         lfS5U9Kux8mJsO9tKpAcul9euqJ4cHCyW8v9T64VMxYEkWUb4LyK1Vx+QTpao9TbBK85
         wYaP5pixEkebI2w3g+nZYxxBCbxVAs+wFCmOhp3Fvdni4twrBqIMMvwqPD2XKxoYR7Ml
         VY6F5TF1HesxQnQDyyj1gRbiDD6mtpiyfrWV6ZznxyzHU5ogfP9j8ohf+STDEV5o6sCt
         i5FA==
X-Gm-Message-State: APuU4Z/HtJ+DeYpAgXPlBrDeqAPfDHAPrObP9v0uyRkE67NH7G75vN+W
	yVUUL7AG3E7WMmH3zGJD+/fBFhISd57G/SYEpUfHHhXdJWEWZJziBWJB8JVS
X-Gm-Gg: AYBFou0IpxDZAwV9rWbNyxtvM75172/WukreVAA23TcyyyCSK20Sd6LuaNsyZLYw1N5
	juiK4MvsrwEyfZ5XFjfaniMdBmUFzO7uJMKz0WoDzot9WUiNbZT1WKWcPMpQIw3XshlKgTh/IFq
	ocAR+rrtoVPD2j6d1FSDEWdJEui1P+i1SzD+dXUCafXzXMyazVTZChoVxd0/i/zRXF6FXwq2X7P
	zEwM/cGJGZdrnxHPajO7lbVVFffDhmANSWMKcjcHqbfRXPk6YpHEpOY3Mh/yVUfPU0BVCK2r33f
	TwVwCMOkQWvmqpx+wXIjavpji0jHFS8HzEG32zWIjo55DKuG7/1TjHSyLG0DFjV+0uD6DkoMXV0
	Q2jcRKoVpwX/L+bvCniKITOYBAoiF/odA6TstKuXgqWljYyLMdHexkqNSGM1xVIKpnKrJ9Gu2y+
	FmZB3n35pMC2p4zBjYHBj+qmgyHdjMysYyxiGho880Xqi7ZmdTMBQhimT79a0kydDwdWhS6pLJl
	PGU00irGsG2zGd3V0O9Rvzv9Gnpp6bbopt2nJ2eoevJtFW+h+cX7FMUhtmPrK9iLUvaw7DWnCVK
	jhsA0xD6gKAF/89X6Ug9T0OAubMNHt9/cP21iEE=
X-Received: by 2002:a05:693c:2585:b0:369:ef63:ea95 with SMTP id 5a478bee46e88-37966e3a7e4mr6112637eec.6.1794723759878;
        Sat, 14 Nov 2026 22:22:39 -0800 (PST)
Received: from github.com ([4.242.195.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm32755959eec.18.2026.11.14.22.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:22:39 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261114-mptcp-wunsequenced-v1-1-707a73a6c172@kernel.org>
References: <20261114-mptcp-wunsequenced-v1-1-707a73a6c172@kernel.org>
Subject: Re: [PATCH net] mptcp: Avoid unsequenced accesses to jiffies in
 mptcp_reset_tout_timer()
Message-ID: <e98769a1-4b10-03fd-4db0-06389fdab070@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 06:22:38 +0000
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

Hi Nathan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/436786=
70075

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/416e13255167
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1211666


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
