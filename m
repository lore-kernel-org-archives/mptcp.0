Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED06FA8
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548256; cv=none; b=Dse4mVkVuFQ6aOre1A1WTV35tCjQ/BCgdQ7kNmQD+UKpizuLf4iIH2XK0wvfolNIggzCvmZ3fO8dtUafVw+nB+9bj06SSOGxOKpRZlEZ5H2CK4TjIJ/XfEZSFBVMvLiv39QkL7TVm1c8ZB3r7fonqFccTfQhHDdmSNN7BZZEkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548256; c=relaxed/simple;
	bh=XbSsFyAxnRwBUACSCeJeC8+W8dg4/EIV+vxXbSmuPas=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mGYAVdIF7iV2SIVy5NvD+A/NTqRvKbAF2HpVouPF++ahxV1fczK//4pdvxxuIzLbvXrwoPo3eYod6+XgEKHqSDabkt9oOh4w6BD1ogdWqZR120aVLkY6K9c6T4A7fELSQPwaR9lqSI31Oln5v9aEPOoRDoKKyToqCI6/Mx6G/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noW8EccM; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noW8EccM"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4346e50ef62so12576201cf.1
        for <mptcp@lists.linux.dev>; Sun, 07 Apr 2024 20:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712548254; x=1713153054; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwl1dCiBWERYggLjWEoMSa5UgmocyQwP5OQ0fAmy7xk=;
        b=noW8EccMd12eq2GFSrHI+9CVf7ysVeIMOHU4j8fIhGr7yEJH8JWvpL/EOyv2MoJL4o
         Nf9tQpLDKuATyC2rv6Y8/05igDDB7gB7OgqoVbAeJQoUtOq/BjrzK+5LHHa4lVtoVOGQ
         yDPHIi6yXLymg6CfyJ5Y5YuZ1Ioj6NycOwujmViHtkk0KJHsQIHmjURxd4JdNScqnyd+
         QP3a5QamJk1aJl3QMVwYLuIRMQhWqiOUBDdqprLOR91FYPP9hJDrJuLi+OnPTS+FMzCh
         KyPTOx0sZqkH+GKNOAn9fol9287brugR/r+U9ng2EkWdeU3OsGcesYfsTtB8HFKNH6g4
         wZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712548254; x=1713153054;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iwl1dCiBWERYggLjWEoMSa5UgmocyQwP5OQ0fAmy7xk=;
        b=m+ltCxZghwBtzy/+NOxL6TAn1JHAniUgIDF+FTNhPMiHCWUYeLtGobCmq8sw2yNg/c
         mNq9GPv+xOd3YecRb2Yh3wVZC4K7csA8V7W996c2olDCjEeoUhas5rkYivsJ+MQGQbqK
         WzyIFD056QRsnv1f1ks4rZq/f6n2o1tgSyJ9hAviwfJS+W+qzX2iuEthZe0eJlGgc4ak
         qKbHaMQ0zsnj/BVg47ZdE6VwrMGaewGjEfbjJT8umAUt/L9M0Sat+IYOxPpGEkxQedNE
         st+FzZ4lwhJwkgie097ASFwl32APZSdFIl8VKDcirCcP92Bm4YeiZnDeWfGYKU1Sb9ln
         oiFg==
X-Gm-Message-State: AOJu0YxTUfdALqStcaPob5aSPM46HUZ4aEQxYuLcMdHeY0nHuMlR3e/5
	TKRDP4tRuoN8gsEz9gwnTNXhrQZvtLbqNGYKNwX02Gk+IuiubfXKIvrbFXM=
X-Google-Smtp-Source: AGHT+IESQdF93yn8OcemVAJwy4Bm+ocFbKgkkA5BbwFFvcT7JpaLP9nFfqtaSKhOONbJ6BieWvbf9w==
X-Received: by 2002:a05:622a:118c:b0:434:ae42:caef with SMTP id m12-20020a05622a118c00b00434ae42caefmr1182700qtk.10.1712548253827;
        Sun, 07 Apr 2024 20:50:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.163])
        by smtp.gmail.com with ESMTPSA id kb4-20020a05622a448400b004346fed118bsm2150805qtb.28.2024.04.07.20.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 20:50:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/9] refactor mptcp bpf tests
Message-ID: <80a3315d-4fb8-8600-5f14-b637bf8c4cc9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 03:50:53 +0000
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
Unstable: 1 failed test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/859404=
6045

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4cc30b99d13
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842249


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
