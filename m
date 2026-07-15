Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5482931F5
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117865; cv=none; b=BerJ5HkKHwlz+bVOm+/AQWKlgRLzSArm16hOos8SvYO4GsJXc6ddL2pZ0dIj/ql61ur0gFYj1rfC27bYEzt7CLY5KUDnXFTycofaPXBewjUgpBXHBCAM0F3QXrJRg/TjUXQUz9FGjGaDCU6tH6hGC3wVs9J3EXBFQNjY1YEYFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117865; c=relaxed/simple;
	bh=enrVZMozhFVvgVq/Zf+4gvftcsRCN1ix49Ef2Xd/tZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=oLFe1arIWru1hLi1te6FSk0W7d3YjoirbIsu2IlN67zmqLPFagkz2JAPlalHPxaby3kjchUz6oc2KzG8nrADvcOrYEzXWwKDLoCMz/9I5O7ueGUcPlUgGqCtqdMyjb5sLgNEIJNM7v15VLCV0E4/jEvbdhIT53O+FXAqmrksPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ9DvbS+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ9DvbS+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848643382fcso6021184b3a.1
        for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784117857; x=1784722657; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3auqnZbuXVdix5wPwcQMCV5h6W5A2ymgtVYfcQQ7hFE=;
        b=VQ9DvbS+DGnvwoHzQlvPIAq6tJcFFrJffgE/yV7TCPX/dBm/7ZoiC07RLFVuI1dDaq
         kxa6GMNbQBRfPQ0y2YsFNXuHfxta4mNafLAw47XubH3j8VNON0yN3DBeVIII27eBpEsC
         wMsUNLfH5VZUpWFhaikBKB/XOUaAeCANe1gM5980zhkEoPbkndrVl5Ixli/1eflbDE4Z
         q6xyI1g8JGnaUM0/7tYD5gcfmDXaHju8CuDUIyJPSurJybPRYUj7FcqLOmo6ZuOtnm9A
         AU323QXtS45iErho7zD7QmHJi80Y1bwRWKyl6Gf3YGDat+tz8G+ARngyWLs2466ztJDb
         xykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117857; x=1784722657;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3auqnZbuXVdix5wPwcQMCV5h6W5A2ymgtVYfcQQ7hFE=;
        b=rlS6dRu1vRH+BrvAtr6KMqStBr4uB4N5caOfXFfDFQlya3ImYR7nZAZKADPjdXUrwx
         okpzo6k4H7cDfH0Z2jWovawDqjA9q2VyQytGOLNUOxMUE4CJ1nZcT3DoUOMko50e9mHS
         axt57uY7QphNGZqqeAiLeSGoJTk/5q0piSClogPkqGqkulSFYyXR42laHRhmOkzhxg6V
         gy5Bo5Nkvu+KqUSImF2uH1HCkFOywCUc6TbLTs1eVXHf7h0fxUmCBM3Nxo42Jnbmi3Si
         3OcI/ks3fsSvJ7sgIbcMDnlW/ewDfsxXRuQFNZw8X2Ftr+Lkky/BAxQAvK/7RANibyiN
         7lUg==
X-Gm-Message-State: AOJu0YwxGBf+qUoDG8EkNglQCsh20q1lgm4saNacmanoad1agzFL0pMe
	VEUqXYi0kFvdldqIBeoZngwVRF1UysTP8YEFh3taOoR42D1A1MGu8UlT6MWk
X-Gm-Gg: AfdE7clR5ScLkgIBemjup2LjxsaPe9WwC3F1dquPVKuGCkr2R5/HgndXJDVHazFLVOY
	r2cAb9efRQ0la4ZN6uFXkWghXvXTSKST6AfW9vM6e0LgVLNClO6rg6P+a+QQ70QL3EJrucwfsje
	3I6Eisah7T271yBn9m9exA24YCVGLN9MaANNg/BfNxlILO5tmTgVmxcslQy5M7HqS27qSFOJRRB
	jhwAC/r5EdYUu5k7COszjMtpO5aB6SZlnQqzQhwOetEkO5GxtPk0SSqhsriRo/4+8Dpzf4gs/3Q
	RAgw1e/1V2d0Ewm0ztcEyhjnVOsvPEJjv+2I6mzaW/BhQpssSBLT+lqpIAwKW+jujNAPtUXvanO
	EmbMDnqROgNXYv4bTbRN5bDVkbX/TXjl40kSMl2UA/558gqxyQE72IKQZ793cuLykogbx5lcL+b
	VskLoRt81Ae+832mSbYAWVnom14KuSE/VdLUc=
X-Received: by 2002:a05:6a20:394e:b0:3bf:6c05:ab with SMTP id adf61e73a8af0-3c34d8935e6mr8251530637.58.1784117856910;
        Wed, 15 Jul 2026 05:17:36 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c08eesm1269609eec.21.2026.07.15.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:17:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/8] mptcp: add MSG_ZEROCOPY support
Message-ID: <a2916d6b-ce9f-e797-9532-7e19979bf732@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:17:35 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/294118=
68709

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b5ef0fe4ad2d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1128077


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
