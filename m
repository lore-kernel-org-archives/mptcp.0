Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60916416875
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809094; cv=none; b=aD8pei74OAEKZhCEwXV/MadpA5kXBnayiGN79gcQcxplElkf7MgF2Re6e0Cm1aNMJHINZBI5GWT6mtilCLJamyzxIrrXEztekgosaFzS0w+Dn9E5cZ8w/GY4Kjg6Ks2HSZUHjT9+dmhPfECnKiNw0WK1cIDWxM5XFJSwGf2NXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809094; c=relaxed/simple;
	bh=suQchpEtWgDdfALprccTtJl7TfgaXzuQpFjJMfyIsMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=imoRkhonqI6xR9MrIX7d4NXKpkZmyAmOPiC6BbFycK8K0vUyHHP9URpst0qXh1bHe0P7rd/B402bEdmHLeWAFT9APOYJqM+jExdpm7AA4CXes6Uoy68wUrlM5ZPsjbEQkIuQZIlXYoFp0ji6bdtToCMaHWM3UCL5nYHj8ggl9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNfHOF4M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNfHOF4M"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21724845ad.2
        for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786809093; x=1787413893; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vPH4fMB0tEjd8bD0+0/TSq/exrE5o+k+uZMgyn4srQQ=;
        b=FNfHOF4MnYbOOknBt0Qa/UNFzpDH8z5oVAKMS+qRewsMgyiPeaAAFwbBAoUdCVKmWt
         Tv7uP/ZR/amn82+TvnIJ1A6/vhEcRNnVTDrVRQzDKH+UfZW9qchwjrQW5OflhA3PbOyj
         bmplQtuUrhXB6pwBjAv/4hxLedbcD9AvX8Ev0hpyPyzuWrw2xQHOk3TEQVwcaPxFqznO
         Alo5VLI9lO+RJ0cEklr3FstUHghlb0GvT7Wyj8Fq8109L/q3cSVD8AgVL7LmjSzL/wXP
         Zvf8Trai8Qgt3qiEcwHffJ8mJST84ZEEePULKyI0I61ecjec0h5ImGxwEQUDGlCumSDJ
         O2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786809093; x=1787413893;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPH4fMB0tEjd8bD0+0/TSq/exrE5o+k+uZMgyn4srQQ=;
        b=H17j4j9AZQ85IBkKhLLrQLBzFZVyZLl88aofiHpVUpu4Oa496Efgel0F+odu8en5hR
         1dIfbL8q17+8+UE8C+02t06PT/vSUurHb2aZvj4B+MHvrM82NA4sHegwSn29pT/t+DjW
         yketxJncE3Hurrtch/zFu1JeA3yogQB1cpWtMYQAIc0iGx8TKwVLOBC5Sews09LQ7Mdu
         xRyAeZCjSorsNj8tdIeMoTGUs2YfBN+IO4ewQnETaxnNmZj2PePb+UrdDnQpi8cuOcu8
         DnyEK+pa9djXaJ6m3wEnJQFktmZkO7G62VgVERtJnVhNmeV9WHkcRCF8JnbuiszUbP1n
         SLpA==
X-Gm-Message-State: AOJu0YzXXSNqmzSRH459EjnF+f0wo7Jw2Dna1LZ6C5qLKSgc4pL+dYcz
	ZTIVSFKsS88e94y3B+jZVWKy1VD6EbBTBs+VQK8XBn+0ZxpZTJwo5nw=
X-Gm-Gg: AR+sD12Ua9HAbvRKDA49Z9PM3ut19EjlAGfJ467wA2RmJDl6cWQhdM5slse45caqQLH
	9A0Oo0BRNPdqjjPt5z27pMQQlk3yFm3mFPYncho+m1Xv9erpVOMDQ6w3HJx3thX/65aoDmvJH95
	oFK3liNlb7DbxhnRwDWuTd1mJ0UrU8o3jLCGIri2kApnjHL30p1DpGjVzr8HloCjRW9uwwckhHG
	FwE/cT7AjfvL2wNQjmCcsX2/mzX+gBiMU+6l4qGmeLIN6FX2F+h7TckYO35hs0DGif0YJ+A9ly9
	Y2VEtZNquJveqCh14nktrb0w8tLJuBrQ4Spc3xx5wC02qIGgMgQvNTZoZHeQxyMaR86Q9ngHSRo
	SZ7f30qZdwc1XV9Jhi2+ZvE4m69UC6y0lXS8t25B6SKx0nPuWfKEorW1y7QOf8RDGsfdYpYXxbI
	xzndeNpNqATwGTnOzNogZBI94Sg/3VlOs/moemWhKdcAWBC5qyEaBouPSHoXuKoZUEHlhWQr8Wi
	U8i
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3cc71ca38a5mr17330476637.18.1786809092571;
        Sat, 15 Aug 2026 08:51:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee70sm20871051c88.11.2026.08.15.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:51:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
References:
 <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
Subject: Re: [PATCH RFC mptcp-next v2 0/4] mptcp: sched: penalise a slow
 subflow
Message-ID: <e6cd3942-ec05-8948-006d-37975feafd80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 15:51:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318916=
62725

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/537913f1e89f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146531


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
