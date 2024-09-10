Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44E5381A
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965683; cv=none; b=mAst8bVTYN/puh9J10j5Z2y53fcC6LIaGu+dXfElW4YmSDxg7qlO9iv7vhNzN8p16kXSwssB4ajFOiysk70cQpvoUryg5pX47QNM3/lZU62k5v7nwtTjOwGSTtLMb7qBRnBacjpfkrwzhLXsfnvHOvwdQicTTLgIset5wgGAjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965683; c=relaxed/simple;
	bh=Akg7bYbww6s7cjM6VOv1bKL8//DE58aQnAn/J0W3jAY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=a1lxg11FKvWZI09ZLpFkRf577lw6zPoH4U2ZxiGF3SpGJn2Vg8fLCINn+ZelefD910mev7JPMdVmZTMsY52r/NGdRXG//Nunu+ieKf/kORGCKHYtRqP0J+gFKF6cXHIj0TmIgsb6WAspvJ6tRnFWYCL0waDWvFuY31T/PSmnwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X14jGT1Z; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X14jGT1Z"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45830ff5b70so13783971cf.1
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725965680; x=1726570480; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWqi7dILSodFR3XOi36wRIcmjOxgaNHP9xeXVWbD3Kg=;
        b=X14jGT1ZUmW0c1kBNesLuh0J/6eyeZSYOS9XN9Tc0nHKhnF4rmxcZWZFzW/2ug4VwM
         6UR8gz9G6M0HT+GWwTe1p398NwqrA3H/DCvHHQYnPfa8qGwu2cRJERl3Ml9iMyCTtqw9
         9yPqK1sw58hKjASr9n5KokImi22hRhipZ8qz221UtyXycs1UZr8r/aizO4LZdUNC0ms+
         PyB+6deY/wfEgwwPdiCCpLWh1Qgb9951Lzd1+QKrKmDTstGsLxIGXAciciD8g7UgG6QZ
         59lgr4CRm5VputfVsTzVSWoWtgRV1xKSk0lEdkGas75rVMfJh/B+iISnEvigxYlIoZj3
         Klag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965680; x=1726570480;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWqi7dILSodFR3XOi36wRIcmjOxgaNHP9xeXVWbD3Kg=;
        b=mgBB4F+pOMny20FKuGkZP1k6f8VO872/5DP1NyRLYYcEQ8/IcrXwZWE5pNki9YsGGN
         JBTfHmQKimioMqv7yNIIFWTc3Dxr+ovQvTii2nRauIMvDC3sHyhJRgPosHBN2HYyeEkx
         +UsBAogpds9YWWACxUWEabJ7ouD0yNxlY5p4bwqaYer1tQskrfPkHa3IBzNApj3U9zvX
         DB+Y49gNBqhxUThtqHa/1+sx/cPyhgHb/maIN0bi9psVoyyf8YIejLNkTsN3AuZrzz+5
         J6/kgufdIT33zZ964cGznCApjR2KzG+JTYsgsRzTbbHyAVQgPoSfdDyYZlbIgrRPL0M7
         z/zQ==
X-Gm-Message-State: AOJu0YwNepDSYZpVsauOxjVV3EIVCAexOlZ5xNsLbHDUbTvZH5peb4uL
	KlYQqjpLbosY28tvy9dx7tJfv2Viy6/0Bma0FHprSFmJg1dgiXg=
X-Google-Smtp-Source: AGHT+IGoTXU6+J7eVz31EJ+dg9RQpdwefD6pDfAAKdiFnmHNXLD+AoqNveNul2iE/iqej+/onsZahw==
X-Received: by 2002:a05:622a:1890:b0:447:e3af:273d with SMTP id d75a77b69052e-4580c69758bmr225586751cf.15.1725965680299;
        Tue, 10 Sep 2024 03:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.127.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f6097fsm28286741cf.63.2024.09.10.03.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:54:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_24C00657C9AC2EC62EF90C8E27F446C69206@qq.com>
References: <tencent_24C00657C9AC2EC62EF90C8E27F446C69206@qq.com>
Subject: Re: [PATCH V4] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <ea2d4e0b-efe9-f7fa-08a3-4951aa698dcc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 10:54:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10790389747

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e58211a3272b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888810


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
