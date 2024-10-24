Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F241AF0D6
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761861; cv=none; b=fI2HRapZBrY5i4adC09jQrQVXyMvG0cRISyNclwnqQfHUi/cfIhTDNHDDP+ko56SR80EQaMTdHh4VDt3hO6MCSacQBI+qMTNxsG282j4a78+jMDoeHGLOL6QypEhG6Vz41O7bIStF80TplZiA1Zn79Oyx0oVMTFLZyiGW3zy2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761861; c=relaxed/simple;
	bh=5dqaN3aXZQxEQ3xSt66y4NrQtNDWVNzetWOEGMnf5SY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZoyfZjl96CYaYb+4EeYZVH8acao6TcVOlFbQWSeZB5bDI6zACrYpYTPhnQPoFZc5rYXif6FMlBalUdbJ8czvuvUcq1s4HjOMXmqKV1/1hrKfduh5bftTnjcNJ+4ier79JXDtvYJdPi/M0r0GVduNEweryWjb8DoLj+qdpSSwbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVy7JOjj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVy7JOjj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso14775986d6.1
        for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761858; x=1730366658; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb3aS8hFeNYmkxtC8AA4jLY3bdIlMm/BJmY6Ed7zk2c=;
        b=YVy7JOjjkqAr/xOjCobyhWy6nmqQnIqfzSD5ROOMCnBC01JLKjJGQIHgGHtRlOiWk8
         MXnVPNVDb9PqMqS4Fhy0ojNKeaGi8eHcoIQ2jz8JZvrmV+vGcfdFUA8rmuf4abmhtG27
         rZoZelGvhKwWQGJ6muRv1Lh4eQnNJm6pUO7AamR3jCr47OniCV4zNR07fKV0quWEbAQw
         5DNnNbtVuQxyENc81ysTON54FJNWUe0hLbE0Sj9pqald35ku8zYCPU/YiW+1KGNzIQBW
         yygv8Ev7njDDzNgdJnkcE9OikVhO5QA9YT/yTL+Io/dKyA8ICGsnmIYN05qkDo/IGrJh
         JpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761858; x=1730366658;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hb3aS8hFeNYmkxtC8AA4jLY3bdIlMm/BJmY6Ed7zk2c=;
        b=Q+l0yasmmC66nzc+8rX5m4dcsuSOlfd4NU7jb0VE1SK7hLRUSBH2kEqPVgARHbNydK
         vdA+8jRKRshs7qaT79etEs4rWkBOWFWLYvGvL9ULcHZvE1Y5PFQ1tyWkU99AJ0BpvnU0
         5I4QMcQtrdvcJ/DvjccimceWh4UusfOZeUp9f4UB4fpBuvYCtlO+xn5LMK5Pqj9N4opT
         vDxrvv82cpdR1f28OgogXKUk5/LTkUAlcsrjOBkIlAAKksC9cG/BwWohxxdcMOhhZZED
         BmLaZYaMfEg/TvNO1qhFVaUHkHN2Fjf5bEpgluhE92S7b/3Z9r1E0/EFWZqtwRYZs36R
         Sv8Q==
X-Gm-Message-State: AOJu0YxQgX24sSD4M44iIikCcoFvTfThWY0bWpCXNUOodHyOT3w7rZAg
	he5uFDNfNr6/dGT0Te9MpcxxNtu1bxDnrL+KzBD7N7a6J8QX5LDP7E0dIDw=
X-Google-Smtp-Source: AGHT+IFI/YyuLIKvAKCYMgjAMfTLk0MqqeEly8R6r0Lw2x+GkNSMkuRwh3kWJ0cPh6d77VA3Wu5emQ==
X-Received: by 2002:a05:6214:d8d:b0:6cc:3fb:376a with SMTP id 6a1803df08f44-6d08bfceba8mr17105496d6.25.1729761858557;
        Thu, 24 Oct 2024 02:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.206.111.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099bef8sm48017956d6.92.2024.10.24.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:24:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <99e57c7470ac338da18f02ef3af5936c8b21f5a7.1729757268.git.tanggeliang@kylinos.cn>
References:
 <99e57c7470ac338da18f02ef3af5936c8b21f5a7.1729757268.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use make/remove netns helpers
 in mptcp
Message-ID: <8703087b-ff50-915a-be93-ae48455e93b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Oct 2024 09:24:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11495575836

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6421d1f207dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D902572


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
