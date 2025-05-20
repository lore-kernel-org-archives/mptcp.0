Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5526A0A6
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737233; cv=none; b=qWNidHbWi1nzYQCSUcnoPWSF11SdyI0BkAerBxsqKH/0ldBzoljvpz3zno4vTAxxBj8TDUq/qMYkSoFxqBI/XjyuQOWLoBk5f4wzaPONYSCSVuKiYFrmAIdhUJ1n1tZs1BRPzMT52M06PpfAKR/JuZg28oZ0X6pB6gzH73hZrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737233; c=relaxed/simple;
	bh=u4GvDII72O87mUayptgEAvDtiJO709tVIe7y8vyofLs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VUX+J68CW2Clj9sEolBOlvxLYa5cnJmfIEv5LMiCSw8/GpLxaOqNxMkmVPv8nurSfPAQ1lEJtTVeqSbKUhoQZ81TdtvNynoFisDRXWAxpGx4T3E/sUcqgUw0ELLwauyNM3M5tqSNXPNzvUhN4H2FjzkRgsK6ML1CQP72iGdxqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsJPfntE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsJPfntE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso56453816d6.3
        for <mptcp@lists.linux.dev>; Tue, 20 May 2025 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747737231; x=1748342031; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUELDZ9RXpHi9Xy3FFMx+982i8h+QFJ5iD0wXUOAvaw=;
        b=dsJPfntE8vL/Je5zB5TNEJWquJ1+mKQDCAOpYUlMCFFXO4tFd2qQ44WJiXSU9nCJPZ
         ZJoaDyN+E5Hn3orGLxGsu+y41Z+3+JYAIsuG9TwoE1Jw6N5MaUZzcrpzu/8iyvjW4qXL
         3mDffwXZpPtKyu1VKmSW0d1/+xSpe6EeRFt8hnZjtRjUIHqCiDZdZ8PeYk8XeCo0UZuF
         atJFUNmd4VBZ2SBDr8l/n9rE4DzLuIvxvnI/PkI017aNnG5mEisAbP+ulxp4T5D4eyRO
         vyDfEZG8nSl2HzbhJExoxmN5M1mIR09zqrzL2fwLGVrY+jHm9/KPlN+1rsBt0lJWVdzZ
         m/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737231; x=1748342031;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUELDZ9RXpHi9Xy3FFMx+982i8h+QFJ5iD0wXUOAvaw=;
        b=RUA4effZR/LvbUUYX57lBs9XoZWsGPb2ZTgqcnb0WyDOcwIlHNgnVX8mpZMqIgqKpl
         FqN3PaK43PtNPm9NFQXZgDwgnU99aY3cq+IDCuDwLnbZdEbN1ppXctFdqjCgoYguYwIu
         gMphPdstjG5wz7jBIvB4qBU1BqiNqjdfNoh3aIcGHNFmqYxR2BK+9fienUA/EveVtJXU
         wB5W4q5XOA8ilkt/QiXWQw8ymgzGhXn9Fe/Ln6s/iHrjm/9Hq/Nf7XAdtXZHSZE3UMQa
         HEIOBE2qtkEjt3SfChYKRpIYY5YSccrYgotwc7JilJSL1ko0O73w5Ejc14gMqOXCS8z9
         sj2w==
X-Gm-Message-State: AOJu0YzPJGGOtCMiASyCGHJ8MoHUGhEjGQuehJs5xgtlba4aw6s6vdxh
	NDtfKmfKmX2J+UYuen4RmbCvBezZX3pfcplGZS1cymisoW1xLq95u5A3QMN+u/I=
X-Gm-Gg: ASbGnctlKvabUVZBwNFAwhtBNwVcccYeyvv9bDvVBK2K4k22dlEYjkvCKydy9RUkHd4
	Sz5xq8k6bKC7YZDGdVSE7GDM/TPblOq2lREOeuFknMtuQBVaYmt2bDNuGV6/pi2G+Z2d21im0sD
	zBnCd2lWnkq8H40FG/jGMP18mxxIEl2qzo9em5Pne6ug3IexSW+xEI2EV7BY7wifi/9gD4HdFIS
	Yq+sqeAFSEmx4woFjUeXQ8K2DZljkqZzKlbexMcmapsYU/YYR859Zdbh3Xs2a9eDPC5dcPGVoBq
	apvvYq/D5fJyJD8vmwOtB3dONpcuWbOT5xokQPk/VktIRMqzILD49ESJ88hbppslofs=
X-Google-Smtp-Source: AGHT+IFdO+j6oPZITQtfRJZD8ibReEr58cony4UjNYvWrOdHMoj7FWTpCV0gVqGAwy/mLBWv4kuopw==
X-Received: by 2002:a05:6214:21aa:b0:6f8:e66b:578e with SMTP id 6a1803df08f44-6f8e66b5813mr29194566d6.32.1747737230896;
        Tue, 20 May 2025 03:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.161.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b097a782sm69301636d6.104.2025.05.20.03.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 03:33:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1747730598.git.tanggeliang@kylinos.cn>
References: <cover.1747730598.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Squash_?=
 =?UTF-8?Q?to_=22BPF_packet_scheduler=22?=
Message-ID: <21bc2612-aaa9-970f-8f6f-e612c3bcbdf1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 May 2025 10:33:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: 82 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/151335=
44129

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/26fbacaac134
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D964483


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
