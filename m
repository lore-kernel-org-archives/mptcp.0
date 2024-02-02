Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC67C096
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868887; cv=none; b=BKUzSEDoBdqaSBSiZkLF38VN/q2chdvKRbpBNCxOkbPN2+qEjYHFoR6EXxSYxSW5/ePVSG1ebkpR1viR48pVTmaSpppH5oT6igTxtoFrcffL9Liu56iOiAPfVsWh4VhsPPzyxeWEa9b69a5AknM2Ijv3rP3XYfPx4TVyWoy+i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868887; c=relaxed/simple;
	bh=cSjbhjWiBkS8JBYUTVqk0FjhwXFFXUDf276Uh1ktJBc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BNNkXOY7v21ISpvrhu+WuGgBifcFgDp4Ln9GynwaGI0/Di4hyvR6Z40fWG4I96qX9c5TkRXL/s/EMEkJKa3TKeUcFvf0Xxj+Pq1ohBrnp3qB4daJTgLJdw8+7PbcbQMFzHUdCUHlbXNCCvxSS4l7JD3R28A2iCx2Dzet8Bj2kx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5cgai00; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5cgai00"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785515724b5so42517485a.0
        for <mptcp@lists.linux.dev>; Fri, 02 Feb 2024 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706868885; x=1707473685; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5kEuPWTblB2pPe9gqzkKxitF4tYdstViIPvbvD0kGQ=;
        b=L5cgai002fCtlCMPhHHa1Ssh5uygWPGtOVknj+HWnIs6nGl+EGi+bjNuj3OgctYyyp
         EYUqI7L+lj+/2q2gIAzwMY/CEAogaqcuRar2r+ct8jLOyDZ7KQRSeSHEk27K99/ITHxe
         IsZayaeMz1bEMEseAxSi8HUM67DGrNUofJBf+pOGkHZ3gKxn8nhopGAovy/WRuYPhRaH
         Bl5xqYy9HQjTOIM+du5wx3GJ1vPbJ81KNyP1LnA3dtvppm31BlTHj3wQgQEKGM+Vaxxv
         r6nOW/Pr94uGJjBkguuIBaFm1rFRldN35jBIOY69n2SEfArJO0HICTYgnMIuXLvnbQVo
         veDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868885; x=1707473685;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5kEuPWTblB2pPe9gqzkKxitF4tYdstViIPvbvD0kGQ=;
        b=HuRn0COBwbL4IP8LvipF52gO/9jgnDbBy1G01jTrDBGomRYGJ1nYw2YOsec3l7pkrA
         0kb78vZ3gOgWt4WH9abSRsOzfyjNQfKNbgamMRiS135ZQLP1E5PzAK+7PgF3qD20Bjuo
         wk6drfWRHwLHB4aolZC0Iz/xOU/gTFWA3zOKrb2CQ5SG1lXbST1kxSIWAa0dunMpGaGw
         rTdiub7kkKJy1XLnQ5QgcLidW9okaEtzxrFws0vOBFdh2N2mj2wFWwOM3dL2Lq41BH1j
         Uymet12AeZEiyySi6qxPuHyeStsHqm+0WusDc+xP6Kk3cLC8QnbA7DJRmVb/0kyax1HR
         GUOg==
X-Gm-Message-State: AOJu0YwqN6N6cHMTTcNxUxpqyu1E5rJ6sHGclv1oqwQWO0GWjTriNFpc
	2xKPJOGEoNRcpDT7HjZr8JjwZoHUz0sU8+sudBRDiZXkvBHFh3yNt/pNEb8=
X-Google-Smtp-Source: AGHT+IEAmVvQ8qm8XS64FUzgfl6ok6TEkSunXTXD/tICLJkZi9kMgJuFXRwe+dQF2NhnUHFDn/hEXQ==
X-Received: by 2002:a05:620a:2293:b0:785:4129:8c4b with SMTP id o19-20020a05620a229300b0078541298c4bmr1667211qkh.77.1706868884953;
        Fri, 02 Feb 2024 02:14:44 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.224])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a145100b00783268da8f0sm564044qkl.40.2024.02.02.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:14:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
References:
 <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Add DEBUG_INFO_BTF checks for
 __register_bpf_struct_ops: Tests Results
Message-ID: <54a68a4f-f081-d7b3-a5cc-325b29cf7735@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Feb 2024 10:14:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7754058433

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c2c76443230d


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
