Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75E4A21
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443682; cv=none; b=eAu6aCqaFehS/otRQAqe2z3OGC5/IkT4F01a8ajrK3/BEzqShsi/Xp8+zx5n26v/Xp/kt2YyUmWZn5if27rNNNLc1H9L6IGx0ylTZ7HA/ph69h42KGbpSzTzqsOFgY68qWggKXWmW3CouDjlnBJv9KvojBNkT0UqL7kWWk3weW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443682; c=relaxed/simple;
	bh=Swn2Ey5bz6NUiQCMtvSr+3WfNtFiJ/biCGJysPSyTok=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iUxy6Ru6oSl9lI48SUL7h8QE0vZU/ReU9fR6leQ0EpJch8ZMk4HW+/l2bh88RTrLdMG5ltmiL1gT9hK6jz2YLWNci9z283bZo4O8NzNYaXlwh9gKu6bLNoDgmodjU+26RhuYNwb20GhRHHHUQIUpjfQErgAJd+ifj4Mn8cJ76a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsURCn0N; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsURCn0N"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818a9fe380so2554606d6.2
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 17:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707443680; x=1708048480; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kha6ISMxhJZyJEUr85H5zsjwPpW1jhzfDemHaOAq7cY=;
        b=RsURCn0NZdDfFSxJGl4XH6gpRFghSisfnW6apbrRHVQqLSCkqcjrWQDbBevTdPSWjb
         beXpqo3ooEmDHsfzDksiNU+TvmQNe9ziaN0V7gDp7zWmuiorRzBSkacZCk2WAMjcmoW+
         f2+b5HFuSVEMjNSo3v+U1xLskaWFmavvSw6F+2ZsRcp+i4CkBhiYIRNeJGE0kAb1C1ff
         ARBbNyL53+f38iM9vKQZAVEyA1sVDd9JkGsUHDuW5PvhQcxFqweanzI5VRTcNbgxF9Z0
         TMn2Gwla8mbWugW/Jimqr/ka2cFun7MsV5jqxZ8JVsXXp0d0PV+r5WEMuGODg2akugAK
         ZIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707443680; x=1708048480;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kha6ISMxhJZyJEUr85H5zsjwPpW1jhzfDemHaOAq7cY=;
        b=K+ks0ZOC1nCDzwmLFZOwCEbVGkiVjiM0eZN4/xgrFY/Vn3hxAgONj78JA0h92vvWgc
         Au99N8QCDdl59+TPeftaW8IldtdKNHAhVeeKc1bKRp25694l5RcQ+t99tKKgBLaUc83Z
         paI5q7XPZhK8GTtrsU/I89gxdzZtk/FJFe5t+C9j1of+H7/ma9dZnowwVqXh1l7h2gQP
         Se6HKVyX++eiHIE1PVVsG9o0hDKwfG11Q9ua1grpT3KvHXnOngwL0aYAkvCgHXKEBjpH
         njVza8yXPcqAVFfvZaYBYRJGgA1eX3VlqA207AHdHdwfBojrvLzwYuyjc0rsqjC/2WwV
         7XOw==
X-Gm-Message-State: AOJu0YzhlLaCIXs8WVxoiqxV1HtKCEj8JKTKiDTIyHKLOQJl4wSeBXCU
	cyKTsTT/S7HJjdBqueyBquNqpuZ2R6JG2xaDn+iC33u3QiBiOKcCkjRQe2w=
X-Google-Smtp-Source: AGHT+IH4N6ygM8sE4fYJweDCzFLZ0wKtixJP3XRBI0AQuBakatnGcAiqMxK6ee+KYJbTPSgM5xJZlg==
X-Received: by 2002:a0c:aa98:0:b0:685:956e:b5d3 with SMTP id f24-20020a0caa98000000b00685956eb5d3mr225057qvb.50.1707443680120;
        Thu, 08 Feb 2024 17:54:40 -0800 (PST)
Received: from [127.0.0.1] ([172.183.161.200])
        by smtp.gmail.com with ESMTPSA id nw1-20020a0562143a0100b0068cb4cba33esm351463qvb.87.2024.02.08.17.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:54:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
References:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <c31fbac0-b29e-7641-299d-04169563ad6f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 01:54:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5931257842892800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5931257842892800/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5109398167617536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5109398167617536/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/57268e5e5c3c


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
