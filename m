Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EC3F23C5
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466980; cv=none; b=T4oTtrwmgxdnzJntcmxZcmij8GoiFhrOe3iaRvFd4n5q6vMWKM+SJmBzpoFk4v0vw+NHvxRW8Ykg4Tmk9GJZMtRYAtD9VrqSWrV/hspvsJ9BsU6k+g422vebfSPvv/N55Vtq0KGF8tNHsn///5WE2t89iqI9HtOHQpOPHO/Ad64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466980; c=relaxed/simple;
	bh=jK/8JMIN//WbnpdWWZBzC7pKO4XqcH+iGlbV2KO6igc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GIq+6wg3Vkan/Nr6wNRcfP+2mhLUJvaZgg8YWmKqg6m1UtR1xKqlCTX42WRWiMgk8L+kPOIVsCMFS3u1WW7fLvWC2bSQuS2To+6SbFnS9vxatoHxgqhScOJbLGEBhhoIT2F4rc6XjX6QqIhg7rwIFqmqAG8UQ9k7Zz+zLgKpMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv0Kt/9M; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv0Kt/9M"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso546597eec.1
        for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466979; x=1778071779; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCQtg5GQJOoIKkIU3AviMIxwAG4Ma/GMwjwG45Avog8=;
        b=lv0Kt/9MmLaXtYWW5AGelbSejiCxor5YCCaPwcTmmVFnXSXioEm1OildHTJDnxXPVn
         gOYGnbxYxk0z03i34qNxcsdblKWnk6uzUVjGxJA5XvXx81lhN6mknF7fHLgabM61nsim
         lOg3govow1a/fu8cEL0Jd0rcV5L/MoRUZJlz8cBl+pAI+degb0YKzZNjpQYqTkmzTIl5
         kgVHWn3GpsNnabn7UYSUZmOuYZvjmkcIVDb19IbTqJeyKXIrshONnXmFNtuyH+hqBDII
         BRB5+lCW7m0rdvSRR52NS+ky9BdgYm+vpd/YpCz+IEEqOpxORDa9n2Glzcrf3CNpd4BX
         mVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466979; x=1778071779;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCQtg5GQJOoIKkIU3AviMIxwAG4Ma/GMwjwG45Avog8=;
        b=gPvNYILvXbAUSTDaKLlpZHxutQcRnt9haY5HRXu0n5GDdPN+6W6EJXmucQ8/9nQR41
         9OsJDGc8XdNQB9KqcmNpAgQmBZ5Eep/rXZTfxeplmMiNVN5MPD57Dy0j+vL1AgEuh4+c
         1V+jFdAGSzSvOu3EbhJcpJ9Anf9V89wyR/D4nJDSDSbuXEy5R9fRdoNbPf8QO/vob1dn
         HqUvzh8L1h9g0kLbBfrajlpwedEKzQCGJYzg+iwVaJrolxw0GUgDaygVErL1SUlm0xL1
         Uc1B1uKYYv2eUJcS2GGonUY13EWmn3Z7Y2OrceeJZj3RstWtztiHd2fdHwtGnonxTcvA
         3IHw==
X-Gm-Message-State: AOJu0Yw3EKhqn+AqCKBqcabvbk2OgQ9Et9ZkWtNDN0CEt3W0+3uytmKj
	2D9RcSUV/sDhHhT52BS9kHTMzcBJQCgfGj/uv9jfIP9TZSlkU6/lpCAUlTJe
X-Gm-Gg: AeBDiesGuTs7EOoX+7tnoebht1uOzvPB2ye0/EhLLQoh7na6OhcJP6L+Ni0j4uSIQBP
	pqWjvRXcjkA0q47mg3Lz6KLN34qXYNjlH9XdzHGkRSi0BU20r8BTx0RrB884Zpb+sObY3tJ1/ms
	HkYdqIZJK1qDsogEXuQH1jUYramFeGM7yPi5J5gHAQa+2VlKUsRe+LsRZMmV3lJ7MJGnJ+r2yFm
	YyFwhQAsjnp1hmhmkcRDa2MyR2P4JzGyxIJbhehweFmQFg4NuTigXgrDUfyDLxvMkt2fKDVXiXH
	HWOTafoKOwb89fcQKkXyPDgqLZw+OqxDHxbJkWm9EyTUReM/Iwt6uR52RWsm3/yUy7Fd+8dredv
	LkNkZ1oHAeIZ/rdIHODd9sP27xj/tS2OKc2engI7Ykhaixf2uxJ2bZvzhxbl1iDBiN/MsKKhKZA
	yEtGWtnO8oUOeWxIdbaIXzkjLU+kbYSmw3fOGau96YeimNXgXITQ==
X-Received: by 2002:a05:7301:5784:b0:2ea:ea7:480e with SMTP id 5a478bee46e88-2ed1b4068fbmr1085090eec.10.1777466978682;
        Wed, 29 Apr 2026 05:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c06eba9sm2275082eec.17.2026.04.29.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:49:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v18 00/15] MPTCP KTLS support
Message-ID: <aebc1090-f392-bd1c-3788-a096ac53d381@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 12:49:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25106638742

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/58c57fde8946
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1087410


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
