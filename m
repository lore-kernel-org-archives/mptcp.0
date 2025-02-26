Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9972215166
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573309; cv=none; b=kXRDYD42012ksPtrSUcKyy8l4bTTV4pIjRhPLnjeyBGE6hndnEd2enV4m+9xfbALTfMiVv2sXYM5RF7RgW/la77uTOrxBwhqUfxVuElxET/G5I5ld/Uec/sPDHkYPN1Dk42zOXlhGbpHP/MCRy2clKFNOcJQvOxffeEe9aQKgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573309; c=relaxed/simple;
	bh=i3CM1MTQK2d/VJ+h0tcgh6pJNK4A7w//Hc35RW+TjBs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Pj9GVFP8vQm8glX8rI0EKhLr2ywpYOyd9w2n9hLzCTCG0djNtNUWFKO63MrKaMoWWEqauiYiu7ba/RDkmVB6xckZjZFdVOGMlSEiDIM2tDguf5i/B27XFEP+r/wn7oUOSz9tnv1dtDh0csBKLDZbvPgw+CcfvofDhnYgjf/zROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQemsCAa; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQemsCAa"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08f9d0ef3so414540885a.2
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740573306; x=1741178106; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHpqKIVwt1jGIZXqTFZB+5r/G2sq+xBvqScwFTaPEoM=;
        b=EQemsCAadw9HSD1LpiU7xnU1wNd01O5TMFeKpTu5IEWqQKttwWYLcNERI/jTdAJKYj
         NbwlpTBE90A7Mb3BoNu4CjicPrgaqzgc4NmFB9u68uOJim9hw1sOMh8gLYMjA7cUxhK6
         BBvivFPLbxhblT4DSjYXuy9w/5RAhh/w0L5da42ts/HL9dc6aUtHs8YwcWDGJIqHZYB8
         kjRjT//lEBCCDR4uYfVlZtVJdd6L6SgCaw8lQrpffjgXAa+NJ6ZwdEhMWG8ZtVw7ltuD
         D+eA7urjDy8XJfpg/zkJSzmVUS5ecxUfKTqMjoKEMG+V4SUsPx0RmSacgkmt9ATgMjuq
         fxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573306; x=1741178106;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHpqKIVwt1jGIZXqTFZB+5r/G2sq+xBvqScwFTaPEoM=;
        b=FVrQ3ky9/FnlVFstHkxZbafcJojsCRYWCPNfNhBdQCl3+JJ2wiq0RImOUXCPyW8gIS
         3osWSqQHcqnty+qetQyj5ohbS/fY76UsysPCTLwreshmm7gkjSctYrg96jwd/jf4aMhJ
         6bpj/69B6iwa4TXGZOTLmu4OKvHmBP3i1RK9R/7Al0m3O/4jlPEPCK+6HCOw4Y2CdrAF
         mkydZKHpWgLp+VjRR18DQVeJRfYjBvR/jK+HLR8W8on96/zkE/plcikZiK4Cc1v+NQHN
         1W57hWC3MAd3gRtDxcjAfgGbIfEluTtyGuEB2t67tEsWVNmqhv3tH07VM/ASl93lvw7I
         i6/g==
X-Gm-Message-State: AOJu0YyhE2yE0UmG1xOHZkCpNGPnqb0Fjf1PubLw/pK16DA4pVhW00wc
	wj7yZ4J0uvI3R1TEifI1/GmT2ZatCtbzyUuKe0lBICaR271G4G8=
X-Gm-Gg: ASbGncvpGsKdrWw2sW/oiUyaP2nJoaRbvaDBTDVZgK0RXv5eMx+fU/ctiUmgLK1sp86
	3IxQ0FUuo4j+aw3RSiCkwt8HECHJWyWmG4vEwxstaMmKGcfGVciP6KNHzJn6M9XBDbdrgfvE8k7
	4hMtNupfrU4dNc7vwPfd8sonv6BsExbNC3saH9TgOYvzs0tG0XOhmR3Wpp2tJqYbjVbZUrfLrSS
	SWqE0OTr7yQkKM4VvpkRx9hmvVjxIlRHDS++ku+lao0JgyIl/JK0z5LBYyf2gWbG6YyaTON1FfE
	MIhCOZGC+Jt6G2x/Kn+GK3mHVJB/e5prBOqncQ==
X-Google-Smtp-Source: AGHT+IGliecxGnn6TNauCOlvWICLl+4JcajcJ3AznGBrT7T7nOEuvLbRaweOtM2p6t/n8FG/ZNOi9w==
X-Received: by 2002:a05:620a:d86:b0:7c0:855f:47d with SMTP id af79cd13be357-7c247fe6297mr508779685a.48.1740573306478;
        Wed, 26 Feb 2025 04:35:06 -0800 (PST)
Received: from [127.0.0.1] ([74.249.7.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33d05esm233462485a.96.2025.02.26.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:35:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
References: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
Subject: Re: [PATCH mptcp-next] tcp: ulp: diag: remove net admin
 restriction
Message-ID: <437ee65c-0fb8-f8a6-ba99-7973f8dcec53@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 12:35:04 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13543107873

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/39f106995494
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D937982


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
