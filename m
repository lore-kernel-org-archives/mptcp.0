Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C836275AFF
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793885; cv=none; b=duUicH7R7ECqBdzNtHwU6IDaoIRT+v2R3aZypt2DnbkhNP87SIDV4uAlNIBnArgVq6isjxEgmQv50nXOrOA3/dxmoEsu8tewmUD3+CICdEgw40zqG4XoLu3/tIy5XMBikogaFlmA2znaw9LJ8xYFSe8dGW4DqFrJ5AKzjZFH3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793885; c=relaxed/simple;
	bh=P3aWob2l9vBN4urVWuv2txt3tX48Q8HRxIKR2dF5hjE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OPGjtsbkxXsTc89Vb6ybiS4y/cN+QlNAwhxDeCq7HltS19J7e3THt3sGVCHyDEV2BYQ4qpxz6QFHJH75LKazcKkRztHv9SuAYFB1zudqOmpW7Vq5DpbTxTYziYFsD0o8NcD/j+maEuKqUGn4KrENh8b4NtoWYqcQsA5LGhjXciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwiRVAIh; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwiRVAIh"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-9486d008fdbso146288339f.1
        for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 08:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793882; x=1763398682; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeBQQ3HR6L/JsurUtboB+tdUVJGHseATvkDkeYzOxw4=;
        b=AwiRVAIhALucFk8mHSII5cZpRNpiaSLpzlacunBd3bVTOzRVunVbqIJFlAHRluCiIn
         PiaHHvbhTI4Em6iXc8tgXx2ruzlPFGEfxLLZjDfKYqbfCLM5UJAVGCnPkPFfeOeUDkPT
         B9xdBu5mKgbaMniPgbezjVbqVzsOdsACyq6VqQfbD0NGMKz8CuGIsfYE+4Ewxq0rAqyk
         2gRzRCqHYW98GAxkNn7ZsYHMDQmvMTeZUfOIvTUnhAwrw3zJtPbTHWRo46fN1YdEtq8o
         po5GvYP6fOfiFE+d31HEdjNQHj9JwFaMMaH5EXuiV1g7qseXt3I9hI2Y3kn0XLL/NfSj
         mijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793882; x=1763398682;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeBQQ3HR6L/JsurUtboB+tdUVJGHseATvkDkeYzOxw4=;
        b=wdf2dFEYiFjP3LHOQ1TF9cUlkiIO6ktLvFFkYK4dh3hPHWEu4u2TszD38+1jJLAzHC
         u0mwrrq6TjTbb6U42vvJcG7BOqMF1vSR6pt2KhgBsJH7iHMNlo01PU/JXDBAOnpZikmz
         cttMIzcXFnhStvs8+4Y+zP1gdIRAjsCKGmUPwOih3V55o88HP6eDKo54kFFkbhZrOzzW
         OsPoG6mK4OwOhkDdrNiTLwiW00ZNMDqahVkneNPp7TJHW31MvbTmVQIpZttuF1mhjbq7
         kK8nuSn9R+5nYJoY4v6YtQkPfHt3dySVNK0n1hN471x9TUnp/eA+yV2QyhuLf7YkRU54
         LfeQ==
X-Gm-Message-State: AOJu0Yzui4D36xhPs1IaP94qPUfhjNnwMjahH/VQ1RxVH1+BZVTbTqBH
	cpG0DnPj59+u6SOvkoB5RN8KTWs8wwsPLnZvKACm0fNg+DSnNJnbCv6fqgJ6
X-Gm-Gg: ASbGncvTGecGo69C5syex672TwxiajDCC3Gr/m4nqQ/t6IThqZR+7xYKRhGnJtX8n1v
	gx3rx6NSFrD/cVUohqLlENwEsziPon/eJHZK7oyQSlf+rFVWrdB3zzgPTYZQ4TKNKiABD35vZb/
	2WEwmogAbStkGZJdB17OpbPs8BNjd7SfwXYHaAfW8k1yEKc3lAGSbGncaEXJF3PacPO6rXjSrkG
	eGF9SokitXxUCiuTcOfUGLlxkLU1CNLilGjXd7uMZobDPLqYN6aGvBbtlj7lNqeLtlXOz18HY9N
	pi9FcnG7YkVvy2SE5HSaVakQZnQLvBTD3X0WKI2X5sgylztGrO9MtXt7Ril4wHeajTGypCAHAv+
	tCQpYW/pODhzmoTGZ4JbIJ8VSIHk2DamUyKkjPwd79jtFiJ+uep0BZKQF09k9B5GBf0lppjymug
	ELVRrYD470Owqwodq1eR9YQ2tF
X-Google-Smtp-Source: AGHT+IFVbXezXomHsZHjGCJZbuDG4aW2Mh3DwsLGz5WGz94TNvL+iRuibgJTu03oPVcL/of/Z3wzEA==
X-Received: by 2002:a05:6602:3f93:b0:948:a859:80ed with SMTP id ca18e2360f4ac-948b48f5ee7mr9023339f.7.1762793882504;
        Mon, 10 Nov 2025 08:58:02 -0800 (PST)
Received: from [127.0.0.1] ([135.232.216.49])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948a2af6cf6sm176102739f.7.2025.11.10.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:58:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762785316.git.pabeni@redhat.com>
References: <cover.1762785316.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: a couple of fixes
Message-ID: <e18653b2-6749-5f96-ef86-66b35a3f60c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Nov 2025 16:58:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 10 failed =
test(s): packetdrill_dss packetdrill_fastclose packetdrill_fastopen =
packetdrill_mp_join packetdrill_mp_prio packetdrill_mp_reset =
packetdrill_sockopts packetdrill_syscalls selftest_mptcp_connect =
selftest_mptcp_sockopt - Critical: 85 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Unstable: 11 failed test(s): packetdrill_dss packetdrill_fastclose =
packetdrill_fastopen packetdrill_mp_join packetdrill_mp_prio =
packetdrill_mp_reset packetdrill_sockopts packetdrill_syscalls =
selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap =
selftest_mptcp_sockopt =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19235857403

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5213638ed0df
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1021627


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
