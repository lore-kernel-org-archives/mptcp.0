Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254927D77B
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208722; cv=none; b=Kz3e9fIF2u+fZ8RzdeTTNkpxzAU9Oy35kdBdtQGGYaRgFAPNuDKdg3jj0jmUe78NX3ZKpqFnBqrjDvAVKLAwQOwpF6GgBuP0O2exZ0jciIl0qvzZtIZkbXpL3Olp0N7o6+2DttKr7meIRQGgCAnqHHpoeXU/RB6BQroZMLPZ67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208722; c=relaxed/simple;
	bh=6tAcAx+vpWJxFRMfrBSKsL1AH7ab0V/FCWQ0Ba1ZWsg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iiTey1vVg65HfKvKanoYzi378+Lla9X8LLhiM1XQEdTkcWA14StD3FPbZUh+AhN/+EJTkhqzN7SuZQTYB0lw87H6g3/iHTBDJ06916djdZf6TmGAMCMhXMRneskZbRFKIfJ7bPtVnp4poKplVx/ecxeLwbStSkGMB8zCR3yXGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STImN4ay; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STImN4ay"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109be3726so20752511cf.2
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755208720; x=1755813520; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzdR8GRI4MAqBuEltVNSGH1yx0KUJ0Mk0il45fjnfTc=;
        b=STImN4ayq5hRBuFwuihcqP5kAPS7M3913GipsSGZcukkehXtOAqVxj8RXI5p/WS5Wg
         LgS/Xa9kMdeEjpmBrdcxTuNh52ugabWpaD2qmdgKQVXrCTzhV0wHH8rhpZTt2ymWsakm
         iwk4qe473lqsBujO0UBA3mzwqOBticotJEiYXWpDqiCEw8w90qDVmcaGLPCqd7k9c5Gb
         HRM/nqCvQNLdkwXn4bgCEtav3zzKELTzyuP/+wGF5h7Dxt/RWTCElwdNDvS+XDBvnGTJ
         p4W0PvIlaocw3gK3KIhQj+cdVCBmrLKy6AhCsxAugIb1yuOKzEOQRUYymlv8PE87Un/2
         +gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755208720; x=1755813520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzdR8GRI4MAqBuEltVNSGH1yx0KUJ0Mk0il45fjnfTc=;
        b=f19BDFSJ6ZuAew8T6psEvkGYjMbmylQ731PVd/G+HGC6k7VtuDVw4OGe4lhxanLXKJ
         AJAWMV7BGKbS+cQuMtNgT0/u6XWB9HbkxKpP/8wNNVpMsOdh1gJPxU4KYNUHfyKJl/1U
         +unEPaGxjG0g0dbvRAXl1LMzZYjd4OS6RpFgwG/EpzKalqYtPT72+2IZQZcjLTxs+afX
         RB4lFLmNFXXkkoCYCduBtKVhBajt2tHI4Q4bxNF2FH5qwZGbylhJWbV1VC1vZBygv0Q2
         BAoPwXaU1tiXS4chBW3PcVvvk3ibsceLpkjNJWdMGM9mMzgKT9Vsfd+wh+MTKXKaPk24
         GoDw==
X-Gm-Message-State: AOJu0YzqnYF6GHwzvgFGW9DYPWf5/YbCaYq+a2JwaF2sPXal1GMtTEvx
	u8qVF5EafVHQ+rDDQYj0w25G1Dfd58LZABpjGG9KXS6dIRMrnGN5B54=
X-Gm-Gg: ASbGncuMTmpGsO1vBJort/RODsb4jtuV/W6raIy2xTbztFAtBtYig8W92Ysph79EjIT
	oy0qHaZEiTwKypPRFzh0eeDQGY2N9JBY/pyoHXdLdGQsPNeJCcNJDfHI+3Hrao56gZn+BQk6gWt
	3WJ7mDAnDfj3txrAvlQy1frL2MdU1rx1MM9I+xYDTqPhiKD7fXE9/ObKFOUkJXzr8oTuexS7GA+
	yWj51BB0cOJ/p1i4u9/T+dSGpvNxsQ2l59nfGIZmEuy4GfPxLAuQSqnKYoUmUpOkMtB4uoDtbxQ
	mvJrmrX6sKPFpzDkNAB0ulZNihZtDKoMyTs0hlqPeuSP0Ql310SzGKyxvTJOSeiyFcCNALFR57H
	ATMZre/eguadN7J+nBard7xAipwFSxurwEMZAgBX8Mp3CT6qc
X-Google-Smtp-Source: AGHT+IHU1sxXx5TMmKyQfXkIkKfU7mwwrUN3gdWuBxcodpPWnfei6KurOmEPZ/p9hwmBpNN5E6qHyg==
X-Received: by 2002:a05:622a:4d4d:b0:4b0:70d2:5dae with SMTP id d75a77b69052e-4b11b13b7f3mr8495251cf.32.1755208720095;
        Thu, 14 Aug 2025 14:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11a8b5277sm1999181cf.13.2025.08.14.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:58:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
References: <20250814200912.1040628-1-kuniyu@google.com>
Subject: Re: [PATCH v4 net-next 00/10] net-memcg: Gather memcg code under
 CONFIG_MEMCG.
Message-ID: <cd9643a3-a2bd-b84a-9b67-6dcfa7492814@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Aug 2025 21:58:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

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
uns/16975823014

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3d8de6ecc656
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D991687


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
