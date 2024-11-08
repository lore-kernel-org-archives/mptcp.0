Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFE13A27D
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060280; cv=none; b=PNbM70tpHL9oWMUPfvSbL8fR00368795THeOu9UKhvCi7zMffzrsZkYxSCuIAHHHgbk2x0fKnEV2BRyU+xHuuNAVqUkG0s4SSdbHaCQODDjIgyEDtrs4ZUGYZfs7cYDp4MJ/nVQvr3JIlTIbZD41h6WOOVewm6+ufditaLNNJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060280; c=relaxed/simple;
	bh=gw/5EqhFoW85+zp5481BSRRzy8KX1xbnH+h5oY0Xs/s=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AdYoBpb9TXrUlX8hWFDG7aC3rtLWRuxt0/Xhxhl/Tqe0k4QgLrOY6HPStQjKJqzpc1FVb8SlHb4vQLzT3ZeIoxg0Tf0IMWXC0JIrPABDwCovHcn1kksGPn7ZYRvachngVqzSHA4IHRglhvJAxAxpLhde4Tu6p90ewTDssUSw4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFWC5Uu/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFWC5Uu/"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ee3e12b191so859262eaf.0
        for <mptcp@lists.linux.dev>; Fri, 08 Nov 2024 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731060277; x=1731665077; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qOVmH4ubbdYHSE5aYr6BPB5Qiazfdzkqk3DvJdSQ2s=;
        b=EFWC5Uu/gSUC/5z3+HhmKGPdMji8Mo3vUo9oWWpyXuhxoGSq6MakdcaiVuaKhadEU6
         7lAP//TV4mU+kqTRdehgGcOT66LR4YKLJegPftGZGzduV+UKCF7Y8GnHheaMV3b2Bt5U
         FVQY3Nur3VFWHrpXYy+fYCfow8MhP68i8kIRmF0Kr74zt5nlMt5LwWzlbLWxmzCrpHGc
         aP1XO6Vw6F3drk9JN8BzwphPPjxar5WtWd+JS63tbkGU0MuKcJuwEFcGu90Ua5Lb3SAW
         hBY6drL0WqQ/eymCmQkrkKmE7Lq+v2gTI9vsntAsl1SDq5JdDeJ/oblnHQqITgYCgEi1
         SctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060277; x=1731665077;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qOVmH4ubbdYHSE5aYr6BPB5Qiazfdzkqk3DvJdSQ2s=;
        b=eFMKi/05pjYDqF3VZt9ZwoKXP+UaxJutFvd3To10/WyQ7u9b4JsAfsVBbq8ZR78hWv
         lC8luHk1cdb36oNHkqTciUUj5VO1orJ4ztD5/ORTGFXYbg+bA0xNCTWVn0vXlbRLx3BB
         y9tilB/GOx1FWmbY9trKJR6n6YpeCZLJ9w/tH8eyfw+UfSFWENAjtnucKcv7InSu0JIy
         p7eG3/Daj0Y2Nq3Ym0GSPAzWdvn+ZFGTrnFnUwexXY0QlPOwILtwsDMKtlm4MTdaV5UZ
         FA2oGx88e+Ukns+M5G/+Mia1priFBqPYlYp2ysoogJKolKQ68ZB/QNl/mJHpl7b3R9mY
         KLTA==
X-Gm-Message-State: AOJu0YwPJnxQE1qoe/M1Adw6k9uJCMxAAJ+aOp5A+UZMjWriiypd7HB1
	OLACM92bY/U7WficjuZMClYFeqnM/QgQ+LKv87goLP19aSGWgfg/r4QN
X-Google-Smtp-Source: AGHT+IHbhpmJEHpXNtQCwc5DVgtgLjSAvnMUuQQtpOZOfh9kYbcj7v8P2g9gypP0fsApADOqrNyWHw==
X-Received: by 2002:a05:6870:b513:b0:288:67b0:a920 with SMTP id 586e51a60fabf-295601433efmr2473236fac.17.1731060276707;
        Fri, 08 Nov 2024 02:04:36 -0800 (PST)
Received: from [127.0.0.1] ([52.157.5.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm3008349a12.76.2024.11.08.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:04:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
References:
 <aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp=5Fuserspac?=
 =?UTF-8?Q?e=5Fpm=5Faddr_bpf=5Fiter_subtest=22?=
Message-ID: <d1fbd358-bf20-0215-0bb1-c00b88f63be9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 10:04:35 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11739236551

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/19c0bb79ad1d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907691


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
