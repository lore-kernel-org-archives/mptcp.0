Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E8ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 08:08:04 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id h26so3803114qtu.2
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 00:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA0n+eb/Y8UUmcIJJ/2J2+73DKGJYdYpa1VoI/b6xfA=;
        b=Y03scIdLchgTT5pyjQPm6pc1gCWrItWCunfDuiyawZcGvdaVgdZKSsA7pg9Pd1c+6q
         SxnQEiwv0LeMA6XykEBifusWZpNDgok5t57qi0QRjej32M6i3/aWnmb9OUyyoX2kzHab
         XqZbtJzKF4aBDcROaEbz2KMvykOTcCChQh3iEyOtwy+frAzZ4HJp7X2Qk/9lyvNfXCJw
         fjb+1B1BEPmuYQMop224Hl0t4kYK5RaejfKsqKXdzMP1foSlojwd1SWvBE/y9ACqf2jV
         GqtwLKMZNMAHZbYtG6L4mfDliVIaPKB5WPqJcGHmiFygNz2y/7ccM0ejiR+HzTkCS/By
         48aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NA0n+eb/Y8UUmcIJJ/2J2+73DKGJYdYpa1VoI/b6xfA=;
        b=n6Ya1RLZ9RpE0vf+uHnAOB5rvyIONdJweRVbEY0ShJp/OrqR/vPbc92iB7ZNEUGf4z
         r87f+B8o+3vDwaV8Co2O/KNQIlyl0u5sPHv9rtLLOPKe1ml7NafzTF5G1JQL8YvksSgl
         h7bfrZ4+ITGjjkMrKhWYI8jIpvQK0jFSZqHnmwOPSVSTCvgTn/8FCPx1h6GzL8+bghh8
         0nmwMTFs3ld6sdFUGszkNwa0nl2wJvH5Rm/dgfg4TG4nnm26xY6hX7dp6WHQYaqOIenq
         kzSsRat+47hKsG8Euee+F+lqpRScyItHzRBcHTCrfl4dvXKY2tIi/swCarsW5Zag52KK
         iEiw==
X-Gm-Message-State: AFqh2kp/rj/0o7Qv9etv2HoWI8o22e2/rLJL2PKBjNUPLSVqcdkGX08p
	5pOljGJuDV8XcX7y2bvk4Eq7cwHDyA==
X-Google-Smtp-Source: AMrXdXuXqzcsfPJ1ocQNP5MtgDGz85qZkC7n0kMD+xvRo++M63Jknv+J/UdbohBPspRBD0LC4zLjrg==
X-Received: by 2002:ac8:5350:0:b0:3a9:6908:6d00 with SMTP id d16-20020ac85350000000b003a969086d00mr20693645qto.26.1671437283386;
        Mon, 19 Dec 2022 00:08:03 -0800 (PST)
Received: from [127.0.0.1] ([172.177.154.97])
        by smtp.gmail.com with ESMTPSA id bw20-20020a05622a099400b003a7f1e16649sm5700698qtb.42.2022.12.19.00.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:08:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221219075048.255811-7-imagedong@tencent.com>
References: <20221219075048.255811-7-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Build
 Failure
Message-ID: <7c0f2c76-f259-b0d9-5156-2cee298a596b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 08:08:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20221219075048.255811-7-imagedong@tencent.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3729469771

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/93db6277a7d9

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
