Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A771739
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121323; cv=none; b=IOuuOWr4LD/H+iiHEiyOuWULLJPCZnBHPk71bzNKbTLeYBaGGUQ3LDyvL2p3M4M8tewr69vcC4K/CqKiHYNMU0eWpkTw79Yuo7cI4LGZ4LswehFWZ5pp52EVrU/JxC8VzT9STah4kVa0hQ7i2MCISm70Azq/8OPl4Aq0o2UnAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121323; c=relaxed/simple;
	bh=pBLhqU9gqA5RWNhFsY69wo+GILLcBOk2Y7i41IGWmAQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=d9ZBt5/ZA+UTsljebQtDxzHwX5eGHstMG08FSNr0FETZzCQchMzNvipkBLiR8pesixEGGc+jdIeF2o+EsA7gRUNnjK+vV7MLtmmfRmg9WJnotSdKdGv+sEgfh+eljoOorWejRrO15Jj/C7q5XjqXzKY12IHsWs6fQoqgu/284wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhifjK1B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhifjK1B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so3462384b3a.2
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715121321; x=1715726121; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGQWhE3OIXKQR4U2b6vyyp2gLWIzmHG1F4QRBHbdVyc=;
        b=lhifjK1BplX86yPvN/0kqOwQrG/2qIle9rCWzmc73jfhNs/+hL4ilzIeCA6fRjh3qn
         8fY1Tw4aZZG9UIHYAsfEWwS8zeUC5pANoRC6O64J7/3HHrBVX/zBjw6xxdsBnJhsNF8G
         s8mxj/zuwhiJc23fCVF/IxDwMcBxViTR2gjOgZy9Ii99bj8l+ClMfLnoBklnrri8+5Hn
         +LKGdPzFrjE7x9w67rhfUhcTQysI/uHHPZLEieZ3xcOpjzk+ckXd3qaV/KS8oVoqsb2e
         pkQZjZ+KNW80emIC0tT1vsL4xJhAl4aN7Aub3wnOvpZzc/VIwxEvjlNdQKjrs2zyyp/O
         atEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715121321; x=1715726121;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGQWhE3OIXKQR4U2b6vyyp2gLWIzmHG1F4QRBHbdVyc=;
        b=X2tnPngkDwfOLk7jzIgubvXUsd5rlZXQ92Oqp3EQvkz76NEf8oQ56Rz6LmXMAceRlg
         xsP9xkALyASP3pWWU7822skwwVyyoRQb5z7x3npuGgWaamRZmlG6GGhfU2oOjYtxvuPB
         61J5R9YGbNV3u7mKPf9V+4ZqJWBKBwXcMBpcusYr1bAEA9ffQQ13GoUE7gaRsJzEuDA8
         OKJHFLWG0XHi9lR7pJ20PMmL81WMNDEePcyUGYBakxfPYppOOMlguDGXE8IJ/bvPgN3N
         M+PkxOG+gd5S5BIaO7HRQNUa0TWNrJ50lOpvxUt8NbXDOj2g74MBR2aLauMXJfYAjeaG
         nw0w==
X-Gm-Message-State: AOJu0YwNo9aUmmKeMtNuj1h/gVqM3YHqvblmIjaMi4svS4cToCN+O6fo
	D+w5Zm8JTUtr4Bst2l4JswIC1GHof+UxuBYMZCiqFFKRyntpyZo=
X-Google-Smtp-Source: AGHT+IH8CfqdykUngot7L8v9ndnfi97IOg5vajcmM3GKjGKuEsnjuBi1qpUADZoY3mR2bQlx/UWz6w==
X-Received: by 2002:a05:6a20:9185:b0:1af:a414:802 with SMTP id adf61e73a8af0-1afc8d8ea7amr1374907637.42.1715121321370;
        Tue, 07 May 2024 15:35:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.27.195])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a388200b002b24c3fce2esm30809pjb.33.2024.05.07.15.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:35:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Liaw <edliaw@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
References: <20240507214254.2787305-1-edliaw@google.com>
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
Message-ID: <c9810477-27da-5322-7bb1-c1a4af6ceb05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 May 2024 22:35:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8992857887

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/13e61f25eef2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D851355


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
