Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BE10F1
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762614955; cv=none; b=YHzxM11IM5awU0oUhd7ODMOzk3ySLoZGjadLbo5SEqZmBH4eoCSKffSHlPXqLnh/AbgiHVwJO1wUy3ZlO4qumK6OPEnMf1KXL7MeOYPm1/FgZ2X8uqkpM8UBNjROjK2l4uUccdbtfMw3e0/MYxPmyYzJGAOfptqHJk8BwJg/kEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762614955; c=relaxed/simple;
	bh=1hLO0RBZNfM9Y4NjGQEFUW6Vh5Y77R8K3rGVjoAbIdI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gmPPo+KmHTpkSsS9NEVWfJSpCVF9RThAcn7LD1Slqghrql6B1ZVS8edSaHFEmYO6lDp+XcSB7cg2xRtI7dCzHdCyy/VP7k5rP8AGHp7OTtKeIhuEd5VSaUbs2JsS/tXzGcQZGPfdu02i0JlpYoeDL7qvHkJuKacFzUz4nNPVJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6wPMJem; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6wPMJem"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso1450722a91.1
        for <mptcp@lists.linux.dev>; Sat, 08 Nov 2025 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762614953; x=1763219753; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Tap1RztMvUzP4qDSWwZy424aLrFqc1NIWVy3xv3fs=;
        b=C6wPMJemXceJeVN87SCXAXHwxOlx6hvh84cZ1LZ5XHinPg34PaR+rVORSwbMg1trvn
         5B8hTm2nGMnshNvuYbmH0f9AqDOnqiMZc0a6vzmVOyf3pU7UB0hCYb0eT3SPB9jVRVZk
         HkyGfvGWhDIYOLcYfmciYmONMy93VMat7Lqi2Q0N2GzwERJ/lBhUOWi6Z0xofQOkgeo0
         aq68gIXbALDh35kFkuNn0rhrOUL1Y0498rQKghtGuMyUb5IxxE2w6F7OajtjZ85qs4hv
         rv3UDPJnQco4ZITBG+vvVeRQ2o0UbG3Lc614VSJzMcsiTE1JyG4ROmu9URi7zz9cx86l
         6pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762614953; x=1763219753;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Tap1RztMvUzP4qDSWwZy424aLrFqc1NIWVy3xv3fs=;
        b=hJb7HDcveyY1Ic8GG5OkQFHuFpPXJQthjk7hrZx/mjEXc7EV7t6cqM4TaYmgXY/qVC
         0DZwoSOXVIgOox7z6/w+594bD5V5E+AM54h25KYO5h15wG23m55E6JyWNPBLcPedlHpy
         b1BPLv2NwU2bb0ugeuPnBpC9zjlswIzMbmurWThRofG4ojELggDlKhSvUN4Kucw8RGfd
         t66sHfmcTx+StZiZRPFJ0FfakSKOsjtccegY7DU9EOEhgwneM/gUFjpPh1gC9/j4IjmR
         G/h8BvNRGyVQKgozxrucYT8npKQj4k4vSFxyxLD3/hK8aubJ/0VpL+/FOxBGrdeeZE1g
         772A==
X-Gm-Message-State: AOJu0YwG/CtQZ9+jOCpACc8Q72nCe2f251pKKKmxk50GPE958lkzbSE/
	4y4Ez++PsGKVCK1SJCpGY+njtshFD1FP/WI304BkPEa1EtAOeif8/2E=
X-Gm-Gg: ASbGncsGDaD7KF2foJqZQrcRIqnwr0pZtBUEeseLlAKRW86+P08dYExBnacXb1KqZC+
	tELmogagLo6T2628hiDlPwwaCdtrx6dJhF6FbUqawc4nHR18TzozrIeiFKo4Ur3SP8pHwnGKS/P
	6ApxbS5c3HtWPRIizHE7E4Qi/D5wekVXMkRsfokk5BrfO9vGAOQ2D4mDPnmIx2NrzQkSNppg9D5
	ExEN0eGsJ7K/n0XX1/S7ecUym8jEmk3bVrdNsbDpes1ZQ4MGziwwPgVFZChZDaw9+XGtPbGEocK
	4usLFMhdak5PuBk+m6+hLSs8pseO143oVHd5tTteekL3qxgpLtW4E4r/Zow//nysvMQ/reQ3lSk
	2PDIScps5C2whDhRyvq2PexqIK4M/sQ7PoalLKvA3ujOkKOZZrDowqGr8g7iBsoA0AmWxu4Bti4
	TBAnapoyS7NtEdkN4=
X-Google-Smtp-Source: AGHT+IFb/jmL1GxPFssI5C8oHtBYPJah2ty7fPvlbBaRuhJ3YckoE4IqyzjlVP35PZZLcHjyPbqdsQ==
X-Received: by 2002:a17:90b:1b12:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-3436cb7cfbdmr3698256a91.5.1762614953198;
        Sat, 08 Nov 2025 07:15:53 -0800 (PST)
Received: from [127.0.0.1] ([172.184.213.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696d978sm12516595a91.11.2025.11.08.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 07:15:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: fix memcg accounting for passive
 sockets
Message-ID: <df425211-5bf1-c792-cfd9-0490f23cc515@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Nov 2025 15:15:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Critical: KMemLeak =
=E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19194272317

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5451f3b28abd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1021093


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
