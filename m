Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C01A3BC0
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543150; cv=none; b=TWurwWbNw0jXHmk71W1m17T4hbpk02hPrOA8bXyNiNBrnfSNfIEHmBa9lbwDx1y/hr80hAY1StyFQIY3lHEltBe20oc+hcL3WzX7Qzy98AOa1qzh63JREAGyeSlvqmHsu01c8axq45YmZf0Tp22k2Vd4yW20QjP959WaTbT5VLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543150; c=relaxed/simple;
	bh=8zHQozBcZIyMy12cM+JbFG2XCTIAoJNnVXoGk6R1e44=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aGg+RCqVJr5VHpuxshle7Mibqq/dJuOuhuh/TjmGwqE57juLTeovXDILc/o/avbfhi/DmvE4LJqo/y/w8p0d3/ZjRg9kT/wQ+pugVlwQAHddQqIBRBASYB3VnnRciCb3o90rwDhKo9ho8sskW0el9fAOSHjz00Atw8t2KjjJhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI0nkQzJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI0nkQzJ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45f091bf433so4969501cf.3
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728543147; x=1729147947; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwiG6QZmyEjybAnCmdYHnAt+9dPVv4FoK0YOsqUDmYE=;
        b=fI0nkQzJb5rJsYci03C1DzbhA+hPFrDJQHovyZsfPzjMl7rW8dW9l6YPtm8LQPELsK
         1LwIQwJf8+Uxmk29qZXSNmT3rgqOLsKSmOxEmP5+3/CMq7b0dAjZum1E38UwnTPl4sgD
         NuVjv1VyYwuluqOvGymVsycN9IbfPfxJASH/4RxHstrhjgXVDpm2Yt6wjMrw0FU1imiT
         PaMeBFvhumkKhmDfN7Yq4k9lpfUSgXSdQbNjwMvc6hA8uX2s8KvjXU+4dl1cT5Mhugh9
         s85If2m7+rWOrSiz4spCRwscsBDvmRhraTCGPEHDoXYeYv/XlYV6/uHPXNUz+XLmOozl
         tjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543147; x=1729147947;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwiG6QZmyEjybAnCmdYHnAt+9dPVv4FoK0YOsqUDmYE=;
        b=bdz15+tuQeJHYdEq/yEU2GMu0aJOmJxs+NuWX4SYx/PnGi8PWzZ0OZAy0xbUj/10UA
         TN5pOjHK2JLais5kcT7TRJ05me5y5/ALnMvYU84dQs+9rCkbebuJELMZ5AtDFs95PWEW
         okjb5cJCNUFxGRZLBWcgfZ2i+fkcs+k9H70HlMvS6cUGmUeimRUU/tNVbDxtO6mu90OV
         bqyL6Cta5N3efzWh6GODBKDjHgFLx/UyNFyeZG//WSC8wVX6NHi/E/Z5g90b//nFiZJG
         Po1EV8yqY+tf7jBE6xFqriwQnFB9G6/vllHUtjTida0FxV8nVR0wOLd5WOhLgMYf7WND
         hQ9Q==
X-Gm-Message-State: AOJu0YwBH7ijuBk8+e65+9SLcEC8ox9uxpaEeLkzmZVoH/MQGoWptohS
	nwZhBFV498DEPwGlYsHCYF+nSx6nKlEu/cZUHY6ejk6XWf+OPxJLn+PJ
X-Google-Smtp-Source: AGHT+IGUm1uMx8SfH5qvZmgPYKTwpg1lcE+v+42Ic1Pv6rdBuOYXORWCniPvyFboAyTQt/cCCp4Jsw==
X-Received: by 2002:a05:6214:5881:b0:6cb:8364:b0d3 with SMTP id 6a1803df08f44-6cbc92d7dc2mr65042116d6.1.1728543147311;
        Wed, 09 Oct 2024 23:52:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.99.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608b69sm2675416d6.81.2024.10.09.23.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:52:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/15] refactor PM interfaces
Message-ID: <bb0bd72b-cb68-0386-b7c5-76383707840b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 06:52:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_dss =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): =
Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/=
actions/runs/11268311983

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8a88c16c3a=
19
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D897455


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
