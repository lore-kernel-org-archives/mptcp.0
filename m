Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3433259C
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162974; cv=none; b=K6GGHvbAvm5WJSDWSoA2n9BWkuHcD8UwaTom+qVuBEaJlXGEw9RvTYvyHkX1YG4lFlQB6HmlrIhXFeKfgB8hU9auSGe3oAAvKxIr/Cp73oS1GHPXHOt8aQ3bhezxOlUopHGXwDwyCVYKOxRrIC9RJvCSaOfXutscq6hnU0UMJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162974; c=relaxed/simple;
	bh=SE6urdgm3vRpg1RpPcidX4qTFDh/ge3hhf4P8odA2+E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EIrmvKkbV6D4qR811e10oZSkjXQwxIBn3uMxeQu3whVPKbLb3KY/JiNMHh3DBhjyGwxGCvrkdaFTrzqNMMeSnIebxICIR+QGortuM3aIDir7gaLaS98tnfhGkyU4M9z1W4YTC3tT76ZSd//BGNEhXHyCkVaHcvczzehW0VOKbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfxPUg3q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfxPUg3q"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1343e8042so84898185a.0
        for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729162972; x=1729767772; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWMPmYTL9kpe7Whexcx90ICyZXJartsJn8bubXEVHa0=;
        b=OfxPUg3qOxUtlaKXT1uTWLS7JROyAmM2Swa2nKFyb+VKgfy5fm24SJcO3qM3aFQdrp
         CHpPTt/9YvJzhgqe10HCpCB/FbahTfBDCKHH1JL3i6j0EADqlQO+MXe8GuP5E6CV1ZhD
         zA7VpK4B/oE+VLOOXxTdB9P5yju8xF3Opwrl7cGQtZQCxILU/Th7kgDoA/eK+d0clKzH
         pOBa2fgRIz7Ok4CiOOgKsu9C9A/ATqrrezWO+tMIdYMMun6y9jX6yDgqdOHNX730ul9Y
         seFeg7KzNSmMC0juCRDO8t6pV9F9NmeixrMehbeOe7KiYe/5zXjKzUBdblLnDbOcj+IN
         Kx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729162972; x=1729767772;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWMPmYTL9kpe7Whexcx90ICyZXJartsJn8bubXEVHa0=;
        b=HbtMLV9NrCzha62jKa9rj+N7e3Hhw+Gk0LXe2CUYJ16MW4Bb8FUPKxxtGU6FL2DSuf
         yHpQ2O+A6HF1cOepphTQrNAcF/+oY1dqA57dR0wzywpZbbKLcE8A7jbkGbFaRuLGHuBR
         af9m+zAaQrtveig+b+/5AzcPLH4NFnjV7EX1xuiKUNIYY7yKNtF8aribbMK6jWmNT4EU
         UWiZMwubXKl1sDfxgfc0tjHO0v8guZ0UZo8OOHBXIz7konJi4Sy2sNU8RBKXzIQnmvXA
         qVUIYRpMXHgH/MOHeTluLZlTP31heG8b5gd8QevtWSNqkjCXUUlgBXmeGloW3MrteQN+
         dYhQ==
X-Gm-Message-State: AOJu0Yyna2b01CkLwW82UCua+qZ/2wCH5sH+Ie8Vn3t62QgBYuCrdr2P
	8tnFXKt46gSHQXB1cCyjCliCpgaWUMgd5+ByQcVWOQBnZAh/0TCfYAxM
X-Google-Smtp-Source: AGHT+IE6eK3apAapEQYLqH5CEnkqwn8fvMxpXLWobJBqe5NlwlDB5BnNmFzZQenqwARNSrx0jt+t+g==
X-Received: by 2002:a05:620a:1a87:b0:7b1:3bc4:20f1 with SMTP id af79cd13be357-7b1417a2631mr981636185a.1.1729162971568;
        Thu, 17 Oct 2024 04:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.106.62])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1361704f1sm284134885a.42.2024.10.17.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:02:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241017094704.3222173-1-ast@fiberby.net>
References: <20241017094704.3222173-1-ast@fiberby.net>
Subject: Re: [PATCH net-next v2] tools: ynl-gen: use big-endian netlink
 attribute types
Message-ID: <fade90bd-342d-31dc-3c56-bb725599040f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2024 11:02:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Asbj=C3=B8rn,

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
uns/11382841554

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/46f5c2643965
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900162


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
