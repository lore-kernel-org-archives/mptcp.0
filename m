Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1094C8C
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651097; cv=none; b=AkA19H7/IWGEJzAdjKujASaMb24lKih2g8CBOaM9XXH2U3R1BWfYS8Hr1pEjqEeG5m+5320XmDlFHuWMKdgoXSWlhoNXrJ31Q0KVUuOlVNlL7TmWRgVPjWCShK6qp+YxiolbssSg0QqVuPoqLs5xIhRoV6vYRrMGFhE0/FXcnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651097; c=relaxed/simple;
	bh=3FaPDAEXNEdHUdmIUZBVfB11u6TXO4X1QMGOF89H3tI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hT3hku8L5urNZik/EGlKkCHYjj4affC5UhJLzZ4XvlXTbiWcIXYLanvUHDN6fVAwBUR90hVI8+ckIb/jf1kAk+4KAAbjx4t42zCpaapvrc5nnUcZsIIXVnY4zhS2B0VPVs/Svke2/KxYbQzRXv19hT1/Z6B/JGAhxu4p/2rVztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIxPfzwX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIxPfzwX"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9b049251eso515460485a.2
        for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726651095; x=1727255895; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv/FYuY6i+Ykr7iYa6XTTdhWvr/AMYtiv58pH8ZTFK0=;
        b=eIxPfzwXd2i32IlYLGHF5CvLaDEIrhgz9LXBWY0RfdfSe0pcXeorA5FjIBJDKK1EAT
         BYTPtRQiyX5I1LYZsLHdwwWZYkPs5+1tOD2fnDBVFi32gvsK/v4OgglmvkUp6Yxc8oOb
         Xb69cpXWbnX/z+QhXlbKX2X2rzN+GleJhasjb3z6BbNeTOdo2F7UKmujFsl4GPMXH40q
         2FYYUWjWNoF1aBlgC8EvdZxY//lWA1rFt2w6MY4PPUio+mVKDy0KJ+MB15gsI3Fumo/s
         FIzNvq8kgsXY0OVUhGproV/R+JoORt4laUeY2WRQOgtjTTySzmIOOIpqe6dnaWvLBPEj
         jb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726651095; x=1727255895;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wv/FYuY6i+Ykr7iYa6XTTdhWvr/AMYtiv58pH8ZTFK0=;
        b=jNmgCr6tDxjikJjykZNSpR+ze98Q+EB0J2yrm1Pq8ZItQvXdKNd/pCkPrKk1uW1730
         7PQaFtwd7mXE7oJ2CuxUcdkizGf/Etg39laD9SWpukCNgyOhyQ4b9ZuOaylufjHACLks
         KeYb6MNqXk2kVx8WCk2ByP35LJwwLEuracjFB7hfz13lbbES8ouzBaxwlKSVMcCLKaVq
         N64IZUwpXh9+YIKzuy15Lyf/fBc1kYmVFSnQeb5bcIotKowsox9qV5CUKOd+O4aLxY7j
         dlx1YpkcHBOQz7nWP9XsrB21dI4mKoQgdFQMuyxa7ni1lIcJB43Oe5YDcsImS6hW0SXS
         DAMA==
X-Gm-Message-State: AOJu0Yy/9dndwfL7VxVp6xy1mnnLzSVyWgRRnS8WJuTeTfZU6P3aW+1n
	KZXpyzYtW5KzN4cn1HjfhD6i4V9u9QT/iq+VYJo1l3Z7JVKGCkQDDKR4
X-Google-Smtp-Source: AGHT+IFqFhyPWIqLVaSYMCaV8JbKskaMcSVzWPth0DlzV/rHt9GUfiW1PIh0cawUk6EkDoESbLPPGw==
X-Received: by 2002:a05:620a:46a9:b0:7a3:78e1:eb87 with SMTP id af79cd13be357-7a9e5f1cd83mr2413043385a.35.1726651095307;
        Wed, 18 Sep 2024 02:18:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.206.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e994469sm437073485a.52.2024.09.18.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:18:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/6=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v6=22?=
Message-ID: <9ed71fb5-6599-b69d-39ec-897870dfe40e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 09:18:12 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10918596267

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a928a1640a28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D891102


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
