Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3E1AC43A
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850428; cv=none; b=LL4TLkUcqQVasY6WVy527lqIgLJ57Up9r+jhHP723WH5FBPrmhEStjd+qMYhoVfkBDP6ZSpCzp0aLvx5RTLRsAPbxutX5wFv8yZacy5cuC1alOAQyO+zRLMOfGc1DRR1vLf6F14u4TIemWAs8O5OGnplk5A8HW5wXrYQwoh8ShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850428; c=relaxed/simple;
	bh=9zzOywvZM7CagzqPcvHVUw27ZmdO7+ILCPs0Y6OCiu4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HIcsFg85eCXxcXqXaAJH5UoM2Xpexo8b9J/5Eb5dOm+j7ayWvsLJOOvnwZ4wN2wMyXlehK3WI2hWAgDCkzkTf7tMG8q1gI1CdlnqycdrLpgITf/gf23W/Qntu+TupEnfFGlKxp1Fv2hKrpda29YRJ3arQVD2lHbHo1LCDddjeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfclAYfq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfclAYfq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e285544fso1088073b3a.1
        for <mptcp@lists.linux.dev>; Sun, 08 Sep 2024 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725850426; x=1726455226; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh3myRiDUUo34DsmACJV30GR02Z0lsj4th9XPy+scZs=;
        b=TfclAYfqNd2gn/9KS7dpg9r5PtE9Ga/sFj3VKjoebgj20ZtPFVvD3Wwktr9a5CaVwX
         WF8Tf8ZjOnPxXR8pLocskfixJckhtnzbq0bnVDBt4kHnjOwYqxbopNhOYb9V2rXqG/LW
         cPFu+KKdITt379zRS1zeiuFauz0uUiqFdbnnaf1zp7MMZppmV1Rn2c+6QQuzk6OOOwav
         RPqdIbf5PBi3mfj3iZ7q+p/eDwh0ElHjLO/N41hdngrmhWCv/EiYuwAshgsvkjp6+i4+
         dFlumThkMz+TUqMfvSoDNXFX6y8GIacWcQZPza9aZe4zpsEZudMZBc/UDU6FuSVcq/cB
         WmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725850426; x=1726455226;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh3myRiDUUo34DsmACJV30GR02Z0lsj4th9XPy+scZs=;
        b=lLb6JrvNpnLII1bLhOHerpDO+YHG9JqOZXzCQK5WM0QUUxM9RfAcxCYr+VW9fAH523
         ofoMuyMV/8IYdzM2omigrev/A/h7TowGDE5FUqfd7GfbNfx/TrYIjuSb6uPWFZQKdKpE
         mEOJHZxq2VTjTzm2nLgKE4Z2I4a8p39SYdE+l5aguiwjEfonj//MB4uOoNh5831HhoMr
         KIfFLT3EJ22Q88dsPkrmKmkbfZGBOuPLPNSNZohBEKLHqjo3Yr6xpTadeR1x+c1vOmNb
         FIsrjyKbV5Dj0vEX93B8bHSAONUJboxwwogtH9DVZZBv2mUxnoeZP+ihs/KqTTnYkLpo
         dZnQ==
X-Gm-Message-State: AOJu0YxC6UAow7eoBe12j+RLaLr5J2g1eVgNM3fJbU+BE9bP0XtE3Chv
	ZPA1b4aOODUMTON8aCdqeiPHoi0+YMfv1SU9V7k4TzQOxyohqKemlGWY
X-Google-Smtp-Source: AGHT+IEieZmpvtvPV9mmLMsEnwrTFwl5cx1kWH/1NOZWmFvaUeAxqj8KppWuDgKLVCicQP5FPoxZDg==
X-Received: by 2002:a05:6a00:cc5:b0:714:160e:8f5f with SMTP id d2e1a72fcca58-718d5e17429mr11131855b3a.11.1725850426451;
        Sun, 08 Sep 2024 19:53:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c6c68sm2573096b3a.85.2024.09.08.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:53:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/4] cleanups for bpf schedulers
Message-ID: <3cd3477c-dcd5-44fb-21a0-f3246aa3f7e7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2024 02:53:45 +0000
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
uns/10765309807

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8affd0df00fa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888199


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
