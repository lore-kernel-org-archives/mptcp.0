Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7055E43
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290720; cv=none; b=tHIisTr+4NoAdpLEBPlI1TWPBsQRKnFZvdlNpYLhk5XAk8bTFzthZDJbn6jGESrzOZeZ9M99aCS59y8Nsf/yvkI/qMATPftshsXSI5bxX1RWRvkynCAYSxfLtPFgHNi2MPGmiIybJTKTp0Glh90FdYfOYaLbzP4+yzngk3wStsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290720; c=relaxed/simple;
	bh=7cp4/v2t990tOT9SUSmtvjswCdaYGy5cmpO5W+uNFa0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=miat/ZnZYXdqpttE7AM67tPMOy+eqXgIXC1uKbpnRrsIzk3IkEVN2WH9fxMb/WNptKYGW+7UAB1kVt34KRX8EMWPU9OV39xqoVu2ck5fo6tGinwllFJ3tsfc7iZEha3/r1OZ6o2IhlEmJOXM0YWRoH3ZBkUY/3FPvwrEE8Ev50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBJT79V6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBJT79V6"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61be613d903so38548367b3.0
        for <mptcp@lists.linux.dev>; Tue, 21 May 2024 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716290718; x=1716895518; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNeHU6sfgFdHcZ2v71Vmf4AgqeyRm4BAijPoV0P7FHA=;
        b=mBJT79V6z9APLJkrnAr3TpDlQLwII1C122O0rDyPdssbSowd8/A7SjI6TFKU67Srk1
         8ndbsIwKvUEa02pB8+uZdgqzvWopZthKb8b4mE/LuMm1OKGl03grHOlabwciJ1khMaiW
         K3D8OoxDNQAvJTqEdkoX1eJ4XucpcEzi26CeF53f69DCIatD4DnukYIxsuobcBfKwOs3
         4YiH6bi/eJ6Mna1/lEQJQYhTk1wYPWB54eqGQN7yrxlbRBGzjp1fs7UJuh9y/MqP/XZU
         Co1pDhTY/L3WNsVzLKCpMosS4SJbd1xJF4TkiUyV0YHlpzvHQlDXSM58YA0pVOZEeQMk
         zqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716290718; x=1716895518;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNeHU6sfgFdHcZ2v71Vmf4AgqeyRm4BAijPoV0P7FHA=;
        b=A8BSEhbBh2gSg7VmcjcAg48KlZQjlvMJmxb0aOrvdR4uibQSkWkxvCjGKZ+aCY/sPH
         cv+v45MH5F5gzjJQVOgrl8SM8AEAfrTxL7Krh2Xa9Lms9VPQDip5tMMk+bg6fPk14SJZ
         3y65Dyf/5kkcWPco6dzrONG4oS0MmrFIB2exRS0fACRxV8tNHSRhGl5jC3tVNeDeH3uv
         T1bhjUuGLJ8LtIBcUbadnGqeyPgQ3i8H2d5e8uP03k/4Ma24THF6pVulgIZjrU0FrDF4
         hNht+o1dcZt64DPgfeJqSiGpORJCqyV4tLqANwQeq9CN8YNFISbEE/bl6o1DE1uREkAG
         EEzw==
X-Gm-Message-State: AOJu0YxoBLkZMzfF+hMsEYUbvMN/AX2uWYkE3V7I8rowJ6h7aHdekn7a
	B7H70lE/jPi0yoljNPFg32v9CYw9oV++xkNL3rNvgVRhTNRTdisQ52Iz
X-Google-Smtp-Source: AGHT+IFaCtamtjDykuSaTW3rt8+/axSYyRhqsiGsTK5U5N98QckNPDKGd+GJV+++rUEwyN4L9EhrIw==
X-Received: by 2002:a81:9151:0:b0:609:ff2d:1814 with SMTP id 00721157ae682-622affd9f31mr316934887b3.37.1716290718039;
        Tue, 21 May 2024 04:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.238.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a354a0a802sm68029516d6.81.2024.05.21.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 04:25:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716287732.git.tanggeliang@kylinos.cn>
References: <cover.1716287732.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <4948ce95-ea75-7997-ff3d-1f54d800a536@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2024 11:25:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/917339=
8814

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/80b3dee68420
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D854683


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
