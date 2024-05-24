Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28FDDC7
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547534; cv=none; b=ZX2VlhoG+HzizWZODClXgV07kvqZct8obFzGgGdMZWaLq8edmfL8ltQWFDnJC5zMPQOYLDU+neqiDP02//1H3xwKNPRebkgyFf6EYNprRw2ccjZT4vxLLvRvtzoaISjq6B2wfBruN+Ww6Jl/5EOX5MknbKRNNVxODL8a7GbrnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547534; c=relaxed/simple;
	bh=kvOmc2tmow7z2jcKbXHbI6ciAJzKWg3N4xIgdMIVFS8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pDFc6ldTfzP5aRTWKdLYKHb1QDE889OhA4zIhUhcn51HfTM1do0z2mv0ZynP5baTukW/I4HQ7Qv8RhgM6d6XW5Zlu2uwgm7nZT07Dv8W43zgY9AZWA29O+hq+OCHEYETsZQL4a2aHNdd5NxZj+zNkzXgQcLGq2XqdxsBbGRFAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNKB8BOW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNKB8BOW"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a8691d736cso21461986d6.0
        for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716547531; x=1717152331; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr+2RKv8eMHztAIq70XQWhVGH1RGsQBNmDxozn7RNpc=;
        b=NNKB8BOWhmzjOXKdEHSWmIz//8X4ya+ohIjxXMMJ/GmfHAWWoiAc+CCaQ/qQsw77kG
         dQ3qiPY1KGSkZzBxD9JmDNgrNd4/G4a83QNV9SMaOCV1XWY1gVZ7SUP+zFi1rFQlRqDe
         PFJ8x2s8a/lKr+idcoKrLDuJtOnNyU+Zv5mykI5uCm7nQLcGOuIHV1OghWD/xC9H43is
         aJNVTP/+LPnGOyu9F4uC/2h1A9t2NKF9PXllYzdFDUnPKt2QDEeblrEF0MV5ZI0UJSxM
         zex68eFhP++dPDCKN3ZVHztP+Li8IrD1xMz86/iJQhg9FmWvSqsC6B4UHvaCWOP0CnOp
         fciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716547531; x=1717152331;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yr+2RKv8eMHztAIq70XQWhVGH1RGsQBNmDxozn7RNpc=;
        b=EVqvPSRC7BBoPpYxaYehSZsixhXX1PSQtF4fpjav4uoxUxnijSREBKjM1es3OuS3LZ
         6D0gAZTMACnsJaLEhNfLV3bzc53s+bbccBxNDeyiPnZAIBCODW1MMz86r2ehCu21y0ac
         JoF0nXuIxny5HKFJ+Jno9mFPlZ5zuuoh3rZUhl5/T5Hv5HKnBKy7rZN0UGz8RT6OAh3r
         8SJ2PUt4tk+jjAeFzK4rvGu4wsBTyxFT3RBbuQI4j5US37KMjltSM6zJcgENQMshFXkX
         kd+vgZCVo8vfBg9+Ja2P4aszpZNJDxNLN0TbPQw+C4r2hLZi9WLwkxjCLEfHqjNc6S9v
         8NWw==
X-Gm-Message-State: AOJu0YxD/EWxLy9ot9aNFot/YEKkeElQoVBuB/StuszijUlR4g4xgoFb
	QttDyW2w+5qG/CD7CSMETU4dOTKg+I5wJ38iscyGj19OwpysdfBFQMSVGu4=
X-Google-Smtp-Source: AGHT+IHq+3czmAvH5o5uce5sLPf+GtJC2ugJXYEIF6pvesIDy7t1M3luc1RsOLgeR6UpRzssNF46vQ==
X-Received: by 2002:ad4:5be4:0:b0:6ad:5d67:1276 with SMTP id 6a1803df08f44-6ad5d6717a9mr11610146d6.26.1716547531155;
        Fri, 24 May 2024 03:45:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.37.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac16306c8bsm6139856d6.113.2024.05.24.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:45:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: YonglongLi <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn>
Subject: Re: [PATCH] mptcp: update add_addr_accepted and accept_add after
 subflow added
Message-ID: <bdea2c58-b516-9056-64b3-b72cce7d36db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 10:45:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi YonglongLi,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9222300685

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e6551d3f61f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855647


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
