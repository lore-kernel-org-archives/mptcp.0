Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB278F66
	for <mptcp@lists.linux.dev>; Sun,  4 Feb 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032885; cv=none; b=Ow9rH/FwOpTZX9UYAXtz31flx1Gfvo5vVKTmmlrbgwKR151jy47ESRrhPI/0wbDUXpI7SzLBlFI91IVR10UvuL4f8PKwjmOivKgGX2RiJZ9xc5V3jL5vYYxdP52zj4LPvv+UGeOemBMY5rXiC1Xc/fNBvvbB0R/f/JLIgyqbEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032885; c=relaxed/simple;
	bh=VxP7XCLR1b45w6+wRAl9rX/kM96IshPxw7hlDwnmUUY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=t/lrD/ie/fdBQqV+4IlOYc/dbBdrSbjrZ1CjsNUqWoqxL+7/Xnig1eu/zQGLKtyMIu18of8HVmVLBg+qgEwfjV1suB5odG8YZrUQ06/tCDeF+vuuuk5LKkR5W1vErjSOFd5H9GyR6Oh/6DsJxZJXZg/mdwLU5wianNfSm8f1XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDseBa+R; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDseBa+R"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7838af983c1so273257185a.3
        for <mptcp@lists.linux.dev>; Sat, 03 Feb 2024 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707032882; x=1707637682; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQGNB0xbA1D+C5eGJzscvCLnaU01WQrRRzug4T6fvEc=;
        b=nDseBa+RMUFZsTG31CKyTWJqZlnQ5C8BgXwO9aDRnt/lAe1HMkb/O7rEWFrOLO7VUu
         JtvWYcyASiBpmT7/MYNH4Ba/LV7zfkv0g+UogTwBmDC1Q4vdocM3YxSMV0VRbraw8Ft3
         QK9MQVTJYfFzjspEh/RCI5ChAtnmKfAZPLW4f2PJPYA6/gwqaONKxJ29W5J8adMrd5C7
         9VVnX6n33eGNJlP1Z6H01yFQ3EgJtoFS1wpNEISZRIiZtr0i2YZqVQdQLUiAVy6MhUeY
         RXO33qJZn0YfzsRA48n7dZPmTdspr7KNWw98O6oDtvOCoueMsJHsrufbzrhKDcm8zsdE
         FBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707032883; x=1707637683;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQGNB0xbA1D+C5eGJzscvCLnaU01WQrRRzug4T6fvEc=;
        b=Nz9t3PMyQ3tsSRiDvmfd75uE739LA4eyw+cmvKiknevISP6R99IZo1j3gDC/lAfZ+h
         MSDn2KptajyUqlTu/uz/WBawjVjSf8PoslJaqhgTAnX1SJ0nnXSkYXBArzm+Coo1WF79
         KTOwhOtOYVvdWo4Ga7K/dRAEG/jEh8f5Sc6sP/vJhg7CPUqLZBpYDGjU9b0ZoDJCzNmz
         cKtymVS30w0/+afaF1e0jfStfFNbYtSuIS2UVl9byKgUsZNsK5LYLpkjtbPuPA2wufxy
         3nWHxkp0hwu3K/yRb24WSldr3/iPKlaQlL3LhSqRBZPRKsRkyhT+EGDbLSQJxkNhpx+f
         TK3Q==
X-Gm-Message-State: AOJu0YwnhXmHUB7wB2t/2+a79ktWOZpMuEDrrlk8PkvB/tcFCwiDsZsn
	KoiBpbM/748D6WABODc9+Dhc0DNMyej3de2XaTu2Y5Pb+zFhCLAzucek1G4=
X-Google-Smtp-Source: AGHT+IED4YtMbynTvQabUVpxYC41Vv1DwGBIbAiadlx91JdYvdazg77gqGAbXSK0p86L2vMA806jNA==
X-Received: by 2002:a05:620a:439d:b0:785:7871:352f with SMTP id a29-20020a05620a439d00b007857871352fmr1686194qkp.41.1707032882732;
        Sat, 03 Feb 2024 23:48:02 -0800 (PST)
Received: from [127.0.0.1] ([20.55.223.226])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a0a4600b007840a08a097sm2009588qka.76.2024.02.03.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 23:48:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <40b390e09ae6003d9dc3c571ae1c5185597e75e3.1707029682.git.tanggeliang@kylinos.cn>
References:
 <40b390e09ae6003d9dc3c571ae1c5185597e75e3.1707029682.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <1f17f84a-4df2-a4c2-3d54-5e0903414c91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Feb 2024 07:48:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7772=
406927

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5d55ee6769d9


If there are some issues, you can reproduce them using the same environment=
 as
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
