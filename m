Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E61714AC
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099610; cv=none; b=nBOKIGe1CME7etITUMnwAahHHdMx0nr8dz6PqgfINsEmongh6omvzmCTe87sP0ORqmg/WijTidnHUiWLoLCK4yx6ALMDGF0gd0+YKMv3pPkcJA1ZT+UGUr6MndHdN11+uEc7kpnMiuq22hEg2LKOJPtjYcPd385k8rtk0EfVn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099610; c=relaxed/simple;
	bh=TSYPLNqNPKiYL0fP1PNm/jbaDNVnVK9MB+gL9Y/YScw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=c2lfpw0e+ClrYikPeCkVRt2b+B5jCKNftqnmcEYrLxEXO8x6n749gCR1AGvHd6ZZ3J52c5lY4HjBvX1HVQ0yxnEfRGMhganhtgobaEWuQDv9O7UcVxj6B8n3V7F7PHEi+VHAgY2MGwl8fyDXnEBu2vr748Ox2sBzThB3azllx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFBJz/CD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFBJz/CD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e45dd13b24so2056116d6.0
        for <mptcp@lists.linux.dev>; Sun, 09 Feb 2025 03:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099607; x=1739704407; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK76eZfM0hKwYkQ6mhITmfYwD3d1e9daPGme+3Z1SOU=;
        b=PFBJz/CD+IYovcSE3TAroFKOoY0CVxdahPpBKV1rrLzt2h4H6+eG7qmkJPS5fEVK1P
         gqsmxGfaS4zorM1D5eQSoEdDAp5DovtY/rABzaVrs5EVo43HpRft7T/geHi8oPOTaN8C
         CdGN+Ip/RRUVXPRo+ZiHnOSJ06Z8BNviveeFdlCFWqDbQbVaJQ7OdLxdP4u4Qg06jKgg
         aykdPmYtuCRJCHxkEN8YSDX3S6A/rR6SG2XgFbgNoPuwykZA6yJydRM5xiAt6DgkePZz
         SW3MCVybsqKiQ/tgv0dGSLq9GT/D5+lj46hgOaqZcnks9HBKZdk4fsnVFtm36l8Vcu+5
         owLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099607; x=1739704407;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jK76eZfM0hKwYkQ6mhITmfYwD3d1e9daPGme+3Z1SOU=;
        b=KN8zAxZIjq64akA2MRueMYvwt4jANS5xLQPe33dbu3cFCngJ4pgmNefooVY2fKS38p
         jQ5trZB99mqSaj/fWWVYamb7Z55+W4yn4HNnCAly1Tjym40oVOtNl1Iknb9MAlGNbIwd
         Zf+6WSYIFw8Y2sLmwuWaO8jl8T61HdnGSQBPCHoGXabmyXG5x0t62/0HrmikDr6cxMdZ
         SsXRHUTBDO+9Pem8nyA58wNnwudWemhuicpBrnkpZ9snYRerMV3IAwPIoigRbMko5FBN
         E1uwAy4RRLryUchiRuZlqq5UREYchxFl+5zCZBrMa53FnzKDRM0SPVwyVcW9UtHGHdB0
         FBcA==
X-Gm-Message-State: AOJu0YwNm0T2MtY8ozOaFYOtrTzPzouaOrhoTSxYMxd3lzJgmFLOn1d7
	TCZQ4cMOCD7KsgToPUIgyp3dnTECM5dn44XM5AR92Pjc96T0tovC0R2b
X-Gm-Gg: ASbGncvP28n1MUxgcknj5i7BC/IQWykyJLiYgluKDp92hZQ021SKlGYp8wThRlNUI6m
	qISPLGH1Xoe3v23NMNMJpD7dEhRJ0lUw4UrZptcGuOBAUHwTsuI40uNJyHdNWRw4qualzNq+0V+
	zi7REtkF7SisEjq1jaba73RJPinCpaQRKGbNdNMx9GFUVXzgk3RNZ1wLcTRJN7T+8kPUx8rp7kq
	uTRmhEJoivyUzZAaSB4kcjYN8j8+fpeTTIsyCkJQGdopNzYzYegFvfbuYKtSLuqEJ1e+ieAycsR
	Ju9RNehFjHOyjWPcqm1BxfIgAbCD
X-Google-Smtp-Source: AGHT+IEQbG/bMseiveP/RaFKszctwgu0xsCgiL7tHI9AofVLKihMNNQcVfHNRjDPYBLP2NmIYLwvgg==
X-Received: by 2002:ad4:4eea:0:b0:6e4:3c52:d67e with SMTP id 6a1803df08f44-6e44563d79cmr127188136d6.18.1739099607330;
        Sun, 09 Feb 2025 03:13:27 -0800 (PST)
Received: from [127.0.0.1] ([68.154.31.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb52sm35085666d6.89.2025.02.09.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:13:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v14 0/8] use bpf_iter in bpf schedulers
Message-ID: <e38197f9-9352-8792-7222-a48d5ce71112@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Feb 2025 11:13:26 +0000
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
uns/13224713280

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5912114f39fd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D931980


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
