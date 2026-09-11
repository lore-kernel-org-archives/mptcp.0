Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28114A6884
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144922; cv=none; b=oKN8t2rXxX38U58cssB464hiTWxcETTWirUCwNoxj7e2MAdHjNo9Vx4Ttgm83PuqQ0k2K+iN6aNpnXEcwHeGF0necgYWJ3d5M95SSWketdjIOB95uSyXRxBs3RcZYRZbZEdYDZvM8vlk2si2rIIWW+YXxfrS3591901uh8+ZtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144922; c=relaxed/simple;
	bh=+uV84TBfyIaWWJyEf8g+Mnh5+ynToHb/yO1TlBL//o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=t7+8GUCaROQDWj5zk3vyXIJ2UtFe87EBEI3JR48eM12aJvNu+OaaLdaqbsyhnwtCQKPli+ZHRDr9UtYj6WbxvAwwD4jqvKNhY/pYDsrxQZIcO+MXZIHZrzw3bvZ3dgD6IkSjaFKPfSDXDBhWeX+hxMdkgzWBlqqiiuRy85MzgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKn4XekX; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKn4XekX"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3149so911630d50.2
        for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144918; x=1789749718; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LeeW8oBlR8FqpJDiSLR83s3oYYEdKuIEIF8iee46/08=;
        b=kKn4XekXQFiRGQ6C3OwTtIowxvpHrZM6TSwtbSZfKCDJg43sZAyYU5nrBmYQDF5vqZ
         cTrIkJB4u0A72rgozAF9s/er1xUG2THMcm3SZUJcAqufUeiL9ldjufEEwCLzcZQaMeOb
         DaPXqhpP5kXK9on55gvQcOnABaZ8I55baQvrheZsxafYo5eB7uyDdmgeO7S3TU5BWFv0
         Gz4l9n2eMsE7OSLOS1HKTWfqlLDz2LGcsTe2vOmTsjBrmanGVdaWR6+Ll8pgOlWy7vXw
         DaJbGWHr/uDqokRXfPOkR/ibYeZofedoifP5lx6i2OhH/nWfr0N2AsrFRdCrnUj9g975
         gFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144918; x=1789749718;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LeeW8oBlR8FqpJDiSLR83s3oYYEdKuIEIF8iee46/08=;
        b=b5wvAoJhLbd3Rwk3d0EQ0Q4hTI540Iarsl1tWRg8Oj6zcFe1pVJGP5SuAJB+CG7K8T
         LKpq7WCI/+/NQLx0R1wzFtNWWXDPSjZGj7kJnd8SoXDIbTSTK9g0vQzYgR5WqkBrAiUJ
         wpVFo9auhEgZmx5tgjKBm6edpwItXyNxsd7hAqImz9K57CWtUQbhnBAEpJzCyNEtDbb9
         y+8zbBAFyz4l5g9HtnbbSFWlidb9IaJrHieQDs0rMhhkojebDRgSjkgSZ2sUhxdGkhFu
         LxpRCAYvU/+APOEf3NgupoI2jmNOB1LGD0U82yGzquMUT10jP/ykLtjrncOuK14X9f+Q
         SaZw==
X-Gm-Message-State: AFuF++lVIwCjsNSZ6OYnWXLECvZJYUGg0Q+mn0M0uEhB0xBQe9a4XJNi
	uhkQxSqiezspOj/63YcxecIGswD1ZC63fbV6kOBRk6Gi1HfXk4yYaWseLS4C
X-Gm-Gg: AYBFou0zpKVwKxMsKW9k3M6JBp27ZqViM9t+3DvxPQs5PSZXD3YeDxTAS/oW9eS5M0T
	i4E9nifh1t59hWxSN62flIF1NAvwY2pej5/TlJnyYbfdmZmkdxn5JI76FLQ7AtlHa3/i1mT011C
	sxNvPa777nL82aEMGgL7ZxAPk9lsr8f6kkz6GLGl5lHlkAEUtqVe2ysFp1ThJV4RPMH7o6+m3Nc
	o395Oa82pqZLOJe7kkV8jKPat3hLarRV/MXLWWiRYc02YGDqs2n2LMk5HZ63gHEzzc0AT3zy5fi
	Ov5BDiGsEGGxBDBsbwGKGlSDxkw5dnRlw6cv0FUk3P4348YAfOj0FS+/tiZ5mrmDGsJV7FH9uR8
	K8yxkrr99e2r7ImWXgA1GAl7BqujDqDfbs90Vm7tqWWsNwBoqIEm5GW2KDhst/wULQci1NwrVZx
	jMM/N0BVUSySfMW5UHk7UWXy3mP9VQZfCzCEILnK6xuiqV/vympH0S+w1NC8NzrNUkaQMnevsQE
	pIHBk0XiiuerQ==
X-Received: by 2002:a05:690e:ee2:b0:671:1aff:d0ac with SMTP id 956f58d0204a3-67124765300mr1728177d50.42.1789144917608;
        Fri, 11 Sep 2026 09:41:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.119.97])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df3180sm1253560d50.7.2026.09.11.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:41:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
References: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: fix leftover fallback after
 failed connect
Message-ID: <8b6ae8ef-c77e-3efb-f2ec-3428dbdfbe06@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:41:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/34619136010

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/443443b1ce28
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1163060


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
