Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868938BF9C
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728667; cv=none; b=E4JM8aaar8BQ4b1CEiM2DeZx4twSQCK8hiGXi4z12rjdD9d1w8WN01TJpsxjUpgwXOAglkvL97/tLTlPOojKjVmElkf/PzgapF+qoM2a0A3eVjMikXmV1JjoerlpsglHuba1GPJu3wmjl/KUhUh/JSld+j69swOnPBlJaFYkq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728667; c=relaxed/simple;
	bh=Tlv2gHEE4fpyRzyNg8oljYkbTv5+GuisnsuBsWj3DO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JvWH5BHcvZrArU1eb4szsR6FRZNDB05s7V2dFyueiDqf9pPTJP/pEK7ZWl+MiTOB13JHGqM3d5UyjpqBeOfVfNmBDFTEf/kLJlyenj0lP74efJticbioTTfPrtmqDZhpMpsDkN+WHEORowVbQyiGYVn2mv1BSp3qvf5c95Xrmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adfnwPmt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adfnwPmt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824c9da9928so866003b3a.3
        for <mptcp@lists.linux.dev>; Thu, 09 Apr 2026 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775728666; x=1776333466; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZYZHvG3yiCdRKUYjlAzeAmJLJcJ+aJGZH/MNRYQH/M=;
        b=adfnwPmtHeMWatwT4VB3O1ug880lSr77XTXyrycq5KyGmCufgTpwdAcvm4j+CFpK76
         RQOJWLZOaxg99w1W6xIFM7vVyMKutMVSMHNNQ5V8a4sdTvRtbPbMItp5TQLoBDiQhuao
         8WipIVguIcbKqN0tPGTv2hrYXfEVB1tvLQ8zpSphMnu5U5gvReBc9MY713jhyTDjzot8
         jHy8P32vFoNUYiBStT8gFI6avoa8aT7ljil+IZyiGLls2ZC3e7ipDjJ7QxkXHq7ps4KP
         l3IQaW2GmMeIGmLO6EfbAlGIKeZEZjNjM4jLcPo+Q7tYe2IMiu64rKdsSftju89urTqj
         X80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775728666; x=1776333466;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZYZHvG3yiCdRKUYjlAzeAmJLJcJ+aJGZH/MNRYQH/M=;
        b=hrBlFRjBsX+JjIgiYleQm3ES3Q+Med+3DglPGIrn0pFs7/rhM/QGwT7mZU8yr44sSD
         0qCGCUKGQHQ3509afVo+oGVrOIWRGFt5QGZv9b4RV93NeCbVpBOWi53l1kImlXxJUc83
         FjoOAAHJY81IlY8odOaKbnyKQoFDx994cX8D2I63AeVssRqDx+tapdhLOr7AjY372OET
         Hvl95HigxrFMsJX9t/doDZ3WEctR+ms7DFbOFVZ5EoJ54n+fyJWytcSOF1wsW7QcBmgV
         lk/y/UIPySlMUIfoOXfNFYzksL6uGlqsW+oQJ2DMaBK0I8Fjezr1xOBj8ASaicCqNUKH
         S8DQ==
X-Gm-Message-State: AOJu0YzhKGFKytZ7G67hXw3J2DZqZrMvjkJOQ3dRmtGgh5wEJJvxXOVr
	bZ4M/t0H3qtcChMT3lAWVsDXFd5D8BRmvcFUouWoRfLXWmSmbcZBgLeWLIk0
X-Gm-Gg: AeBDietXfvR7qKJkvWaGiwh+08DUuQUpSPRYjkSVGRWjXNkE1ou6APwE7oeXcPRlucg
	5vqZVWi3Yzr44Br9ZvyXTbdzqR0LBbpVO6svZbXORe4tRn02iYL9K658k3M8qfZ4a3QqUFQgyXe
	i5QZMYgbJW7jvkAn1M4sNm6bN6GahkAUSDUw4VjcRwTcXv6otPzrnvKAwMA9leme9FT9nY9aE0+
	YrC8jP4Lj/CRNQWqO8NhEqRU8ZS/+Fqshzu4ocVfgv3gvWREPGjwPQ7Kj6itz72CJW0T/NfEK05
	j2aHTVkYyPZG4j9jMHwY1Fcn83KfxlCB0v0Uq13/0zx1khI7VIWyNjn3429SehnVi7XLDRiz7EV
	+K6sSAlg5Y20KuNyEkPi9nVw7ucd0D8/fL7ZxQRvZfqV+rpSqShtGEDLAEpzXfeXUV+3ZVS2Iyi
	m4Gi4DVfwmPwjajd3a55cGyIOHUYnrrZCjerSLSyoqmyXMbA==
X-Received: by 2002:a05:6a00:1143:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-82d0db404c3mr23121424b3a.32.1775728665484;
        Thu, 09 Apr 2026 02:57:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.233.87.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6fdd7sm23736502b3a.48.2026.04.09.02.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 02:57:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775551182.git.yangang@kylinos.cn>
References: <cover.1775551182.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: sync the msk->sndbuf at
 accept() time
Message-ID: <f6ef8df1-61fb-bdf0-dff5-124207147fb2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 09:57:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/241817=
89538

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7359a54dfdbd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1078012


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
