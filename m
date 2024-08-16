Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EA13AA2B
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810150; cv=none; b=Wr0ZosOxyyof2DpqTpHi44DUoCtrzfCWIr1AINUus090572RYTDWHaoafYbPN0qU+bDNJwtezdPvJl5jvLGh6yGvP5DAGIIucKfGGD41jdCBQQLZEuVUs7/AgPdfhjvftRmOjrt5331u0qCci/+/UWXTHhRQ96a+Ml1Qu5VnEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810150; c=relaxed/simple;
	bh=k8ui55I01SZcdhJ9AbUSxoMgEZI74V5huWQ75XzjC4w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iZRFKHOKCCto/r4x2PpfKN5816iA2u38EGqky5y/PumPPAnuZQolUjtMvMktxkWjZtvoHI8rDvdewK6hS060+GxOu3+xSUSWHxNoc22g0xbNnIG8eCcfAD3s0ChPCPokkYhXKgyYOPDY0JUo1h6gv3DPvorxGi11icWhHvz5Lf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLHmUh9l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLHmUh9l"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7105043330aso1726001b3a.0
        for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723810149; x=1724414949; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flQ/7h5oVTSJA5+bK85KSPF6EuRHs8so1fRCNOCFQ+Y=;
        b=OLHmUh9lyLxg4ukWsEbLEli4YpGtyaJda47MI62MKqKEmncFFehFj5N25QbgHaLQdb
         fgLPc60Zg4GPYmGMqBXm/5PBt0KXhTMb7EF7QPKqNt0HtDXTJLmEoBvUDGVfWKsLbhfq
         XTBMDB1/JIiCU5ZvrQGwKQP5CROMNUeyE5WuufQZw5ZOruU3QHEyuBn2iLvF5ldUCDTh
         VsW2WZ06m0OYYd0GZxctWBY0yvapY1mrTuBx17so5SHBO6ScOjZLLsj9DsHQZodBKtR3
         jmoSQ1Dpo4ZT2JsYZfU4wUT+Yj34/Ri7ralcabFfx5NkkX6H7sZ/qbnltcxj2aGCVN8s
         hvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810149; x=1724414949;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=flQ/7h5oVTSJA5+bK85KSPF6EuRHs8so1fRCNOCFQ+Y=;
        b=q4Dy4bf3Pgi8O+hwu8ZowzkWwl/7IHk8WHN2s7HCT73YN6gV6M5mIoztZIqq8Lshlr
         T39Zy5/eNbgr4nG16Lu8fcDSvcjBLPDGXKxxUuEZxJ9kk/qKKSqojiD3sUYFAF1fdPFo
         fBJ1PJdoMVewzsC8vbHkRz8aDNlkKusrnVml62O5DH0JVUdf5I6VzE0ef1dqC0cm2PaV
         ewnbatmpSRBAlXZa6ExhUauZnQuOHCYRgfP5FrWPEgw3CykUg3Au/2WFeSdB5NKbnrX/
         xyG3+tEYH3AFVniMU+95VmOxikiXLLuvVqvqFzn4OptDrnT6tVIp2J/ev13tYpAUnI/G
         y6pw==
X-Gm-Message-State: AOJu0YzSc0y6o4wQZ3C4JvyMYawKAdGE2rsmiax9TZj5ernzkz3O1Vq1
	p6AdHsRXlhIofKS6gff5RMkRDmeiM8zETKhLR3PyHvrfKC2ROZA=
X-Google-Smtp-Source: AGHT+IFcWp+nnPHTeLcrOpiTVKod6DOlSfh3SBf0ngEiztcQOc0RqUtQdRWnpk8nQwYdXBDAEKnS6Q==
X-Received: by 2002:a05:6a20:9d92:b0:1c6:9fe9:c425 with SMTP id adf61e73a8af0-1c9050534fdmr3422313637.45.1723810148493;
        Fri, 16 Aug 2024 05:09:08 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.115.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3d129sm2493147b3a.210.2024.08.16.05.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:09:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID
 0 endpoint
Message-ID: <ef3110d4-e8f2-52a9-8a7b-876e8133ed97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 12:09:07 +0000
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
Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/104190=
16942

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de4d0b5876cc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880310


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
