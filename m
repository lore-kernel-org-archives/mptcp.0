Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409B19C540
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983489; cv=none; b=UBBJqK/nvAo1EIjxXmWP7OL0LhzT17vlbUPkpTrcMITKtskIwhe30ZSn2Ach8lfoFtVzlDIaiGSb4tbCIo1YNZbWbz7ehN6JmbJFF3skDUvBHZP+2e+NcKfeCoc+++Yuy8pPQV0cW6O3IGfM3CO9ScdczslbzdTN0MxKV3uDmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983489; c=relaxed/simple;
	bh=l9ud7BFlhDWwqKIKiXmWn3KWVWAiqkdEF3mULBMc8Xo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fFzHxbAn8tXMJ27HXxBk05bYPH9jOJPNYmjHWaCBbiysn7g4HYGSUfz1EhvagI/EN+KRu1n3yA5DMvf9K21XLM6GWAQb1ubrtZlvJvCvhdMV5U5/xZBt5/AMSF539xoc5y9Tt+9je1gArTFHvC3+/Z6pfmWHkV9O8x2MNp4iheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te4Ue9Ep; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te4Ue9Ep"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-91179e3fe34so84498739f.1
        for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758983487; x=1759588287; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7xWPOm0gzWGrTYgdCfRQlDo9RncuW0gfM4tQC9+GqI=;
        b=Te4Ue9EpD/C5be+1EA8U+4+TwdI8xBgKj/4tiQjSMFtlMLxIzPCSFbZd1pV3/Si1kj
         FRt+jEVVfidJH1DmOsGeb0eGlj3qiZVT9bZxaBKd31ZAHAURU0HKbr0Ad1MZexQb7ZQ5
         rQNPnA0sJ2WRMEnJiRdbDsIsMsVwDjt8GOmUXtHJLda94Nf/6QxA8PWFale+EC92fuOn
         cuk00qj0PXpOh7/jBzKSCG6oyApQS/aACs9Px7yCqhjMdu7FdhYiesmskJeEb7ETPEUc
         MRMHrYNm6yccShMSLq+UgJROxwrRALUTE7UCOnl89q4ZuijkLSusUeK0dHDGpIE8ZsoJ
         Ta5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758983487; x=1759588287;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7xWPOm0gzWGrTYgdCfRQlDo9RncuW0gfM4tQC9+GqI=;
        b=cE+Jhi1ZOrSFk/WaxdQB/IFylyfwmYV7W0P6+uvdKQ8uRra6zIHtudlL1fHZagY8Xn
         50YKUXqt+Fnzs6LWDuOXr7JvAi1JLhRnWNB8oWDi2ZPyDY5nDCu76ObULNCMyc3Hg43+
         x7WUPgS2r995o7cVbCt5J5Mdigowy+V8iXeWm5XbglGxbqQOGnuXrp/AyQVz0PyBd7GN
         BA5A+vVBdPcaECWznNYQaspz4gtL7C+dAcqkw32mC9gW8ori2DtHrb/12QcOdsC7+23H
         m2lyxi4V4h8p8txEo5BcvNXa4JNnHmk/tDDZTDJq5F3DiT50/HwlkxCTeyH8Tz1/OLLl
         7Crg==
X-Gm-Message-State: AOJu0YwZlfm0S7x5nyiozPfT2IWkuKFfNrxqCtwiQBT5A98DQDd55uIG
	kougweX9l6qNsAsyCq2AZhyBzhXOnFZeJpd03I70mUnfGDG8UyajUXmbT+uPdU4=
X-Gm-Gg: ASbGncvZ1FjSjnNe0MUsULRLS8EDQbu1PoonRGJaaCwvm3SITskdihxZMEL0xrpXdMj
	dlaCriRH54mXIorxyr+JfQNDoTqzozjaINKCDHCHPrvd8NLBfytjL40OQrx/Oe2KYTXIGe0/5ud
	Wneu0ForFKKKKNpRV4cw5EA4qWeoJxWYuakc9AVyDiruvIvLDHaYROS9LhimVA4BSg+KMzy7g8G
	wGyZV1uGqa8WHSj50WG07t4Yz3czn/GdNL9n+KszHGjoT+OE5khjv10kcf+tlQwg+Pi4EGp78eQ
	eN98Yy7HRHJdBuPittri9rTKxdrnW8YvOdB58SRUr1hG/G2eYiH4FvcGTObGkIT1p7U1SiW5ptZ
	hwulF684rwnsVnHXdGGbhxJV9t5sMoJoOowDn
X-Google-Smtp-Source: AGHT+IG5lL7v1RlXL5770Wc/97IErYEQVq9zbdjEbxNSqGUNnrXd8iV8caWrkK4DjxjladisClsOJw==
X-Received: by 2002:a05:6e02:1fc8:b0:411:6759:bfad with SMTP id e9e14a558f8ab-428752ab8e0mr56714075ab.10.1758983486875;
        Sat, 27 Sep 2025 07:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6508a1bfsm2936744173.18.2025.09.27.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:31:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 0/8] implement mptcp read_sock
Message-ID: <28ba6a44-988b-cb93-264d-87fca3b44a00@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Sep 2025 14:31:25 +0000
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
uns/18059970889

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b8b232fda49b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1006759


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
