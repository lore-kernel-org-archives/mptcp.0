Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F182E337E
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903155; cv=none; b=EpadEj419xQHT6g0/ko/KnfS0XOfyAlduwF5nCwxGe87xcBZLG0XLOg8XG+sHXEAzEcFHJBQYXnqhBCYIPF4MvC9yQzJe+J6O7yd/J6pPL3jA52uTV3oiZ1Vk2uMxqiwi7kFYKWBWOUHkFhHKiWgX6auJ3XykYxWP6jN1oc6z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903155; c=relaxed/simple;
	bh=1wBWQe6NIN6lC7TqRzT/aFBcCSyHj2e1vtLsWI6wRLI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NsB54kcKsHJR5m3wHUBvIaYhGvCX3vV7yE7w+Sh2tbxc6KvgSdzUNIK4i5eEs1othgo7nDPdC8TUj+XAm1wDuO8/nS7xbeZd6AH6pDPvqnMAPavsmfjrejonlT+SybGTvhFIAd8eWFFAmZ0Dzbkhgc1LJlsNx7vyHsjE7zg6Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0hXSUGw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0hXSUGw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22548a28d0cso111782345ad.3
        for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742903154; x=1743507954; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1QCnphhfrVKbZcXshJWXno4lCU+VDvlM/cDy3zSpho=;
        b=M0hXSUGwAq+icgbnurkD40GA7Osq6bgAtIjZ3Vw+jx6VZscDPGnv001bQClCRyGvOC
         9icc0Nt+Si14PqJDcQCxTKOGMGu0veZofHXvVkUjZY1b/fr/XRz6QpXedhzpg9oQmr7X
         Zf2yZiT6n8bFAaxTeCZg9quxHw8R0DVcvcfCcufyanQgkqvgtj+SVMFqvVzjqXoAeAzn
         SzPic5T5sasKsGmi/exOz2DCCWkHAEoSlBDG5X5iu6XKRB0r3wi+Mg3p5aDRByyvmLfy
         RVeQVKWH4he6gskE/b3UcpIhOPKUriF0apag/CLLEUyGheFQhyf6lnFnCMu3NNS916AJ
         IhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903154; x=1743507954;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1QCnphhfrVKbZcXshJWXno4lCU+VDvlM/cDy3zSpho=;
        b=YZ6h3VNSBH+bwZ4i9l8sVtT0tKwo1EsC14ksFb4W01TtLY9VlKo1W3g112I/VsvamQ
         apop96S8ZgFkfg70l9JFzf++gZz+vXesVGEnV1J2NEKTSSaejnEYZ9Vfkeq6a9l51cCc
         kD9VpLWOn8xQpXGnVAP9cO+NQ60aUO31/L2mQlgiEp3MNz1gdyjO/3ZNLyKWyCe4dlJT
         T46lZF+po0Pe3LbT66LfqDqhhuQqMNFBw6/Rh3zCw3MeW3Djhx2ReFt3f1GiUnSyAjsm
         fZHLeLhQ6qpg6hkxgxurhEALkELdUR+x3xX1pR3ClOSAvO0YegffD9MFhc91LwT7h8RC
         IPGQ==
X-Gm-Message-State: AOJu0YwNOFcFtNM3WmDtJ3G05K70oie+KOt1lAPNL/S7M5oHgfPZG78f
	h0zi9bUyqd9aSn0oIQgs1yx4a3wMQANkjShFqDZoRBzsDpXbtMCkvQyL
X-Gm-Gg: ASbGncuAgQeJ93uqiH5uwGxuFUpzNaJXeH7Eui+kZ3nkKIj4so6YaUCF9TiIziIHiLU
	84qEnp/oe4ya5WSh/OxSHDCnO2V+uBMMg+0PV7GfO0hRUPRo7BjpMNXbh9jU3Pw849Wm+zWfKoD
	btOAY0HZ5aGvOjD38NGy+FbiD+NAbdMdZf6b0miygM8IwWyJGeeOH6tedz4IV5S9P8/S7tJRKxI
	pta9ENKXi7BlaL7Hjs/3efuNnyD64eE541BBNkfBSJYQ//fc+RzIikkQnWsZW0cqHlPTSo+ppwj
	v3+/QDOuHyvnx6ucDAEGblIiLUSNpno1W1oEWRpmo0Y1kPpJ2PK7Ito=
X-Google-Smtp-Source: AGHT+IEectggsTnK37d1My4qg3wlPv56NqFiOGxJsNTXC4n3j33Rx+Z/yJEKiW8JdyrPmelGcICTIQ==
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id d9443c01a7336-22780e0969cmr248189155ad.42.1742903153344;
        Tue, 25 Mar 2025 04:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.155.62.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92dfsm9822930b3a.5.2025.03.25.04.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:45:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
References:
 <27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1] mptcp: fix cast type of
 is_fully_established
Message-ID: <bff0beac-f873-6c0e-893e-539b96a86233@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Mar 2025 11:45:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/14057787415

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8313b14b74fa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D947109


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
