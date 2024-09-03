Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42A188A22
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379430; cv=none; b=gBbK+99llMnUwjKXovYQcifEFXUFeMHONJ/lTct2R0d0zS8f3YE/35QnYPB9c/Gs9x0jw9hSnj7c88CDMbTBJafxzZCiXbYxqyV68c+8wBPnJKRZ86aDIC9kHsyQz+uTu5xmiwmCf7cLoVdBfvchPnjvXeiCZYiDBkR8cF4XpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379430; c=relaxed/simple;
	bh=IH2ryZ75OvRgOZSoOyuU7t4Txrgn4OfcdHA83H2r6MI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YBNpJMeXL/FI36vLiead/SULivqTJq8bXoM0TSHf/sIGNorkPR4jZrzYhWX9CjidobuGMSrUetXXpz/pgdJ0fO+j+UHDMibixr3pMj7FZPDljejig/GhBCJ1h9qcgs/7zN5TYqbORl3Ii2JwIgBW+UUBVOK1FXhDnP8YOPoRJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF+B6G2t; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF+B6G2t"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45681098bbdso46487141cf.1
        for <mptcp@lists.linux.dev>; Tue, 03 Sep 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725379427; x=1725984227; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eiyqWVUrlMxS53y9mUKws3tssjbGTOOnXcZt7SSrz4=;
        b=gF+B6G2tar/7wgjq+p/4li5d6NpYjXjPuJaQdiDGQJj56658Z5WWLhRPrbwcX14z76
         TzrUdhW1PeC4csrGhfPPyvNmwDV45MvI45U3XMI6IyIl4uVeKQSio+edztvgVme9BQKh
         P0Yc0J+x4PTd8ABWL58Ks3cHkLO+6EB8R/dioopZoYNBtEsvYvtMqmb43jcIlzs2xbXv
         EeXFmhS0Wou8buMf1BVnzImCclxiyhY2Ob0nhAa7+OT7Mcnyt6vhySu8BRRoUg3VZZ9v
         SMTUbdwnFKdRWETJu3aBJ/p9rQxj8hXo9XAZnCU5qQE6bYC3pkPSnDVk2vAPaxakmqPf
         OaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379427; x=1725984227;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eiyqWVUrlMxS53y9mUKws3tssjbGTOOnXcZt7SSrz4=;
        b=XzSB+twx6gVKs9xnw2S1zyiko6kCOLGtskaFFIFXhqMfkFkvT3iX1HCunGAf31nxs7
         A6vDKYFQRzmTLxCTf/S8lMjnT6HtwZbzIJjOEDCMQFcEnHNRR9yK+/DHrYwFhFk6ZfGo
         n85/KhuZnPK++exHEB8cA4JNU75ADxdKnlD1Yo3kuUJ9O6OMy6KLcBMfJ5MHn1MaB96d
         jxxunfu5ukL48FqGQ+cqg9OSZUK4FYSiFXl8m8XzB1YM7JH+IaIjxJV+lYF2arnGdmql
         BAROidSZIVYFk4OksfNCZrQEHjQMzIKOgnmC1FCe1P5LubhuyjhuA6ghzm8MOZcEPevK
         bC9g==
X-Gm-Message-State: AOJu0Yy1J2k7VEQBrGGAYx8fjIdLBFxMl7E/e2hFsOu1lm9Pcam+ZdNM
	GVzFvVGGsL4wLZ8hQPcNIV07RANoKC5LL200nmCKgTGdwpnEexY=
X-Google-Smtp-Source: AGHT+IFjHCxyb+jCgbdg5rMp0rnLb2akv5LxhTP1WZqKlFX8a+Jn84TcoQpaXyby7gReeeOsnY1FJA==
X-Received: by 2002:a05:622a:2b4a:b0:447:d963:ebbf with SMTP id d75a77b69052e-4568bd92c8fmr274876611cf.21.1725379427397;
        Tue, 03 Sep 2024 09:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.5.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce3037sm51021011cf.49.2024.09.03.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:03:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
References: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
Subject: Re: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <2a703004-3b57-1e27-a15a-948f4899273c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 16:03:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): mptcp_connect_mmap - Critical: 1 Call Trace(s) =
=E2=9D=8C
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/106859=
82560

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/96d64469d937
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D886357


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
