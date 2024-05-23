Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D85FBB3
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454730; cv=none; b=snopW7mZueSo3wInjvv5F9YK2Xrdc8qDMNmVrk1M3mOafcsiUl/fnHa489E2mkTxS3w0AFnDC+YvgHv5wpAkFtNMmEhSs0DGfkOF94dHfDlFfw/yeKKcG12ljxGuammH3KwhApaRjrQCC6OHw05QBYVcJL0P8uvjv7XTXCj/fFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454730; c=relaxed/simple;
	bh=/swXHBDrj2AfSkMlmpQWvxBrykdGQqxgtff6AXJQEec=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BmKtZJYl5mreB/6CTrzvpxSzZoPHjv7teXTsQC+aW+IzcaUbHspruuWeAUh73pyTXQhIcMPsDMa6FTWrgRPmx/GkgN4xMtOi3wp24WbnZ5iw64iav42ydNL6lpLsduhCdlyy+slImB5G1ACrp4A3SzNrQbO7O75mZW07/jBGL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaWzQDuj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaWzQDuj"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a8691d736cso12270866d6.0
        for <mptcp@lists.linux.dev>; Thu, 23 May 2024 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716454728; x=1717059528; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBxHaOKd9HuG/e5WqirPoONIITG3GgMD1kvdTdVb4Og=;
        b=TaWzQDujSZ6ILWXmE6D9VDpXiP1N7yKOlL3upRQ+w6gd/as0MNmniRmB1Beb3dQ+B7
         vezAoMtG99pWs49d8v01zHEM0Iq6kLQthj2UISdgIXCI9vdHeUtXjzxW0alTg80Sd2Nm
         qF+nan9sOwQhqZKxB2mSEwYT200SUuAGwua/14L38cbj4wSDN7TJGtAXMaHkJGZeme3L
         b+lJoPfs2NOWRGpaH5p7NRzLqDBXoPb+kWicItM5iWuPhbIsLpV8iy9ovO07/52opeVE
         hKVpmPilZb2Au+bVBodjN2xrEAeyp3l9oWZzadx0L0WgoD8zlXPTvMV0CR+4z2NdeGCF
         0eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716454728; x=1717059528;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBxHaOKd9HuG/e5WqirPoONIITG3GgMD1kvdTdVb4Og=;
        b=fDk9EW4b5cgO1WujEX3VvQzqcDDoo/A4Njhq2BAoilGCAcBhzyg4Ab0s/dXckA7SwR
         5yl+aPeB8Zq+fmXc/uw215CTP9IrHINzD36LEHas9084WGJ/48/44jH6UqFuOgTkwAVf
         by5lJmIuBCWCpf86Umu0VCjUaf45mWND33UR4bwitt06gNHDkDN6oya6q10nsrK4nPPk
         8HexX4wrs5oG3GTysHOzIflY5WnccMfrFifksnWtGqYy9ozJ/H8jGHKSbjRoL1B74byu
         Lisny4v6F+7qL0LRZmL/0gdALk+V87DxS0z7e8DYrChxF6X8RkJ7S1D8Q53TE8cVhEnP
         dL8g==
X-Gm-Message-State: AOJu0Yzka3Q9zzF4c6il8MzaASBv+T7Z6KODQd3/3cq6UTTfn66RJN6G
	sJd7xE/l9WKeK7zuvPNEj7TKBHYAEUUT/AlyllTUEW7knNQM/+L2SZWh
X-Google-Smtp-Source: AGHT+IFy3aX7LtjVBnC8Nbs1cSzAdOnoWSSF6GB3biCgDjExR+h36HRiqJk/m89bfeaA2r94dU2qWg==
X-Received: by 2002:a05:6214:598a:b0:6aa:2d64:2015 with SMTP id 6a1803df08f44-6ab8f5d0e0emr29102476d6.18.1716454728373;
        Thu, 23 May 2024 01:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab9318e14asm3142596d6.13.2024.05.23.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:58:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: YonglongLi <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
Subject: Re: [PATCH] mptcp: make RMADDR MIB counter clearly
Message-ID: <f7ce4dc6-c60d-f776-66a1-8ac12e37000c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 May 2024 08:58:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi YonglongLi,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9204665497

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d0561f49bc09
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855243


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
