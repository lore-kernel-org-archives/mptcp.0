Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56A2E41A
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606582; cv=none; b=cALXkwQAOuSiUxqF/hyknJS3QBUJvafrKkWpkHqjmNeqkRPDZ/b5cKPlrzCdMI/6W1i1FSCsiquMH/x03qUHXZRypCtIo2sZNM+TvkPQCc/SyTLJbtS+CeFQsT4A2cftHbq0k3I8XovXcDkG5mWqp8n2hhZ6kbnGtzRtGI1cqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606582; c=relaxed/simple;
	bh=/OVa4DGGMjqlbvJlGDK/9YNaiq8RyyCzhOU6vgFrOzI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aFBUbktjJkc+wAozjPIccRZzpec8FbDJMnuMbfnlhvJvXoeSW8RtCny9Vl95ncB6KrWnKb3R/iG73iFkELU1vs5NrI5k+eFXIwfHC8Jcl930n7wUOHtGjQQHY1/4gXho3YH+qStyHMjGVyUCXnmXumBiWq7GBJHRTAwbpOKuuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V36IeyHO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V36IeyHO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7164aeac1so4643285ad.1
        for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705606580; x=1706211380; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9E+q+W2j6S5phVy9mX9p3g+2F+KH7RpPn6zkwIDXUE=;
        b=V36IeyHO6P97ZOvAfMGVksyehc05ej0kLnRk31XGxDTiGzXHRMQXj354PlaRg56cIp
         2tUuYmawCV/5eLGWNhVgOjn6PQ5MBZBUD8qR7qsO2sjvJw2YowPxyPU/OkLSrZoiefd4
         aYf4Z3x2Y2yyCwxcQKu/hDKXCkLWZmP4WGzZxi6Os0Cers4L0LPQnOdJighVnRyvmVEs
         NjmoJVA2uCXvQ6+rgzHXk6pKjMLz0qYcP9sWJqWxKXGChkLNCbVcB+HL4dbWT44f3g64
         +jkvSZqsfh08OAov3S8u0m9YgzoftombJioaRlF1XZqFG4407HFzWYpnHL4yVLzPmr+P
         hKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606580; x=1706211380;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9E+q+W2j6S5phVy9mX9p3g+2F+KH7RpPn6zkwIDXUE=;
        b=A1VYtku4hUl2TGLTjfyW6VZeEYrz4bbETSQ2M6zcAppZecZrUJPaYmUj5aPNrCE17k
         cQEXBeg8TbSAiVEPUykJJ3PY81Hzuu6RecFjSG/obOKepEvD9s6zHl4v/EvpnwhbquXQ
         vvnuaDtEjt/B5Hkx8uscBRNiPA4OxwlCAIeujf09UwKUpSZjZ3YiB56oL7Dfoaa/oHrr
         GAJ7qO1xCUchthFV/Zrw4AUJOk0xP/FccU1HG2jqo/Fevd5M4chG6QvmvhyJUjFbc6q1
         Kr6w1diIZ+IBmPUcXKYzx21HWgeUI/KHMl5MYNA3UFpp7O+7GYoarXZb//m+w8Kfpnyo
         4yIQ==
X-Gm-Message-State: AOJu0Yy5EfAgHX3ss72bgLMWy1VdQASdxvIQzTTrZXIBj03m8ovqoWmM
	U4zhRpweHKT87QOGmLcqt1GsxPeaE8vRLKln3/t6fEOr8IaDXEA=
X-Google-Smtp-Source: AGHT+IHK2JDHNJMXWeSgDqyJura5eHhSnPXc/RVdc44AhifYGIGZ65ny9uIyaxfCdtwTVf2Qjx2FpA==
X-Received: by 2002:a17:902:efd2:b0:1d4:7abd:146f with SMTP id ja18-20020a170902efd200b001d47abd146fmr1035022plb.80.1705606580151;
        Thu, 18 Jan 2024 11:36:20 -0800 (PST)
Received: from [127.0.0.1] ([52.238.25.3])
        by smtp.gmail.com with ESMTPSA id sd14-20020a17090b514e00b0028d9fc97c29sm2272830pjb.14.2024.01.18.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:36:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
References:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
Subject: Re: selftests: mptcp: join: stop transfer when check is done:
 Tests Results
Message-ID: <5285cc6b-df80-9035-01ff-1764c684ad98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2024 19:36:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7574570879

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2af4c20dfe1e


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 Core)
