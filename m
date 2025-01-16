Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6414EC4E
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055285; cv=none; b=Qr8opRGBkbxA1bFFcNqEx6OFP5x2WwuRj/l+V7bexYhrT7njZy2t7/uxfHwXbrWG+fo+WWj4lAQXXjA/5P0x/7s167T3mbad/GPeZE/IpeEwnkcY1R1c47rT9aZIFJSw44N9FwFDfggn1FsKzG5WYocrPTCY5JrPUVSbZKhj//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055285; c=relaxed/simple;
	bh=7BfcOUDPq+U72e/ZUUSwqQtXLbZj6hrPVdshCDCpxVM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XEQvbU/bY8k2LkKxedtW7JYjGEqncSFru/ycDG5KvP+VvvleeAerSrfG7fVdVeN40Oa0Q3TEXvONkGNny99aw0LCQWFJ1sOW6rl9muKZYoRRa+DtZwwL0Ip+VoK1Xhohkx+EUsV9dGZfYrjhx/k+KrXffvaFMaqZ51vcmhvKs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERVGtiUf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERVGtiUf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a8d2d7f1so11866611cf.1
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737055283; x=1737660083; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TNx8UtjBsP+AYCNfiCuuIDqoTRofKHnSBz0zWyI5JI=;
        b=ERVGtiUfb1C6gsy8uECpq1TwFTuNDV/PXoSUohlMKGXRmd1THWrnK6EjWJeOnTrHZj
         MJm7rLt0Hm27q6quGJ50v4brSzRJnMde8+pe0bikrdnrA1Q7cZOvoJZX4KhsG1PCjvQ0
         oYH6p2Ry3zaDEn22DfeGWc1o0NMEjEAn+eCkoBa75oW9N5QU26wxOqjnZxXDPt9kOzOh
         1BfjzorFgFRUDMEsgW6ozaJPykIjZYg8QduR88TJfYJOaU3TA1iX++kGhWdVwzTJHZJa
         ApkNIGTS+yO8giOYV0UeZVv90DorTLJKWszjXQ1RH1XlXiqPMbq8X5aCRmzWos6xyOuR
         a9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055283; x=1737660083;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3TNx8UtjBsP+AYCNfiCuuIDqoTRofKHnSBz0zWyI5JI=;
        b=o4hLtSB2AfJVuVoKmZBzvppPIwj4eWGr4nGQ2Qf9NwIQ9Y7ncDUYMUyMWw0ggeVNRP
         Z3Z6cg81oOIgK+09VfuVjNR/Fue0zVu+UBSWYE5ACkbZtwlJBkj4jyy3xyEKuP379p2m
         Po1wsYEoAKNgogs3ff0p6m1gmZuAXkEZPCTEIV0NVHDB30ESsOPAhS8/W3odQBwKq910
         h2omcnGwojjfK6uJydOMzp2KVxbqclD02J6D/7+QEDkt9xW19ZOxVQKYd6ZVbCTmofWw
         IqejIcH4lbzXvGDfy5Pu6Q7mhX/GDF3tgzi4eslu1bnI+7mOeHue47uta5CXyBemzYBb
         B29g==
X-Gm-Message-State: AOJu0YxoxdZcw0x9Ds+DdikL7J3ux1FBQ9JRi9Sph33g5efp1NCXhs4I
	Ce/egU93zc3khjJeysmzePtjJE1ywBx1fxRz9q+cgJBtMQzqLwj8DYH1
X-Gm-Gg: ASbGncupYM3+ql2RJgHyV93Bx3hKjxEfq+78jKAns104DwyIi50nrx+uo9SsWfQ0cbp
	nx/uTA2M3rDVq5EmLMMI0Klhhyh0XZh2rXw/aQ5eXLIOyn7qsvFsGe7OpZfumnLyITKCfFjQN/B
	NutrKsldqJhyuL3WjnfxF29//DUmI8fb2ZibocuKmpCdstDhAQq36S276thPLyCPUpHqs3xeA53
	zuIrCEBoZLMLM9uyn/aau2OgmkrrOzedj2FEy7OYCFBKVwHdYEUGwVvYqU0hOKdsz7LGH4=
X-Google-Smtp-Source: AGHT+IGJM2jGPVYnW1yEupkR8UziDyqE5UVqsRpCz+LeG78CWFO2RdzhP3bF0brIV4bumflPurwhuQ==
X-Received: by 2002:a05:622a:449:b0:461:169e:d2dc with SMTP id d75a77b69052e-46c7108ecd7mr493752911cf.49.1737055283181;
        Thu, 16 Jan 2025 11:21:23 -0800 (PST)
Received: from [127.0.0.1] ([172.183.152.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102eeafcsm2646881cf.16.2025.01.16.11.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:21:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org>
References: <20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: only set fullmesh for subflow
 endp
Message-ID: <b129aba0-60e7-d908-e636-78e73d5e79fe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jan 2025 19:21:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12815258286

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6360b02d53ef
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D926189


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
