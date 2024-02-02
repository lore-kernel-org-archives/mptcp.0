Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72013E20B
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873413; cv=none; b=IqQu7teOJJ0mFOv4Cz6C72qFgxObg+gqERPLhzTK+EuzY7sMGNBT54NcIRHOxcuUItuCAKlY/tHaXalHTmxIX4Pu0eOBroSHu0L4e50ymeOLT2k0hjs4KvXKG/AwHh3o1lwxplEniT280OJ+Q5pgyJoi9ViJ2nnEj9wvcMa/pEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873413; c=relaxed/simple;
	bh=eITD/hCo4AAZoEtz5cIy42hCGb2zPocs9Y2VFzhKh1k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=H9hQ68etoqXKweDgT5y2g5dBOfXsDgJ4fnLbpRI7X1n6XOhvC7wDqLi9CzL/ThDJk9Rw60vodZRpZdELJdUVqZzQF2Dv+nY99h1FicPhbs6+YJpL9TBqFU2ZnWFsixfzSGAZ4GMuYsY9MkrUeIOoGQ7BHjPhfwBdHQDzX47VbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgzEbpAw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgzEbpAw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1778633a12.3
        for <mptcp@lists.linux.dev>; Fri, 02 Feb 2024 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706873411; x=1707478211; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr36gAU+HOG/cV1/rmN8QuuYQ/4uc7kvA/0LwBokAM0=;
        b=HgzEbpAwhggN7x67xzBFaJ0CW2I7JJRY683m7rB/YUCrRrxKYEhmtE+zXtuPG8eVrp
         B8YYXJkT9a5EzxswMDJCOzpoLta3D+SlI2Gnr4Gm388JuKg86i5V2kEUYrzqN7BrzgdT
         q0zqDpbfqptVqo5Vmj67kFfoRiEGwgRC7CQep1+GMnFKIjrjWl6Fyc1tKDsQF6F9Iiov
         JEuCZaWTtA9zXWdyHxBpL6TXYGMXJPQUyYZ3c7Cc/91pAiJf9oA13CwJfcvW/vT/tSjP
         /EaKOAKId48oOznHpBHPPkmv614s2WlJ7WzHtt48GT7ElgODKlfQoVH/2mLVrf2Lmjaq
         dlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873411; x=1707478211;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pr36gAU+HOG/cV1/rmN8QuuYQ/4uc7kvA/0LwBokAM0=;
        b=F2k/MVMarfc5ux7Dv/TOdg312Zg75lObJk6Y198blJFxDGsFto3BaHcZ1laCvy45Gd
         anouVwyn1A6g9zDNDg3r7HHCXXxVF9Ej5uyGUTLmiWTsEeNgJJghCCNj24tlZ7mpQ26s
         38r6V9FTU3/Mfd7dln2nlCrEe7iwg9V8U6l24j44rjYGv3iAA1AtEm7/ve82fBDBNjWR
         moEOz7n4QrzGZHgnr3MjHEwlrOwo3ASjeMZY4bcks6d+jh7Em8lwBL8XDOKNCSmquH9L
         /3Qdtx7wtJo1ruRqhFe8/6AeiC6fXyJDJQM3pNWhoLJ71Xv7JmvBIXj7PhFlW4ASGXZ0
         3ufQ==
X-Gm-Message-State: AOJu0YyqAgLXgCAETwYq+6e26nuNf4GcpJ1f315xXjk24aozJQowwP17
	oSjqgOeZtT92bMDD7DTL8sOfFZY3l4ArFwNy3pMJ+auOTB7YeNlM2BziEpI=
X-Google-Smtp-Source: AGHT+IEkqwGt8sDIVPLfYTG5H/hSjRvlWympNXfpfdTCqdQjGKCN90ViMb4c+2f1dORtaZ0ykJhF2w==
X-Received: by 2002:a17:90a:a617:b0:296:c0c:98f5 with SMTP id c23-20020a17090aa61700b002960c0c98f5mr4822364pjq.40.1706873411017;
        Fri, 02 Feb 2024 03:30:11 -0800 (PST)
Received: from [127.0.0.1] ([20.172.0.37])
        by smtp.gmail.com with ESMTPSA id gw3-20020a17090b0a4300b002960a58b04bsm3547566pjb.28.2024.02.02.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:30:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
References:
 <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Add DEBUG_INFO_BTF checks for
 __register_bpf_struct_ops: Tests Results
Message-ID: <b149171f-d6df-1e69-45de-9c62ca7f7bd4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Feb 2024 11:30:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6015088893624320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6015088893624320/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5452138940203008
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5452138940203008/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c2c76443230d


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
