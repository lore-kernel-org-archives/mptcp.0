Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB252F7B
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977229; cv=none; b=SpSsBiHx99ezP/Tpb9D0VGoxxXR7YNVkGqlJrb1sXhWlrYakbT220yLZfFOzwqDghv19utfp17tdMTn+cSKST7TGFSaWz1XnV7elc7p4njv+iksjQg6/MHVeYzgyypFJIfOei26DvlNMovj6JEZ9Mvnt9wKSH7Nfwo8usmcMgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977229; c=relaxed/simple;
	bh=nWpZuDw08Pn6gVxzpJMJyYaMC44wgvTWqqe+AIx3rtE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ltjtqsy5SPbHKPqBafIkIhgxFVyy5wCP/RwbENuhT3qAa+/RI56QEkzUK/4huByZoJmsLMVL1xpMJV9aLtW+SawhJjg7l1CUFUuzY8MM05w1qpm+W40wD4NAJaMqrPZA+EZ3yTEGjKMje8VqG+fXYbot3peUnHiycuxT/CVNrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxkWk6ez; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxkWk6ez"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6868f31a555so7855346d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705977227; x=1706582027; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRgPz31s6lvLqSpOn4kI/2QsvcBOdeSWWcHTPr9L+pU=;
        b=kxkWk6ez3gzFWUENhCR6MgmRjoj6hfIhYKz8sbfZCkM1QggJDxUm46WcAr1rw2P8ry
         Q7cxSCJpikSvFHT2Ms8ReQlruX69QKzahtlsW9EhRVITMod4zb5INrZGQRdUu8zDYeRi
         izi+kfw+tYpiu5+SrsNAiIYFlygeemJVhU4PzDvxNDmExTDTJJ1TjPRm8z3Gs8keiWW4
         ZjuRkMyz7hFYJ1T0PnRMQhZJxGE0hxcgs2gd790jx0Qkj2N04EVY58jW8whzt8lFoKY2
         BwgmNO8mOziRgdrLNNI4SYYfPMIIWbRkAfo/cB6H1eJMXfX2eae9HRMBeaQDe+77FO1V
         Onnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705977227; x=1706582027;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRgPz31s6lvLqSpOn4kI/2QsvcBOdeSWWcHTPr9L+pU=;
        b=vGKuFVZXkxXJ8Vn8A46exGEPqWVxuoUf67jtnRqpObK94IJWXrXZKKsnB8MuxJRyXB
         2j6v/hQX1dwWw9strz6G43thZR54Hh+bTkTnQLOLdUMFZVwII8jsWJjLmJnsSTJ6weiv
         bG1/JIGQ/dykfnwXGLsfS1k7MUpIUW6Vx95I+lHC/BXzhyl5HGFuF0ydKL7vk9IEjnm+
         AwbbI+eyT5vEx/J/iq8BzsfZ4k6fEsKMIG0KS5Y7MUs0HkOGivMmQrfcMLlxjYzQ2ok+
         zIO7ag3kyV52Nw4zUiFgpbcW0M8AHRJho7bcg+bQ7/p/b39TIAbb247gHtzqSNvVOVoe
         +6UA==
X-Gm-Message-State: AOJu0Yx5bf/3RNWf9j7eJg3Na0jg9upJcBkbHl2TR6aQCRCD7zGXQ+wt
	PjSmnix3efd3V+Ca5gsnDlCrYwaZcUdTkQFb3Ol7gWV6ZyB/vms=
X-Google-Smtp-Source: AGHT+IHwRxQ8HTpVruGiZdxd5fbuGiJuou6UdK14GSdnTsX0KXE6U6QFEk5sHuEz3+APBk4LkTW+bw==
X-Received: by 2002:a05:6214:f09:b0:686:92ba:8e16 with SMTP id gw9-20020a0562140f0900b0068692ba8e16mr247254qvb.63.1705977227291;
        Mon, 22 Jan 2024 18:33:47 -0800 (PST)
Received: from [127.0.0.1] ([172.183.74.8])
        by smtp.gmail.com with ESMTPSA id ny18-20020a056214399200b006868e6d8b37sm1673840qvb.23.2024.01.22.18.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 18:33:46 -0800 (PST)
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
Message-ID: <9c05491e-5a64-02f3-6346-6268f0bd1120@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 02:33:46 +0000
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
  - Unstable: 3 failed test(s): =
packetdrill_regressions packetdrill_syscalls selftest_mptcp_join =
=F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/act=
ions/runs/7619831831

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8a9166777803


If there are some issues, you can reproduce them using the same environment=
 as
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
