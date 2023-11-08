Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05334D51A
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnl2hL/Q"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5875e2b27c5so3409296eaf.3
        for <mptcp@lists.linux.dev>; Wed, 08 Nov 2023 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699430457; x=1700035257; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ0sCG2neKyPZhInl+GDlehMCib/kYgYrjlud/CzWVs=;
        b=gnl2hL/Q0tdRLTa5nzm2NE3PGgZsQkIYjCLD0jrh333FZ9uyNVdooC1BAG20lO8471
         g/cxs5WcLM1aclabUhdH42w/Gzqzl503e+kShvUDuIsUtVT/QDBfk6yBRt6s/jGZ9c0h
         eLU8PMxKhtwgjUptx2bterXIKk9Qh7KNdgjIaQ0GuqIBBx6fRPNtpcGJuoDQp48uUFXq
         4A+aKpld8SNWuCwIfzTErAeCauHyBag+Lbm0Nhk8XFb4TW9DR0vPWFyXO7AXERooIKxq
         qgo3N9LkxwP4fyaGl9rHwY4JA9cLYbASljV/R+1j6m80v5LlNMuLbc4Iu8SCyN+ZlJ0G
         /MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430457; x=1700035257;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQ0sCG2neKyPZhInl+GDlehMCib/kYgYrjlud/CzWVs=;
        b=dPpIFfEz2OVvddn5uOwf5YGqlHDDqIw6fN6TkbyDUuFquR8a0GzFyY3p7oGHfk3CTE
         jhkGDy9MeB5+iG2PT92y2b/xQqyFZ87grwls4xjkN9Nz/IRl9QatSGAQv7K7RSH6QoxF
         b7j0CPy2+aYVvxXx+GgnitwHSYFwSyAqoSmzd8VdLqrcXXnI4O5tUPQwq1hASJs6zo/A
         uB3DeeDIQxbWja7WowVvqCXU4IGVbh4lLzuJLn0mbJi1LpxYCtso2etRKqyncQZnldAU
         GERWsEMCSX7nXTHOLKqK6ksS0FJXRFQrpacSQlmnBP2Ed2jerawy66G4yakzvr6aheUH
         A6Kg==
X-Gm-Message-State: AOJu0YwdWSZxaGIJQrIasLiytcNy/ttrPUzAO9YJvi2G/PpTY/sV5q4p
	0NhCebo8Ni6/SkinWvjkapiDUFAkTg==
X-Google-Smtp-Source: AGHT+IE3to8u83d9D1seSPZqSVgiGbjN0FS4qaSzwrcOD9iZ1EN288oDVeBUk3pSiSsALW0nkPTvlg==
X-Received: by 2002:a05:6820:356:b0:581:dd3e:dbce with SMTP id m22-20020a056820035600b00581dd3edbcemr1202112ooe.0.1699430456768;
        Wed, 08 Nov 2023 00:00:56 -0800 (PST)
Received: from [127.0.0.1] ([52.171.135.163])
        by smtp.gmail.com with ESMTPSA id b17-20020a4ae811000000b00589cde89cbdsm345880oob.20.2023.11.08.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 00:00:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e8876e80bb1365e3b42abb36d343c5cebb3f6cf8.1699425895.git.geliang.tang@suse.com>
References:
 <e8876e80bb1365e3b42abb36d343c5cebb3f6cf8.1699425895.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <22238637-e834-e87b-8ed9-6598da375f3f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2023 08:00:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_pm_netlink =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4657713125261312
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4657713125261312/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6346562985525248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6346562985525248/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5783613032103936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5783613032103936/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_pm_netlink =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5220663078682624
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5220663078682624/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d7935e74f13e


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
Bot operated by Matthieu Baerts =
(Tessares)
