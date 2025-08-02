Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE01EF0A6
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754158463; cv=none; b=DtdLv1GpbHgi3K3GbMi0LxokT0npTut1OwjvrtYQ4q2+ceuSpCx46O45rD6JaMYiHesMJmu+fwCL6I5eef7ZRz7hhYvRD4JRQLh3f0+66s7ZISMaA/3S/vrFwKM36r0eoYuPwqlOIHbc/oHYxXNYrl2MMMeeTvBq1dx4IfWXKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754158463; c=relaxed/simple;
	bh=V1zZX/1pA1qrfeYq0O/P+1gFv+2I41nQK8b+TNsZbYw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VUwkFZI/VjtG+0O6YDPpAMuJTpWZH+Ty7WOho0WrX8tdBfQGxosa3lnSpcm+VGeZHgfspLjhE28evvK/wo7LhkY0JuzgRSm6y1b1u5vHbXzcLciS4m5lcV5qhk9C8p9ShSqx6iVLWFghWe//35XhrgquJKep29S9WmSoDq2cyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIX+R9S3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIX+R9S3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7682560a2f2so3151325b3a.1
        for <mptcp@lists.linux.dev>; Sat, 02 Aug 2025 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754158461; x=1754763261; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMQxgqHjGe6TSgTJ5Ejk5pYS+RAchyPpt6uKqt88HAg=;
        b=AIX+R9S3KNQtRHXzGhWOp4f4zjKTp7lS+x2+JNRjFkVXGVxXl5sF/Xodvv85WBb6ZE
         PaPtxunDFXM5rwfYI51e+i9D4wrIpFlF0Gl+x4rkS1opyBS/rfXnmHqPUGyjk9zDE5xp
         vs89KRZrJZs66ldkjPmy5FZusFZZoWfSv/mskohnG3+N1ADyHkYIaqYUkcw1Eg56dj0Q
         vXA8AYv4qkaJGOpFb0yUf9cJXyc1B2/DEp/Um8ODHnMpH724DznKv3Pc/f8fZ2YGjKkv
         mMg7FT8E21Ki4d/uOiIjaOSJMN5iauBsn2npy7DQA6TO6bUQatBQ7SUnDN3Vh8noyT46
         ru4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754158461; x=1754763261;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DMQxgqHjGe6TSgTJ5Ejk5pYS+RAchyPpt6uKqt88HAg=;
        b=LSWryK8cN+VlVgUaCxhrEXVfGjEMur/rigkokus8htc7Bgj0X6USEp3i2T69Gxcwhn
         faFAcGxk8eLdGijpaF6yCNq+Gi3COycin3+Kqq9m0V/HDFONL4Iq7NqhNiQ4Yy8HSBh3
         +MUa+vxjQInJ1ebiamPWyGs9uAzfk346gF/t2YO9BZxcN1o6pnMjLa82zHdCZzVwTgi2
         ka8+EB7TQJeQaJyjridOzojb2ub5C67cMht3hsWCN8+0z9G6jalzvyGp5QotwXE/TMWR
         dE3nnL3uttL9Y6VusVTn8636iOQAP1PxBs151EAEuHAz4VJqc7AN/qpXy1iGWaMyALrQ
         ZsCg==
X-Gm-Message-State: AOJu0YzSOFjzbH4hdhATIAG8/zystn3ibUlQhyZK9THaYIBq+lQWnpEY
	jhVyd4k8BU81byBe7kmHgxGR9TIEG2kaur5l3TZBMM9IMBtLxF3EfcdOXcyf
X-Gm-Gg: ASbGncs2VdNoJhlUe7jo3ojPdcQh8oiPgxoDnUBYsFZchN8v/SXG/7Oj+735KBs5Vtx
	3RLAssE81XNao1Vq6cyM9RcMQXEBpoUFh5JSJSP45PRMo6AtDaFfmOeKjZ0NAG7bIA6xfT5BQ8F
	GmZ1Y+nsjJfSUy5VnnatjPeUIZRZvRQoscBGTa4aAmbWVCVprCYzcvDBOwMz4S/19lymIePtUWI
	HuRDxein4zHgho7GZQg3QiXMmglwSJ9B627PKNjOXl0zJvleAvSdTYqEZyDVQgm+EET/B7jgtTC
	Ild42I8gAd+qdwCUmdeiKYSWUKyWQZhn0Yn+lkGEP8ztg4rtxq2dlYBI0+xl0inQrTWeJ4btfmC
	lgLP40vfIaZ004icBtKzabObCdJFTItTGJuM=
X-Google-Smtp-Source: AGHT+IFdOX2YQPYjFkCX3WvsSH/LSek5RRCbqMP7Z0a84vetVKY9wZpHYGTewNLa4eSChFrgKRR33g==
X-Received: by 2002:a05:6a00:b16:b0:76b:3ae7:37a8 with SMTP id d2e1a72fcca58-76bcd082770mr10938919b3a.7.1754158460991;
        Sat, 02 Aug 2025 11:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd1d8csm6821336b3a.101.2025.08.02.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 11:14:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754135958.git.tanggeliang@kylinos.cn>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
Message-ID: <d380fe7f-099e-fbbb-e205-5614c4a8f28b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Aug 2025 18:14:19 +0000
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
uns/16695728843

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/79f05b8aa681
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D987879


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
