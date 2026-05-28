Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A1322C78
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951726; cv=none; b=B4UmXcnkYjf6+LHSMnnrtVKKwXZRgPGjIwTruceodP6tZVx50tkNM4Nhs2RQJ5tLFVgCL/qq2vO28F5MP6kjcb3z6VNWuLf0zSGVdxrlPHAwTkZyraGkwFt1lEdkhwVHfmchi5dHzkuxQCOwu+VQ9XpnZ5ig8Ll1UwqNfmjh33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951726; c=relaxed/simple;
	bh=WpdflL20r8U829EWqE5DvlzITSA0gK610N8jkGy21Hg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LchqoDv+leSTAxJ5ppUScQwDrs1YrOz+0mVvlbNtGYjbTuaEbi+CIoqozs3RoQqFJmIt6MUH4FNSi2OMPjVIdhL0LW6GCi2Y98iNxAscutjuCtCoDjHunlYiO+BLwTXqf+pFHiT884C34lQ/ao8j/FGuFOlz3hRR6Z0OY6aY8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2QqNZWb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2QqNZWb"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90d042fa745so2236945185a.1
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779951723; x=1780556523; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYaW/lSM/UfD6Y7SBuZETyv9slAY4qTTaYUMADSCJaI=;
        b=X2QqNZWbY8a0ELdi4CDCXPLrZoX+Qq6AgyYpRbJ5AjW+nGMAt0pdZm8yqBkCay5x+U
         FG3MvQxUPqEc8y7kxp+GdawfkYBAiqZlqxQ2wwjkFbNP0Z1EXbCfPvPhYecq2VhKVbBV
         ahrX0V0vFipvDqTwokXRhwiWBG1eeIVxwyxXYadWB58wIRmPwcRhXSHj/GziXbpq+/Sm
         +DTJ8m3tix9SQNL5nOCCCP0xRsVQh5WP1Ng0Fs5PTZgmbsxuPDMZ5DNzgzHQKKjXs8Wa
         C9yQa3RO2E8wQX7Osg1P3uBj5jnc7nsxdACHZp6uxeW6/MQjFFDVujI4zFrvdG+YwMwt
         gO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779951723; x=1780556523;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYaW/lSM/UfD6Y7SBuZETyv9slAY4qTTaYUMADSCJaI=;
        b=Did9wdXIJRw5LI4lKGVP9Svzzw2Raes1veUfdQ3+W+EccWYaB+mE8KuG45lztnfc9d
         UX9X3scTjfxCJUlmuoesQ9ms8iJsXt3EraTzvX1p0rUCIzOp24E/Mucm36920cpCae9u
         iJQnB7lUX+3JGvV8hshQ4pqQGAqwMmwWdHYlSPRHpOzpQn7rXuV546xzQ70bmFZFcTE0
         x0gzic7WC1xrLtJ7OfWAYI8UdNI+61412U1TWfQGPj9ewoPM+Q/qWiie6G/SV9uICmaX
         UxYoNTWi+jbm/ahF7ryidYCijfWVhpjH5+5osJjAIEcDq/2sB0pJvSWKpP/EFwpzU+lp
         nKIQ==
X-Gm-Message-State: AOJu0Yx4/IR4tAYwE5+8xYQ+IUT+WMFwlXQYw7bN7kQBManNd4TQH8UC
	zkHaevRxyZsP5kV5TGLOXSfysFdZ3Tc2Izbl5L4hSWSyY1wp/x4wmpQ=
X-Gm-Gg: Acq92OGGULhD/L9nxDzbttbaZw9z85+oa+b/GllohI9xXdpBF9UHyxPH4bH19Wi5PKk
	q49Xx3a7wjKip/xJPHrypM+logMnCNXhCNXLr8cmST4/cRbXlvM0+l0amdpWFGqc6BVQ3D4GfdY
	8kUFOYWg4QZjt/nwkW+F0oFUBiqeTj7q7129MoHGdJZx19Vvu+szs+8+83eHtU+ZS+MN4VRl8ez
	FoiKTF46f3MASu8T3nGYexHGtcEbckDuEIvjfchDDU30YaRGD2MKmFz+uWKXbGc6We7oi2vWtD/
	kUh17GWkmu6128pPAj5ZzknfyIKUK3D7T5cL90yd0CkARTMfdPTXZW0Ptq1+e3tZu0hjVlRGxcZ
	mAutH4GGcIsVDH7d9ynDTuwm3hg7vMD5vCJ4pX7t0bVC1s8PXqlK58ApTn282n1GJ7s6OdOlRb4
	kJ2eFUTgkWMkbai/Ae1G+rnQF9fzT8SU4gMbZaBy0LSjyxglFG
X-Received: by 2002:a05:622a:1aa2:b0:516:e5a0:2a63 with SMTP id d75a77b69052e-516e5a02c09mr262908091cf.33.1779951723305;
        Thu, 28 May 2026 00:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a2655dsm67446171cf.12.2026.05.28.00.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:02:02 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260528055459.55133-1-devnexen@gmail.com>
References: <20260528055459.55133-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v9 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <29a81efb-42fd-0709-3ab2-9bb94896fd6f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 07:02:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/265580=
57392

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2d0a6ec6e1a9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1101981


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
