Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109703B8D47
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538129; cv=none; b=KvOaO+weRYqWADGHW+SlIIwuhqdp4FZxkDzsA41Z8T5J15+4cC2TP1jEKGWlxggoIKHDSsum/AJVcVkpZSPgeWwgwepcJz2qTsKgEmCIO2WKkOhlNcjIbY/pwjKyDUajOfy6JB5ADkAMWb8Eo+4gcuf58leuEp/SItAXNKKaNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538129; c=relaxed/simple;
	bh=vK+v0YmiNMJ0T26vPlPv+xY9c1RTKOBh8HR6kuxXqzk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=O2iok30FHeRYpV2Y9T00TO6iBE2iEhb8igkHqD3mCAnmRmCpfuPYX9KIjBLM3Un0XRQDkeI5P0I0YCbPE8/BgUjc2QBA0ycnfeIINm8CABuAlBnsqqLvCguWCANqoxuy1NsvmBISJECDZpzgEv4GLnW7nEIS2fukmK43csPgKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsYKDlOW; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsYKDlOW"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2dec4d115so114302385a.0
        for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 03:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765538127; x=1766142927; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfifXdEJvZ7gZElnS3GrIFtE/CTdJFrKATxAHxTGOSA=;
        b=ZsYKDlOWSe7i8doDpQWNm6kR+7LwYPKcUln1babor6DiPcI4svswQIvHYviJOpomaf
         FaEjh7TaMctgjtLKjd7PdSZYQppdFLBe75srj373r4ry8neBKJu3ZvrJLxRnvY2cwuBm
         M8bhuSCe+kRWhM9SlrHft2RGYAeAO7+7Vy40rCKP3apkrRyc7HHdbN/Q0eGcrKOYPL1I
         x7DHZ7sVMuyRK0jgovphsipdXwLo0oP+uuPCVkN0AvdwPX6f7ymR/q5/O3mO1YSu6gxI
         d5hMa/kERWWFiB8RmES358JI7j4G0FQMT+r4NI6wfj1CCCT7UMS6ZycXznqhjae2QqDt
         KEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765538127; x=1766142927;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfifXdEJvZ7gZElnS3GrIFtE/CTdJFrKATxAHxTGOSA=;
        b=ttPUKpKytMcl3pIzD43xPdO1zyrQ6C1oRJ8/Qu8yOdBhECoRnTH/u/oGJLLGjUAQdv
         xIhy9XjGtXmPzKYsOjwIRqccdTzSKck+F42bBCu6APwYTokwU2m+26JBH/mcgYOpAMY7
         JC4b2EbMGCK+a9r1ajYTgvjPXo9rlgF+OzsNK9hZSmjnOekjzREjTYJpdn6a+eYaVzfp
         3MMAoIZeB//EuABgAb1nbsQ0WahhIHeLnUqgUr3Cix9u0DCNk2sMa+Uw5tVilFblV/pL
         uoXsaTk6Z9Htw5YRB+sGFZQ6vEsPJCMBXLeCyiNmo1Kw6FW9fVDaIAeQ/Z1GL19cXs3+
         7tmw==
X-Gm-Message-State: AOJu0YwPGPzp1ep7HDh9Owpk8hUzon7LnVS2ql4nI/As2ofg5WzJU7fC
	xbpNuycb2eUl8KejphG9xVAOs9+hSg19qf3xkaAbzO4LXGar2NBTvlVRv7VXIM8=
X-Gm-Gg: AY/fxX6OZneUvn58XDaIvUnNyTOnFjGzySC7EH60vZZnOiOYBqlHC03hmrjTzjWv3YY
	59WRm+U/8tPDS7HAjXDwxHq846OUKBISj7DPIONaVIkpvYHLeqONvZQ+MjjSLzC7FN4A+AZ1YpR
	eOrDiSvPHKGwg93qxAw0FbkuU+YHd3pv7Zku61Af/ARBBuPdwPOM3fIHgjXJcKWaGtSpvv/JlgA
	yy+iROuJkZGUApqe3LEbjQgmzQWWZIvKeCvfy0TseDcvsAfY0Vx+pTaov4CKwXUC9nzEG6kmupW
	J08SE/FO6tk5aYWGN/osR5XNox/3RMi6RUNps4nCrtCjKpayfv/ufq4cVkcyXRMm4ru59k7Q1Qq
	McYCHfeilNAkIxV1h4M3jOTAVHibs5ngCP+53onx/bQ56S387IMt8ikQjTDtFXQt6m+6s26qpZh
	LcooXvabXWovSkd41pIfGMkdKs7UJOLF7WFA==
X-Google-Smtp-Source: AGHT+IFgtoDZXFno+eM9FOgLpPQzJR1NHPgM4xqVy8c2Z9m9pkXOmxlqYY3ofuj+WEKgpMfy1d4jBw==
X-Received: by 2002:a05:620a:178d:b0:8b2:e1fa:6eab with SMTP id af79cd13be357-8bb3a388981mr200982685a.62.1765538126808;
        Fri, 12 Dec 2025 03:15:26 -0800 (PST)
Received: from [127.0.0.1] ([172.183.89.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888819fa7a0sm8334186d6.40.2025.12.12.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 03:15:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Evan Li <evan.li@linux.alibaba.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
References: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
Subject: Re: [PATCH] subflow: relax WARN in subflow_data_ready() on
 teardown races
Message-ID: <0711e109-e8f3-cf27-6b87-5a523beafdff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Dec 2025 11:15:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Evan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Critical: 6 Call Trace(s) - Critical: Global Timeout =
=E2=9D=8C
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20163673400

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/db1ac6b5d91d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1032600


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
