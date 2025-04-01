Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3701DF73B
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489437; cv=none; b=VdYHdT1YW0goDjPAT9/0LNRwkgKEY8GEtgUvCdab+iNEqO1mwdU9JCif1UhJlU7sloo1G783XtnSF2uF3YnaievZyS7/X4eYjFxwhLuiZTjndDErQdwGmEVj/fkZ4oBO6UiFqaWDph5BRpNg+wPdrFr9RdDPtSisnIIMoR0f7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489437; c=relaxed/simple;
	bh=3mDPEWXCkiGrPHyayfuQt2hxsa0yhKXNculnzAj9uFc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DlyG89Yp4sdftwPt69wQel5TFhiMQAHjgKzvaTClrQ6jmZY1qVDM0iouudhua25GDYSlDxuJdfI3o7/dwJLKA+zjMzHhU4E2rODFGW6PLtKS6z5viWkS7FYGonRC1eUalXsQqpfci3/0RelrrP5oJfeQpFiwICIzPKO9qkyggcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbiG8Lz1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbiG8Lz1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55b53a459so545509685a.3
        for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489434; x=1744094234; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOzL0LITJJdfmZYJChLXA3qK5zq4RFrDF3MHV1W3O+4=;
        b=jbiG8Lz18bRWHmBuWgjUlYRxFhNUZLQuI04CHYC+chnLktB1+XtjR5zNmThWo7E1tj
         kidAQPSMj0X8+gJ7QDZ+oRy2go/5j/N0PicmtDDuXpLcZq//TkcLznghlQwOvlowXMRA
         GfPV2qH93i+Mv/VJ3E4iaz4LZu/bPhJ1k9hXD5PO0nXpIXu31nAZbqvmGB9iiDw1+NSm
         iJJXYPXkwaDq6UCHyVIIC0oBmZlSh8BYyzlZX5BACg4QsnsxAWNsbnJMRdTkcdM1l15T
         TDausKjC7vduxuYVTgipGQCK47it/lVwMO7C5CUIfBKwIH/2hnF2PHaQQATxAUsImPD9
         cvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489434; x=1744094234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOzL0LITJJdfmZYJChLXA3qK5zq4RFrDF3MHV1W3O+4=;
        b=q3VIR+49zdUJ5IiSfenVwGCJfbPWx+g1NN/bYobSXV/v/hwANsDsc6YJmUvfReNb2J
         xR/wVBJ4CnWGeD1BZ9mWdlfH8ghTwKpvggX6ETA5lCnyvh35cXtXD99sDO0N4IFeIvLh
         W2XgejO3HODtotC40+v/sIY4LFilvaGgxUEmD+NpjM5GPWL7sJGXouh7z9FDtmmva32d
         KEpkldOQJOPdeZtOFk7NioAti7Jyowh7Pxobn55bko0FEwT/94Gsh2F6zYBxyp8K8tzN
         0z8qEhpy9ISXiq93swFm+tXsolum4CoxoH7XUbCvFzcBMmIg51SkN8ADu3j7gDnCL6tb
         4Krw==
X-Gm-Message-State: AOJu0YxcLOa0PNdGo2xeKKdzDfWQXWs81flRrzIwvC8gN1oNmAz9y0Tp
	3u2BQxwOFMHMLCk4WsbfS40A2t+29PjV2SpV3jR2//owjSjHf+E=
X-Gm-Gg: ASbGncs+y2Dw45Yb3EtWd+5KZIhb25gckgbVvjZcDfHlgrHTlLPKIhHtbnbS4j7xxEi
	VuxWjqTqVKAKVGANHE9KlP8gnGnYGiFg6f+SpO/I/mE6vl1op40rwNdIz2pOy1iMaBFNiSc1S1Z
	1e31IWurVdOS2iclnv2J5jCMgSV2ReiXbCsrEiRtb88KP/puSbVgZnXERH+yDpYB/mIyzNbgf2+
	11X9g/5nH9dSTgf7xb4aGZ4CmI5o9annHyJqthSll8awSjlQF/OGvYuLDvVBQLWE2C6OW2zBkz4
	+Q+Li11ea+4tnPOS9d74s8hM9FKmh0vomP5vqZNL+xdZO5Ug5hwuPLgsbDK+SmgyzkI=
X-Google-Smtp-Source: AGHT+IH2fLdapTd9ko1wcR0w0gKei+RAioh0KmkXOn2sAV1BvF6AwR2X8GXmUBaKH7ntSMFKJtBIlg==
X-Received: by 2002:a05:620a:4506:b0:7c5:3df0:48cf with SMTP id af79cd13be357-7c6862e7846mr1368430585a.3.1743489434488;
        Mon, 31 Mar 2025 23:37:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.193.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f777e00asm617477285a.90.2025.03.31.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:37:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743449872.git.metze@samba.org>
References: <cover.1743449872.git.metze@samba.org>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via
 optlen_t to proto[_ops].getsockopt()
Message-ID: <1fcfe2e3-064f-bced-5a2b-b6b2bf286b9b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Apr 2025 06:37:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Stefan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/141808=
07770

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5554f1e2602
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D948670


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
