Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653892F60DB
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190814; cv=none; b=hcMg5orOP2k7wvBqhBXyYPIw38vSq+tYduzJKCCfEeKpJGzrNKqH2t3EB/gbiKgVLTKztrUE2Pkz2pyTdlABeguQ+zKMfhDVklGw9acw2l/F2uI2zUx566V+Ndhvzt9rtOiUmO2gNwj43RIR824TNXsIs9j99AQTOyggmKi7XFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190814; c=relaxed/simple;
	bh=pY8C013QZbbWurylJQ9nmjyf7EXiQjFdblroaQbiDcQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Oj2IBhAU92nAGch2QZUnYfCmm7WoBqs7uWgdAWIGIJzWtxFI9UKPcMs6UN4gR7bU+jJN29WobJvI3A30VheLD5iNJQGDXd1iOCjY/T79QrRpj6Z19U6UXEhsvoG3m/XSnpnq4bD+SHhpW6T+BClysVywP2ViV9hTYDiEGrW0ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI45/V7J; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI45/V7J"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70dbe6b8142so24398046d6.2
        for <mptcp@lists.linux.dev>; Mon, 25 Aug 2025 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190808; x=1756795608; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8xXuYok6I8vPDWnlOQgoDfqwiUldIBmTOzV+WdLYRo=;
        b=bI45/V7JM1y2S8oG3gO1mSg3fnfgyBwEVOMcfNwvYI+KxPo9uYI713EiwFp7kB3yKS
         C3DRNKbE0Jhvmi+30zq1AuBZ7pDG63kf9b1HUQy1zugGRwAvRVS5GYudV6zwM5DB6BAZ
         KSaZ4coG8vbySzw9KzYdHdf6Jwqn+GeuqkrkUmtnSCAqa/oOkA4WjGbPdf+Ijr3iX9oJ
         oIhEXYmm8EEi6S+6vR9CDk8ZHPlc0hmXlu8qEmmyij+F3UtYuYLjqgtvGzyALqNWPnIM
         OWlF0MvnS1GRVP0uyTEbVJn93/wu1CgKeqZ+dgXIo+DziZ9oXyKnKpsOqjHTvSy/kn6o
         rEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190808; x=1756795608;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8xXuYok6I8vPDWnlOQgoDfqwiUldIBmTOzV+WdLYRo=;
        b=WI5UbMfRRES99VO4JxNNY/kxkWcl1+9nCHEgcxNGKSbWu3rSHTTYC6zLV5Sj1R3SuX
         VIuIg0II3ueXWn6KGCyXEL4Zt7HJt+TGyy1cWI5oJ+ripyg+su78r9CpNmTXjpPp4iy/
         lj7Vyo70Q4XP+5+bPRdBq3f5vTYi1N+oEdU8MAUmJCPgZwlRGD6yRFtfbCgu1ijXSkec
         tRyz/rHDh9ywOCbjF9RvoXu7koAwO5gFCvruv02z8wsPydlXsBvdozhRNDxtU3lp53eU
         3ZmUwUMle+GAy7KnPhkRGFRKdKvJFPohYhCX7jRwg4FZEypcSPhBsyOAx8ELWb9smkSi
         vnyg==
X-Gm-Message-State: AOJu0YzjXzexoWSE6a3tSSXebphXuymWU9oelKAQfUE0msF8W61DbQTW
	flIqOksPouVITsBJHwvdiqd7dqcSfgli78CDtWd5FUjEbHfkOWpeJQI=
X-Gm-Gg: ASbGncvdBim9IbmpXl5EDqvZvPE7OyOeGbe4OISUpuU/lBJ4UUnSewFnpk7gQkb8wis
	1+2ZFzELa0thXrHI5YeYvmRD0LMcvd0mP6OUs05cgW8hJmd3Nag1JkXP8xeSRfdzsbG50HIWq4B
	MMZHEA9vwXJG1ef9hXqMgnnRZR16wENhqcIxOdOFAZa/ZaXWPtO5revlvCQ/tNOLVj0XpTeyZmo
	cDJd48m7T1sZ/QRQvkW7Y28IWEO9xoBns5ZuYBpk81yUItUP1pAbbVr28pIu++5zwpufWKWS4QM
	43U9hp+PMK93TAokZThBNSjutwhJWG8zrHJIlY+ao7TGZy0m8eJr0fajZJ2MOxa3CwCBfPe2Yao
	4k9N0Bw3YI5nXEr9V9ItdeAt6sjzTIqIuE/I=
X-Google-Smtp-Source: AGHT+IE77aFnSoR0koYcYpTszHsK77yict9MPy8wkESzkFMfB/SU6Cx0MDkE+7ojPQ8BvrWa4NHzOQ==
X-Received: by 2002:a05:6214:2a83:b0:70d:c245:d34a with SMTP id 6a1803df08f44-70dc245ec56mr56979836d6.64.1756190808290;
        Mon, 25 Aug 2025 23:46:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.87.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72fb066sm59340826d6.77.2025.08.25.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:46:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
References: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: Support recording MPTCP
 subflows in RPS table
Message-ID: <8652bd3b-0452-1fc1-dcc9-9cb1bb926ee6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 06:46:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Christoph,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 2 =
failed test(s): selftest_mptcp_connect_checksum selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/172282=
84455

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5039da03db6a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D995486


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
