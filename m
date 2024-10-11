Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408920FA83
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643149; cv=none; b=i1AzTGvJjelDQ5DclXsOuoLTuDas8yT8kIKU/931xvxix/mmp2lig8FUFT2sbm/soJMrf6ORTQ7eT6iygoP9rtBanJ1P1TlDGAtDGuB0utf62iYhBAbXEovpmWvoDTuJh10mIXckszofLFh9SGzAJUD2o6T0h+/jKcHEYcuK/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643149; c=relaxed/simple;
	bh=SI+LDaACaYRsivzOY+B90UGG2lS3KO3mcuciIPSI4MU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KOiqtbzfn2zJhHg7vbzkd0EuDLycTJox0y+wW+MRaU93IwfGRxqsrv1vXzieOEITvJSEN/kXkQqZepBYSLTbPKDDCRkLa0mlcVuAoPp8BDFXA6OMxOZCzFdFEgukePRBJGE1JJBQ5fSLcHYC78KAX+aJk2hqfi4LDxwHmO7gd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT0rLn0k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT0rLn0k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c8b557f91so12482275ad.2
        for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643147; x=1729247947; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta+3tLCjWMRam5b17FI/8H36xgrBh7SKnI3dpte9fLE=;
        b=cT0rLn0kA1IvL1pny9m7Ey5IgTWkaolHzkfx6iOMYG72VQsfGtEcTEENVPscZUG/Ht
         2NDp+QN/AtOnEwkiBWmGvcXa2rP7a/lK7kMyOXK2O8wVyCGO/lazfhBePXZ4etIyHkWY
         qO/0P9Qzj8FoqNOdxCWcbzHnoxYZ272T11wDVLbSJt8lKLRLWbg/f22mQ4oC2KA5EIUj
         WhLrnQTwMjpJVmnDBZCBud1IoDRIp5lNR+jClDQj7tFq3pG4nfMf93yo+0a7O6s4uxus
         73xlDYi55yPBADZVJXJtNDWvordMBBt8E2xSlfX7oFdwuJ8OVOS2akHkub8Sma9KLjKh
         +6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643147; x=1729247947;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ta+3tLCjWMRam5b17FI/8H36xgrBh7SKnI3dpte9fLE=;
        b=hZO540NPprauXyEZ+AWrCjrpWc51lOvdw53oPzrl8UUzZ5Tu/a6iDGYAWkvwdF1GWZ
         NxJiioFEm1iUVMoy162RRRYa9yY76vNCTdeyoFiBRVc8XCuuR1Usmzhf8aTGMlo2qgy6
         Afzj8sem4anl+R3BngKWtKiMXcledwyegXsyE7gKdhiTU6Zwff/BqTWwaQfrC31aF/Pb
         IhQoFC3i5BR53lNzXwdnainNBS8qz4GWJ8Ck79bXDONtj6IyRBMXKx4ndet1KYCh2BOD
         GxHGj3kPHtUjREWrnkMmhEqIXYfzzLwFqC6HFPt5x18m6LZm8hUZPvmeoulPVuCalVcI
         8mrQ==
X-Gm-Message-State: AOJu0YzCKi4VzOyE7qsCz18ADLNmtPDj4mI6LMaw5ctfdLq8nYeJ7EAj
	GR+ot3JYjYzVdLh+n9MZtr9ze8RX8TzVRFf9YXjcOLaycf7x4FnsfzNA
X-Google-Smtp-Source: AGHT+IGIbpEAQryOZYrp4q2JHfyugJDrVn7rmt1pZwCxheXzY9YjooYCIcOPI4IVyWiMtMiNO+Dq1Q==
X-Received: by 2002:a17:903:2343:b0:206:aac4:b844 with SMTP id d9443c01a7336-20ca142a1b4mr25828795ad.6.1728643147297;
        Fri, 11 Oct 2024 03:39:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.122.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bae3f87sm21328745ad.9.2024.10.11.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:39:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 00/11] use bpf_iter in bpf schedulers
Message-ID: <d675a18c-18d6-1640-a8b3-a6cd354828f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Oct 2024 10:39:05 +0000
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
uns/11290149421

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fbfdd224fa01
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D898148


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
