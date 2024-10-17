Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782641D88D7
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166954; cv=none; b=JnOceqD7+0gpQJxjm/MJSZ7YYqHiM/hWdQygyKpMz11mPRWzVbGTEhdc+RHsT0FK7gG975NrMSVK0GXHAv8BtanJ5qsEwvjWGVoRU3RYF0mgfYQzfXO1pBSQU2NaoIR3Qtrd+jhD8M5cMDYlEVRAtgJkztkyHQ+1ZA9Hph9c2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166954; c=relaxed/simple;
	bh=31OIGqaUvF6I+AZmnotFXwQe50LoC7dMfVP2mHl6Kuk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tt4NKEG026gLWC8vYdDGFNM/USHk2Rs26m9I/fZScEHE/hGPz1NdvTSfQtcCpodQjePPIDzWSCEbrWBKnfUKhAvC9MoKavzbo49K7zASCgY8HEyJz0jh98XrznNPXr3Rj8yRAsvu7i2Ne2wZtW1J0TBQGKdi7er/XAZbIMnOT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2Qwxf8d; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2Qwxf8d"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4603f47b2c8so8818531cf.1
        for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729166952; x=1729771752; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GX+tDC4Pp2xBYirRDb0Hu7/ZB6hgPKFKBC15Pl/4Ig=;
        b=c2Qwxf8dSrGvshuhbyRh1i9XB5qL6+6XfeI2kqOsqftGTEp6aNQTGQocP2balhrEM1
         msbTbcaqM4DIZq5uQwDXZW0ZWKEP2ezo+4OJwRF4Q1KKq4hGEWudbz1j05Tygj8kDENT
         rkawDgRtKLbNYeZ0e0/2SLEt29pZYwsna+wUcMxR7h17/kZI4sPkh6zz1c1OzP9Tz4aw
         NpMKa2zenqswAOgdp+nc9ThHvQm//e2cwSa3scaNxPbl4YRQjoAh38V5P+rqyRl1MJy0
         rnkgrK6tLRN0X6/a1LeWvTtupC/GFkPNvZYWCP+LXve7D9vpVsyCHv1IBycUeviLGOO8
         OL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166952; x=1729771752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GX+tDC4Pp2xBYirRDb0Hu7/ZB6hgPKFKBC15Pl/4Ig=;
        b=IcqljvHZLGqBj8NBc3q3Bqh4IaA1jhXHTgV3Lj8Dv9idRHxdkYJbakRWKsCTHLS2of
         cMwB+/Ul3msVRLVM0jRhIxo8C9KKM3v5b7w8Db11zJ5GqBtS35mWXYGwLdOnokT9AsaV
         h6ziGvXiR24UJfJacsW5XLmDN3pefcptWL9G/OACCp6XvnBOs485KJhYL4jGnuAc17X2
         4T+L5EJBQcvHhhx/8nsMEkb50F5Y1TaX2lVLW7TpBeiGc7V6hJJ0Ea7KrZjBYLvlH1nC
         TGiTwX4otAIOvD5hrU/5dnf9sMwAjcsOrKf+UXTr0dITVyYvASY4VdLve2hunmPF9nbB
         iWdw==
X-Gm-Message-State: AOJu0Yz159pDHf+vFvyFcSF/yE0iAB9QCjQpUmueaDkJN6n+8LSn1xlB
	sPhsem2aC/kTFQBrE2rlP7q6ADRc1ojj+Xo1XD9jDQTrQMW5/DtK6QUX
X-Google-Smtp-Source: AGHT+IH8hka/z6/brgiIE74Tr8lL9kBJs4+inzWoIdiha/HpyeMmikHoGTuJsmxYiDOFd6+YrCkSog==
X-Received: by 2002:a05:622a:1a95:b0:460:850d:cbda with SMTP id d75a77b69052e-4608a516e51mr111886871cf.31.1729166952316;
        Thu, 17 Oct 2024 05:09:12 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.5.238])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46090351d27sm15946021cf.47.2024.10.17.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:09:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729162349.git.tanggeliang@kylinos.cn>
References: <cover.1729162349.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/3=5D_fixe?=
 =?UTF-8?Q?s_for_=22add_mptcp=5Fsubflow_bpf=5Fiter?= =?UTF-8?Q?=22_v10?=
Message-ID: <432beefe-07ba-8a4c-0bc6-0c620c5f35dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2024 12:09:11 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions=
/runs/11383799550

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5f1cca141423
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900187


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
