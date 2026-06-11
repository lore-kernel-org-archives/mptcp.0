Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DB253B58
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201232; cv=none; b=o2hP9gHnuauW+kzV5ECVi5JH3/HcVHJgeJlMQM4CGG0gLfd2aEDGvJFKrQ8FP9GgvtluD+QGSbVOjaHbyltTl6UYAUVe1PFj1mIiuAXMBp/1Lb0uPayAXCp+K1S71s/dQIP9jXt3+RCGUjCZ9PtoJmojKt7F4CH1CVCwlSgCMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201232; c=relaxed/simple;
	bh=R83nnlAORyqq9QURbensmWlLCcqbKxKCH3T7uiVCDSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Cvda1V1DHFoOGiH0sQ8wPi/w7/VDoOg5TXF+6Xsl0lXzXJ9fEK7phK8t++/LWzFoG+YNu/wCh08/vXjI2YTWSUMX5Ikhod9lkvA9Sr1HKhV6g4yCMak2xKCXCEqiUCunOU0N563RKZ32KXISv6GwNjUiR4Jsd4XZSg5Ey9OW+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORQcyqbK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORQcyqbK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8cce22e029cso16798636d6.0
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781201230; x=1781806030; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii0hXD/fShjq1PUMqM5M9rr14LajJ5pChxiF1bF29UU=;
        b=ORQcyqbKNhtGG0rlUpwLYfRrkCsWzQ3zYnHGjvp6ki4BCDN928ACMFegfpaZVNuGIF
         7Vf/ofDCLsC0QbiApnVr8qkHVVuamKuvh4m/2gBBNYCtfEpjaNm3qRq9/roWtpTSAdOg
         KlCXkWFkFQZFwJ3nOXj5eLt6putY9l8ufEq9Jd5itXYYofcMQhjMr65gtvi/KObs5PxE
         NO4R+mW4Pm7Se5iwLF437LGopL5GOHd7XjCBGxf9rvxAq+W0+JsiytOKzKxXdxd+VahS
         jPhwuwDvMW+PidYSI23b+1BEZavWwxJXV7l3+pnPLqiLo1kH440GVHT+fCen31CJQye4
         E7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201230; x=1781806030;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii0hXD/fShjq1PUMqM5M9rr14LajJ5pChxiF1bF29UU=;
        b=fXlqiSzyS3tXvxbaTop71yjg3HsfCXtEgGZqd9VeJEC4qSqf6kT5/68oRwbainj9P2
         abB/sLqMi71RCyuWkZniIE429zYqwoOd292hAG4ujFMeBxRKo6rLIHob7j9mBDgId9Py
         Gr8e0j/uqNyPGPHL+TQ7b0SlxGOCxtEqQAWcgqfxCz7NmhWX+yDAEhQZC/NebXcljAZ0
         EOtPFYK5acFOVGCorJp6B05fCmDOZTJJ07pAN/fbgLuAQW5jwhKGuYNT/B6+sTnv4urm
         BNz7SYZUb0PE7xas8H3pTQ8mp7Noft1bapJzc+gH+FY6uxTnFw/JfzFUrqkgCUKsdcq0
         U/Xg==
X-Gm-Message-State: AOJu0YznSZ2/d67/0IjrQtGu+yO9vdJNRLFzIb8g8TT07pzAAU70U0NM
	LpTVZuplFo2u5SGfLtFuT5pufOsnGRSn6vqM9hSdOECcdUGvEJ6M/ZYZX86J
X-Gm-Gg: Acq92OG5ej1RHHxqYDwXxNblLNd4LyS1gdLcq0FgqIxKQQxJUZ31S7kGPPuU6ZCJGgJ
	lNf/8Ao5S++jSh9lGRv3FrApAOzvNz0X7aQz2rkU6acT76mc8XABYNvbmm6JgVcT33pkudvK+bO
	01100Yo+aNeZToDd//sTMWbSdx8qVbX70WyyHbrBTsPh6e/ugVCNWEY1+cXIQmA+cKCVVbWYc8F
	Z4YDHtJTzhvvIixMH1oUlWxYCXNPC5bZsqFUHsWfVzZ0IRLwDYh2fJnHc69KKK+/F0BjAeM0nV+
	RH/39z4Vh/veqJJx9zSlAp3zhI3zIqiTgwhcdTIpUPwa8mStFjH2RwSO2/G+dSAGrJH+U0cWLHn
	VFdCiPW0ivhzagwvz3WFw9TCqeT9BprQ3Y5MyLgTXuQJMVjnlbwvvxH0VRZmbW3oyO8ZyiDccZf
	dbANEImvxTxeLGSe0KNnW9ClXweJsOW4QL59uhKQ==
X-Received: by 2002:a05:6214:5f09:b0:8cb:e78f:21de with SMTP id 6a1803df08f44-8d1e9245564mr57854896d6.11.1781201229929;
        Thu, 11 Jun 2026 11:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6b962sm589466d6.9.2026.06.11.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:07:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Subject: Re: [PATCH, mptcp-next 0/9] selftests: mptcp: skip the v6 subtests
 when CONFIG_MPTCP_IPV6=n
Message-ID: <4a756e97-a153-3ae2-0db8-735d14f03390@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:07:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 11 failed =
test(s): packetdrill_add_addr packetdrill_dss packetdrill_fastclose =
packetdrill_fastopen packetdrill_mp_capable packetdrill_mp_join =
packetdrill_mp_prio packetdrill_mp_reset packetdrill_regressions =
packetdrill_sockopts packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/273648=
18369

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/127e9ba80ff5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1110208


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
