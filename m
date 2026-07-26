Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6718A6A8
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058634; cv=none; b=ZqJw1cL7sr5fRFbJqJBmhf16hikTFSY3qxJy6A5R7/8j+9IDr+zh7G5GwkWl/EWLecr8rI1NVC4t1MEiFKI7oOL1XGDMM9LM/YjMPBgjLbokLvyprFatliD9X7Tuk8hO9AZB4mb4kOKbqWJxAHc/sMLUcmh+UmqJuvNhl0I8+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058634; c=relaxed/simple;
	bh=pAd6qps85yBwvpfBuqNy7fquBV7gSNhyisB4yVYXRy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=oQlkrP/FeNi/E8xlQJ4HRQvPSAzinaJ0F1qQHv6IzEN5JwAeqae1dljMjPiw5AbHD4NoL2kDoMgfc9ZkrYO8EcYlT/xMQHNsG5Iy3afFzuzryz0ClV/noBltTxuWpvU6K6golLwBraqHXjbwnehTBqpLTydrfQ3m3QQdRKaSaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkViM1QO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkViM1QO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c04bf4711so18977111cf.2
        for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058632; x=1785663432; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fAnoJS/9GjG4MlRoPOZAd2Y9WU45AO+3NzVDe1/7ASI=;
        b=WkViM1QObp6x3IfBCPA18gaosQ/qXJM8NVDd/ypp7V8EBuYL8rRWMZDG+LakU+fuvW
         lJyyuaxZhf2+MCWCN9F3lnVMbB9dpCJvIIkdFl2ghcuM5+Mu+v/mCPCQ5yVJlZGv7G56
         dH6zswliSETQn1FUxv1NRffgW8zhIHXIM4n4j4R9JkKPX0TWjcZXilrBpTUk0ca/ORE1
         6mjuE/8OsbREHNn4MA3aFQlSNOx5wzksBs+MRd/mFQ42IyAOSzFgtKlTi4PUcZ5nBomp
         HtReKWUjnV87vQRNMikBWf4UpOSr6TPfi5StVo6NtXmq+GVeNO+Rbg7gXfiTsGMOe+RA
         Av7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058632; x=1785663432;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAnoJS/9GjG4MlRoPOZAd2Y9WU45AO+3NzVDe1/7ASI=;
        b=OTLfBjdubk5d33C+F6cp3KeecpGizASIVxaZNCuS9rT/VtLo9PzGbV8C4pS1gf9LuC
         KsQ4GUURRgU22ZmYAZ6rCbd1n+va49p5vhcUhmEQM9unvFQ9y/u83XotW1gPAzy3ssgx
         aWjw4lJgkbp3My09KL+2QgGpEAAVBtIY7vEqM2U/rxxEQkGkOKYRPQm89zqPmKUsanis
         S/W5i8gKPJ4PG9OiezhyTxAHnFWEN6n5nAg/OPMgqnpRp4vfWwmzD8/Tsy3L6uYl4SIJ
         WL4z5S13pzkB4H6rD2Gfa/LSdoeVcdGNz1mD/cyHmj8ZFp/rSBtOAIUC3k5O+zZ+Jdzl
         cTyw==
X-Gm-Message-State: AOJu0Yy4iyK5hrXSaLPplJaAGpD2PVe7FzaGPTX15ErrEGc4Ge4MTpdr
	h7Z/mC6z3QwLQiRK67aLliyb7Qn7ZCoyWGW0vhRBbrbXICzyVlfCP4Pnj5+D
X-Gm-Gg: AR+sD12Af6mrUyYzD457JLCMkvAmflEPBOyaNlPFhbWBfOCa75R5HyETjluBCKc5BYD
	rvdO3sCjARGzMFsGy66ERJTOGt+LdGtPOTCC3KPZJWvtWEoGI7KwkX80aFjBjPontLm4xdAgGtD
	18oZdGJ3mdkYuF3kJIh2dICG1zmAl3wfZTqs0boXPpBLLfBZLaQW+gTXsAx97/kXtT4fsqUGK5R
	lRdlKvSnsGdPs2IiBN4pkPcMhNeVHFg6n6Na9pVNABNoFWleS2Ydgl91HNOERTWdyKirJFFdV3N
	AC2eZF+MB46wmZqFhJqYSKmSrGSJV1PZE+q0MvTrQErlunAPMQFrFd4FXzXkVsZQuAI0aXMdzE/
	JbdgorIkcUl+dSH1nQ7wOHpy6ARz61jvxzbSa9HmDd60V88zIH7JM9ntkpfjgR+2AjFRVAH7+Vt
	2QtkQdfJYRQ6OuvJpB
X-Received: by 2002:a05:622a:1910:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-529a8381dbfmr46330631cf.18.1785058631756;
        Sun, 26 Jul 2026 02:37:11 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a27cebedsm32576291cf.1.2026.07.26.02.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:37:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/5] Fix socket options used by NVMe over
 MPTCP
Message-ID: <eae09e30-f6da-83d7-8820-627b22c48563@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 09:37:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301952=
36916

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/006edc38647a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134602


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
