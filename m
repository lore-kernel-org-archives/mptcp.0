Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1B2EFD8B
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165261; cv=none; b=RlUPakCmgZfo8guiioKJriWgxA7FMdXKS6/R/4ZGog/N0HphUnSG5duMt7XDKiAdbGj0WGq/Sm+Br/b+LON9tE3O0yUNQzSG+KDdJ8iYq07k577UMfJb/orhZPRFG/wOtOSOGi4X46f9PIbPnpgg2rRY4/x8SW6KCWTm4ZRZv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165261; c=relaxed/simple;
	bh=drcro35d+TsjuV/Sgnv8Je02Cf6hXF8003fLdZjFsxA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IgnfM1H4jGcJNZ66pF0sXUFv2Fm78dSfrkYTD+UyIJPWapXlhzY9hETdiU71g0E1a4FceiCrbiAzw4+nPl0zkz1wj3qTNSjfWf61MNPUMr6YPLPjW8HNOsRWsTtaOG8fFqrVAiEgyeJchpfZ3RxWZlNbYBAvYRozautFTX+L/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVEJ785x; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVEJ785x"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a589b7dd5fso16630341cf.0
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752165257; x=1752770057; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R4Z6s9wFgUpyHSERYPASid6Sg11y5xlYxW8J5c/FLk=;
        b=FVEJ785xCD60aaT6Z5cR6oofZOrevDvcbr+CyUTwrMKQEhZE7d83sdencH34hBtW0p
         qigl0Mlo1LXR7MiJ24X2UrmsQkMJvuyoNJXt1dVarvuedf2nRD6XNylckIDH7tGVcMvZ
         /UviW0Zwt/zBftj4GS08+cyWRJ0azW1QnSALabD5tvqA0J9a0/C9pdbNdBzazBkqA15C
         wPbNr84BMbpqCrv/J4CVXA3iv8p8/oJGgvuXUE3R6/RwW25SgXAuDzN3B+/gfS1Z69d5
         FdyG2qJkwlsa+0aKceiA6Ly64Uwx60CvJzVICboZuEIk/pVyS5L0osmnATizW8jPErXc
         YlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165257; x=1752770057;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R4Z6s9wFgUpyHSERYPASid6Sg11y5xlYxW8J5c/FLk=;
        b=ODA+kLxnXJ+FrNtawX/oPL96RrEKMTCnWlW1UH6+J+mYiuKJ7YEoopBUxpe5Cbtwge
         mjafbsctofbxnZIq6fiFdQk9u9TmnNTblUSylRfg3KUXnPjmUKOJqIVVFP8wMTyMWcHK
         rtbcC4/h+GOZbX0x+Pq8TSKkdpLHsZClIUoMkvdulKRwJFWBUVtOK7tHNImP9g8KLl6g
         f6aDWD5dMR/iQ5zS7ueHn8hXIubDil4YwSmsgA5rj0BVB7m8IN9nI25eNxhcwex3xomU
         TjqXiLAr3vVFgVUXTx5WbonxMsuRQfXqRvekHyzKxQXVieHsKTO1nfDKuOq24ZYCJfxd
         qP8g==
X-Gm-Message-State: AOJu0YzgR5PwdRVCwoIXWs/1QUPb5fsPc0Dva8GEQOdeVxu0WSHjxHhB
	yF860l9uzIk0Fan9jN27hyVVfpWtwdnj+B7ALYLD5QWdSvkBs153fXAuihWTm6g=
X-Gm-Gg: ASbGncu0hOYSc6C8aXg3mxwY+tbNbRIu4iLQpUHxAt12JxkVGBpRVHqa6tLtW3nPMQ5
	7TUitlWx+RkRuuo+vzO9ylYYBXoihL7yzlRk4WnzbpIQVoqb6blEl2LJPPB9LVkgPlQ0ydsIwVc
	Ivt9R+eKxe/oWrnJnBS0DKIX7ss0oY0k+qObkCr01yZyVFFemnw9/aNqZVt2aFcxu4GHkI1icCw
	pCWMpzuHdorHgYb1Rng53higjOp60YhtE4i2ZTqLtDNmwUchQNMuekPdzVSwMrM7jQYpdwnD1zr
	/bQ8fb4UHmzoLXrnEM5bdKhbD1io1RNDfI1igPgZ0BRvBlx9nE+qIfSVndiBbjXDEpg2YybtEQ0
	=
X-Google-Smtp-Source: AGHT+IHXr0ZPX7vRkTUmcHl+EFepye7srOjcRxpG/9vDtdmOj9udI/aavaP1iM5V/3UsScwtOY8f+g==
X-Received: by 2002:ac8:5984:0:b0:4a8:2eee:4093 with SMTP id d75a77b69052e-4a9fb99e807mr47531cf.47.1752165257122;
        Thu, 10 Jul 2025 09:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.5.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edf0b7c6sm10258511cf.71.2025.07.10.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:34:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752141057.git.tanggeliang@kylinos.cn>
References: <cover.1752141057.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <b4c19efd-2ecd-270b-6a34-742400286971@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 16:34:15 +0000
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
uns/16198880391

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8d1d0792ca2d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980943


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
