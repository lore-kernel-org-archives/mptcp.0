Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1921516C
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188189; cv=none; b=a/horfyrEmkhZUmUK/f/XTwI3nYESTOAK6MmU0CZ8P1TwP+Ki7Wz9ntgRpIahCkxLf4GLdJ4RVmT0tIJqkLfkLJykX5Lqa7O93RjVfbHF8i85FsofelXi8awx+nQU3WHNQIxSLmPdWUkG/X3ptDO2eK1lxkX6ns+MmT3eve59nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188189; c=relaxed/simple;
	bh=x6WCx+egL0i5/5v+f09W/wod8SMHrtMy7JYc1KI+zbA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PwdvfJt/cLD+mRWlS94cfffS3SYJ2axlf2WrePFWI7uCRb6oV/RcpVTROebb/kCDfpioHROpj6mj/b5vTzoXP9pKFIa2TGL1w/X7LJ3d5Nb637SZHoKKvM6sD7HhfrQWPnILRFNOfo4AP1yhBEzI7DuMOBtpRBfPtGu7ULVFuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UueT8fdm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UueT8fdm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so7719955ad.3
        for <mptcp@lists.linux.dev>; Sun, 16 Mar 2025 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188187; x=1742792987; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoTdZcKh+1XF4hqeMgC9ovk7sS/lHMrsYqHuj/oMagQ=;
        b=UueT8fdmPaTpaAVDPL6Y940SbAVWD84DI+0o8mB8izM7wT6fBJQWPxsQysxjM46uhJ
         p+amiIbRvPGWtkl3HSa0osCspr0TmVFz5hlTgWWWLXcD/Vhe8izm1blXJ0BvF9aGOEcM
         bam2rS8Zl6hyL3TUtfp1HZYmBvTchR1s1N43ZTowGh3IyKbDRjPPJH8ublfSZo5ZsC55
         EHYKq8xJPGDzMcH7VC3hwBygtg9qx5px81SzIxrF8cAluxu89ENPLvcSQH+Quj+lebIp
         FQ4kqTxn9B/nrUQgd9Uqswd3O+fROx7kIfq/50nWGG65oyNlEGkOtT7s215T3JNx4gIi
         Z4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188187; x=1742792987;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoTdZcKh+1XF4hqeMgC9ovk7sS/lHMrsYqHuj/oMagQ=;
        b=EKW3qD6FoBM+8cYMD8F1AAvaUesLxxf04rLufQVZOLZDLAZehYVr3pME1dI2nnNEg6
         eZXDHVr/enr1KkfWsnilKACwunwbqREEfCzgtnEIvtq2azoIiFfo9JBzYFdLoeb3txkk
         RJ1KrLN6kO5kgZm/R90BrbgYAhMotCuLdMOjsPXOspHcoRewbiV/L0eOgAeHpObwbwDR
         wJHXcM8Z6vhzTfNj3Uk1OTFsS6QWN6g6wtcTre5DpBkdfVEJGRbFSYphdYZiU+g2pVAI
         +ZJH4HRcJxM+CSh5rLPct2xhZ4vWA5comE4fUp28HOXqTxUI3LeaXjxArtq79vu1P1Q5
         tXvQ==
X-Gm-Message-State: AOJu0Yznd/xOngvmL1UbusuYxB4XP2Ef2ketqjgW6ZDPRGjsx4/I6XWq
	YnbIyD74YdGJ1rEjkjTiewsEkIW/PKYxVpEqP3H98gRjO3JOTl5dYYKt
X-Gm-Gg: ASbGncsTyRcH/N6TtaLuE2w7V42WUuG5VY6fXBRtArIqlkrjY2BiqYwuil+Wt6M/cAl
	3HN0DX/lZaLIyo24hWHG0qaD+5Ax4C15F2uMN9tx3YOF2Fta1q2byxH77Cic0F8A7b7XJJfBUo3
	uQ+SXKgQ6vRyFkLdWnN/ayvhpL2atmimkIKr9ce5/xGXsHKtA9b2F69bJsikIEVDAP6TnAqaKFW
	+o7KXWgq4UBxNBsKfsUjOkeKnHoqKU7IZdWWXMEmqnt9RLDJOLoTnbofQcgOjlBiaDyb9Scy7d0
	2NvV1V07fXzBwatDYtlpsLtSITMBfp8nwaeBag8fdH0pyA+IUj12jbxx
X-Google-Smtp-Source: AGHT+IHE0bUkyCV0ljFVLJuzoIBfaOsoYx8qy7TLeNzRlWXMk19ig0+BEk9p1WN9WneyVImV0bgiBA==
X-Received: by 2002:a17:902:d4c6:b0:224:249f:9734 with SMTP id d9443c01a7336-225e0a5220emr142092925ad.4.1742188187130;
        Sun, 16 Mar 2025 22:09:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.29.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688866asm66212175ad.50.2025.03.16.22.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:09:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742181977.git.tanggeliang@kylinos.cn>
References: <cover.1742181977.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v1_0/3=5D_bugf?=
 =?UTF-8?Q?ixes_for_=22BPF_path_manager=2C_part_6?= =?UTF-8?Q?=2C_v2=22?=
Message-ID: <8e118008-e0c3-e02a-df43-b5364dddd170@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 05:09:45 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13891109215

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5d1caebd25b1
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D944484


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
