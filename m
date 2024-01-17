Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36841225D9
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513721; cv=none; b=Qm+xTQ55lcaKej6G9fH1uAhmvaQ0kv07EEurwNpmRonl7iiS6v1+pq66ysigQ7jR39DnAgNYHmo7KjdJCr7fRjf8/EDrtcXpG3sQtzejVq6LR9nH0etIjKu9jTd5/QmzqrLZkRbL2unA+0cFI3QEzuwi/nzaz8yz6b1e6KpAGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513721; c=relaxed/simple;
	bh=KwfALgAW7ZafB8Yg5PXZ4S+0fMVjIQCRL/pmKM+W5Ek=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=oK42SWgnabdltmYRtDPGi4hKwbc0+A1R+KNktMXe6kG30OCMsAoGdgTPyVepQQfFdHMDLtV4OTvQafwFqsxJWa+AeyqoJUjLIQ/uyk1jYHZPlpMgQDRLDOEzlCNCGUfvQ6VgOOMPUENhNNtKyTCjo25GdIbT+73+re+dyM3F2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asNtL+u+; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asNtL+u+"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed0710c74so9018341276.1
        for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705513719; x=1706118519; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6+axSbc9q94ZGCo+yopnKCwPUIV2owISdcw6czbcVI=;
        b=asNtL+u+XSFFjbWgRuJ5iqydCg+/RKCqvQ3P4r2ge/Ke0NKov3RsFthUxm1aiRLFNG
         vDZOhJ1sJj1lRTQa8sQIfdRpVEmAW8ZA6eYTOQZAoqx7qbX5eErU9IrOVZTXoWRewGe4
         gUgZ/rp14U/sXgAPC9qXBrpS8RMWebgE8W38LC7WP4VFW01yQFgsvo3DGy/VjgI6RR3h
         6C3P8wX5hzrlCpRBP1OoH2NUAmCFRDCyfc3dHxr6/h5DjU8nQDq4t9NdaPGWgme5tCr5
         0HDlpdeu19SJYyGh14tChIKHAQq/X+ifPxImgqGzy5aZ92AupeZEXeYP96R9GEYXySCp
         yEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513719; x=1706118519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6+axSbc9q94ZGCo+yopnKCwPUIV2owISdcw6czbcVI=;
        b=PW4IAB89sLCXsNpX6S2k0RYhmPjiCGO/fCkSVIAA0Rci4IMdFdQ5guuhicZaw8W2kG
         ytNxmQuZrNHMdzhJc76nEMjTqkhCCu3HPhoV8fT/U/1AiIaaEAg3weY1lDgy1AmDoXUN
         RPaTTilOvcxmcHSX/BbxGgwkq1h2mxvMLi0n79C5KxsgUZq5SnJdEo9vAaWlSn/jXBsH
         AfYhCLpaxTUO+Mosyi7Pr3gvuJWCHtyCLhdImf6CaKb+GRV2LYRFSGibtsK9FnDhniRJ
         HiLktE+f/4ajHk3YvVZ2lyeWNUTEAyYitVbWW/l8tYniNKezMM/h7JLQPe+xmey3CLmk
         MIwA==
X-Gm-Message-State: AOJu0Yyn5qFt+4HGyivQuxC/Wl0rjoDOmBwuAX9YuL4LI/c63reweYmf
	tBBMQ2M914YgFzJOetlxWw==
X-Google-Smtp-Source: AGHT+IH9Yose1ufH+e9lVVCZJYcw0cznpVjCqI79f2iim7NhVTNkmWeFHCpvaStOJl9rhbelP+P/QA==
X-Received: by 2002:a05:6902:38c:b0:dbe:cfe1:3714 with SMTP id f12-20020a056902038c00b00dbecfe13714mr5888550ybs.124.1705513717909;
        Wed, 17 Jan 2024 09:48:37 -0800 (PST)
Received: from [127.0.0.1] ([20.49.63.251])
        by smtp.gmail.com with ESMTPSA id a1-20020a05620a124100b007831fbfc8d0sm4624156qkl.133.2024.01.17.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:48:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
References:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
Subject: Re: mptcp: annotate lockless accesses around read-mostly fields:
 Tests Results
Message-ID: <d93526c3-ca0e-325d-7967-25df04e318f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 17:48:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7559110630

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/64d56009713c


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
