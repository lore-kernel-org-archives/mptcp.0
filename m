Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737931DD87
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628313; cv=none; b=mbTYsCo9ZCXMgEeJHe5KK0SrWxcIR9Q/iD5WiqVVobqGk14FpfFfpfqIy40LrxqieEwXxXQt/7gkTfNx4wvxWX5wXiOzBWY9uweoIAemaP2spv1aC+Ghl8F0kBan2lDCgLu0teGIsfBdCeOmVoxrlsd30eHV4IYLfMnFFNzNWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628313; c=relaxed/simple;
	bh=7v2zAhuQ5LnYaFFvzZ17tZPDxXNekVj2Z97ZJYKSOaU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ww/wuVaz60Xsn0m6UqTwvULtlIupiRmdGmyonfuVs8Ime8//rSSlqXqI4vHu9HZzZDC1OHLEX5nYv6jkCMyR8ohRUIhPbFtnINfNYdFTI1sYe6ewF5uaeSHKrh2EKJsGrZI51d+yIDO3YV+8arkzqFe9tEs53h2KGJNlgwcn5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay91UG/U; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay91UG/U"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1415310a12.1
        for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758628312; x=1759233112; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoBjFFk3CDEb7EV2ytKxEtJ9Ey1fDxxVGlYwp+3KdlQ=;
        b=Ay91UG/UT1zPQP5qaRXlL/VhoPnXuaWLG0tLoriIIFtPQk3NPmHbt89AFc1yQ08fFN
         4r0BW42zqj8j8Jjm/nkMMs2dL97qA2O1HePynQOKjxTlhSkIICgNh51DYgC60Wv++7/f
         yFuiCdYEKHfBiLTdhA3J2B5GsIkOy8RtCx+8cc6L2XyCybttA8Wsm6nQWJNReU8a28jP
         2wAUpscTgBilaT9ZqiFMQMj7Zim5eRKss9LZSxcd7YvXlOH1/m0tERCDcKzXNXj2mpnj
         g8GAUbm6bi/bM34C+KwMOiRCQni4h7/KNo8Ud5McVouUBJ0Q6XlHxKbOCdVj0OOgdToq
         2A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758628312; x=1759233112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoBjFFk3CDEb7EV2ytKxEtJ9Ey1fDxxVGlYwp+3KdlQ=;
        b=r6HjtgBs2R5ugmvFUcVVGOYAfsLgDpbS8J5HwKWyihVVvXX2LqKQQ4KqfGvdP053dU
         GgrPT1ECAL8HRgUR3YFGBR0+TnoI7691qz/UV4hbKMatKlqRV+LL0DuKrCnYRvbHKv3o
         l/b3rPLsERNo+uqYshWiZy2NPJf2YLkBSE4firG/wzhC0sPm+StsFxp8drvBfGev8rfw
         d9To4OfWgyUqCvWfaQAP93gZsmfXn7SbmW1jm8YkkX2K23NQCNo75A2fLdWIaCK5nazM
         JynRlTkfYT4Hmx9tBtjS8l1itXjfyCQVRBqSf8zdRGMzRpp2dGUZwJFWGBaEZOreRJHV
         t2Qg==
X-Gm-Message-State: AOJu0YyT8ga9WPIu+XJ+EDZAwa4UDPUPjdsBu5VULy2qlrrPHTTY6cI3
	CC9h5idnydbUlV4nkbQPB0CSxqD7POrJF2nHqNlz5M+67WoYPZNV1gqoA0BX
X-Gm-Gg: ASbGncsFqg2W/SE7rkBN1w1ZNA4OJVAx9UGryiErDN3blkWTOLq1hH/uMop2n8M1QGq
	rDCPCtZdBv9bNkYmBAMMAq5laANqIdx+zTRgAkLNw1Zby+UD0QtxVROQxHN+lNrvSKU0eQR1GGb
	AG3SjYbZ0dTdn8hTUYo0sLPNZReqirr7ZUcBD5UaJYrNgPckLFM6A74pFD0X4k8pR5KEvN+C3jc
	D+7LAt4lq6lP/1kbuHhyGyyqRvUU5X37SMXK0qbQmNw/mn+uLlqzWzuqSqWkLm3rjSNUybDJ5aX
	eoQ2GkBA4E6nxYCPiuIUppZmY6q01+sCU433WWhSpF9519IsEcfyAnM6tzO4z5dGxoV0EE98HqD
	W3f0cBLL4ezkUTl2UdMmgzz6JRAh7yPKjevBv
X-Google-Smtp-Source: AGHT+IGBPKQM7YWHu+ZfL6EPTzXw7XtcdSkO8K1QOfaE4D1L3SHgRGW5j44i5XYgDqx66KefOn7KoA==
X-Received: by 2002:a17:902:ce0e:b0:279:daa1:676d with SMTP id d9443c01a7336-27cc07ef63bmr26838805ad.8.1758628311645;
        Tue, 23 Sep 2025 04:51:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.244.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-271353b8792sm98032695ad.123.2025.09.23.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:51:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
References:
 <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Message-ID: <afd74ddc-36fa-59fb-0428-b7058f1b62de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Sep 2025 11:51:50 +0000
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
Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/179423=
35666

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/44d6e040779f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1005202


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
