Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AB36AE0
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985795; cv=none; b=J+SzaC4Ubpq2ASqQJMLPkai5Omyl6Xkk3ZuaiS0zT9J/kd4T2V41VxiSDPp7dNVcnOyh+Hx7EH8YfnvtxJROsApzqSQDqenHlvwaKyECOjKaEP3s3F0kUYvk2ZtJUVRTZ+T8EduWVy3uHpWBR5ILjjaKy6HDq8CsAZiCX5wqtzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985795; c=relaxed/simple;
	bh=Ousmx4bfuqeIGUubq+s2SLKjF5JSn+gAJqC4Wu7/wrQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dSK1h5XB1/4ZmDPoNX75cpQwOUdb7qdRLLGNHUrVeemWk3siQ6U7bsmAKB4TcitXES907eTrsUt9L1g39LPRFlyEGMfhXj5lQut8ke+2H2I9v+88S6u32c9iy1QqTPqMTqbmCkbc0k7a5IP806UwyVnxHZSUMeI3r/3gIyEPM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ1KfCYG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ1KfCYG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fded90c41so2313541cf.3
        for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721985793; x=1722590593; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yuxSCqqmr9bxlPnwFv66bizlzbjzAGMuo2JdSQOjiA=;
        b=VJ1KfCYG23vN1qnjKhqbdA3qluLkCwvDmmM/2kshIeaNmfoUke389Wt79TEmmH1cMr
         /OLs0wYyfCyAYzC4cEJC0ehoV+g7dz8r8XFDBi1jsGus1AN9wEXvxpqVy+HKvkQEg29D
         IHS7LLGYi/sdzxHAPtvnXNxZGJOFINRKbbCKxzjmV9FWDE1/iU9Fi0+/EmWj/KIVMKwd
         HHPT7xE3i/JJOuHVG4VIIWQi5DCp/MKKELDIk3O8RoRfw+hdGvR1dGYZYM0CmpBWLNRE
         i1s7AEHfRj12x950nzuhy/oYf9NCAtcJZKNMVoODJTvpKtOJyrpqq3WAEAEuCIHfsvnJ
         gLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721985793; x=1722590593;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yuxSCqqmr9bxlPnwFv66bizlzbjzAGMuo2JdSQOjiA=;
        b=LEdCYDzBOxp7GH8eeYp+gxg4HoSBLHOpaS3p6xVXtQsM0dP5o9kRCN96mFlJD0GQId
         mTRsTMtIbGYxG2CoPrCkzW5HYxaY/YLcQNURPzLcv2yyH8FcgmfXMg6oQjeH8/J8BxGe
         JKi6W4d3KHJCc879eAi8ylTugD3bSYJNGfYt6c4l3Tf2SQKHQb+347AvqVc42oCZxbt4
         bRhM6VxsxmAwMjtGddSzO49NWcFuKTg5eGHlsZ6TiHSu/ho5vZREs6iyihCUH0ox0NWI
         W1S0TVG7qLyXpFF5j/Q7gdKLABuV5gOva60mUxrbDZrKGTMCr3uoGViEnlwQtkZno4WP
         xlRA==
X-Gm-Message-State: AOJu0YybrIiwA0Ubh9vzb1XL/bMjxd3aTWsJxPo/v59kESJT7UrlRGTt
	Iex98CVhi4uY+DDKhy4Aj0lbqTguulTd5UC3uxdlKwyQbIbQTHo=
X-Google-Smtp-Source: AGHT+IE7qZmZBxigPLk+bry/Xhpqt/+f3v4PoZ9HIS81iBC83870/f40//NnYiNVVTX0uqz1w4T8/Q==
X-Received: by 2002:a05:622a:1485:b0:447:ede6:435c with SMTP id d75a77b69052e-44fe91de2e3mr52247561cf.26.1721985792871;
        Fri, 26 Jul 2024 02:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8207b42sm11996781cf.61.2024.07.26.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:23:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
References:
 <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate data handling
Message-ID: <47aa1668-43ed-237c-e717-b8f2c57fd416@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jul 2024 09:23:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10108418141

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9d038da097ea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D873877


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
