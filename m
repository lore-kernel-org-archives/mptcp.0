Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15F339A8
	for <mptcp@lists.linux.dev>; Sun,  8 Sep 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725822357; cv=none; b=mIULf7RJfOrfqnBN8UF38NdQPN5gN80LEzPpCgwkRKLOuyyzB3mqVNgrN8HQJ9OJ4okH77gX2bGNwoPsaYA1af6hkYpyi6Vir5FgHVlD+NBIY5R0ukR8LR5cDez2Zn2vhF1EdQGNNi354e0Lk9Pq/Nv+xFpl+2x9CZxYOXhKbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725822357; c=relaxed/simple;
	bh=jT7HGZ5y/NL6JIRexlrrpPg11Y7+x71rvZUMi7RqYD8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kIytJdtXlMZaO6PLdgCuTXy38oOvegvBTKhHlPDQDKFM7dIB6262jqlT1QPU+FyQj2HOPwtYd5oSlwY0JMqYARav6oeBTjtl77hkWJBvlxG7WXW2NfHa2u32GnKlCFqDIy60gcnwIfBcehPD2islmC3/vIvwGfPMnmOMobMqqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG8Roz6b; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG8Roz6b"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1902893a12.3
        for <mptcp@lists.linux.dev>; Sun, 08 Sep 2024 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725822355; x=1726427155; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4mDXWJCD8eFrqYcmOlF9HWja8llI3Lodzu+8gu+Dnc=;
        b=bG8Roz6bJ11qFQhefvix1ryuYcgGbVXyB/7HB50ynfp7fD/18rfX8UTdO6qr0gU5Gg
         mjueMBTqj8MN6ctFMN8vcEweVBFK0kQSu4Ri4hC7gB0qlrB9vDfxSuYXppAv9GKhNYDr
         VcazJBYcTMi/Touj68vW5VYJynZJhJeT9g1s3Xaug0mjNxSNmfVWZMV65uq5VN3pBECn
         KtX5oPKeV+6KkNjwf/nrAoxigaLe0B/2W8R0epUCM9RFWkSENoDjv6Jh4Bypz3xjC5zZ
         RKdGjy5sy9JknMUhfU/m2eTBIAcP4Ohb8RVt5WlsWv/GmAj7iizFBTxvk7hA7zriyFh9
         XlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725822355; x=1726427155;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4mDXWJCD8eFrqYcmOlF9HWja8llI3Lodzu+8gu+Dnc=;
        b=njdTyegANtMnQRAg4+lUr9/4XXjA4DLSITCkrBKGtY+vUW0VkfBua1gv6KIU7dGZ+O
         sLnjijhdWW0Wgo0VN98asE6kNs3Y87OVQ2ZBV0E/aRF4L34Ig2GvO5guyKMmH5dtDNb8
         CgGuVZ/WZEHm+dqvD/sV+4Uj8tAZxCIm81E+AtFHsTYbBer8AtRYHMsza3pFLKwwK+Mh
         I003DOJciZjOTVna6gq8XTsC/1eD/nahOvFbu0YWDVQJfy++rAU8wNxGCe9nUddDhZgr
         Rc45R2t5gdVnlYVS96j/Om7RiCgYf/8joGdGqn6KcsN7TwdqShb72zFIyvMxnmiEJ7ss
         X+Mw==
X-Gm-Message-State: AOJu0Yzs8VhQ4st8p/GoH/n7XsFQBxoY70iWZxVP/LUIpSLfiaPXZeWv
	piUr270j08P7XVnVjcyyaGm1ws8gvqf3xHu28tvAvRlNcmwUpu8=
X-Google-Smtp-Source: AGHT+IH8NwYLhn3X2ZLaUcSi2nunCMWJsWGcZ7IPkNX5mMbVOLkYb/EAQMm6XtxDKYWAyo/4btWjiA==
X-Received: by 2002:a17:902:d2cc:b0:202:4b99:fd3b with SMTP id d9443c01a7336-206f05e7913mr68812435ad.42.1725822354613;
        Sun, 08 Sep 2024 12:05:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.23.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e35d02sm22410955ad.117.2024.09.08.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:05:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cong Wang <cong.wang@bytedance.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
References: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
Subject: Re: [Patch net] mptcp: initialize sock lock with its own lockdep
 keys
Message-ID: <4c8daf5f-b36b-b333-4f74-7b9684644dba@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Sep 2024 19:05:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10762126900

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e76cf58756cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888144


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
