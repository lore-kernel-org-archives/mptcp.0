Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144222BE644
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304487; cv=none; b=jGTIGTF9qGzJ7WDFHWMsqmHwUx7kqMSf2qaI3frF05+g2+yPxS3xR8zz1WmIRV0tHkdOWZAEDaJjUXRo182p3Cv46el5eaTxuxGKbSbeqXtryerkhKZioe8lTR9RNk0IVGONVwfl2gI0tWRBiG4fZWgObAvbNeXIJP4bq83RCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304487; c=relaxed/simple;
	bh=lAB2AzVHOox6D1AorQLaTiIUSe22k81Z79tg1cYP8Tk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r1CVkkBCGobDoosJa4l9EgIe150v+9hhenwgk0Tzpj5XsI6wf+rmdSzTdKQY1z9HgXUpj6FkDEEFZK1xKi0pI3mYm42iBnwyquxvd3Q16sE0rIiQBm6gebd0qXHqvwttIPzPfaODdVoK3Gfl+bYlawegfm3v0sKG5C7FWx9v4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZYFxcVX; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZYFxcVX"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4f1899960f0so80952551cf.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 03:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768304485; x=1768909285; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1QiLfE++VH2v0goLZVnvlYcbaCORdHi76J6jFZux6w=;
        b=FZYFxcVXKK/3Ipow+cYFeH4L03O4QJiFWmjrKnV5GkRWo8/CfVM4InZyDitYiWviQc
         kYDlGNqht8yNvs+br4vU7vJMVo5d+n5keBKnjxZE5mC8XIMYtE/vJxl/W0S5gLnV8IWi
         prouESsHDyM0gXotYLDRvs9AXLCsLwyNvP25DPq9iDaKIZkLfUNGWjvzYZ/J4Upf+21m
         knTsh1dsQmNdTEwxO7kpki+PAG5n+dh4epXXOQMcE4rc1TXYIfiOe7xS/63Njwc/gZxR
         3k1nCXjXEPdKAv+M5+xJure29cUMhZK45BUEQWM8JxxMduE73wSTis2tk0ladzVRs/Eg
         XbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768304485; x=1768909285;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1QiLfE++VH2v0goLZVnvlYcbaCORdHi76J6jFZux6w=;
        b=DolDt7ePYDSP5Ml7cQZo2bLjXKVAkwsBhRB8w6MjvNZ/HqHcNpoTNr3z2CbPFeJJlq
         w1XE/xzlUhQW2HICyE0C7fw3MbAQ7BgF8XOEyPYKRMOIFRXRox45i8a+ppxF9ZotlC9A
         5e/i38Jz7KNi9TkKNFLtJCYf1BJyO0xMftV2a0rWSdMHhweZc5NAW9nfjOCMkXoKklnS
         6S1bo3QswuiQbOms8PjyML8hWBu58ZnIh0WkeEdIgIQIs7VuecViEX2EP7T7mddhs3Mh
         n1qMQwtN4qDCLPNDT8IsUWHcKcJ6pzrbA+SM32byvOjYQe9jcAtstpAhr1QmHY+eLhWk
         7b8A==
X-Gm-Message-State: AOJu0YzxZWzRpjAKbuqw9xtTys08luIwzx7gWZxrD2Gj7JVhWRZKAkVK
	1WR6lewV0E+vc+xsi+dn8gvmwrbeiVVKoLo5f0cYw6m7Q9pPqDkI+wl4fLMkDdg=
X-Gm-Gg: AY/fxX55Q60W9fltQpuA8u/8AJM3hMYSsOeluVAMvLQTN5CL0cT/9Nk8Jh/EUvhFPm+
	mxEDchI+dOKJkLnxq55u2nHQSv0aosQDDeKmCNkbnFT/IlQmp02k2Vw2H5zB+qR8BOiRPJNe1Vz
	sP2Qgp93ClQUnkFHJpCTAtKasGnF+J5ROIcnVk7KV/P6q0kanXSXth5ZUnQnFdT1Flkg1LDS2M4
	TOlB+E6Qfaz1Qc6uUKFmO1Y/OpUgR/baSlimFnhzO0qwaW6U2G0nA9YXB/4zqxwsMBv/WQ1VqT6
	O3vQOtNd9fQlqVJx1nj3V8ojnwlL/06vOI+vzcoC51UB/mbhhv+6RbF+BiayhGVlgBhvIHLngfe
	cdaI8SFaVI4LAzluPW5rXFU6i0aTGEbjLplGW7GdGf6o6vx1L+mrnNcq5BEGvANNoldWblHjy4w
	nyqdYnbTPn+ECEafvRd4l9NA==
X-Google-Smtp-Source: AGHT+IHZ24r0dObVNSs3NEeCx6tbNkzcEIukSzRTpFUDvHcuSBxsj0NeAOqOyN477OCh57ryXy6xBA==
X-Received: by 2002:a05:622a:589:b0:4f5:fd34:bb02 with SMTP id d75a77b69052e-4ffb49c626amr280436991cf.57.1768304484996;
        Tue, 13 Jan 2026 03:41:24 -0800 (PST)
Received: from [127.0.0.1] ([40.116.93.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc5f80d00sm98637011cf.11.2026.01.13.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:41:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1768294706.git.tanggeliang@kylinos.cn>
References: <cover.1768294706.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v8 0/9] MPTCP KTLS support
Message-ID: <af429870-dddb-b9f9-f38c-dc808c65e489@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 11:41:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_add_addr selftest_mptcp_connect_checksum =
selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20951543332

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/331d91dd8668
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1041671


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
