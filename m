Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8D2563
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872616; cv=none; b=KAoLs6kxdAi2cyAgHko6T/xUkJxX/D6U2CmCzqTtcjpgwyHuJjcEAON/GuO+6dRrlr0TyzBM8TwirWWymQXXKGhBtgEZyQHxm4wWsTpTviAH9Ppt2CIp5IoorkSX3zWFuPa5Eoi1T9Z+/0/QB3FENn4AuXS4OnUH38CcX8rmgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872616; c=relaxed/simple;
	bh=6+kN40SwSzDv9RrNbOBsiNsEcWtLDSBOq8OP5hca318=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ReVTsen3N81g4lSFaS5bIGYAxhSTyB2FmhW0OCtdDw/361Bo/wu29aJLZ6n+73J6YoS/WAQOFmF4r3faUw1BzI5jU9yNO9sYD5h5cNKKNjprQFCOITSCCrN+CUz/uq4Aa2jtgOyFK33gr5fjTl6J5XJb5jgaPkrl+muEW2QsXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMZHNmMa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMZHNmMa"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68f01133850so257666d6.3
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 17:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872613; x=1708477413; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkdnOlOJ1gmbkYWfrCM+b8JhRbpCfT8XhlPXHw5MN18=;
        b=cMZHNmMaz0EMd/8X3yfZwqb8k4tPedpoLVpySAjQBWAq8Md3X6IotcXLHykawkpE47
         WHAgWqZKDMKqjT/ggLnN4ldK/FKmsBR0iOZt0iwY+xox1n/NslXXwwv3he7IZaxrb0Lo
         G9DDICpsIoGc5JP3x8Se3udKoGmn0m461dRvH8BH3M0ckrPZgD2K7k/F53zAYacswls3
         8gJemKE8g5axzcZt/QlhQNv4oUf+PRBFit+Rg1SyFA/a3SuxVi+S2T2HrgM7SYa1nXSU
         YIaS3j02yxmmeSxkjPQ8aga8iwWHQg2ImrLlpB5idzadZ+0ghFnDL7/uZiv7r9D4U8Jn
         +3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872613; x=1708477413;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkdnOlOJ1gmbkYWfrCM+b8JhRbpCfT8XhlPXHw5MN18=;
        b=cuPT7rQIsx3+BhAbgCGMcaKATzbeEEfX55yhBO+Cdngh39yTFu5XRnzAUIECA85CfZ
         4nXVUahhKV/RSZkvXCXLjSA89wXz7LiU9MZAQnNPXEJJzXQn6Wu5mYG8vnn98K6Ooi4s
         W5WxOdD4ivGXtjPkccC1XxGlw1E4efFiDaXs+gBkxl1cvI5xr3hRW2TDwiGbG9AqFVAL
         nk9nRhXGkYAOx3FnkTsudQOsGzzHDDmget9AfxJiN60XhVZq47TxREfB/V7WzWFMANUh
         Dz7XerRe8AOsKXJvE9SNoPm5eckku4w0o7GcpY3GRDd8eGZpNFK4xUMJW0vXCbR20iOJ
         ooyQ==
X-Gm-Message-State: AOJu0YzckZBFDeJY7WGvqoqkuTrZV2ahAMSiT+fSo2XCF/wD6SQyFLcP
	naD9utmBSlKSiraJ8pdiwrb5EtSdMbQxf8fxT82/GittXXTSbY8=
X-Google-Smtp-Source: AGHT+IFnO70xR12z45GnvwXopqWCJEZdLOeXVEHmEGWmI0+OVMzpwAsXMQl2VFP4I+7KQlYRqyTmnw==
X-Received: by 2002:a0c:8b1a:0:b0:68e:f0ab:46b5 with SMTP id q26-20020a0c8b1a000000b0068ef0ab46b5mr1006996qva.62.1707872613131;
        Tue, 13 Feb 2024 17:03:33 -0800 (PST)
Received: from [127.0.0.1] ([20.51.198.240])
        by smtp.gmail.com with ESMTPSA id p14-20020ad451ce000000b0068cb05e910fsm1767055qvq.5.2024.02.13.17.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 17:03:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
References: <20240213223135.85957-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <65af4539-d2b3-11d8-6cdd-f87521b68435@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 01:03:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5969355108777984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5969355108777984/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5471411028885504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5471411028885504/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b82e0568acae


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
