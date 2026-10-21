Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583407;
	b=QlkWDY2zCtuxJ//DAGnt+e3waA6HshhYpavyzK5SBI9KuSOA7vyKWYME3uVAEKdnZ6/U
	 jVFXZhLwWC6CXfbXoU+Md33R5DAQJ1LRDySrESu1AEsiK0l3+yoDwkCir+Zv0daC1RpAv
	 JkDoXvo3OStQwwUmIWzQ0yfpBdr7Ona6yXpeoTbIBQz03RXK0ZQExe+JLwuiieUdtHGMt
	 ILRvQyvMhRK75bfLFhNoPpw4zH3E4DmxpxPxuesLNEfLT8iEHfJd5HHTCOU5onGvs1nCf
	 nqoYWI7vgL3i6yqLgwf8j2wSks9hgI/+GuUypsao574D/dAjXGig0iSh6GumuStOe5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=HHSCqZSFOSsy772JTMkKMYb15m668zp+QoqbfYPQUHM=;
	b=S4w/nc1KvedvHr3QY19OCzfM+BI3jDxnR16ph3qeKAcoDL8I1vgR3FSUmrPDJkVUFeqz
	 cvNvxytCCGEKYoKDumV5lKQE8/wFwp22KUwBcPVVPkZXj46ZYd11/2CEBPo+RxTuiIW5K
	 WzcA+ACFIMStyhKN/zr6cDhfpXeDv4/whWNIxRVnXo8jykxMHc+Ny31I0vfAq8MjXY4Ku
	 DCeR/CqH3J22F6hNm4mwpfR+vlorvD48HreNCGIZl1uL7Pdz8s+vBsnObjcrDcQaXTxmC
	 0GSsz9QitQSAiu9Zp9CItSmZh7gfZPUD38OWgRsLia+bfE56iTB6I0rAphByDoQZ52w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o1ALx8ds;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C5606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 11:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA3C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o1ALx8ds
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so723255a34.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792583405; x=1793188205; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHSCqZSFOSsy772JTMkKMYb15m668zp+QoqbfYPQUHM=;
        b=o1ALx8dsdWjBEj+DfUFI61fsmYHTPpcLDlfIbrqE3KSOaPSHIl8R6LTWI3dmScZmFe
         AuwBzTm7yp1OyVJ+dsPsIgZwvLazZX4urg5Wowpg5VXoezO86jv4HRp1GEnmYFrrL8Zr
         GhIr2P58oq2Kz31ayW6rHsTeclZT6KRSQ5GyZ7oj+bWTSOs3ZYzZoZRCJDs/ce2CyPRJ
         jOfdrKKQo8zorrrYGfNwru0RikqH6MLSNFs6jG9nEqHYkbvCKWN8Ew6cKUXV3cN4f/4E
         EndApIbK2hKCbFoDU78UwVj+vyGgyLuxxSnrC1ATquPa7rw3HVKHRvKmVUX7cCDBfmFj
         94wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792583405; x=1793188205;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHSCqZSFOSsy772JTMkKMYb15m668zp+QoqbfYPQUHM=;
        b=m9ePmSHKTGNgjJvuGn8aqb6hGn0WkbDC0MkFiUKAUGEVMte58fc6VuQIP6Dx7lNOi8
         Q967aqOGSV+Vossg/R08L/XLqJ0EyTAB7oHzdfw65pC3FWvEPu7o4bDb/OQ5Jyd13wlO
         UlvGYV5XeprGMTTCDep9LEPVr4mM5uaZPRJqmyvVJZQXYaQ6GprvGuzn1uhn5mSV6Kbu
         SBgZ/JvKGnUQ3g2F/0Y9e662PIQiOTd4nCiMSl/NyP3ReV8Eu+En5EF+fC6w1BpeXR9c
         AxTmoDVm05ktPHHWpflGm6oVlSrC2vdhX1zUu+xKiobq2OZVS40qDfEULe0BvcXKp+V9
         jLIQ==
X-Gm-Message-State: AFq9FYK4gUo9UVfGl6SiBuX+bNbvJVqTmAGS++28YkME64T/vxY5lKxQ
	9EaLcbkp5BG7IpvQOpYkiDTRCKLYSHJ7I05hvdsC066Ah3dpmVrm5EA=
X-Gm-Gg: AYBFou3Hy5FfvGk5bhDeuuO5S/jYEdHvoKxUwcz3lGQn86m/+bEgUtU3KMBjB1oYve2
	zFLNPwI1fm6VFanfGbSADd8NoN0jbGN95Vomx2n/9IrguxkNIQZNu0pgZfkGvDToxn5cMXWLJF7
	pVbGcJ6TJgPMTvV49QwfxDiinStzLiKA8uEhgOBss1GFGW3ZBnUD4ArOQK7dQ2Yf1CD1cFhhut4
	EvzMTKBpv9Zdg1GZ8fapQG2w77BBr3w4m/Q6MhdmBF8wlRjWJ3jGqofscrkiAnz2SUVRZTyHluw
	DJsxfOdHYsvhwWOHM5k3pXFcvTG3W5wXpj/3JZWKzV+EGHINjyTjHMvrBghCIpVZGJt5vgJKjcO
	R20abiGZHBTpVxWubhKgUZR4rAZxm/d6ej7lPTZ0/lzq5146pLJEAiDhZIQXXE7HbFcstbYBGZd
	oBkINx4xKAV5jCbccNfoxW01rZcMLl8+nEjAci8UAV7Cpt/UODTR2Ltn79w/WYU8adYeZsGq2qf
	u0TsnVSbrgd/yI4F24QfZ48x4g6UOd3Sz3M0i4NXE19DsqPDfAYuYGTEUauCrNpv8Pq+lM=
X-Received: by 2002:a05:6830:452a:b0:844:4959:e854 with SMTP id 46e09a7af769-84d07f098a1mr1117331a34.11.1792583405509;
        Wed, 21 Oct 2026 04:50:05 -0700 (PDT)
Received: from github.com ([135.119.95.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9afcsm2047654a34.6.2026.10.21.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:50:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v5 0/7] mptcp: pm: in-kernel: retry subflows
 closed after an error
Message-ID: <db5c847b-2052-7651-0c1c-9e2442b12f2e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:50:02 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39578295986

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/993df1c70e0e
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187487


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
