Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1D18BBA9
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592694; cv=none; b=SwZY4ZiJCp9Mu7pBLYeBg2hjKK5p/DKNiH//KWWXirzgNlA8l1wX6nUeFWUAhdU1GnuTCWzljxbCx6eBd1sp7VfdJt/WPm3SOgn3UmJ0MZSpqb1QUIJk89Rn4hPNHEdqq+KJFwkbSNrHqbwLZxR+frVFSkj7J//8B80tCC5pMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592694; c=relaxed/simple;
	bh=WOuqLKOigc2kEpG/E4h+jBRCHkwbBBcXleo97P31Vy4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VUto+PAFENaN+FIM8v3a2jQ8V3wKU+vQ/aJjfdGQ0DoEXYK/MpQEs7ZZXtXAwkoPn2PwsFCVTFZHTX3OXvLV3ytVdNN140imoLka//692+kBZaLYSRrhGhvJiM9+PKbn6Wb9YQ/8XT31omJSeQROod5IXwdnovTp8BfGGpRl6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnsVAUNL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnsVAUNL"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d487a93a5so1420005e0c.3
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729592691; x=1730197491; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32S6Gw9AB6cb7GOLdA6ZnvOIklM3/+ra83ppxvc0JYs=;
        b=bnsVAUNLa6Iljui9sHSHdVODH3FnRl1NhT0clMPUPGr+yZ6MFb81n1QyFVEcFsKUDG
         soGvVV+UgV7R1vRYlbF+js0b5gegU8TZKVSuij0/EuEHYQd4fFLa3E2Vj1Tzk2vKYlx9
         icR8BWAtYmnp4w1ebZLDJ6GyI7xQSPLss4dsu8p1UIj7n/IhqwAuFA3S5EQOCTIGberU
         R8xoAyWAfCesrA97eRyXx/vr64/fzcxrCQOiTM3pp+q/IvbY94L2fkZx28CM2DlNFBnA
         luJOP9tW8paa+1iWfAGpTZfQqCOHy32E5LpfaukmjtkqqcoATjqX8XHhPXZBZMfSuIhL
         WfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592691; x=1730197491;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32S6Gw9AB6cb7GOLdA6ZnvOIklM3/+ra83ppxvc0JYs=;
        b=fAgL6GITPp9uFWmZuwxwZmjSLhtM53RX1onPkl2sfX2XaJ0UW0xkA7YnEJhnKDRb1y
         54dNKMKTymlRxvVtzssObQrob4eleaujQWRECShy5cmq1EbsTl5Vh61JPUROEdUrgFLT
         i3Q2XsbTJbXLADIw1nlWiYLB68nqAc6Ds3jpL1C+ff7JSE3whAfFE5BarypQRdsp0AVx
         LrVO3iaCIh3+Mv3Kl/+fDj0dFNlZd7Ri5Q6BVuddgQQJJEa2yVxXureBinjZsM3TZmrn
         i2ZzrReadA98Fc2ncALGETOD5obGXfT2lFhQu0VOOP1OmQ3QeiwP9m6ITgiBQMhbRbr/
         FLwQ==
X-Gm-Message-State: AOJu0YxlGX5GiAFFc+hykM0Hy1gN2ovsjJcLMZ6VMjlWVKNI74SdaWHx
	zQVfExkIUGVMaMuB1xCIkWBbYAwkshXTvDBcG36RNtbcH737n8FwzJzf518=
X-Google-Smtp-Source: AGHT+IH7ocPvD78E9RR1HAXULhns+TM0L8MoxJs6/zfBuZgvcl1g8iiVaAejH7U7Ymc/oV7Bn1DRiA==
X-Received: by 2002:a05:6122:2521:b0:50d:74af:d480 with SMTP id 71dfb90a1353d-50dda1bb590mr12168092e0c.1.1729592691325;
        Tue, 22 Oct 2024 03:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.86.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a0347asm263816585a.59.2024.10.22.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:24:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/36] BPF path manager
Message-ID: <6831e570-f8a0-da79-a52e-80e02d7731fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 10:24:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/11457329343

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9def5a043f12
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D901761


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
