Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46347F5F
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984362; cv=none; b=nAKE+ZSnzZDazMiMlQJQBD4U0LjPHLiJSqNYbwZt0KxaUr/rZnFNZTnPDwKFnXDwsuiB3FMCm3cnTmTzvS/BFNYA+aMlqNgCbCB0eW1VRefKoROt3FHJfuAaK84pEm2q+ayeVuwv70xeldlzjBqhAzL0aA6xHwAJPQNQYC92jrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984362; c=relaxed/simple;
	bh=veMSYoFqIPGvJerds1bMlQju5EuNxd71smmSjNBZGpE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AjIl9AocOUNG6RAApxUSeaa3QZ52r8Q4H1k6H1zSny7edWG7OQR7IL/G+wLKF8ir+K1JFoKOI7ai54qNy722xmmvTFRKKZ495//vGVfr15M+4lZA1V6MN858wTl4mD5cA16VLLsRposHOlolKcWwT5gpQ/HXfUwQLjVwaRVwaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSaDEhzK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSaDEhzK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b95359440so12272715ad.0
        for <mptcp@lists.linux.dev>; Thu, 03 Oct 2024 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727984360; x=1728589160; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGdaAWOcoQoC7tkEytGyngf6aew1AnD9hpI8ci0gAXM=;
        b=ZSaDEhzK4z9JkvKzASnMaG2MSFa2/OiMEUnMVKmQvxQY25tk5nehnzJDdH5a8VhBxY
         DhNSp00wHzaYTwYEtX9HI20jzF8VMhJsaLuLvQhMnNDSxamg4dNKVG1iJDVMoIQmDHAy
         MELutghDrPzoC7yFafZ3kqzauZxkx3SV7PjFU1BAY09T/al51a4mo+WWKMp6rDhDVHt8
         kPSgyZh7HskL+XBaec4+oz/zJ8lMSF+kCt7t60HR0QFvSdnQ8TxN4KBtJ1gDkD04Cz+Y
         IksmiFefojnq7IZJwFV0SofLrIzXNc6f9d12Hj7tpZHYa3EabReHE77KDZTLGFMB9mkA
         uUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984360; x=1728589160;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGdaAWOcoQoC7tkEytGyngf6aew1AnD9hpI8ci0gAXM=;
        b=CNrorahIvS/nvVqDoD3OiuvFmhnKiGTnY8kA4Q2WX1j3sM91ceJTdOHw8jObNId5Xb
         UqVWq2In1eHPz0jUobahfDvi3avYWmbwCuytd3txxC9PWCOOkWJ37YdWeQAec+hlLh6x
         FhY9P0I55YI34S8BLDYf/ij2FD2C1kfaApxSuYNQ+QIiV8zV8XVwVoMGNrhKBo4rWnVi
         Qi+9lG8V0mIKEftJHAlAxqDAxfNBh6FC10WEnY2y5aRG8gyLiQkZE4geFqQCtutGF949
         aL2Cj9CoUKv4ScQmldLBqnicg7mp4EGT86chQTe/wH/7iN62pvSxwonEnOCRufw20t71
         Gz4g==
X-Gm-Message-State: AOJu0YwDPoGSafRpbq2VKD6KOe1D51M3h1cGUTCeJFRKhYjEiQsgLCPL
	LnN+mzxgXknorDbNbz1uPJVEtqoOJrcc2xW6QTJwRCDU3skYl+Y=
X-Google-Smtp-Source: AGHT+IFgrafTJfWjVueguOZQSmVvS33b46zAHVp95dfhmguOremYbNWTc52Dcv6ZyTlWm1JrBxba5A==
X-Received: by 2002:a17:902:fc4f:b0:20b:7ed8:3986 with SMTP id d9443c01a7336-20bfdff58a3mr3749275ad.24.1727984360180;
        Thu, 03 Oct 2024 12:39:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.6.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefb3b5fsm12351955ad.237.2024.10.03.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:39:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <66cfbfdf241fb43c51bf3c7d35c92f79a92b025d.1727974826.git.pabeni@redhat.com>
References:
 <66cfbfdf241fb43c51bf3c7d35c92f79a92b025d.1727974826.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: add test-case
 for MPC attempt towards signl ep
Message-ID: <e1a3adbe-b2dc-cda8-66a5-c8430f903086@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Oct 2024 19:39:18 +0000
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
uns/11166495934

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fc448b976b8c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D895272


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
