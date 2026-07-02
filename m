Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D66395AD3
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977835; cv=none; b=FrgH1YF1Ntad4LC8H+y3LEXgHMj1dmkBZfszZv/twD44mSrI73kF2Sn2e/b0E83vxI3tbt5LkPhIlDE2VVcXqXhE65+BMvV5t22ogDIBQaSfao6xMzUeFyOi11G63WpxcAKd+lvS/RsNuijBQxOCLMm+6bEs/W6vP+w1KF5hQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977835; c=relaxed/simple;
	bh=bTK2iqNHv7hlRbyrYH+g9mGd2xlKSkXq6QCrJC0/Juw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=bwtMjy8b0Ps91ucGewJKKUcVILIMNfhI/EnkClFHfmcEOtg3hURGbUeFvcvtKcc8RgWM0+r/2P0oQZjmRgXmGqFaN7o10TlUsiKKy/YFq/piL+CYhXYdLugM5tAvT3oqc+mBi1G2vuPN8LuugN7XygVlv0EwcGZO3zToNFm0p4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD9hgN0o; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD9hgN0o"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a308736a36so814500eaf.3
        for <mptcp@lists.linux.dev>; Thu, 02 Jul 2026 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782977833; x=1783582633; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3V4W+G82OfGoCUcWtrlvObp9D2hi4rkrsn9OVZCTys=;
        b=SD9hgN0ojGvAMgBkaPR7vVy+V/uqt3XB73PvYY5YTgZuPhuOTuZFU94+4PawwdS1SV
         TjA4pxMCGDyYl6fNpRyqhBWh7lCzcYHPFe8ksTJFzF38bSYNFun0611hX6vC15OSRdyo
         +89JyNdDVbHd+1GWcA/8D/lw7CnOM6saFUNvMk1LxrnxvBuLLzdj6PiGZ/4t0WlgaJGY
         aifS6LY4O4I5u6DaZYM7HtEfF7rLC/h/sl/V6sH8KLIO3hMbFzAeRZgex975Nk5/5gEi
         l4J22cq/P5gpL7ZjZBLSxRPOBwC6b9T6ov0Vq11oShoT1Oe2/4BT/8hphGlpFTiG0S/2
         HrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977833; x=1783582633;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3V4W+G82OfGoCUcWtrlvObp9D2hi4rkrsn9OVZCTys=;
        b=Xw+eHx3AvRIBIujnCodGTMH0YkeCzKbxZyWIayrhm5kGubcqRu8h3XTytgD2rHrH27
         CuEDGdlefKqu6HexQOhsOxTsZO4Ceig3V5O9dDTr6g0Zcmsi84sYQ1WgyNELLtGJZ5Is
         QfdRsVknS4S39brmpzQtfW7ZtBy8HqjTd554W4m+mpVLWnsx6htb3mkL2oKkJOBwIGUi
         6ColjuX/6aA+pISIaS1b6aOJCrHRGQi2Z1JbWjHtNGQiv8Dl3/C6pDGw82cSEpmGz+td
         X6MMr2CmKa7w5/0mi9jQfnZhtICsHzZKUU9j//9ZNAsAeZDsAaUISPFJTNIR1T4idSdz
         6/OQ==
X-Gm-Message-State: AOJu0YxM5iHkmkV8zB8p1TPZ92JJ/yNJbjTW19l/9eaoyqaKNAzvHDda
	bMbKo+GqRpHtlTTtwo63jMJSmkXpBKYx8c4AXgWajtxfPzPtQea61UTJpupG
X-Gm-Gg: AfdE7cm4j1LgFHczep1utnCIlX9JGWT2PMQ4IavzPMFM9amwC+nXVEIWR7apqLk7Nhe
	t5DhaIG/T/GXA2ZGrZJCWSzjC0MBGqDqtBWxj2znquMEllCg/dNRvHS0/wMY4u+3KsyvVfCE2bk
	/FVZ25uU0Qx+lbO45vL0PSrkO//roAf41CSeAE7/tRScVrpSEJ9JJ0cppOF54Br5vV3syNGvP+M
	8QDbl4ewtM3rYmx125/9ZeibmfaipbyGi2mxL8EtY0MQ6w3Q0v4rlt2qJVjJf2fqBODlSdZQ8SJ
	SydXurxpmaEv3rqfHiCFWlrUf1klCX6y3reUlXSz831y/sb4ZZrwQAZ9R3eaVRcv1E3+dNmsqo0
	PDU3EKJxljfxVzqYuL5XLvMEy/mEw7ruuOZ6wAgaaNkNEgZLRMmc0LLoGNmcRsVFCbx8D+81EDy
	FpBhmAwRkjkIe9pOK7Cgzb+qgVrrQ=
X-Received: by 2002:a05:6820:81c9:b0:6a1:5347:2af9 with SMTP id 006d021491bc7-6a30d87d911mr2577208eaf.36.1782977833052;
        Thu, 02 Jul 2026 00:37:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.247])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30ff8e462sm1580822eaf.1.2026.07.02.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:37:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260702062909.4147641-1-yijiangshan@kylinos.cn>
References: <20260702062909.4147641-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
Message-ID: <580a7b90-97ec-37c6-6423-48f1acaaf298@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:37:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Jiangshan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/285712=
96294

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ff087a33f75d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1120250


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
