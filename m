Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567194;
	b=z+xmKyAyTpmt5gzmUfOB/R3ZpI0QF6mVnoQ5g9UROiOzAp7cBzZVd/Y16hURfHsChvct
	 IsWPZkAWh7mfIw/3vtfoka8zcGWpw4c2eJpofngOMkCf9/6+q8jB/45pTFhW/JyqhOL4l
	 WPq4yzU+RSEaSPVa15ERTqYj99bW0b41toT/DVNMRlP2BljxdzqeryK4SI3bMe21TBxp4
	 HQ3HJ8aIvWVAtzFxutbIGY6qo30OasmctezJpXKmuc+a5hTaiIGOFH0wPbLCEHYNRm9ho
	 XJLsEWbp9sv70p0q9L1S+z9FvZpLeZj5fA4Hpl8lJnuBjejzcbwJnX/UVg+VaRGd0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=YVZHZ3mibs47LFjlVCpIQFA7BohfXHuvJS28L4a66UU=;
	b=AyeF8VgY6SM64tJUyqMGKOJ3R+BwBtsHSeWDA65wBCWS7iigp5KwPsTGgBbQ9zmd+7MW
	 cOeASXItOT0tAlkA22yVEq9qVOLUqK/Be8RncvBR7Qus66+FLZ3HHBBeqS2q/kMjDZsj8
	 WWTehVOwFnyKB6vfkRieL5x4nn9YFk1Unt/czX5Mr3HemMUsaeIj4rV+BSO8yBagtFvfo
	 mZstsdktSodJAeGbhJCa8MSkiXO1hrziWdFBQaKPoTH75kxdvPLdXB7TyaNOGupNWzvc1
	 EDbp8tL2yvtZE14ht4SF8ht6VNxFiQ4BeURmNDKQ0SVefG3ai5VYptyl5lR7OiguRoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qp4HRnU1;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50288606A32E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50288606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qp4HRnU1
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-70bf1671c21so2968272eaf.1
        for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795567193; x=1796171993; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVZHZ3mibs47LFjlVCpIQFA7BohfXHuvJS28L4a66UU=;
        b=qp4HRnU1AYpei3NCNHI4BE5nta+YU8Eu3HIMmNR+Th8t8FXx+kvGuj9dfTXhCsvwbJ
         lMzpT6F0dPqbHvQfgjqolA191JTRbWXW6WjAteoELs0NeqPm3LiV6qAWAilvkHW6Jwt1
         o4y30B96kicI0kekzgyRQsd+iDxcS7IVuc0Qu9NYes2+k3EE+LP1oSgaVOGtrLc/u/77
         b5gdv5GrrHpDNW3yY39X6hQiul391Wy5CwD0UjWroUgnNvU03vDi6t5GeYYza4hX0e1e
         swBNcP51MhvKjsqjhdNMTofBAIg2j3TCuLZbmIHFYNmlHJwV3zHsLVmbcJCIc2m43Wc1
         kdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567193; x=1796171993;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVZHZ3mibs47LFjlVCpIQFA7BohfXHuvJS28L4a66UU=;
        b=RSXXtMZ7Ly4DNQypiUrGa9u1PRC9564Ku9JwTDYEn8LRxvyfja/qFiT12fThU8oeaD
         UnGdXNp4bHoaEeiJ1L6LxKamsqnGML9Au6cQQ1ZB+lLEOeD9qNU3Rf7/iSBlUJYHzmuh
         URhkq8jEl59irKrTr6ZdS9YsJMx0idoeIPUMHE2j0kv2Dy05aRQcr9iCX913MpPfNqCL
         Lu64vPBGiJ3invnrq1dj6WGt+026QIlhj73ZIFsEcJ89Ad3IjWrUmd7eGiRPzJECKLEB
         JXrN+0m8nuD9G9az65KjMxYlS38INfNxqvypMiFR12v8jXtIlqXWV3/IEeE1gEzLFE+b
         9+KA==
X-Gm-Message-State: APuU4Z9++0Qm0fAy6MfcmTdEJPGEcWUm0FRBDJ4GwDMarDeN7vfjHH4v
	effnC5RyoOpCBu2GVziSPF9TrUSD5moek+eNY88zxGQaOG1Lqy78Ysw=
X-Gm-Gg: AZFdTZflqaXkQ9B9Tud+8K3CkziZValAadKcFKLnNWmaU4+ZUedoXhWDra8xwga03Z3
	zAwgL0Lj5GPXweLvGnodn104l/bpb2CG8qMVC1ILtOt4r/ZHVAczaLwtXv6XxSOqRrw2sQ8hrod
	KHBVysy3mU5g2xLfj9ai0YP5T91+SoolHLpibCk9ZjF9m7rzV1HfjbmN7fH7Zvrj2bof1uidYdL
	BV3KcikyYJetk1QHiBkxL0GROpTRPu+qMPcWqcv9idZx9iNQGzDdv+Qpav4gmr3IJEW9lfcvHp2
	ksI461xyUuxMhBpEPoO4gaVenkQC0q9hY14YnaiHi2F2+Aecls2LnbYzaOEq0xzmC9nxjuKce9Q
	dCyuWA5HHgynGt04PvF/h6XV5W+cwOc0QIbrOyB88JsXgegS7/HkdgnFwZ9ufUOe82R4fuxpcWX
	LJ13zONA8IQZeL8LFOy7rSWUtfTfW79FZkAp/HRd0m+QKsW9q6hHNXSjkqv32p1XrjpjBsGhZCl
	PIcFmU2M0PMbkRL5zLnA4QDUebI9jkNeiQOnY3vz8al166v7dUKRkOTPehfRhcwrgIZN6VlL29O
	izue3nBOyc968AgtuQsfHco50Atv9CLnJ060cZ1k4faC
X-Received: by 2002:a05:6820:55d5:20b0:71a:facc:5a3a with SMTP id 006d021491bc7-71b395a1fa0mr9247424eaf.64.1795567193005;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from github.com ([64.236.135.119])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm9596877eaf.10.2026.11.24.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:39:50 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
Subject: Re: [PATCH mptcp-net v3 00/50] mptcp: misc fixes
Message-ID: <fdfa2ced-395a-9de9-036f-c3b582442a86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 00:39:48 +0000
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

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_regressions =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 5 failed test(s): =
regression:sched-cpu-preempt regression:sched-mem-pressure(5) =
regression:sched-serverlim(3) validation:sched-loss(3) =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F  (56 new outliers to =
review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/run=
s/45501866736

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ecc8ef853125
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1221333


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
