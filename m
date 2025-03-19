Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4B8BE7
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355351; cv=none; b=X4+iuPJHxNySV4RXkWWUCTKZVm5Am83niCKoyYvdQGR5ar4amF9R4paWRUKvloc0juIFCkwgitzHvxEx/lKzz0i9ABhDxP1PuEjOX8L3AgImMLJRQV01IdqYy3NFYnaja9YYwAFDAy1UvXpSIrZjkpXOu2j0w7F9NOjJKuta2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355351; c=relaxed/simple;
	bh=s78HbJhURwly5foFxXee7M8Bbwjok23cFJGenDdpBg0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Xg060/eST0TpoFjeTNPwSg9ZmeFXB/uyFevm/31G3x7onD+FwgMbLasWdKlAmmw4qqQgOfIJ2WSJwn4nIcxkTTqM3SzP8Ob+4H/ZV1H8IhHPs43qiDIB1BvpKJKqa3yRQokwKCAIBLDPw/Bam9Tt5kLna9BnImq1qK19dLxBWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP99qkyQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP99qkyQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so6771893a91.1
        for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742355349; x=1742960149; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNyf8wLmkp53fYzFqpUkXD5P3n1ARJ3kNa+cK2gocRE=;
        b=WP99qkyQE3N+HWrcX+iiynuHB1jKr3fvsJUqZ9HqbYs84NQ+a+uNkyPaesQu3I4DW0
         QJGdAnYnKbeCS+rdoT1hw0OiSmwRhxUkambMLLDZ98E6l9QyFhkNc5UW50/1DK/fRTvz
         h6hM3NWj9vRvBcGIosn1uwUvJKmQJRrr1Em29yw0fLHu8d5v/vMUQGkb+ngRDq8gxdAS
         c1XOLmdWn+daPIQ4BzCcSUg4ZxIKlsyPu0UpKPaYk5h2PpkknzgQhnEFzGns4qpMGYDP
         kUfCVZjuivKlRPrESs1ba3bX1hNTNbnUbZD99Rvm7v43TajyFpQCN2ec2q+OUXmP1bUK
         Od3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742355349; x=1742960149;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNyf8wLmkp53fYzFqpUkXD5P3n1ARJ3kNa+cK2gocRE=;
        b=VLvZ32mQ/8001n56VCVbeaf0BPun3QP4cJQL6+/pvR+Bl41F9M327b9qbyef8i4iv4
         5mxTCxAb8/Y2fHIHGrgzhb0sCTvvLBp/oqRzxcXbC1YTUyySsG0h03ACfiht/tAJEyNH
         QOGpFyVdLXuY6xDNLYnzTQPkA38SRPb6fyCnilLszEp7OScqPzQIEjK6cdJit4PGdoS6
         C/MN6+C/miKLBOu+H7FqxU6JGq9T+JmIuVMIuEK9Z3JSaj4lEf4IOcrvF51jw0Q70bpJ
         cVHbCC/x2c/LDiyeJvuRVdhAUg+pDtD5iPWwzc9gPrc35R6yGPKrdV2iIjHA/Xm51h/c
         ANMQ==
X-Gm-Message-State: AOJu0YzQUg9JLWZRmgBTumiMUj9oC+KHUTc69azRh+82209GlW1RLvBC
	XylvIbs0jhC0OuWHvDk8zYGtykepeEm3omD0D57AE5r6jYg7TpCwzDfJ
X-Gm-Gg: ASbGncucuqGlSv1NYvvwA1jk9kBCZ1GBT+nameihhNXh06cHyw23S+mEB3XX8eYxGJ9
	L78233dMqrx6CGqSjXgT43w0UBGSjbRogKG1uL7sowylwBDQVOWRPYQqD34RECD6ISKGT11cHun
	r0Muj9E50gI20XhwE+IjxrnI5QoL31+dDXtB9WZ2sjT8KEs99Ifj8inQL6Amt0WgaRxKOtEv4Lu
	5KeyLDMxPTEDzdj0aJYflk/LjOxBDRuCe6voyEzzpKy+8Hh3xQWL5kvHZuFryM61DoSuRPZC2em
	xVRdPPXnk4DlwJrVOW3kw3P/en2BxkC8cIK7kQ4ZjKANOAszXdgBZqM2rg==
X-Google-Smtp-Source: AGHT+IF6VFp/bdX2b0LOAa3Lq/1OyqlFGYka8ew7Q/LvMERmj+5OTIFRF10wToy1JGbfA/GbvhFhWQ==
X-Received: by 2002:a17:90a:d604:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-301bde6e0d6mr1723822a91.10.1742355349213;
        Tue, 18 Mar 2025 20:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.41.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635fc2sm343736a91.46.2025.03.18.20.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 20:35:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250319022733.51444-1-yangang@kylinos.cn>
References: <20250319022733.51444-1-yangang@kylinos.cn>
Subject: Re: [mptcp-net, v2] mptcp: fix a NULL pointer result in panic
Message-ID: <16cbe069-5d02-bbfc-7613-a5e767eb0fe1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 03:35:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/13937733185

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/904006e09ceb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D945398


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
