Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013715B54A
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925109; cv=none; b=Ga+vp529yl4u+7yHEV2ok4R0LP9uLcHpJHRJTx0z/wmM/xec7VS9Za2SDFNWvJdyP3DhUP9TWr7omB2/Cjq99R/FXFSdZmhB8iAgNmnWcvmUdq0c3Ha5rrybPIygAINbotvYoqSdMc3pjNN2ysYDMsbpqMcw9bUSsLczXTEg8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925109; c=relaxed/simple;
	bh=mJxvSWs90z5ERea/oH0aBpHFS0aWHs8EOF+jphnm/oE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=O8XlF8uIy7kGOXW/IuHMj7C4M3npSwK9FxfAmGQEv6N52PBl0QbQi5/A6+3vqcR2pC/hJc1hJVoveQZgW8I+Es2GycvQ91R4t3YEFkwHUTy6O47j40cLbwGCoX68jMsw9kmhlrtDMGUHGebO3xb/amfI051FWBgilMA21ca2qvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz9EUk3l; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz9EUk3l"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f0afda3fso223913585a.2
        for <mptcp@lists.linux.dev>; Fri, 07 Feb 2025 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738925107; x=1739529907; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJoanq9O5ryX3ihJgBWzyifviSLF+XTqh8+SbcIwABM=;
        b=Cz9EUk3lJqwH+u2kHg4ZZl0s1FMqkWY344ySZlv3nd+v4E0vS2XK4Hlwmsju3P/rv9
         r99I7l/UaTuzbXwp6pb0kX80eUHm03bKpAufyeMZV7WoKTPDv5SGD+If5JbBZ0BS1vfp
         R8vyKtz/zfpbjq2x04Ae9jMwuVDsfIb307/DlwAfIgjwLgewP9A347OTzMJHYxft5hzg
         ooyqAeVSte6EfOzT59WhCJJEZbL0sBnDXV1oHTbkPv9dK4A+NWc3DqTamEOG2Lf1RgOq
         Ao9VLj+yoPvBmBrJdz7hBvFgtkQmAj5nf4+nD6DDvpRIkhf4bd4mngJhU+a3Gob7W1a5
         0R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925107; x=1739529907;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJoanq9O5ryX3ihJgBWzyifviSLF+XTqh8+SbcIwABM=;
        b=a6kMVbc4VP8ZC+4t3WhyqdxlQSjf24iXISoVdoIAHbqdxY0ggJItUZbx1Ayxsb/jvB
         7hIGW3tIn9xNG3GGmz7alQzD/qhXfJgzWYEFJo6riQYZQUpKE22AQ+gENtnvMpuR5KDQ
         n5OElj6AUmn6/UluL549LWbVECZieAOIXU+slK6SQhWq0M13tUGGYFEZM16otga1df2m
         QvVfyGryyJtGpgsoTwMKsQJK8a/6kpfHPhnS/zH7FwZ6oOTWBxFgBJCNkL0hQvg9fTPb
         3Syj8dZbT4HEd2j7l6NZw+oVs+cC5+ll1uqnb2VdLB4963QJJTY+hgF2/uQPhDIvodlE
         cyDw==
X-Gm-Message-State: AOJu0YwSNQhXyLyUeoxAS2ryJFmYMeO0tbQGl+9kts4V3gAEB11l3/vA
	tX3QrFInQznfYDbIDAJQ9cHdySgCEpToBY/MEabqwMghSMLtx/gmWY9L
X-Gm-Gg: ASbGncswrECizzpVdI+QoIPhQNVVA1lNu7eoLhFYMKdoBdTNB1qXDiiW0y2UeJcMpsF
	6d7m6d/ydnvianhT9AbmEdSJjJmCT+xjmIPdiyPCh+Yw57mUwAmY/KumifZ012t5Y2eo/p8st13
	moxR0AFcTi3e0+gCRJNURymUk9Rs8ed54XtVHVC+KsitGdRbJ0fZDn8UKdLSqxDf4OWAsZNPJtl
	c6VSPf5xgDDW2QaArs0wKWVIheigez2x8Cfx6xGrKMEcDOq1p2SFBRu+waM1uieJccwOqfbwAyp
	BCr9tQUJigSW1U73FLjhIYk7vw==
X-Google-Smtp-Source: AGHT+IH2Oxp4XZcVyHM9XYkUjKSSGOWRkQ3KxU+73OXFnvtmjaUOl5X8apX8ugSWGhqMjTVwUQdXkw==
X-Received: by 2002:a05:620a:3946:b0:7bd:bafc:329d with SMTP id af79cd13be357-7c047c978abmr386164185a.40.1738925106804;
        Fri, 07 Feb 2025 02:45:06 -0800 (PST)
Received: from [127.0.0.1] ([20.25.192.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e1388asm172336285a.61.2025.02.07.02.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:45:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738919954.git.tanggeliang@kylinos.cn>
References: <cover.1738919954.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/4] BPF path manager, part 4
Message-ID: <7db1a757-3af1-aea2-7ef1-81fcfc454084@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Feb 2025 10:45:04 +0000
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
uns/13197339964

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bfd65fd00d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D931513


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
