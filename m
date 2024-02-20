Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE178B4E
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453660; cv=none; b=OC7OElhlqOjsUShyfmVMdU40FzGFI03vDYYAg17gN8NTzxEO/LzxwKhRd21win5/0tNRtpsDZXoMMbaXqjGz+bM8d8lEgUg0gg3IaS/VXa84vCx9yR9pE7WDPiRojrdi2VRSNbNuDXf2G4HSce7F/VJ/HoKwXXsC7hTPGhOaz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453660; c=relaxed/simple;
	bh=JmSrn5KMKWZG7CuLmDMKJJPJgaY8zdM1svJknyfEWCU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kxEgGoHslQ8FhnT6XwFGUBorYzT6AA+/5WI9IaVYDZYJJc1LpmZxdu/l/bAzGL5UWdwlzjF1pkgmvDwTmWteKFT/33bnY6QEGpmXOS8sujDlkMR16ALY6NSsc8b95c0iD2eaKryDHbEZutbMf/S5pRoK2q2A4fhVkFw0TSr1r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtLeXOKV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtLeXOKV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7874a96a01dso185208385a.3
        for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453658; x=1709058458; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSbQJtM7Bh3DMsWba3jZhfLt0JXJuD7g4wjFmsyHQAY=;
        b=mtLeXOKVIwuVanIntVwzVTMKt4SfjPlsBSc4Vi08pkx6QCpLaoMST+NlV4ZFbaO3e3
         Nswp6gfOesGDJm2bXh1pUDjOnwyvFv7d0msgM5RvJbO7WpkEgqLZ8hcvAbeOzJTQJdcz
         QkKxtLNkB5KXPh4CDIyN2tNq6Im8LFlJ+RPHDgTRaHNnFt8ofbRjWnoWWaq/N3AYymHY
         mHkKSwCkhLPIOgRhYeZYjFACYvY82GAZiXFUsQ2bvS0DzLpuHayhuhneY0Lg1zmqn63G
         ereINPsFW8hvWSFKcSw8Sce0NJMzuGl78q6TGkfU6KFbeDTQDzBFsuIcjT/IgTqxO+ul
         rpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453658; x=1709058458;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wSbQJtM7Bh3DMsWba3jZhfLt0JXJuD7g4wjFmsyHQAY=;
        b=lJfyIf7IdgojqlYTGu+QcOsMJ1G0syutWi3sjDsc/Jeggc8tL7YN6t3AV+ndzWyc7m
         ZfyNmCu173Kb2RzR9XbDfWUItW6xQHXQIvVPka+QxIHmriKM9yWBYfBAQKmGF41+s1hO
         XO62M6AKYnFDqVGgVwKG0EOzoHHMTlJ5fi6k5i1t1+ENPsMCEqM2fhPxnyG+spPrOyK7
         4v3QGXwa1sFmdVWUNiBRTQC4wltViTpFS8aFPITG2IJKKfQmaejKODSX9Hz5SSTUZAzY
         6ekqOfETxTg0HXrrZYL/aQ325pVTBIOteE1aKLbtKEkYv3m0PlYj9prAbIj2KmanGXX9
         9lgw==
X-Gm-Message-State: AOJu0YzujOg/H260H6ogfSswq60lFuJdmKmExepe+Xy0JP0qJXzq1CGh
	LnE9++PBAJnkB1/7KuHSziZTdV/GVYDS2br8k5ZKGiCGHDdd9H/3oKK3syY=
X-Google-Smtp-Source: AGHT+IHG17iJ4+/j0d7TrDz81f/YW7AW/Aym7bogTPEgb7fYGj/28D7fFCqzbNI1OZzJZ+7dRdp1Gw==
X-Received: by 2002:a05:620a:394a:b0:787:6e8d:25ef with SMTP id qs10-20020a05620a394a00b007876e8d25efmr5376223qkn.66.1708453658224;
        Tue, 20 Feb 2024 10:27:38 -0800 (PST)
Received: from [127.0.0.1] ([172.183.82.144])
        by smtp.gmail.com with ESMTPSA id 17-20020a05620a04d100b00787346f1edasm3572454qks.54.2024.02.20.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:27:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
References:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <d7fc627e-1265-cd3f-a153-d85350b8b9cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Feb 2024 18:27:37 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7977793179

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0bb7f79304bf


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
