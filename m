Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4020C003
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300504; cv=none; b=mJWmlzUvRpWdQgS1yabDIJiOBe3y5P9ol97dzcZafvC4Kbp4gQnf5rMdBYAvDcpRU04lWLjpK67YYkET6efvKtrjmTnrGBY3HpDHnGCLXg5BYw50HXDmhJoTUsY5KPdr4PKxiynUVHPosJn/+0CVfINuzcih/IH1R5+D1jTlxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300504; c=relaxed/simple;
	bh=kzs2JI9OSQNx8bMylx5kia3pqgqHdfwswEicGb3HqNI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=o81A3OgFfN3DpxN50LF2ZzpB4IoeZlfPpOb7IJP1xPRaKnpaksi4ZOeB8YJx+HKZ9CZUe2Yi8dG/RQet9AZR5z0yvSfy//OPCOsoud/1zbFNsKAP3TydQUKZCUzkhP/48OwetR69u/uISmmYrOJ7mbwPTXfRRVMwxN0dD7heh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtYLytu1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtYLytu1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4766631a6a4so55705251cf.2
        for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742300498; x=1742905298; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJXSC1Y6a1KKwKxAo+tCPk8mn6lnwWKN2MIrwjcHN9g=;
        b=ZtYLytu1C8k0R+/Y/5kRPuz/py5OH/jlVVJCG4HrtXJmm8HtAVC0P6CD2qlOsWiQ1e
         oH8KkjLmB04n/3ZDYURRU/nJID747yYC527JQrhRGF+BDfw0YJphQbxwim64GIdAjPul
         JGjeSGaNQ4Z0UQsaazha+F1mQnIxrEqoT+19CzA//Yx9UlvGY3tI3F5tEr0VuiKH5lY0
         f6Gr3sger8wCaAiXLgcsMm9O2Tkhqkm5hcJjnk6iyXmMkiOjjTzRiitDxe5Q07yiNsxr
         PglfXylmkkC3fiif/qimDOwz06NB20BtNOEe+NSzy+RzYEYdhFk1bjUztMTFbcZAeu8u
         u62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300498; x=1742905298;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJXSC1Y6a1KKwKxAo+tCPk8mn6lnwWKN2MIrwjcHN9g=;
        b=eHIS+MOXeVNFq7xuACLGyNl/FNq/UuGFZp57nS/NLVK0VLmYIird0kOqzpquXMdpRT
         6CRwxSVMKHH0YlbcSdzKwSql0zbDeIKxwWsGB34fBD35ceCL/031cGah8gXCeyimUOo3
         iFqF3NYdGVZMUBZFyzpdkA49j3XTUEVHgSkHb1JeA1KnM9kIr0O7Mxmd+3CrEeYvfBe8
         3P/JYbiZFP5rPUgg7j07btlJrvoz7PfWaIijNpkzvTtrY3gM5CSfVE57F+QRk06zFXVp
         +hSzv5I3VHDtjEH4O/4S+aSnJfJsntcPNdPySPCfCudVoOXGCspBNdEJAbKvlcj0YaHD
         3cXw==
X-Gm-Message-State: AOJu0YzgNkOydEZPN1qYeCiUuah6Ha7UPoeUuS7vjmIV8hvUmbMDSj2w
	mcC2ANlQZm/azI+pm5iicOTSUN/fbB7rFQdWo3M8eoXInXpz+yIwOohaaA0=
X-Gm-Gg: ASbGncuH2xHF2c/0Bxs16C/m0KDAGcr19Lxnf+1fToeJDLVoFHGzQsXdA8L3E0HdNn3
	7801AFN6FjWeG7RsKS88MeGO68prxM2V7WKqkIYIh7vFRIhWNQEp/KSRv0jVhFPNfZVxquyvlbT
	v+rbcoSKy797m8IIXJ4fZwW+3GeGDXSm6t8MFP/id5CbVGpBbbl3WOg0+SbBl4oR6f7halQHkl2
	fUIRpXgUJH6tAu3EfCiB9GCeXL5IVZt8fEgU4D0Sg02zVinD0xevvkddq8zGxpAQDA9vd2iGLvi
	61vJcD5Tjd3Fm3l4h4cmTgEV+4uyzx1Yrew3PO6Qk8H7FBq7YsXOi08w2+dzkLFmfgs=
X-Google-Smtp-Source: AGHT+IEYZo8MOSECe2QzYnl/QjauLLPfrn+TG1jlkaZ7btJz3hb8jX3+tfBzZklB+SoNfMheCKoCfw==
X-Received: by 2002:a05:622a:4109:b0:476:7b0b:3110 with SMTP id d75a77b69052e-476fc983714mr54498571cf.20.1742300498301;
        Tue, 18 Mar 2025 05:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.39.62.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4770065d060sm7291551cf.0.2025.03.18.05.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:21:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn>
References:
 <59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: fix incorrect fd
 checks in main_loop
Message-ID: <94fbb5ba-cb45-6c30-ebab-a71d9df1bdaa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 12:21:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/139220=
99850

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/29c0e445b6d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D945090


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
