Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607D330312
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981885; cv=none; b=aErq4QRZ2TnQgukxQA82tNQGK7ssPuXwXbMIOV3Ly7Zy6+avIYZbY56IjlG69Lrzi585TpyjDWFELpqUg/EKgpPgn7XUvEGtWGhxvDopm7zLhZ0QtJjQ6Vfa2AofAQr+zHoaMIP/te0V6b6XxQabOmUcUOfvDyWLATvht9lztpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981885; c=relaxed/simple;
	bh=uY+45c/V/i/MFqUj6LkMn5LIfts1sN5e+JlC/jBsnGs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LNgGg2KCWY6QVSAvNNHhxSrzX9ZOxRhl8lM+lBgA9Z707gI/ZS+W3laartG65Kcn8eJJz/rWCZVIQD2otWniQQs872bAfFVWBhNQZZmzJiw70TUbbKVv2GPwPVmrVTJ+M0NhGZV4hdlNDyWCv9GeRlHMLbKOUkWMjMNLN6NP6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzOFM//e; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzOFM//e"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430d78a15b1so16489775ab.3
        for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760981882; x=1761586682; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvFEU3COyQViK1rs/rYonh4sNfPEYS4869NbmFGh9FI=;
        b=jzOFM//eqIampOCrGSyVd5sVkzvCBiaC6vZ3Ug8E78DAVBY8+Oavrw7O0Ia5lCbkcB
         dX2Jo+oCMJturO9ia+6bm5r47qRBk7HUX/KqpU6MfNQ6P4bNBIL7Jtc6WxAgIfHZYbEb
         NlGR5ETWVHHfVwaBUcf244cfMdlteV3hjPh1kp6htsR+e7NJVpQrJWdSvZsxWsTPk70c
         CDY4wpmevvx9TNGF/LRW6R5Xeb34FURjLO0IyyTCgFaJFtf9GmbvQLIWFl0NdXDIfLXQ
         TCxDoB879Ssu1twOTl+tpxfHvWJWlwrPeJ3xk3xmGik56GO107qHLz5qZaQWuIbSuydx
         kPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760981882; x=1761586682;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvFEU3COyQViK1rs/rYonh4sNfPEYS4869NbmFGh9FI=;
        b=w20FxodU+Hz0GfwC/e3HvRbGTcwmQqcVtoy5/dxOI4YjPtsULLyZ0V1jlFS1Z9hEPV
         YqZ40Fhk0AxkjkrFYy+VtQtroztUakHFyanzOw7Ea85ALZZehakotsFBFA0NJriQSBtk
         BMOgr8tPmzTrQ83N7Pp2q7Om/Y4avl57SfPQlGwGEORslPEGpZMAHU+Nn4l9Yccdlq3e
         sCo224wXT0yk79vVFKnnGFLwPt4UcLyI1hx2PsK23iopObdHV77qlGkAhDDeNVADD1F8
         cYn02xdtBX5Enx3rSDrcmebYfWGJqpREw6P3W3H/EH6j8b0J4dCkmiLxyY+YvogdZi6G
         qV2Q==
X-Gm-Message-State: AOJu0YwarJDrCt6dq9+BaXRnroKmp5lBpF+zXd2ZXSupXh+ByEHIm/sH
	vmuyW77ez/ZZs5RVKlPJWdWZjNvAuxmboEczT6jnTj8g9mQNib0U/w+CQNgm
X-Gm-Gg: ASbGncvK84KOXQbA7VMpd0timDmh6isRgXL/y1+fwHG+9AhAJSagvBijgUwKJn0Tv/e
	WdUZqhlu/1tRe6BFHON7MTzVq1p4y0z6MKxAhw5/PI3fVg3koOBY0Cc/2ABg0In9N/KJMezxVzL
	ELGGWwwkujeNJ2pxMsug2lKo6blBAqZyttQ0+7PxgELnXJ912Nto9LTsb4m4GsvDV0hsAUHNAhX
	HV/f/ZoORqe4iIUkcYBr5lyLeMGcneh4uY3s63We6OemSypgMsE6wXRMvcHm6bOVRpyBG+HqzwR
	fVs06A5TG4QOgv0PSpDqztnx4oYYLN7BWWVhjngSP8sglPUxdsMavkH07KqCW7YJaR4ZEm9Vi6f
	kdPsnHzid6UkGwX8SshRegvyF/2PMI079kClKZzaEnR6vX5ydIZMvmiGsn2uHcv44j7N6KBE2/6
	OEO9eMhwyyww6xYkU=
X-Google-Smtp-Source: AGHT+IEsbP8/ARCZUeC/UR68yS0a6NClG/8dr4CrB1SNFZuL35b7nh6zCMKebVczOJWyxERCACN/vA==
X-Received: by 2002:a92:cda3:0:b0:430:c1ba:3558 with SMTP id e9e14a558f8ab-430c5268daamr20016155ab.18.1760981881970;
        Mon, 20 Oct 2025 10:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.170])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fede6sm3165991173.12.2025.10.20.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:38:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1760976334.git.pabeni@redhat.com>
References: <cover.1760976334.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: restore zero window probe
Message-ID: <15bc3154-f117-83d9-48f4-e5cf4618f8d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 17:38:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18658193252

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2f955eee50f0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1013663


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
