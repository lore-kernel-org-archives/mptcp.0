Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881281E766B
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853397; cv=none; b=hZLA/Y6Z536EJElQy+79in25hjk7q7PPfkBnDDwzXklQgVXxaIvW/MGVzsh52+qTTeGNbdajgjL6RDBuZwpNeqkGAxqUPNqlZmiTw81TLPxk7gCQHcFT7Sb2Qny9Ol3ejuym2Pda9n4cGPUfQvoHcI/zA/n2ewXy7PxeDfvFBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853397; c=relaxed/simple;
	bh=balrBGgNvarirPA6CvhjKiywK/7w8mdZP8dvS7w+1Io=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=s62m9B06PKNdIRaBY7gHCFXRL1S8fpzMAgBmYqBfMPW5gbejwlN8mSZQNtgG2Wxk+0e+s/Hzz4UunVcoC7/mkSBrkiMr4l3zp6JeAsKEG4ames0KWv7tKoEc51cK4ABoCwiBSZwbleDtmBizSVgLkZ/z+A0cHbDYP0Yt/hhpfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9UPbBKD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9UPbBKD"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1114035a12.1
        for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729853395; x=1730458195; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHaFrq9IxKNuAFt7xDdoPAiUxo6+zGrzuwQR8wmM3+Y=;
        b=k9UPbBKDthyGsUp6J5Bs67J9kkIEcJbXP+npuhO4ISe8iCHsnCYqT3EGTdRfz8jfJw
         O4MBXdZ3bVl1J2kFwSdRb3G7gQwtL49HS+YO5L1qsXJpVkzLxHvcX+0jOTj8t40xPvBv
         eudO7lVzGA81s/MmX01q7WTqCJBCgRgKPm23Mh6InoqeJMvfBC/5umfAoyfulnqSxrgM
         Csi4nt2/ror4hFpfFm1zj+Y32tNUEWk7NvhyTXNG0zr165QlH4Zl0mAV5aoXeZfMYvWC
         OX2Eo50C+RglIwtHXnVQoU5J6Lh5iI/W0c/fntg6zF9P1bLHZnLOhneRIQzlSX9Qcx3P
         sh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853395; x=1730458195;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHaFrq9IxKNuAFt7xDdoPAiUxo6+zGrzuwQR8wmM3+Y=;
        b=fM4yAX3y6Hwu1A5Ml+YvyKqsBnJedWLiXIU0pT33WAwS5AbE9zDi27GLgBKJufytVT
         QPafyjHpDku+3CndCRb4EfA9H4Bs8JU2M85zAkirC8hN5n5gjKvlWyfnH5y3qI11m7G7
         h3r2si0Rb4xFBbzR6WSl8C09YeDvhleVXy9W7duVxadbjXvFAL8sUXYePyRRfL9srEk0
         hC5kgg/VgVUGwAjAmCL76i6oR1/U/MkVET33eisyR2kRBeub5fPpyctNHACmcDv75PP7
         Baw7OMKwgSF/CBY7Etd6lRQ6wOcmm7lq2p8b0qQOdE1Evu02aZ1+FmBO3YoRhzur4z5a
         AWIw==
X-Gm-Message-State: AOJu0YxMUZ38aVdXzqbRa8BjI2DQXcwGuZkitr17JCIzlUKUb6NN6BCq
	rHK6vIwXv8wqDB87DXkkfrCliDgGUWbVBX0Z1GlIXXrdHn6chbGknFRI
X-Google-Smtp-Source: AGHT+IF7pE8IDo2h7/u//Yrt2Mx9wEEPAby0m79a55OHDWtue8nE+SRrLHaZq/S6kNVIoHNERh+Wag==
X-Received: by 2002:a05:6a21:1693:b0:1d8:aadd:64f2 with SMTP id adf61e73a8af0-1d989b15a4bmr5834908637.22.1729853394626;
        Fri, 25 Oct 2024 03:49:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm805060b3a.115.2024.10.25.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:49:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
References:
 <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Message-ID: <93bcfc4c-c9d0-be52-2a3b-ea9510ab9af4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Oct 2024 10:49:53 +0000
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
uns/11515979216

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e181d411224f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D903060


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
