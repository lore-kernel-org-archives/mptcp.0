Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E4A8A13
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368558; cv=none; b=ZCcvIU6QMe/ZiMtWimKKnFkZvIbOtBzISuHZm4Oh/nd57/RgG3dj/ST6xKE/PKKV2uhS26RdM8RuzH4ZrxonF/yUGKk+2l0kDEIkwDTjzbKMBrYOYeR9LMfPKTPoPw5k3p640wqREp7MY6OLMBnFnlnv1t0Et7SZWJM9E0E0U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368558; c=relaxed/simple;
	bh=LQOgL47bigkWzpNB/+ipddxXoZGmuulw//Jf9ea2VzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=fBqhSAkl+sYJNPIG+S9wgW3E9EOLmv0uNsf+S/RbjYqym465eaNNAqR2oPvqP/xqnlaDp+spCJQ5MnFkz4xnNyx8GpX5Eh0vZajZr2DYz+qbXuBsp6BHcogbZnhL7L4THQPgpPczzAjBPzwzh+fBCLWXkvQjejtSv6wPQ95Wam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5HzJ/6u; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5HzJ/6u"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1297184a91.3
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368556; x=1788973356; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jAE2EqeVrYbrifJOBaMh+LaJor3tgSn3Dp0x3ylBx30=;
        b=q5HzJ/6uGe1D0GsbPxsAAhQahSG3gvD+h+4HdMBJqAa9eybVOj1UjDgVPB8dQcxN+o
         Q4+teJ1B9Gwdb6d40XK1SVjjl7OSSRc6ezuOEZ/waD0j3YXIPn4glSIBv4Fm4aVRoMzC
         d1JWmVlWBfHsc2iniqHFOOOKdOsVD897Uvid2NhUz69dkiw2h6QwCowdWhlBDCRMSQOF
         zFAjJ52kCyi1I4Fj9R3vwrcbOXK5lheiLp7l19nqo3DA3f45d+/J4fmB/5zCQeZNpojc
         pVRX/7qq4w5uI6w3gU6/ql7ZOsEbEtMF9ULU29qLILTqjrvsaygHUcVLIz3qiKIJBOGu
         IvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368556; x=1788973356;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAE2EqeVrYbrifJOBaMh+LaJor3tgSn3Dp0x3ylBx30=;
        b=TKml/2SpDhe+DWNCiplq1l7YVjFCPNaeYm7LUPlaDS8D/Fv+UQYPr3RGqMjvyAW5+m
         v3WbVRhrm1QK2sdt7MCWaWjIgPrH32FZn6Crnw/hgXdkfP/sljy7TqdQUZE4Vhv967nu
         FChWgSGhDp1TWM0Emed2O4QoF0ks+wsiQ7w6gF0HjHrz5O6ZVKC+5t9uWadXV/cFEoil
         3nsDPHkkY+9YKpSpX6x8KiPwtrX/PR5WZqHB5KARYyQfBLP6fWuW2fxQxJRfwvwrKyGy
         BXlwoNQK2wLq+Gf9bfxFbNXRIByQ8/0mV7PXxxLcnaTt4Mfd497gXRAxRKRPx6pmERqF
         rGbw==
X-Gm-Message-State: AFuF++kqzfs1t2wN5Kx6PYQTPGxUdsb5T6diP06+VJMz7G4fswBj3HGw
	RqqkTkKfdfEiFa647049e0pspX0v4ZWrSmiCz0gZN6yb5ui1Ft6XY5kZQk3p
X-Gm-Gg: AYBFou3bXvvyr2n8+vzk6BLy7XcJNrN77uRV/VhSUQEfaE5RKLO0oSwIaeKiGzy/Exd
	IlWEWmJnUG1DxL4eIcn9ODWNHh7ZAO3VNAKRbAG3bK5nrjSRSDbname1sehcDhsvW96zYxvcLAQ
	bcIDGfFjUsJXZaTukZwI/P3RDLgge395soj/9mfaDFynucWnxkkh4CEBGVjGrFzuXbmnNCy+7iM
	bmMlR954DyV6WGtzTQ89ASvLyMxceOvXwekwwCoktzysy9tZHwxpVkhd0AfRpIwCOPQRNe3y73j
	d9z2d2KfRmW5oWv30LvPfkCZF4sLWsKvNUPq228ge0vmdk+90B1ICIiAMr9GQkvLf6236wv0yhW
	QU7G5xzp66/CSc4+CQtj3cy//FLR+LWQhCVutR7DC7uG94j7eIlYCpBoBdmLFL0MuRl/NO8eegX
	TifLmt2eWgg5JQ6NSqZHGhhW28KiO+wwTqFAuSA9bZSNYL/Y2gswLnn30ICMhZSpoY0XU/xQsOY
	SWqrjFOnfE=
X-Received: by 2002:a17:90b:5908:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39aedec4caamr9820813a91.3.1788368555467;
        Wed, 02 Sep 2026 10:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.110.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3318bc19129sm5599861eec.16.2026.09.02.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:02:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
References: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
Subject: Re: [PATCH mptcp-net] mptcp: pm: cap userspace extra_subflows at
 U8_MAX
Message-ID: <cc9e769a-5a0a-1adf-a906-09e61a5159ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 17:02:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33652679146

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6c23d697943d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156285


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
