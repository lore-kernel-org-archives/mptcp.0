Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BBC2C2
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekc5KBHm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2806cbd43b8so2654493a91.3
        for <mptcp@lists.linux.dev>; Sat, 04 Nov 2023 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699091793; x=1699696593; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIi6BoBs/Qp6QEsqdkEyH7OIe7EFSB90Kpf62+RonsQ=;
        b=ekc5KBHmuObMX+e/1rjjnPA22kIpub3i5Lt1yuHWXLXq3b1wbYFIEMG7UVOtzfzD22
         Gh0o0hJOX/LZi5q1uKgxe//3bzo4wuHQ+xUQq+oZub+40r8FNy+MQL3Kg4R1rUhuucqz
         UJmhUNqAgTM9lc/bk1FnkwDXZkpR4AGStChIt8T96pIJrcpCI+yi2ApcarIWsJDzNCh0
         98/3Mre6MqyTZcne3DraJA25rh+WTznfdCMF3ef7xtNo4GOA3OUh+SRaxDbgISPoamSy
         NuRrLVPWHSIjLg5PfUyE6xWAu3q/1pjhKF36ZaAmsB+nkpyA3umatC28JhRRKV8IweW7
         timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699091793; x=1699696593;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RIi6BoBs/Qp6QEsqdkEyH7OIe7EFSB90Kpf62+RonsQ=;
        b=SPUhO8PS9iw5PZRQQI6KnbF6xaIw65PXCkQz2AXNQXy5iiNMQuBlsAa0OX104qmVBo
         KEyt9So/9h5zClUFvjB3h+NGzp3eEDrpj7UTjIBGmefsACuqkuwt5yUOaw9c8jycAazb
         n0qtJVfuNy8/K2iHlMV/aJAPUi/Ensl9s+0pCv1cy51bqIUTn9y8JC9J8eurNtjI2I2W
         BATKwad9wFxULknJrFPGosCHhK5kDoZNrA/ODq/p4tbTe4IqCN0zMWCivKh/W8neXUrg
         QzM2Xplp6I84QQWzRU5/v9i+Vzc7n+us6RwD2dZ1af6JImfHuvyy59o+uN0PbR9Hj4x3
         /q4w==
X-Gm-Message-State: AOJu0YySZNgD2uYa1YHsahSgbjmw3nG3d7X2Ggm1KFUBCid1sjxDQeba
	+uBpia/w9LP+n1qjNLgjY3U+CGi8Rg==
X-Google-Smtp-Source: AGHT+IHqHbiLZqVaV7CrzK7XS0OjmquGAJiNTKV92/uf7B2T6VrUwk1GP/ozvzukIF4C5PwTLodmZQ==
X-Received: by 2002:a17:90a:de84:b0:280:18e8:6d4f with SMTP id n4-20020a17090ade8400b0028018e86d4fmr20803057pjv.12.1699091792899;
        Sat, 04 Nov 2023 02:56:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.99.209])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902b09600b001b8a3e2c241sm2691663plr.14.2023.11.04.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:56:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ac3acaec649cf088b9aef476f7d8e0ec38d62ac8.1699086244.git.geliang.tang@suse.com>
References:
 <ac3acaec649cf088b9aef476f7d8e0ec38d62ac8.1699086244.git.geliang.tang@suse.com>
Subject: Re: mptcp: drop lookup_by_id parameter in lookup_addr: Tests
 Results
Message-ID: <72cd87f6-a280-6965-6263-ef220e326e05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2023 09:56:31 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5715754092331008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5715754092331008/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5152804138909696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5152804138909696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6278704045752320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6278704045752320/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 3 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4871329162199040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4871329162199040/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5c73e0a6e105


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
