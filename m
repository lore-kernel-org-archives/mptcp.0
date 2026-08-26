Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78043C13E0
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744420; cv=none; b=kZ/8/vBHus0raq3e7iBn/Gy4QspZg5+WwE4DwMwLHGTiuT18jIJUtk19h4BzFzR9wn1KdmGAJjANaaHmywYh6BqkpFLVJIpuL9ej8GprxEwifC5yaubXN6CpZnqlY6uQgdBoFxD7Pab7C3a46DeTmUDfOFzvgoDsaGnTTnGgaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744420; c=relaxed/simple;
	bh=NGQ0bIE0GururDX7ok3MgoGrTko1yDrdw6gjcAmT9LE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uTvphcUXeYZ9oZwb5kg5lllBiQDYZokBHSsfUcom/AXPkPGz+6mB81GNbSgBWanBJkgG2VnbEOOfyd4MR6mQE/PEOdUofGha/wBjZvvvvX1vA0VcX5UFuYsjN0I9Wp1tRi4Ay0EOPMtP/6fwugpoWB3wLZ2gzy7YkyK1XKg1Hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfRbcaRk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfRbcaRk"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfad59921so5765441cf.0
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787744418; x=1788349218; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=re9KeV0liPQ17tAlIg4UQiFFirrUHT2EA7l5/m9O2X8=;
        b=PfRbcaRk5zSQT5uceWmo7L+Z+WvVPQ9QapeGb6hYnuxy7wfM5+HWWlovODoXprS29y
         Gx459xug0mUPzacP5/8jT1nHXLAZ/FHG1SEMv6lPcEwel2OkD39SHIrXTnjGsxOHO9sz
         lMnkxefE/NooP5sbIAm7EirdwbzMG34FNPLfott2uJtqrjxres/dzlC2k/y5Y6wq+Zww
         Ku6iZrswUBOSpnGRWtWQB0a9hGCSIWVWQ03HPRZIZkY3j0KeqFpdT9YEaVpJrYafxkRY
         6+jN996xj3hJ+zVyyhBLEtTbG66uWGFNc16l+uKcQGxI1/+Yl4FqcejWuO3U9PsWWy71
         YjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787744418; x=1788349218;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=re9KeV0liPQ17tAlIg4UQiFFirrUHT2EA7l5/m9O2X8=;
        b=URT1qxf6VsTPV6fgppaEzvTXOf4iu1GOUou6cv5tjh5Q48V18C5ySdjXporYkQSSRT
         sIpIjy8U8qxpBYKZ8ytw13ldGfi3kzql9/H7TBrzJohJ0zAhWvRTKyrWkRXlG28oodWC
         apVnQCn/+dvquuk2bvppBw3BGvyMpA5sg0AMYG2sWV9V1bnBAwOyiq2RvEN7Rb62SClp
         ZXNn9N+wNQbPyJ/FnXrG20dMhbzTBx9iR7PRQyG+pIpLMwIzojXom9qNN0GDk5G9kSdu
         nYTLmPovnh4eBQR4yplu4Z+qacLW4vJ6cBa62asre/ghEFxxdsOiIByB1qN1OfFkGMUt
         lqVw==
X-Gm-Message-State: AFuF++k9A8l/ZkUsSEvkfU07XEk6wNp1g8D9t0lYDAQf/qeRI8GrJnqR
	rUXADtboVCLG2ts453AhgySiirIz5o5NmIfRGiJBFor0tjYBpZ7EvvYwNOcs
X-Gm-Gg: AR+sD11bdvKDB52koyuCKKiWkCfi++zjibnvGTqqSHqrsTEDfIUJ2DDoR6VW2T7MwDl
	UuQYR5fl/V/oHkKSZwxxzZJdd+l6afN0l2wgA7uC0gNPqml4iK439eD2v8dikFoZvnuMtCRw2E8
	I/KyH3wVrsnT5zpd4SfeR3hoLtFnIxvlQS8tgvJaealpfKNRhJc1LzWxet4sh+AoLT6DRGgJE7Z
	8eY0UMItNz9MiQB/SPxaCIDKIVsD7YB/hUmAPO5z6jC+76fD9OO4qJNDJvjjpQW20o/BwYMvJSk
	EGpPXDVDDY/0eFq0SvwZp7q2WQIvCDmwKtOiiKlMMKhyjkBw2otmgkjyrRVYq8AmAE02kpyaC+i
	g5tOUDZ8cPpDxg4/KagjFcx4ocolO0vR+oB2i+pGFE3O4UZNRNtzg5+1XjjYLfUV5uRn0DpOWmR
	dA7Fb5JjbRfZZWFxCD/DTG+tCNCV5z7sr3dUkoD4DWxvsYNCpZzWS/TCfOclrz6Pr3g6Z39Kxd
X-Received: by 2002:a05:622a:1903:b0:51c:a7e:4cc2 with SMTP id d75a77b69052e-52e42327923mr58910031cf.20.1787744417566;
        Wed, 26 Aug 2026 04:40:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.95.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc78dd58esm20160616d6.16.2026.08.26.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:40:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
References:
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-net_2/2=5D_Squash-t?=
 =?UTF-8?Q?o=3A_=22mptcp=3A_do_not_reschedule_the_R?=
 =?UTF-8?Q?TX_timer_for_fallback_sockets=22?=
Message-ID: <ed42ecb5-14a9-e982-4649-af4d3c6b2535@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 11:40:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/329599=
77232

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f617456d7bb0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1151973


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
