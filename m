Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF03A9851
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267724; cv=none; b=DS8F4tem6pYftNP1LKU8YlIZ5ny17iwgKjp+nTHQ1KzcDo75Rw8CKSKn3Lm5yE1shpLIL96UeJ5j9AUGDQpUvoFKdAC4tOrVFzlHCqBnkkrc4QWsA9Sd9U2jjUIXxwlGopt5m3iiY0+OntmF+lhHcbWEOs+FP89GjFHS5GAuohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267724; c=relaxed/simple;
	bh=6gmEUXzenkVGAJH5poA4FcsHKELN5BxJguu74npASME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=L5jeKQoT+dduW8OOfdlf/lRyaNh1lS3d5HdUMEZ+Y1PcwGdWNZzQ0KbI5XQGp5OsZKonuzaz4lQwEScuAXrkZdg044ddiG6orXvoNj9fXW2hqrn4p5NO74zduy8YvUWKtjhls15WYvoKQVpuqacS7fTQkY5mlB31MefGFfFUXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V63rtObZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V63rtObZ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ec1e9d3359so3141484a34.0
        for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784267722; x=1784872522; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OOWOUVp2Ks9h61r6iZFTfuOeSJ+bgETNQp8RHofnCPw=;
        b=V63rtObZ0HaLzU3who07WhazdXIZfih7GGl2d6oFOXxvYV90ZmSDEWv2UN6G/AP0Fy
         9MUaw4XQJ3h/1tEXwU4VG8fh1qeS4m3RLg/eRx/PEVAJsf1Y/DSuN9EweV3Hwp+1IbBz
         KVcDDxn1m5ihbwzxKMx+qL69itRASFECO24aLDAgKBEom9/Kh0EgEcyeE/6CdaZUVrI1
         uacBQK0rgU/p6hbieL7CLKvcUvquGktohckLGy6eNyw7rw3qYbFwaCBwQ+R0vCy/HM6Z
         JUFrcHtxPXVfrpjdb7EYU66Yzk9MU2PVm0W+p2ogeArp50y1k0i9aFYHmxSk7OR+ycQo
         rzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784267722; x=1784872522;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOWOUVp2Ks9h61r6iZFTfuOeSJ+bgETNQp8RHofnCPw=;
        b=T3KxGOH6cB9mbB6XbjYQAk5khHoLlC0dHjElX6sc6/eoj/op5eTqBQy6rlcyr0Usob
         +B9ZzhkUGx4Av5Tj8tFK2rBxxCvUry0l7JU/HBXTXkZ2/rG1Mvwl8eyIZh/USEAkI60m
         TWFlxwTyjHhQNLcdnhKk6e7VjC5L7D6AaulfuwyrLVeIpTl9IzqRTc9UTaeTJMNHIOhH
         aPCFlBBxJl4c8zzaftWybqJjyOgHt8Y88AAV09uaQng4nuXJUmL+CFmTVi6uidpCr3+k
         GLz5fDBK20ki0cDFQatbzNI0KV3LQn6dfIvK1ain6sAJ/aNXm8FtnOA0+b0qOS01e6wX
         j++A==
X-Gm-Message-State: AOJu0YwQxdJIzM5ZZYrFMUt9vv6i3bCuy+PSq1lIv5akTFPVz2qcE9TW
	BE1U7Ymrz0c642h/Mdphl3GQwTuyn1NG2wXepA9LNRpMYQSynxLauAYE5CNj
X-Gm-Gg: AfdE7cmIWAgCRmhMs9NMTptX7lHuM2isfuv6fpo42pqHXjj8/K9HTxDz8i2KSPJctFR
	7ep7cr+syXwE1s7UfLKKcKAue82FCMxV7nDF+QK4QtiCaXijkp5jz9REabinKdIHZAxat2a29tp
	c+ed2p954J7Jq0v5t6PHK9PVr0bif1LwqiZ37KeNgcWGBBUX7XUmnsn7d0d4qkY7VKQqT3I1NOv
	NiHNmBdEqT42HsqmwPkbOQNACrrnVNngF/WgGWf3WWFVcha965Do3x7cuq3aWwKXIpcSWRELKkX
	s2sYZa4Av56Bo7rQ1eGKVnlcPS6we3QHSd5clr2GQVM/18JfsdaNLOb0hDPDUNRmaq7pcXLO0r3
	tLZwzP1hdh7vJxO46z/1WKbYzJF8zJHic5Q0XhTb0K8BAztfUVKbxx8nlyDFESaommhzqqB/tyn
	9+ZfInythnfENpoQ==
X-Received: by 2002:a05:6830:4390:b0:7eb:cc5f:a6df with SMTP id 46e09a7af769-7eda4d39912mr707451a34.18.1784267721891;
        Thu, 16 Jul 2026 22:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.126.65])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf9d5b4fsm567491a34.24.2026.07.16.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 22:55:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/9] mptcp: add MSG_ZEROCOPY support
Message-ID: <070d81cb-55d3-c4b4-9be6-2a4995b9b1ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:55:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/295565=
02423

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ad26cdbf6ab5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1129243


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
