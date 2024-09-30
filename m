Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879E192D63
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717332; cv=none; b=pzYhIldHXj0VhedT4CzqoARwR0E+1sZygzo+If1tM+6Iij4yZ8b8vPJoY2vz8L1BIDYWCFFw+T/pmcymbh7sb4atWn98MHmaolIbfjHKJeHAj5lJfJRPlspybdSyM47I5FeBZLMpd6BN7Ild572Paf+atIWoKJq9ktJuD6hIzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717332; c=relaxed/simple;
	bh=W2rdz4zkt7satrKDASlozAMkwH/ti/JvcE9f5orIHU4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fPZ8tj+8hsz56Qs5KJSRIy0BcZM1SqvYMdwPuXOauZiaN1O+OIhanobiHGpb6tgkF1PMtEFUh+ytMYbnDbSXosVyV/QvJSJPD1c9pJie5RI2/RTi2M6cb9dH2AMYUa7ptHb5Ev+62/vvAJw/UgA3SiTiQ92x+Jp0BrB/LQIknnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTRVO5Ch; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTRVO5Ch"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9a30a0490so525031985a.3
        for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717330; x=1728322130; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWaPwN7mUsd+AgjCL/O/t6kAHcu9A1elPGkH9WWg/68=;
        b=kTRVO5ChxA8Cd0vXai89wY2bVUkrMfRDGuWsk1x2GddIfdfxVX6ecQbRr+4Ez3JjfM
         TX83U+y58/mjMWHtFyaqnifNpN7V4uSLjSJrIkN+ueMNwWVTXYEnvt0r2f/fXnxDIijl
         s4GWj/sn/kQrPIM2o5y8WAdlM84B16SZwMkY4xCNWJ20Jkxuycc/zRPXfu4wFD0GfFFN
         rrYC5N77Ue3VW0vE1BlZEy065GW59yDaQgUuRdlkc2+VDclqjhrA+SXGItHUbMDBtIZR
         MsM4hkUi2y160adjoS7Bq0YCM3xVPmZ1YEI9nRfoSlmReFPAAOF1QUT8OmLBi8C4Vlsz
         ToNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717330; x=1728322130;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWaPwN7mUsd+AgjCL/O/t6kAHcu9A1elPGkH9WWg/68=;
        b=ER0N4JrxPKt9uCLqrkm0wigyIYSpoMHCkvrYU5o4esyPsTmLfrE5PwGoCgbz3z1n1Z
         MdRpeWwp5WqZoO9l4qnd9dWRG0U+J5hIzW5GgjWb2a5iaIkq3xlYB/dMmCBwj4D/AOIh
         NGm2+FxGffjhb0Cl8XUOXFBLhH4L2N2SomhpFaQoI7x0i0bqJ8pZljrKRsW4z+kAVAK+
         yxHkUF7mcd2fhlMqQap341T+E12+CPnwdcPYiuqGqQCyGJO5OKGrYKPpdCYK0icqLevC
         Zyjc7jYx1BZvVIIKf55PPWrwctSZv6zKWv3SrFFrALfvH71VQYs4Vy4NBJNetINvwTsH
         duYQ==
X-Gm-Message-State: AOJu0YxrcK1yPXjHg/jkkLdHGx4BfQcJrkGSgUTBHpf4L0Dug/BD3XTZ
	lpK8T0PzI5T9YckXYtdgU5Y/8Eik6kF047uDiuA3k8t3kK7DT0qBUdcD
X-Google-Smtp-Source: AGHT+IFkE5F8PMs/A4sETiHKOwLBM6ma+6rPgUxYYk5VLeOduh/kzHlVK/j7QVs+kvlf5PxlQgahag==
X-Received: by 2002:a05:620a:2a05:b0:7a9:b456:c5e6 with SMTP id af79cd13be357-7ae37955936mr1927483285a.42.1727717330064;
        Mon, 30 Sep 2024 10:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.76.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d269sm428113185a.116.2024.09.30.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:28:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240930162345.3938790-2-matttbe@kernel.org>
References: <20240930162345.3938790-2-matttbe@kernel.org>
Subject: Re: [PATCH 5.10.y] mptcp: fix sometimes-uninitialized warning
Message-ID: <dca50c7b-b072-8ee8-94fb-9e8a59e19a81@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 17:28:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11110355350

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/56a5e603a7b6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D894151


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
