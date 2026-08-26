Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BC351C02
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729222; cv=none; b=RdDldQByTpVv28bW988bk3N7FwHoQI1YopERil+QccYdZ+PJ9UkYsbjE+onQQdgS4NDbfQT+cJpZKiJIEMiRPyy3/3v23np+JTfxx0ASPlAWMXRtKaypfQ7PWfl631knw9NF2HqSXzCgMiov9kCr+ZNl7HuJlf3OAkRU6TS+Qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729222; c=relaxed/simple;
	bh=9CPh3zXTjK7SjBc/zNItifZNTFid4m6I2cBdK43DE74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=H9w/p8K0y1wXfqxJJ418FBFQ03X7V0Kcx3i5G96MUp5U9ph0SavZ6GPB6YFPACTUWil1iXsTIl3PZNjVQ/uAGO1YSzwL+6P6czWBmKauTcqDCRoMIZFfgpRkVuapB2L02LuXntIT4zGu3ue3xiSKAd81M3AoZ5NXOEvlICA3wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNhKxerW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNhKxerW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so595493a12.3
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787729220; x=1788334020; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQa0Nl9DkqFbOj87thA0QoTW4yUOWE92U4K5UX2N73A=;
        b=DNhKxerWh2ET79I1eMX9x9qKuUjMAkP38ew2LZeIGKw6SCBbyVDp8YwTEE5Ki6QSe5
         +7LgFhHIhQx+ztkgEFI+E5wE3UfHntzDI4L6cBFV5ZikshqiYyEhkst+XmgHVxjlSomF
         3eXoFXH0omZQGgLYYR3L/iIEHx2EJ/dxu03PHPRdoG3doQyuWhYo6hkaQMg7UlV2L/d4
         HDkteh/Fc1CYHWF7fQDaL98HMFjE/3EiNjPJHhs/zbP5VXexrh/K34dKtmP1JOrLNHRk
         bOxajURavZUrS+6G1rGRXziQC/FzGsD0GIKrPotfOg924A+trcroqQsnrjF/1NiIi3e2
         D/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729220; x=1788334020;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQa0Nl9DkqFbOj87thA0QoTW4yUOWE92U4K5UX2N73A=;
        b=NS9MuNg/wpntPpoPNz0utOiJlj6VlzQRTNmanESTCfddqn66FmxkxGfigWNIeWlNoG
         /dPSDzc2H3C2EJcrDwl+vjcGnkyA+tz8MLy6g3fqGVGbWg9I+jImsY8SryogAGY482cG
         AHjONSzvWzcp3X9fAnJBJKMJ5l5OSUNOY3qWAAlDxlV3ge+gfWwbEIX+GS6Htj+U6MP3
         ChgO2od4pyR1asKMXuMMedS+y2vJ2FVeKH5t3XzNXMWNU94BaxXVQkNd8PggqZ+CFgg6
         eVXtHmQ8PontlSqWA+AmR0p5aWwv/o9k3wwJGqQJtIKhvkZTQvgcvn/wthy02acuzLNm
         a3bw==
X-Gm-Message-State: AFuF++lRfMacwvT81OEyHDn3elKCJT/EasqJCRoZhlA1076b0IDZDbGP
	pbg6KqlGK3Gs48WlwFPpSsx+PHPIU4W26qVPDr2ffcBhGwKg1l3UFpHB+jwTifQ=
X-Gm-Gg: AR+sD11kOWoSgjoeh1MJ7DdtwJGTMsbjfPhJFBepxa2QGswbyN4LeHCEbE2ndTt0yEg
	23TayJmKJM2l8R37HMRAHvANphHOw3z5R6z5/LJ1jHUo35g/Ze/dbSM2AZf64BxsExfK4LUoujl
	8Pq5zF0nLkMQgd965kcapju01rRHP1h50T1J0atNS2R52fohno3M6wRqsKgg72dugfR52xE/HWN
	par5pDAOuuNYry8evnOVnwH5R8USwPCjkZNU7XgO+9tn4jfac7OS+kK/wGtZBwVLO1Tln/CFcOL
	u4MBqIo1jX8vwUN+hRoif6DSvkq2vb+Ci+rum/TJJ2Q0urFJ5vxVIkgZkStBWA/1VF7S3wHzrnG
	EkUZDVeCWvNjaWudGbPwXDL62+LiuVMjkV5fbQ0bUZji9CyrFtLIkF3f0PDmVfW2Ld8kzFgvdJB
	uwVfbNiUiJD7t3CCajlTvw9PdN7rB/cuFIo1zypu1fMNBDvVdVqNXvfUm8ymUjyZX6SK1IaG1qu
	Cdi
X-Received: by 2002:a05:6a21:4cc2:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cf85468c88mr9860115637.18.1787729220510;
        Wed, 26 Aug 2026 00:27:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.242.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm8914027eec.5.2026.08.26.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:27:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260826060318.571751-1-kalpan.jani@mpiricsoftware.com>
References: <20260826060318.571751-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <aa62153c-2687-7579-fe0d-06429e4520a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:26:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/329382=
36918

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/10bc5a274e67
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1151847


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
