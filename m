Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6D15855F
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724211092; cv=none; b=ErfhL7LPc4P78anR04tmeCx2wT0/uKNsdKu+Bv1pAhioMEItl38eOZ+hjx+dyqT5GeY5B67yJhjXincYuZMXgHZBt9cyCKrwMZwy1MLpvLgFnpny9UUZqT76EQuwMDCVCJ/u0C0JTDuMgrolEZfiAEX4bBof1BGNaNEY5zhDYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724211092; c=relaxed/simple;
	bh=FD6LrURznbAgsBQ8mu/b0aCBhaus60+QEqZ0qPcie/Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=im58i/kpiL44of4Nn/3RHWTBDxZaLpC9VvKO2ZD0JjwNAW0peXXIzHpA1geI7HOpLHq3poan5Q7Ycmnm5MAVT+ZiVv0UMYzwfOax4Tdm5Ind7V0TNmzqfRGWTshPtJwjqDbqRU6dMgeGAknUNiuKpYfluKGyY+iTrT64Qv2yc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chz4licj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chz4licj"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso6174350276.1
        for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724211090; x=1724815890; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opo8h+GKswDG0mry0krb7yn/7/RhNRDJ9RVIQTV7LRc=;
        b=Chz4licjY3z8lB6sBBiag6/POUUTiHOEB/VaIv4NNBmgCTwuvxE1tDFcBg/W0RC675
         +kXAaj9jAQMbrbIz7oQzdVoZI6bbtXor29CbIsjYgwcBckBMiiKP09eSwnrLmD0ibb0u
         Vi95zyfIwSTsXexqvfvTsTsLUqoLbX1ICy9dRaNmM3O/c57cxGISdXb0N04KmQmNomdz
         1q3hO2aQ5ArLdtt2TiEVlCkXPX9oVtXzWLkY8sHuF+v+EqpD5O02OQeG7XlR/Amoctet
         X/y10J7PMDTIKb3gohGr0YXfuh5FDAUUVsqWkpYGRS2+CFgfNiQVolmXiOcvKOfovCzS
         w2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724211090; x=1724815890;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opo8h+GKswDG0mry0krb7yn/7/RhNRDJ9RVIQTV7LRc=;
        b=BRZNyhbHzfG9FCT1KVbzyTH8I/YpnrBJov3116Ty2XT76qVCDPtzskQbkbG6HcFdAW
         N5GzJC4dHiBn4INIMpNodUrjkoIyol37ivt1HDXjphX1jGtn4EpsDZJIGUmM6/JkVxi+
         OaHjyIyCvfw1QExnFLGOOKvHJljBf9FbPSmnLS9RyQHttwX8OUNHjuFugYTk9mPWWVtJ
         uByB6OuizIGgVLV9OzPmCb2QRl2ArX4T9oeE/NRsq+kHoFvL2Qzgl6xaRQ4a1LvkxHp4
         Y2fvjf0qqXEJyl0oYFZelVk3igR8nO2iOkcbk7SbzBcjxDi1YiF//5HiXKUf/95FBLxM
         0YuQ==
X-Gm-Message-State: AOJu0Yy+W8GhKvqjqDLBVBywtNCyaphsYBjYmL/Mcg/buWqLhX7UcDqE
	eXJRpi0qpkbEmUb/+R6fJYYZycivPt0vl+YS7gJG2+6jibJNxKfmCKQx
X-Google-Smtp-Source: AGHT+IGsjksyCQVH0cl9IDDERXW4u/iY4+3SNFel9XqjCAHtrKAMz+D3YkONVhyVW+7nkHRGjaDCKg==
X-Received: by 2002:a05:6902:c0c:b0:e0b:43a0:3ce with SMTP id 3f1490d57ef6-e166556dcdemr1542835276.57.1724211089808;
        Tue, 20 Aug 2024 20:31:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.206.110.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454c0186bf4sm32591021cf.83.2024.08.20.20.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:31:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_48C13AF02833651C8CEA9329191D76628207@qq.com>
References: <tencent_48C13AF02833651C8CEA9329191D76628207@qq.com>
Subject: Re: [PATCH mptcp-next] bpf: Allow error injection for
 update_socket_protocol
Message-ID: <a3cad38a-4b2a-1acf-9b5a-2b3027235f0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2024 03:31:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10482667406

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0757fd384ece
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881543


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
