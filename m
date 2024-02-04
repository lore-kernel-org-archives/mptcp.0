Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B2101C5
	for <mptcp@lists.linux.dev>; Sun,  4 Feb 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034112; cv=none; b=tQX16xAeLr7NZVyBgEE+3eliJJWRqw9KCXlbeB+DbGT7LAaoeWFnun90g0AE6ry9C9h3qctcI3meHFaV0L0wK3KgHelNot1jc5PnjxgOW8DuF1foD4qoz4kovLK3FmYgL/Ty7aWyn5vd3Y9Rn5d6ZFCpP4tAyjC2wAtQAPHqXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034112; c=relaxed/simple;
	bh=6kmIXx22T3vy+Yh8cmSr3gYoWzVs9onuPBoHzVrs86I=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rZ2IYZdYBO9OqNgGIkgUiVsv4zAzKh3lKdHBooMN9lYcwGQwfx5PQ1fqqh4EMgUIO10n7J7ecLE4KLSyBXi4apFVdSg0Y1EsjkQ6ZwJWNpYcIuViuH8LPtiP7EKwTwJl5M+OGHti94d00Y9KPUdKR64EjlXJ41rHOR8FKsnu+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQbVai84; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQbVai84"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso1456641241.0
        for <mptcp@lists.linux.dev>; Sun, 04 Feb 2024 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707034109; x=1707638909; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s3XF263MLSbYoih87TNKeidnh4WHbIunRjJ7gbJJRo=;
        b=JQbVai84wuvjBT1I6DmCsSO43pI2tEU1Nqxz+TdfpufZTlpKMhrTUD2iMoBGWjy2m7
         hHuNwo9BitV4OCc9xIgAlarsiv2WInkPTmjPEdiIkD64yuvZ4r6ulzUDIA3aLdIwlPv4
         qoTg6Uv8FRepz/W+FCbcQByGE/YPkPpR4OJgPzAF22+HXPvfshrBZChxnzU75apwLZnY
         FYtL1DqtYnNajrHaffzMNB7808ocLH76/0r2v1Kt7kIBhVuhIWqaQmZE/0En4Z68jOQ0
         eXAJuZqaRnjSMBZ1MvSxO7gf2SlXYY4gJ3E++2ZYXeU0zzok846MIAvUEh/NFnYz8C4u
         ZU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707034109; x=1707638909;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6s3XF263MLSbYoih87TNKeidnh4WHbIunRjJ7gbJJRo=;
        b=rI2TbbDRRrQ9+H/D4F9ieqkyVKCCIeTPN4LHgqtAU99qy8ctRd0NM8o+Uj58MdLSko
         KQjFF8Ou/sXaj2iNV59fsGuGP0Qguorg7jP+uX4xxCBPDDjmldNEYV/ZDizkqZVFMkx6
         CICJlh1gnTfaZclJuxpQ7BRKoa2yzTGUZz34KBtC2dRhHBjrDu7DFSNU4McuZwpLbAN0
         R4RgFfBy5Exit4EHENVY17rVNPz8piegDseK9UUUb8ZfVDE2BRjqcHjUVXnNRrDQmgE7
         u/8wr+gQmPl348foF5lMkabGAlSXBDa2JJgywP3dlUnDvxS7VpYNCUDC6do/Cx7ATYSF
         sPBQ==
X-Gm-Message-State: AOJu0YxPSrO1dvHDYg5nCe63TcSc1dNB1gZolu8PQx4f1VB7bSPiVLGg
	5jOGfzEpMxcs7K7sTGPk9AFuSO5VJKUfL06cW/EbA9wQg26h/06Eamq9kII=
X-Google-Smtp-Source: AGHT+IENCWyOqdxNO8sHCbaEI8PtgPXUsN2xSPWyusKhgkMyOkFCWJbedolVbbj8xGu6DjwcSqU2Lg==
X-Received: by 2002:a67:c796:0:b0:468:6b0:ef95 with SMTP id t22-20020a67c796000000b0046806b0ef95mr10638703vsk.24.1707034109401;
        Sun, 04 Feb 2024 00:08:29 -0800 (PST)
Received: from [127.0.0.1] ([20.49.54.13])
        by smtp.gmail.com with ESMTPSA id pc19-20020a056214489300b0068c964c3c4fsm1021649qvb.127.2024.02.04.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:08:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <40b390e09ae6003d9dc3c571ae1c5185597e75e3.1707029682.git.tanggeliang@kylinos.cn>
References:
 <40b390e09ae6003d9dc3c571ae1c5185597e75e3.1707029682.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <c5211297-0ce5-1066-e18c-23ef32f906cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Feb 2024 08:08:28 +0000
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
com/task/6020601719029760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6020601719029760/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5457651765608448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5457651765608448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5d55ee6769d9


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
