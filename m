Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C93F9D2
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941617; cv=none; b=mV8iYzWybtuMmR+VKmWZ+9IxJGjFpoqBN6k49AXxkSGZlV4XWHPVygRjPNRzWoTrIomzusOvFOEbxlcgP5z55Gj0YdT4rb7843axwWPJmSOVq+J4dqDTLWjvxYk0yXIv7UAdbVZRkr4XH7JFtoKeAB8hhi610oEjtQCRATtXHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941617; c=relaxed/simple;
	bh=aLCglvJ4J0BB0l03/qFSi/Rgz7kC4NujX+jK0jG4mso=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZjQs6RKL7wB1QUYIjeFXxpNa6b0J8Yp07D1ubHc+XDn8KXdAOkeE08RTHwCCZPjIfh455KyjWeI0VLzdmZNqOuJO0R8sPL3VnG9QzOgoGMzy9REmvh+7YkHJhJyo0USlEh7Q3kvzvxPeKw/pM6Vg7sNmCmA4NWg0BAFStA//dJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXUWM7fx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXUWM7fx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-429f53f0b0bso40755291cf.2
        for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710941614; x=1711546414; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nltSv9SXobOB9ZnyHuB2TvggvSgCKmtBdCgFOAqCRwU=;
        b=UXUWM7fxjddL1nDAtrME5ZlT+uqP6kueUWiPIETke0qzs0r5hl9WmUxVtt8fK8ps4P
         4q8VczBfU8gOmY7HRSNS7y4rDJYGRQeGJbnpsBBKDbBcB/5kS6hnRwMk+5f2D5wYBBgk
         QhSZG+sLaT2kUwvlLQivp5KPMkV1SVDP8WE73nvcvH6VvQHQSmh0N0ZaXnzWOXgqS2Ko
         gtX8/hvUPY0arHTgF2mnv9jKs8hfBMfmY0dnED1PWlBO3EDltPsEJOdr6Qof6kwQin6i
         YmEcrtw7yBdnK5IXFU/W306sMJK9OkJFVoFfmiLPUO4p28GSill8ryJDsK2MgxuIz/Pg
         YO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941614; x=1711546414;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nltSv9SXobOB9ZnyHuB2TvggvSgCKmtBdCgFOAqCRwU=;
        b=XGwAYWTUlhOsJGivKUCNgiCTQWhehowg4+0XS491eH8reQFGaPCiBsu547uVDA7mVl
         +EbUt/LsnufZxdi3RJ4B5Dc++/QOfNZ2FkvZo9E38aCC68GTYykniR03AL5HLRt3O8c8
         Dy3lI9kpGV6okNK0aRatswW3B5CtOUAHM/pcnB8syPGh6iLH3zjagjjShyPnUQjHB+4P
         03TVy0MVY926Mqkbzl1PeTp3bO7WKbbsgKQG0+iaXy2DMabIgWj9aSusFjJWq7krNGR/
         /4a/Q8K2SPkCNrfAB1RLLNTBJ8OeSvM2Z2TSg/QGoczY8xdWvDkD7iy53sPzNBrw6I8x
         QN7A==
X-Gm-Message-State: AOJu0YzNw/vS82AzMVse6T+0c2FST/noe2wBIUtd1/Mzs9QXwEV8Hbaw
	+b8BTe7ZwlzhFAHZEvHQMlw6sVZ42RbXOkRYXkmuVHwLZ1u4R+GRQnp6D699sA==
X-Google-Smtp-Source: AGHT+IFTlFd7bEAopeJaKDTQc0ttjoE2cnGZUqfdDvGl8WDbHUNls2VYE52j6t9oSvdx+cBAyRVWJA==
X-Received: by 2002:ac8:7d16:0:b0:430:e63e:cd8b with SMTP id g22-20020ac87d16000000b00430e63ecd8bmr5798506qtb.36.1710941614302;
        Wed, 20 Mar 2024 06:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.108.47])
        by smtp.gmail.com with ESMTPSA id gx9-20020a05622a27c900b0042ef4b5f4fbsm7454625qtb.38.2024.03.20.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:33:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710938175.git.tanggeliang@kylinos.cn>
References: <cover.1710938175.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] etsockopt per subflow: BPF
Message-ID: <215c0978-ef8f-7a8b-1ca7-d67969835e97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Mar 2024 13:33:32 +0000
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
uns/8359348187

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ba35635464aa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D836743


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
