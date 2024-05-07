Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFB79CF
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715056424; cv=none; b=V8TY7hzhrQwyVJaP9AS4cymhRaraPXDvLxYI0yhGr3p/UMIgJ0+bvMm1Flepq4xcIegwVFWYGPD0C8JjsDV3tGGBMTpb71Xs4PHqtxcalUvfVuG/vdZqzREchQ2pnfYam3T8bf0T3MOo4VIpT/hh8S9KpCAY0BDkFO+pz71QsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715056424; c=relaxed/simple;
	bh=mArfoEoSNQes5v6/ZwXML8+gfAuYhOXIHZUnoAn2XUQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bRif3joBNnOvqpcp/8mz6NEGNEtA1t15uDrX5cxTqDiLJ7qrKpfmaFTUw8sT8vkvw/bd+AKDUgGn55jh/47Gu6ruXlMBRLxfmPqc8FKg/0ZC7xNDfwlp8euIwghKkNH1KGCSGC2kJ6W0Dnb38SRNiasSokJcjVR9G1G1pN35HbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7MYzvX9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7MYzvX9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso19790005ad.3
        for <mptcp@lists.linux.dev>; Mon, 06 May 2024 21:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715056423; x=1715661223; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIFl0tOC20nlasMDVf6NNkOc7jeKM8uOBnLQpT+doDk=;
        b=S7MYzvX9cXwJCzaaRJ9yjsg2wWRtCZIOz0KWG6ZycFkvZmq4iZoadbdxJmL8h4auFc
         JckrFKkkdFHx+Vhxfm2Byzd2kSENjR57E83xkwOfL8twGksorJ+KkTug0PAtVrscxoRb
         mzHHXVEFZe7tywOJCl2QPPWz0NXgDpCbgHIPpYmzDnxVwroO6oH1Jegwksr2e9dyrQGM
         k7bYJCDpPDza/5n+J2IuwE0aiUMfui05QvrFGQPUgqf3QxypoofuXlkHu8nrUkRoBZFk
         UuJ0/R4fzE7idP7RIcJthX4mPdZlFoeQdxNotgYJ3D4O3VM/1v9oFYwmWm9hp3PKL0/j
         4F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715056423; x=1715661223;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIFl0tOC20nlasMDVf6NNkOc7jeKM8uOBnLQpT+doDk=;
        b=lo49IqAsnFfq5FBaeP/LvJRADPEmIubDFYt99+82ScIH6dAlvsZpx8vzQEk45+O3Dq
         tnySXfx940kfpVnQ0I/ZDLk3YyM66xqxWRxN25ALqwuMN40sxXutsfmBovLfTIGX6ujp
         ET7/7DIfq26BGbpIzv6pHuZP+xd1lD6Ao5CXIX8N5VUgZpd1d6byewmY9GDpi9kQ8I0b
         WSj/tCnyAwOu4ZX/0kW8iohtSUK6qJrwVeDuJaZ+ZDaAD8fFQGRThPdH3zZXpFfr174m
         yDRRABN4dCPQLvD8c3UwDzu1tdNp28TKKjtYULo/gTdhCf7TuPsvP04VYkFNJKqhQXuj
         ZZww==
X-Gm-Message-State: AOJu0YzhjtFsSw6n1/lpTqjbTefBGWYSKK8kE+jEvKJnkJHctx/3yJy6
	SgY0reQxekopVDKMq4+X48cgS83jN3MKFIkCOmnFn1yPVl4L/ITR4MWA
X-Google-Smtp-Source: AGHT+IEdY5xxl2utl/v/+cHEMH/BGmYokM76Os4q5zqYBVMbciDse5FMtsHyLdBfxEuF7BOZtrcrSQ==
X-Received: by 2002:a17:902:db86:b0:1e2:952b:81fc with SMTP id m6-20020a170902db8600b001e2952b81fcmr9994471pld.29.1715056422736;
        Mon, 06 May 2024 21:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.25.1])
        by smtp.gmail.com with ESMTPSA id kk6-20020a170903070600b001dda32430b3sm9143759plb.89.2024.05.06.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 21:33:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
References:
 <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix the default value of
 scaling_ratio
Message-ID: <92c5821d-d32c-40f2-fe03-d66f525d0bdf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 May 2024 04:33:41 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8979422287

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1c37730c0e5f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D851005


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
