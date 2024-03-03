Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE81BE5A
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470854; cv=none; b=VU6JDRuEzSYD0uISIa8+t2RUIIzp35XQz6cgf6x3jh+L1V7xlIzIgFrXvr+/LoBoztltDNHXdrcMF9wNv6rvMrl0kYAi8xbVWpVKJuAopemfd0KqC618z0iicolrZmBrLAPQUv4fVB7RoMYnHESEvQ6fxhE38EyHhLtl1gHmI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470854; c=relaxed/simple;
	bh=7/7d0E+uY+hAE1qk2SUAgrrhA7ow9Mmh9bPZnNOK75Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rE5K/dERcFFySA44kqNEVQW3qloty/a2V7xF15kiSJ9BtB+pUKecudw/J7Cy3sus/CTHP3U8L3UDoVli2w8L9avxhuPrMyUKKVjZZF4OvY8BzMUDbBllmYzQBCuStF+c1o8/SUGsiMiB6bTpuvGdNk5ta/jYjaGAr87dsQhqJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYFlemgQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYFlemgQ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e125818649so1998245a34.1
        for <mptcp@lists.linux.dev>; Sun, 03 Mar 2024 05:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709470852; x=1710075652; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxqyuKwxp1Mx+wCQ1GJCQRHQmDaIxGRyDuT/8OW60VM=;
        b=gYFlemgQe1eN8G9DrGvgU+QXz8om9Qlu57BQeJc89qHxD2SfhBjyqUvaUPL5JYe5GF
         i1kYBhasXe28QIP+PINQzaZVrq8i8vLXG/dwSKB3WAnpGZmXj1yEKjezTTZs0A8oAjE9
         YAo04FM97POf8Zia1Zp+vykNvMoWatG17ydBba6NF8sMoSyXidiTq3mpVefsaulDIGjH
         A+C5tMfvvdc2CB+No4wocD62927WdH7zA5aIGubZORcQt/YGoxzw8ArWJ2l5A8TWTaF3
         hswO+6XbC2e1Uq6rbqZSZfcSExyL2qv6TQ30HiMRxoaDVB5iF4I+4yfEyRoFljXv3Z41
         8m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709470852; x=1710075652;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxqyuKwxp1Mx+wCQ1GJCQRHQmDaIxGRyDuT/8OW60VM=;
        b=FPmBX/mkIxqEo107+10UR40ic/JieO5H8fL6pXMXRbTzxkpur1ktspOw/QPiYBYjDl
         dPvg5cjpHrTVm/gLgGa33qkV1+8+DKLkbUuB439EXSGbTboqa6UbUjVbSjRYEdfHPTSm
         /kcVt7ywdB96ff1XbGouni+B5R5y6nBoKiBlI2japaFYTDpJjNHTcOF0st3zKjEFI/Gv
         TxzskLeEM0FNM09c6xwIgc9PyNObjJxIDHLNJqhEkLbEKfm99orDZdHWTKV7mv8UG+Po
         aDO5Ik2s0qri9MCtHOlp2p4gQw9Nz+qO66ydM5PWF3B4kyPRWe4YxdRRzF+xp+EWBPP0
         hiOw==
X-Gm-Message-State: AOJu0YxBXvRecvl9h6AspEqQbd0R9GlG13pgjTjAQqWVNHFx7YWVKhjn
	I6XHjPbpkEc9cWpPqBrCyblIucHM+7wGPJtUzk2B1FXCNx8gh+v9boMAsuI=
X-Google-Smtp-Source: AGHT+IEDCSqaeZBOzCT0UHjwykNM9KJ5Mw6VqdMtQyGGhbLf0WFyFnFtBNTuaFvBAcnAfGm0WTXC/A==
X-Received: by 2002:a05:6808:1288:b0:3c1:d172:9e78 with SMTP id a8-20020a056808128800b003c1d1729e78mr9259561oiw.12.1709470851976;
        Sun, 03 Mar 2024 05:00:51 -0800 (PST)
Received: from [127.0.0.1] ([20.172.29.176])
        by smtp.gmail.com with ESMTPSA id gu2-20020a056a004e4200b006e566b4872asm5684154pfb.113.2024.03.03.05.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:00:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b95eeb617ba13a563b9f8c71d784a0f776e93877.1709466624.git.tanggeliang@kylinos.cn>
References:
 <b95eeb617ba13a563b9f8c71d784a0f776e93877.1709466624.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <857ceb67-9029-3b4b-c908-3006fe315d8d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Mar 2024 13:00:50 +0000
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
com/task/4769522020777984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4769522020777984/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5895421927620608
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5895421927620608/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1c52e9cd3c49


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
