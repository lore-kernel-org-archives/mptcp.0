Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DC35A15F
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557755; cv=none; b=M6pD+tBeBQyI2SqRnEhKdWP+Ozxop4tkSrABeXLKFv4V69Lm+9Sj1BkzvZBaO9tHlhPGwudvSHbihWc51So3kPm+4wTa2OSqACKYh1RGC3i0EkcYUmwfuX04JgmKHmMj5MbIgAlWACu2KQqTcqI5Xdpp2om8NgKJ85n1Y+PYz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557755; c=relaxed/simple;
	bh=PHbSI+Ri77S88Il665t27ey5FJFHhsxLj947oOMM1kU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Rjng5EbDTzzT7FkTqc7oBpXCYKKbhbMBsz8ZaW8pagtX8NLEll/FMPG+ZEoOBoEm4pkuhJ3RX8p54/JYlpCgJYvqYnG7/gD69Il8l8w/qPAXQ5vuHKhXnFUel1uy2z9+G2jLo6UuB0lKZTMV7kAXVrR1icSZg6jTLJRzi9FC6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSScNT/F; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSScNT/F"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1fca7a16so27690921cf.3
        for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763557752; x=1764162552; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0XJ9Sq+iD4mVWsgfSnuxjz5HAaJiUVhx57GiCWjiuU=;
        b=BSScNT/F4ZPdc/VRVrLFpKtCgNOTAcFx2nXxIQbh/7oTjZDLcNo+fqWQ+gFImbC9Ue
         +P0jzFQAwX8oD3yJ8QPfsMgAEru9lduHSvokf9uWV6rz81nyxd2fIlWedLuE+dXL6xL7
         NxLmDZMppkfyHa7MLYuabUwxHDciH7JGHu8QoIAsGsSc67IVik8fCd/pJAhrzceynKi8
         Hu1j417zRxk227G80dxeDOSMYcdJKaJN35iHDc+I/H+HOq7S2tpT9kiApgv/qN50fzcf
         b01RkyXClIeDDwD05/OzvYO9uG5zqsb7RBuJjTwdOLJyZZnPT67uYDKRyJi6eHgBvbnE
         2IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763557752; x=1764162552;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0XJ9Sq+iD4mVWsgfSnuxjz5HAaJiUVhx57GiCWjiuU=;
        b=YrQIR1TrfAH2WH2eoA1M+ycOqRNg/7C/2QGutrVUuN/7I+e/Q3ebg0YiRTWP4wVAw2
         ndn3IeZbCCDrLYJ1WuhA8tm2lnyrj4acwHCFKBfLv2ykneTQUUsbZc3lpo08QxImCntB
         xaNaOdsN8EjuxNQ8skee1pDWdKiiE3+TYgP4BU6kNOUxeej39fB5eN5IsaT2tApQU0i0
         //0unm0lr+fgIEZfunh/4gxMuIzwbzPOUlj+/0XROCn7F/abAMXiGyI4Txl6yl7Ofx4Q
         QQ+T7TeOVIvCrHkHS+FIgskl+CA/I7vq7RHu0Wl4/NzyNAbmZL/SFwAF+gNQef2JuJwK
         hnBw==
X-Gm-Message-State: AOJu0YylmItl8E21LHt1NOTizpta6N6evGMXXBzKvi5vNW2yxZcszBeb
	8od+AKU6W5LohFE73OybtR4V9ZHfydiKVvAeqwuQfzO2daJlhmkQFBjKxvq/
X-Gm-Gg: ASbGnct27e3JuKOTI4JklIIUCXTMDRRpbiLze2gARLVJFrVRMt7RqcfpfAjTPU/mMnM
	aeyPcFLh6+Y9Cia6Ctw0alwiqKjTxkRsQvvQkvOyWmNZJeblutmvHs3CBksfzwKbRiRa6Nv2AAh
	sCh/SJI78RfCqEZ+Ak/FhxGZThffdiNI4tZE8kwWwU2ZiRW/TVRMzH/SN3VGxzFXN3AhxAK3e9Z
	0jq7bwqQzOk3tZZCO48PJGnSBQvcpx6sjcEHMd0DOZ/cO01/s2GXEvCdbQ8kb+V+HtCP9ngE7yp
	99jS/B0CWhte0/OWQEWBwSa2r3U/UTzC3CIs88AcAXfPRvQ1utR/oHeDbSHbXTW9pW6vriFnUyU
	HRClKIpoZAs+1WujjIJ/zmgZFYyHtxEi7GOrd3deWFnomcwgL5uXype/rCx4dHlI1T+oxVQ/Zx0
	gAZIdpMxM1SFK74MVEXKd/LV4uGzCnnkS3Cg==
X-Google-Smtp-Source: AGHT+IGF6OVa6rxIEKmeD06k36NVNcOBHoP9xo4ohCgugv2dMPDKFyuRQXxvdqMLLA+cMtd7tzJPww==
X-Received: by 2002:a05:622a:1aa8:b0:4ee:ecf:420d with SMTP id d75a77b69052e-4ee0ecf46abmr179878901cf.47.1763557752175;
        Wed, 19 Nov 2025 05:09:12 -0800 (PST)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b376dsm127528211cf.7.2025.11.19.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:09:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v2 0/8] MPTCP KTLS support
Message-ID: <03852702-40ae-c359-1886-981fb7d9fd98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Nov 2025 13:09:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_add_addr =
packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19498013524

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/554098b28764
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1025245


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
