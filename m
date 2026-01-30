Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057E2AEE4
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767159; cv=none; b=DECylHkt+0PuB5QMGOh+74y+aw0fD83Y2a9R0ZyJUW9E32FXwkg9WlMVZsf8eqzXE0Vld8ri97qY6mdQa66aKEDxHpa061h9xX22ZiNeO40pIRhtzYhFh/U6O1TWUXddbCGnA563igUK0P2SGXvy/OEHPaFWVb62lWjY8rRFlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767159; c=relaxed/simple;
	bh=zJm8qCwwSlrMbk0o19WLS5dqOaC0bPpkmm2S4fZEf0o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SU0i3/pr7hhqW5TqIsdL7wSbdnx9jBBoNHTSl3hpKRYU43vU8OQfm3REFbl1ukq6lv/uWJIzVIzfuTkRnbEMwecUav64F6UJwFiklWkT6AjTKqPOahalYNWXazO7GKEIOTbXRMrpMKNK3tOu0VY6ZP3yMjutu3xhdDtgPnNeYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzIplWFb; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzIplWFb"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5036d7d14easo19853261cf.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769767157; x=1770371957; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZndXXbACQnVpYTfq21S1iP24HaNKjQg1UvwwYogr8wc=;
        b=IzIplWFb5y5A4obB72u1MT1tHvX63qhJKrnRa45zfIfdsuppQPUWWceBjTZnjrzRlu
         o+VCEoBCEwOnXtwIvZvin66vRtsbh3DVuXQPB5FK/eCPJ4fnDwk7jqTI3salt0ys/xdf
         O3gabhHJdu/QafuqbF1uJXP2fQVHIVLyOeCoFsNmMAq4BqkwpvdR7bZArIdVSWooi2jl
         o4K4xp5lZz2Vx6CqHXZtGPSkZ4Z9hwBn1wdw16r0DW+HXYgm9iRvjaiOIbVfDdYZynaY
         ckowrLTGjfIguHySdGKTOyK/bAHsiU4dy3l1UCcFgCC3/PNIV07R2ITGOqEr3dQ28k3Y
         29Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769767157; x=1770371957;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZndXXbACQnVpYTfq21S1iP24HaNKjQg1UvwwYogr8wc=;
        b=pkRfeue9iQ+hsQhVUK1nTcqOAMk/NojartIhoN3PethBZyUE6DTJ5LoGUx60e/tc2W
         AK/eQH/29bM7XHvkf2cTEbvPiJ1nErp95Yo1cLJPCOi0Qqspw2plrz0eF6bkoKAOgFcG
         Qt/owdnCWKYK5Ao0XnmKQ+oFf5ds4isZZ4YMrVZtt190wUyUrsHGDBst1qIvn5lEj+Yk
         c0Pd+hZA4QlGxLnzgfbgQUiCXwn4qbH4qptvVWmbp/UDoThfX+hcJb50ONxh3mH6dO9A
         A6UvdX8EzOuHyXkg8g0g92OE/dSGQJtse6GoX/D2tMFYiZ0h4dmYv49S5cOgiJr44qlz
         vvzw==
X-Gm-Message-State: AOJu0Yxh1IhuyWtKVZPPqAaGBrR5MA0MSy2hx+pxX3YuByIIJj/QyzgO
	xf6c9KV4qy+P9mMoS3W0A+TT0FJUsHsRA7HJqygqMklDmnfNrjw7uf3ztlWfAvU=
X-Gm-Gg: AZuq6aIxTR6Gw5HaD7FV+PO4U5m3zTuQyCsjbn5TBhHGa3ma+MgMxaO1cNWHtHRbZ0U
	acSWjDYTLX1GvM61tsifSyfrNWowEzGyQQE/OFl2lAGg9ITzeWYPB1M/sR/T0QNocIZfIDcv+KJ
	l4VTjgvqhT2kb674rQ6q2P5pkccVpY3CXcoT5KMCRKSY1Lbdpn4MqPMeFbAPykK/LNN5MbGv2KU
	CClhqXX54MbuF/sBbPEWIAhgWgLDtrqVJoes3zsqQ/X9fnEQTiO5VPW3W2+v8UIWU/xgAWBDUZF
	MGtnidGBAcq8tn3O7sGVRCZA8pYBuZHq/ME08x5bbhYFSvmbu3Iz1uogSkqPvT1Xnmzp/kwVAET
	5jGmqTIk8iHdrm7z7doj2ADnF1Hxg9ur1JUVCSRrwseAO9b1+uW0+zF190kDtqvXkj9GAJP1KFF
	qJRkTwyX5ZE7WaG081XfTjNSY=
X-Received: by 2002:a05:622a:64d:b0:4ee:1727:10bd with SMTP id d75a77b69052e-505d22c3b2fmr26287801cf.66.1769767156666;
        Fri, 30 Jan 2026 01:59:16 -0800 (PST)
Received: from [127.0.0.1] ([40.76.117.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d29aa2sm605620185a.35.2026.01.30.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:59:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
References: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: fix kdoc warnings
Message-ID: <e51b5870-a0a9-7965-1f41-23226cb6d7af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 09:59:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/21509881155

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e7d299bab1af
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1048865


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
