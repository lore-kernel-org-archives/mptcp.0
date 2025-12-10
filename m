Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2F26B760
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358714; cv=none; b=qmHj/LpZUT6QERXW2vswQW7+YOyd/oFnt9D7PUwKWgvSG7O78VNznIAXEDvhoVvIsP0Oet4GfQyLKXYDzHR2lLPAUCY25Lh3YCpTri2+vjmjgK7Raq3Hm7a756skM5n8GxedFQXqvXUzfWoj1a0Gv1+FKo64/OPA/QuRXBdmFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358714; c=relaxed/simple;
	bh=N29UaFfWJBkW3D+pIKn6hfnV3Pd5q782nBqdCk61khY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ob7ggef3QKAx15XsswF9bBpKSAeV2IYMakxDl6Dz9BSPyXOrgxX7xK7iXT9/+1IulH5gFFDAY1RrkTG3HQxizNdR9mDEyCIQqvhN6eR/1qAXiOZSNhZ7YrFFWF5gGtVS6Wpu5I+liS3MJrHAgPiTGxWgq6+QSF95JVSfNWbxn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnLhioIb; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnLhioIb"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2ed01b95dso576087085a.0
        for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 01:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765358712; x=1765963512; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSvLWRrbawcnvr9BYT1akD/tirJVGz3eoodHNoXYcyE=;
        b=FnLhioIb/unYREFwWvuYNW/SvrPfY/gJzFUHWmX0iWKr0lJTPhQQokG5U4qHh2SW/Q
         cq/Y4aowafx+MR2/DyG4E/FrbIRlvEF5Kn5X53f9CrK4vQjCyj3F0JDXcZeyJXNYcmHT
         NzVRYKCA2d2kIINaCjDxCL6y9ObrC8I5sfTbvH4dBo7jsgnYj+z4B9eLK+3EfO4Rkedv
         2OvJj5UQUOyWRhdD7VWktKqJSZl9soMFfFdWgREnxxgW67MGmd9RlRcvjByFgJgqSgrt
         F+gLfCHhd4SnD0kyV90XfmvIB2BYN/IflYYbfehBwpkII4SH5U1Ide82xueME7IXlk8g
         2d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765358712; x=1765963512;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSvLWRrbawcnvr9BYT1akD/tirJVGz3eoodHNoXYcyE=;
        b=pW9IIi8l210ugecHSuHbTcmZ7xrANL5AOoTK77exY14M22uV/Df2Q+2uUWoR2vp3Uc
         971ouz6G/y8ZJzPfh0Ne83xZOG9wGgU7S5AQxpMOgw8Eg02d6HE2Sa9ly5Onz3X+cQRj
         LC0W35MfsilDZLnscBB96kq8QfXUTXjrWaxW4cdGMk4Qac20WABv3M7Yel65X8k3XtkB
         gFddElq7bhiL2yGk8nanxQ3etb1voe3HeUBfsZ6v1fZNrBGphcnPjqz0+PPjetaOMAto
         XNe5tcSoNGKNLXGIusR3kfekWgTXAQbjeDClj8KOA0RYYtbxifGx6VWNiYVv67hzIuPZ
         4QJQ==
X-Gm-Message-State: AOJu0YyRP0p2hyko0LRp3zLQ4HW0R6Ea1rn/ExvxBSsRSft5T45D1pFg
	ZHLA9FKZLpZdBvDHYRwsyITWr/ccYWTNVKaZ3KnaSGdVl1ROJtNasmfFRmTcUUQ=
X-Gm-Gg: ASbGncsbC92Qr775LkhgPUtDqUSYm3ToujLShhRmzWqYxfa+jazLfKp1V5TPeMEwPuJ
	iGQ/UwjgqrH2GG4V5P/xkxEpeydWwg9LEOlaakN8lFJREyP4QBOuA1eLbFWOyUqmven8WogSnms
	JFMjG62yyFwRZXPFOTYE03haqji25Fsm+NnZgt8AGkojBnw0xKSEFhRhVdc5ZdzCZsTGKZXOAMf
	ZoGY2uxmcPAv+AJc6ulX84R5XC84lWkR0O8lXQG658+8bytgTHFpi/ymdnswG6E1sGg9sjCkBpW
	2wvkqat7SVDJPD2mpmvYGqSoKQej7TgarSx3EHGcY8cBaXEwTQkViXdV3kOFQwkVsiPjboQfdUO
	5pYRD6/ZVeKxHsEVKhX24gbcLgXEspkr4w9sXtPHR4zWH+I8HdwuZuLRaJPsnRJeg+Jf1BK2ee7
	pGS95ZlbgjEaE7nu6iK9JIRcs=
X-Google-Smtp-Source: AGHT+IEnxsySFTJKPgUxx8DQtZwiJukriCUJl65NpR7A0S5z8/7nubp3qaxLMqZsr8GDg1y0JGe0QQ==
X-Received: by 2002:a05:620a:1a26:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8ba39a3ce11mr236456185a.3.1765358711914;
        Wed, 10 Dec 2025 01:25:11 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888287d6c1fsm151373356d6.44.2025.12.10.01.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 01:25:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765354225.git.tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] add sk_is_msk helper
Message-ID: <e6e1d000-bcf4-a483-e6d0-1a7f26c55bff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Dec 2025 09:25:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 11 Call =
Trace(s) =E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Critical: 11 Call Trace(s) =E2=9D=8C
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Critical: 15 Call Trace(s) - Critical: Global Timeout =
=E2=9D=8C
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20092325434

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fee9e0c74459
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1031929


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
