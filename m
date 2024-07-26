Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C83032A
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019266; cv=none; b=N41rAROZHNuK6po8zqmCUs6/A04886ORCz/fZ8kKGYu5xVVCQ+4KWIUsc/bo5AsBmzm/TmPf1JUsSczKQN5O32TFiIXfHEmNzpdxdRgelHe75qd4OafFnamd/Q3GmugJ6eA9QOK/Q4/YjKV1uR0xolQSQ52gj3J/EgpIatPtEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019266; c=relaxed/simple;
	bh=iSdhsX6yJXrdJzVr9622HeEIQHqHNnHWyQXJC13FSoc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IpYK3AEbX2TlnTawPjHrrGSSxsMFsmFaS2RIQKj37/gQJMdHFSZPChd4Ci1+O5oJ0nGsdNFcYB7vR0tQOXJgjMc1pMqlUNku7okV8UXM5KFF+8AVtmkD/hTgpaUREGXjZgTFa0gVPULdI5eyL7WKm5aAQhc7QjwT+/lptbiSI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm4bpXmN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm4bpXmN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc47abc040so7644705ad.0
        for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722019265; x=1722624065; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43DSX2Qbtt3woEuLu8Ipbmx/142DJVJip9gCaY2d+mE=;
        b=fm4bpXmNFOLEsTFNT5RgF5FuNRktUhQQMSSXkxdMqpEBf7hyfI61+7ZKSCvkC7lP5K
         8ggxE3L2b7sr/LbF75yLUyQxrBrHEzPdAOjKXuHE0mqA8RZHR7WVZCMhk8duqiqNdJbL
         vWrmF0HNpsmAQU6Fq5iYp8a6pr+u1sWHEYFA0SpdlIBpOgjNviH2WfGXYYng453aLqnM
         mSFtJcD0aZUGXU/obHpuPQnIpUjgJaQ/rHorNh9/gVxpRMtRGqL+QWdzVimCmQv3fKS+
         FP/Yp/twmX5PPzh8p4A+GpBNiSUffBNDRlOoVp2WWADNZKWTp+YNoLUXJcKMtrILAU2Y
         ytFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019265; x=1722624065;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43DSX2Qbtt3woEuLu8Ipbmx/142DJVJip9gCaY2d+mE=;
        b=oqDvSO0Ljj/zYNsVkzkB1AxAs2VYUD+XMvKxofaAJ1mzkFPVwg+D9/NJEOx4OMEbR1
         lUj9AvuWMb9FPTwsa7rah4hEjOgYMdQDiHC9W5aAC2a/QYYE1ekkj8MkwcoNue31BivG
         7cDP6ocvVaY+Sc1okB9ar1Ku7Zf9CgIc0KhkdeXNU/mH6GFDWWV5NCo92mJH6R8DbmBS
         M9Lt6r+Zl4URN5nG9z/TyXvg+e3sfENVglOf/CX6eU7LaxSXznzzRCaDJxBnJmJbn6q7
         ZeEBvhIJHUcs/t32IgObnfyWZ33o2/VW4TsgRrE0AMvFbsnCoi0m0tPaUQWm3eHimaSV
         94Zg==
X-Gm-Message-State: AOJu0Yy1mvhDnjYzVXP1Yd2o5AAsbut4ahCJqqcADw3ZlbtY2H0SgMCo
	QPTdlTCibWpd4bb6cP4d8bB+jskNGIfRWDWibET+6YZPqVqgvvpOUMGa
X-Google-Smtp-Source: AGHT+IFN22et0txRBRhoWFxqidikVzinh0aiB8JvqbrXc4nZY5ME+bGIRoh7x2vqJSOZwvPmNkcB7Q==
X-Received: by 2002:a17:902:e542:b0:1fc:6a13:a39f with SMTP id d9443c01a7336-1ff047a6287mr5913405ad.25.1722019264223;
        Fri, 26 Jul 2024 11:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm36067335ad.237.2024.07.26.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:41:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
References: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: MIB counters for sent MP_JOIN
Message-ID: <86d11b94-b01f-a455-7a9d-e7f77a0204d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jul 2024 18:41:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10115560325

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a77ba3f17f2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874150


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
