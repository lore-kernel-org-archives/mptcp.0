Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12757800
	for <mptcp@lists.linux.dev>; Fri, 11 Apr 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330227; cv=none; b=WIGc1q0eTTG2Y/cQ83yLfjWYXRx8Cyota+vY91rcsNbDDO2yMaNmOVER4yKr4Phr8mRTOt3fF+fWgng6Hr2PqoRQOt3a0mjObH7EyWvVqGbGPrgRX13sagqPFemoJ8dV7r6MTvCPffdyyztl5Jf3yqle0hSe7kP0pp7KZUj7rcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330227; c=relaxed/simple;
	bh=4O1opJEB0jZ+QWmzeykZuS3GPWAp6avYyidxNitVRYA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qmt2kXdkISoSLSODmg/VFc7ZUQewLqVO9G+JjXZr9e3Wfz6rRX2dR/gs0Ho8+UCpmr/fx/ik0jkPBojKDktufu2r5t172MgLR6kK7tu9PhDndq5enh0YPpva+A/CjULhsidIXfNRbQ1iu5vhAHI8KjHlmBdmYjX0OF7nUYW9CMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm7J1pAQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm7J1pAQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so13516725ad.1
        for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744330225; x=1744935025; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nur+uav1txmg9LFmRrELM7+Yd5jMJUcJPjmHdqcXCDA=;
        b=bm7J1pAQ3dDm6SiolxXbOwtZspFIUmuum+DHw7+D2CnqlQu5A0Bj4eCRc4dTyRtXZC
         7rCFQpG2Fs6Sdq+oByheLlmyDwXMxUKRGE8KEpQMxUoShMfhotE5boJYRq7jNPxawTPD
         CCXz/52YBIQK49+GtVtw4aS/Dy27HGo+yWLetErWsxixuZRcjo5YAzE9u+SXBlHdaLYn
         /PsnmNxqk43iiMPuNtrTU1Le4TDSRS/vbVhry7S0i+fojiaRCNz+LyMAoU6Ud+zFOqb3
         8owDrZqUhfC4Hvbikfwbcu2M9d88U8ED2sJE3P3xSUf2ickRRQudoffZoVMKR3VgRXPZ
         R/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744330225; x=1744935025;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nur+uav1txmg9LFmRrELM7+Yd5jMJUcJPjmHdqcXCDA=;
        b=ShF11el3DgUFX8+rGcnMw6U50gDtwtRTFX5Z44sno8XU5WR64G8mOkvVhEYo8Ywm8Q
         xoBO7RhJcsquce0b1tdGQmAR5hGDMAAaHEefHcmkD7q/Q6LlWrKKsglSAXqqkSbR8jkh
         cfkcU+z+i1EejfH45mcfRnXH3ZW6sL7aBDfmqlP0z1k+5vrA9OHOx03dIxTkE5VfOSnr
         64P6dvVMuQpQk6F464f1VjKYk/ZvaTfL5Q7G6nvaQvvO4+pZV4E3JabXpenyfUD/Qjoq
         ZcFBec+2X6j8N81UKth/0QxkQwnddB1nA+SOKLYzomWjNTQ58O8W3STGU8lkNF9Vanwq
         ZF0g==
X-Gm-Message-State: AOJu0YzA3HG2Fsxoi+tUKKBemVSyfnKaYuOpvPX7jlfEMq7VOPzheMWj
	d9pLbtIDglvJ2lionumOykGeE5PEt5lg4/q6MzFgsHwkZxFBte9jTpe1
X-Gm-Gg: ASbGncvRcBnCpkxOe5b/Y/tzkMe0yzh7eHfD6zI9QgFEBQFTu8CV9a6CRzpz+FhNtWt
	EDmE7YJHuOyO1TAgG6DnaqY0EbD1TDOtzQWBgr5n3rrsj0cPYA6llVt6v466IYpIm3gMI71ajVX
	SF5A+CPxL6kk2w6zczHn2MI5hpn3Je2M/D+OzRwwWWpceVLmhs8T6zHxRxZ7zFxYhV48oztFaJF
	P06RF/IU5vF5r/QbjHrmliJfVf7Mu1/Peh92WDH7cf23hStas9pgjgqivyijtHuRILyZeh+EJpb
	PPlHOMN1HFP3Tf0tSiPYhdYExNBtAF4k/kigoXGsBO3c7dN8lWSvvA==
X-Google-Smtp-Source: AGHT+IHXnXURENhv7QM2Zm2UCu2Gv6XEYqrj+btZWBNkYi1XQOK2nWZgo4cmPEXNimLnRteRLzT5PA==
X-Received: by 2002:a17:902:d585:b0:223:4d7e:e52c with SMTP id d9443c01a7336-22bea49583amr11725575ad.5.1744330225201;
        Thu, 10 Apr 2025 17:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.41.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a182sm4183530a91.2.2025.04.10.17.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:10:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250410224503.2056587-1-martineau@kernel.org>
References: <20250410224503.2056587-1-martineau@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: Defer freeing of MPTCP
 userspace path manager entries
Message-ID: <ea28640d-f4fa-b167-d415-65e6d818a12f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Apr 2025 00:10:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

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
uns/14391915501

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b3df5ca41b93
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D952252


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
