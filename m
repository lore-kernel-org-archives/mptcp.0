Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9A194A5E
	for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330955; cv=none; b=UHf2A3xRBQ86U1H3e4791IpcT0359CedkmOZz0Alukxx+nZWb11dOKBnoL7eHZyAInssS1eWidoFoA8DUiCELH/koBEqtZm1ys6jkNJY2ILCPihFJMnlNDBcOtcjk3k11oQpLjBX21ylPkvOQdOtuo0H773l/9D/4l2KhalaAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330955; c=relaxed/simple;
	bh=5GgTSsXEibw4EiukCyZ7u5DwoWRQO1YH6PqjwB27ayk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gJRi3fAhCSGu0iDau1zMKT9Q/4wZx3J2WdCyJj1cNzk+I5luxWzI4kWVJScxmOTHshTTvwLhDnxqhbagOS8PtCoc2k7NdW8tjFiTpA8v6M+kFhe9i/2Orc6e94QLcg2728TPdxpCzG0ACGohq38fDnR2jODaY5083bnXa9S1Q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLwm2TDH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLwm2TDH"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so3194624b3a.2
        for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722330954; x=1722935754; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZncqrOwyHsdcT/n6D5g5YEH273ahMo0xTo9TGIa2hEU=;
        b=cLwm2TDHxEK5llttRMP7/EHeU7QuL//FBUVFPmZmOHhdjPlPvSnCeGj9DJhHLJSn5C
         u5qBQxkLhFevVmBzJVJkxpTuc1ii6ORwdR962QO4EAsWEDD2l0y4ZOLqE3Zl2dfpIrRg
         Wbvc11ynHCq2dnU5DaCtOwlnW+6IrSGdFatmGTBZhOwsJ3lZpBmC5hXUrQrvsRW7vNFe
         mwpFMkUqbtTVLuzD55Vb4mN3SJMaA9XaB1zSSuyYeVATMtcGlUUqkhVUsUs+Z5HIkHcj
         SE8bP62O62j3afQ4lrGNFzj+MusgTMy96U4gUfCjcO3RbJfqPWHNHzd1cSXGvgxjQOEP
         KLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722330954; x=1722935754;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZncqrOwyHsdcT/n6D5g5YEH273ahMo0xTo9TGIa2hEU=;
        b=VjF6kyko3nDbm/rHKSJpZNv5arjKERR1LgJ+ahMhJdKStEF9LVMph/uJyUEvm3jvny
         xnuA1EE38w6XtfTjKEGZ5ShDMaL4ZJl0233q3/e55LISgJKp3+kSUl1ECNIM9ckK1Npk
         jl+z4ZKUkVkpXvxpMq9m9fGOHlab553o1Vn3YVK68x6EvXL4ei/rpKZ1T9F8RIucFXRT
         GWXmgYpKObXwaQcLJcg/wK5gkaSNTwjQx0y6tPpBFlRhm5dIiTpOjw+3Kf4st+ZeA+g4
         maLUZWyK3UH/iiLeQ9BnmVQ52579/ekz/mlqVY2vBqAPeqlN6dTTkX5GccWTW/1Ev+vO
         5ONg==
X-Gm-Message-State: AOJu0YygQlpcHuWeZyHLlz+8AgPIaUB8En87guFbbJEWYrVGYkkJDxkz
	nhQe3LftE0JTX72uI/6R2n6TDiVkG5Hz4StqAs+vC+PogQtNdCdrVfPJ
X-Google-Smtp-Source: AGHT+IEvJVGcAQO21cexS1SChEtFdGJDJ6IzAHsMuBIt3UvIobjI0EGfk+uF0fvSENkoLO5zi0Vgzw==
X-Received: by 2002:a05:6a21:3513:b0:1c4:aedd:7b97 with SMTP id adf61e73a8af0-1c4aedd7cedmr10602931637.32.1722330953766;
        Tue, 30 Jul 2024 02:15:53 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.120.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead816722sm8065798b3a.106.2024.07.30.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:15:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9dafce3091d30a8446897813d2a9d302625c09d0.1722327628.git.tanggeliang@kylinos.cn>
References:
 <9dafce3091d30a8446897813d2a9d302625c09d0.1722327628.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp_subflow_su?=
 =?UTF-8?Q?btest=22_-_set_limits?=
Message-ID: <c356e0e4-f823-d967-4c15-c71914c0fbc7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2024 09:15:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10159055388

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/46124ffdcd41
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874969


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
