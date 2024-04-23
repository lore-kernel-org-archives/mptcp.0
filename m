Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAB44C8F
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860156; cv=none; b=LZptf/LRBbgfn55/P01JAGhqPeWtJNen9nstRL4/uxbVBPc6bIw4yf0SmT915frqMqSvYSBl/fBjfoSCLSitSee2Z7XowqeTnJ7oDbTX7jV4NIUNPBHqwWC3JBBdBi3hNEJtysW/CS9fRGO4VM/kAWbku/W/FD/oFh5CMrIIE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860156; c=relaxed/simple;
	bh=lNejgoAhIdQlWZxj0mC3GjmHzQ9SJ/NJVNThp3ozoac=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=diyBSa4/U1QusPXYgcGxHwMRLBTYJu2b/tVPVBC9v1yEgXNl9spw0ZqHQT1M3HcTjw44vfMTEpqZr+em4+NqbexqcX+0K6W2vYFmyN1LxwEve+8c/IhTRvjZyeEGkYpYqhN+nxEperCFsAD10LnaLNxUBulKeWtvLSQr4guOasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daYR/mzL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daYR/mzL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so46587525ad.1
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713860154; x=1714464954; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Tv1aOmrTVJYP3ZIWl8HJ9QZhsebPYbicidddteTIQ4=;
        b=daYR/mzLw0rkO/gf0C/uuEmAxXDBYVZobFfNG39GoCg5i2kTKS9FETMQ7W4yQL3ZcU
         50CitLfcrfsiUOnIar7TV2VlXlf30o5iPeo63Q6eMpDDS+ZuMKMuS1jybkcvqjHZXHwO
         w92tILurgC/U3I9Jw+IFT6v7qo4tzS5/q1sA5OQHoJWJvFj7U5pcyjB2FmJgMnAsRr/B
         63sVJV6FSIjb2jQVU7fZa+MsxBEBuzg8qT2uqmXqk668dMZUB9H3zs7LYm4M+IVZ4v0/
         5EDdUyViRwWuzL3Eanmz8LX4crcHjN/SmgAn6BVHIEZFASwfzW8A41WNwu6dxqDkY8Km
         Wtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860154; x=1714464954;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Tv1aOmrTVJYP3ZIWl8HJ9QZhsebPYbicidddteTIQ4=;
        b=sIvZ7gXYi99H3FIYo4x4GPVOi7jMcuMrH5dZWOhm1Uxw9FlyxdmyqIv2aIqo6P6kQX
         E7kjxN4tMlY7DVADzqkMnUs7b0qwMBVTXMa0P+zmmOZNq85yAWb7OSCFoozOYia9BA70
         9Lcmguwdk8qDTCVwoGYeQREdn3tUl0a4Vlr4CnAM0NPGBpdSCbRrO9ua3mfjJTqyKg1M
         JPZxo7eDwX/cDkH3IW8wcr+LpkgfavveqqBcCj1GDjyQqBeHEW47Mw4UfwFmzBZRtKCv
         bKSKp1xTPNVEUaqi8PVBoEynNBAiXpb+Matm56kiuY8DLTGSKZJLtaEQPB0QsCTdUzfZ
         KELg==
X-Gm-Message-State: AOJu0YyLQQ4ib2vNnqKhIAkn4vK+Ya809JmIrtOeZcrpj3TPpzmvSH3k
	AhSJ5OC1aGMTSw/2UwTKJA41WQtXoxSN2Y31pScl7Ry2TsCqHac=
X-Google-Smtp-Source: AGHT+IFXj042zNMch1hWLCJiU9rdltfvDe5JYBwQsHyDPYR5zRXUEeuTUb5NNs0N6T/kJp2he+1JLA==
X-Received: by 2002:a17:903:41c1:b0:1e9:490:cda0 with SMTP id u1-20020a17090341c100b001e90490cda0mr11928610ple.1.1713860154442;
        Tue, 23 Apr 2024 01:15:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.249.54])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001e87cee098fsm9285469plg.110.2024.04.23.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:15:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v8 0/7] Implement reset reason mechanism to
 detect
Message-ID: <7aaa0898-bd92-1edd-193f-7b479ca219f3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2024 08:15:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/879660=
5426

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e748a72f4dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D846887


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
