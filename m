Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701356;
	b=qAmG79f3y0op9XoeuAAElmgW/UhW4TwHS/qqUWdGgKw1RURGHuLLsPprgy2Z0Qvb4DQ9
	 ul8jW9VRmBeVnx8cMFBl4QmhH+nqwsox5LZZndMyJ+jeYDmim7qn23fgTNBtQFk3ZGS/Z
	 n7uLRXxAASW4qDEhs2XuSV1rWALwUZqxl+MtWxO2TsD1gP2+NFKJKz9jsdy9Siz6rj8rT
	 dCcP/W2Ah+BaJmgsWTXOdgghvE0w81gvGXS7OKIijpBfmVNikCNWcF7EIHsVd8Qv7wCMM
	 HD6F4wvQUQr1Qt4uk6t2QA5YXGuTdHZSO2orrHfWe6xTKDrd1TX3GYN1mJr2c62KMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=BC5zyg3LtIphv0227gEa7qbdtopU611rbmMZiHIGECU=;
	b=mYeq91rhHPqwvxCb5rf+1AxNmeYXMuHcmFkN0NCpu+/nWSm9o35EzqhuQRqRgZUoWN33
	 bSmYn4qVeGHztDiOLXrNWp9pbjzrVgYJ7pku7DQvKwroLQEikWG/CLPuWAiR5alADDh6G
	 0nxVZoV4XE0rp4slzu8/H1+NqTugW3ckaVcLqnimaEzvyJXgFW7uu5iKylrZnlUne5PEt
	 EpB028Y/+bLsy+1EDCXivJ+S7ny31o/sU1OIZO6tlCfv9ST/DfeFwtQzvDWirLahiDYcG
	 jPSB+1L0hCBJLUzr1HqGWSuW/93/1NNLBoARKKLfPZ9oxc/8jUJk5nDRGTWplDJWCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lht7sRk3;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E46606A33C
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E46606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lht7sRk3
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85c1135c286so2561960a34.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 02:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701354; x=1794306154; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BC5zyg3LtIphv0227gEa7qbdtopU611rbmMZiHIGECU=;
        b=Lht7sRk3y7enZQNF8gUAY38Efp6ydXf+G5mqOAC1eNtV0feCJZR1SSX8clk3t3P+Hi
         A2kn1xouh2Sp3lA7VD2bC98lCdE24+gBYagu2Stb64/XPcvBY+V8MmUptPo98mr0RSMB
         Mk0K3hOuqjaIPfWHQbXWIkfhFgK3jcMLD0H47qMvXHsP6Gkd5TIvssp3HHaoGMTpXfb7
         X8N9jf7UyES0MdYaYC35xqul8rmnSzDsYrv41JxE06tM9YoK5bac4dvyLb+5nTedBjQg
         PamPJww93GE9fPc+bVaKAjDxvlj2ULJTsS2a04p/G7W/c1/5Lk/8/9bmOk5TfQKfxXiT
         kyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701354; x=1794306154;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BC5zyg3LtIphv0227gEa7qbdtopU611rbmMZiHIGECU=;
        b=fb63DWBygBukvGHVXVhZcWIwHgDNJwDnpbfECilq4Gf+Jfr6LXHkRM4F9PBpthADfG
         DO7Fq9XU1je21HjwzE5cHBoOkTypAYSUKzJW+tcPEzROzSIbHygE4LP/1xYVjIU040GE
         4RtWNco0mIVk5o+rr3qp+xq6JCqD0XF9LGh7EhBM9JQKuXWK6f/l5mzt++5DgB5V6MHQ
         BPw1v1f330JX7eP+y7QI/nj0QaV6chQW76qforuJ5sLfQSAM0ix15eEEO4tdzO6r2pxF
         txjiS+eY5MygxVc1Hm4nY82YOeA1jWZhvcKP2HX/G/kxRCb4dvrLZtFnR3Y7G9KzSIfH
         nYCQ==
X-Gm-Message-State: APuU4Z9W5dTKzOHzcKSj7jp+BN/bJNd60b96+0wLW1HqVjA92EpjbFNF
	LrDPMvs7cd1hvBHLEA0wKiVzr9wYgfDdOtHkYnGmiHuvuf55O+XuhHsRpvzt
X-Gm-Gg: AYBFou0wgV8hIh/kAWsObiPahSnWFaMfKamYuiTPqSI2XUE1cyexapuwQ3Ow6pnktMo
	BFfAFNvtb8bEEFzps6km9QdgaHmb3p7cJOJYyD/k/a1rfogqS8uOOzkqlNeCppWz3i7tjrw5oPr
	kl1xj48dhznQF0G1UapHqZRTqoosp2cWHpwpeb8AgBNixElAAZ8S8JZ0TGgcnf+2UjmfOJyxpEJ
	e+5K01f8WH0e4wic41ovzt/xWqR8fqy/5sV18u5AC47bXQXRZt49+rVC37qB4YmA/RFgKPGZcPf
	kVovXs5BexhXoJvkqU4gBNFsHHUpaTer2qnALZjsrzZrzSwiwNWLMi3o+sJbIGb+wcHFaAFBH8/
	8xhmVQuSazI6PhW6nihCuD94OKHIvpnTFTner71hrY6o4VxZ5gWeoYy5N80n4pALOerKA16Kph9
	iijBpANA1zevRQ9qr44xA0RiF0alIrU5nNV9DZPUOAWSgo+DM63NpQ7hSjBpB1SD9Blu6NmF/MP
	+imfe9Tu0boCv7DX9J5yBOKe+nM/JWe4BcAfBRTjn/LJQO7zhVA3SjyGB8MeW+MDTNGnyKIx+Xx
	S5GIN9f4JMQEJdOkRI2AWFovx4WbuZ+UvLRt7GTIhA==
X-Received: by 2002:a05:6808:2207:b0:4e8:92e5:db5b with SMTP id 5614622812f47-5640de625e5mr8874285b6e.54.1793701354545;
        Tue, 03 Nov 2026 02:22:34 -0800 (PST)
Received: from github.com ([20.186.239.47])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm10765995b6e.2.2026.11.03.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:22:33 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v20 0/6] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <ee74287e-34b0-acf4-edb8-85adb19bd043@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:22:32 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Script error! =
=E2=9D=93
- KVM Validation: normal (only selftest_mptcp_join): Script error=
! =E2=9D=93
- KVM Validation: debug (except selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Script error! =
=E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Perf: Unstable: 0 failed test(s):  =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/416098=
65581

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8b0ebaec7c2e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1200005


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
