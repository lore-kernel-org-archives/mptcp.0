Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB8BE4E
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709469634; cv=none; b=GIrrFjk0FfBtTaLf6yEAKo1ix+wl7xrP1SJF372BRe0N40umFgRfQoCKjz1ibSfIT/0WWU+FP5aBXA9LJ7cPaFbeQcG6zjoSRQ2WqQEfpDZfIFRKzq8YzyqOe6UJ68EoEyVxCCaraGhqF/WhYFzlNHxNWFSqnOmYlCHvA/uwXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709469634; c=relaxed/simple;
	bh=uINkOFupGnGAE+dni0/aAym/u0ciePsG98c26FXFZB8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J8/wriXuUnO/K/P0/UOHEe87yu+n9ZOZdkeBAUJ8xEDVzqogGMS06rqhTeoJ/ZjHtXlpv1LYtmK733szgM4lJs0nmEwXpGt3Sc4wNay/9bF9kRigLDviiN2XlDecLr2Yc/XKTPVQjaUB7LmmpYq5J8IMqQkmkobnmBJcHPR3eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAmeBtq9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAmeBtq9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f571be9ddso33173166d6.0
        for <mptcp@lists.linux.dev>; Sun, 03 Mar 2024 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709469632; x=1710074432; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYOgvxAuw02w5xPgV+saE/NbYNpotfM9OWmtfq5uevk=;
        b=mAmeBtq9l0fwTgUjsQwhSTyFQFfH4jAlE8KtzBLIC0k/kEj1IHZ1oBGsdBc0jHp4e+
         Yc4W1rKw/4JRzy0Exs0q9HcBFNNMONCFyde8YS/mqpHZX5p0XrAhx9CYuS2V69l7G11T
         C88U8BSsQe8ZYunDqpjXEJpCVOsg3Dv1bJ5LdZ6CU5wlD5tCbgRZj2PSh127oYv9NXGs
         XMROsDEMac5Uz34VgpeDvTZUvYz6ARVjUp0Y8vdNH9CUHQ5kMAJHPXuQFFm6ql0BXr97
         TSrHNh1/KtM3VfWThcqppMxq2mgjKvbwY+eMGLzoO3xV6YUOXa4qnCJ0t77BaYeJ8Z3i
         KyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709469632; x=1710074432;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XYOgvxAuw02w5xPgV+saE/NbYNpotfM9OWmtfq5uevk=;
        b=Hxo3na48iTO9tZMAliaUy61w+lxMKrOXbssjsKDpmXcvFphyuq02vBHjK7GkUizOOW
         p2QU9f0rwDoOtiXi+0CsdGpIclpIXUfJCSgVipr77fm+ZpHqjG7W1EjiMPK8fY4rC74C
         r1pZHGE+19h14vx0mmbeQel5BSXBMVeH1AaR2smEURHnOkSE+Iowv/DrtNtUzr/TA9bQ
         PFOm6tne1PFgSqffXmUCf+trCQhsCDSD0tUV86Ia+Q34fivfSg6oVlhBS55rI42j9LMI
         rO96aJg1iGr/sCI1fk08p5ZFnOcnWl9BLZq78s1rpoIiTzmIsf/appfSoIOa3Zb76ewy
         4X2Q==
X-Gm-Message-State: AOJu0YytWRvA5ntf1OLNlkIoKnw5YDoW6kEGl0ReHmcNUR8+galBt2dv
	+j5JYGQhqKbVMB2ShUeSNi3+SBkdTk7+CtkfjZfo49j0mk5AeFvLlLNoHiI=
X-Google-Smtp-Source: AGHT+IFGAAmfmo+OcR6xaOTcyVAxR5HAwzgqCTz1oJ2i4mI+k4EySn9E53vYiDrP73pyLKS7EkY2qg==
X-Received: by 2002:a0c:9a44:0:b0:68f:60fd:d328 with SMTP id q4-20020a0c9a44000000b0068f60fdd328mr7231939qvd.43.1709469631741;
        Sun, 03 Mar 2024 04:40:31 -0800 (PST)
Received: from [127.0.0.1] ([20.84.127.106])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b006901303d90bsm4010754qvb.79.2024.03.03.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 04:40:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b95eeb617ba13a563b9f8c71d784a0f776e93877.1709466624.git.tanggeliang@kylinos.cn>
References:
 <b95eeb617ba13a563b9f8c71d784a0f776e93877.1709466624.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <bf9a1939-e86d-0fca-10f3-add5c6641c70@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Mar 2024 12:40:30 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8129994768

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1c52e9cd3c49


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
