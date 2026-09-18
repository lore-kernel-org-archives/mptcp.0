Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BE4B66E7
	for <mptcp@lists.linux.dev>; Fri, 18 Sep 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721910; cv=pass; b=G32fzf3u2wWDsBD9gsa7n4PFDrcFwsSSYAWgwlw/CydFIh5DKWUaTAyTC6G3f/wsBq80xWQ9vY2inzi64gLOylVVrQfBxqbVmDRki/fRQHHil+7hGvxVAZvg0kHPhr04U9+h7p/eNoe+eI+bvnezQTS+LRFJfZMSk+cloSccsAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721910; c=relaxed/simple;
	bh=z/LGpT6R/K8MuCc78kQ0Sm/cv5SuOxP7TUqRkIH5Dhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZ+kUL5aGzHk+ZPkHMQDiQcUkY+gt2rLP9Zhd46fek2cF6g74nVeqqTPCiODVTckRdscpOORP52/AjQm/nucYYdYmo9NV4TGXtNNTsXR3TClRp460ZpOWnLLYJqPkSyaHFgwuHC0rL54IYfJuhFNzRaSarjKskn4naBx0w2rgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzise2AF; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzise2AF"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb769ca02so5943771cf.0
        for <mptcp@lists.linux.dev>; Fri, 18 Sep 2026 01:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789721907; cv=none;
        d=google.com; s=arc-20260327;
        b=NMqOhyPuaWsQ0rM05OH1P7CRxOjMoRAyB8N/6oHV707VkFVB5u8KJmjMnxdENqzTlg
         gcdvqIOM6PXnpF4gSv7iMMmRrl3PeHD+jjuHbgG7xJZ/ibaYo13YMGiGPUifQD+slTea
         1lZ7TMiBiYjZxtlM+yYq7qke/w/MqgBw5JnAREbItPM0n9HVYSWjYhZbQGauNzGj8LPp
         Q+rmTV3iHJNH0qVRkNq5GjifqiOqiWzZCWmD17OOzJTalX4vZc20fuPXfFa115KLnrtf
         o5JkOfoGfWoAkif/fC1aHeAuLQkLH1DlHa9Bp4hXh6iiH2dSwxuxduiAWRGYMM6m0QyR
         pOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/MZzkn17IcrulH9WLNQ6p0tJJzz5hdqmt+9izhYMovc=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=EQp6n6RqW4U7gCIMR8xbpujPwUcxZJaNsvebERtt01U39OUzbA+VfgX8fdC966iska
         /g9bAKB7jMksnlGE2OxlLkTnh7DhpXzM6N05mQ4u3m1Cz6IK488M+7xxTLyuE+YcGuoy
         8G9Ysq/2rGOodaTKsZ4wiZNLBszKesJUf/7Rt336TB7/YAgDFDOu/OQKHqDn4QAGUAXy
         esb3pwG3Tj+RD/1GhXPBqbbX8v92upXA3kijWHop4pPWVbU72LUXJBXt3a0vk52MQOGf
         jfDKiLRDnYIH4VYZB7gIVBh0VieLSSSM0bPiQUZtZzWQSLoXpFrWEdLYtKZS2Sw2q75j
         XvWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789721907; x=1790326707; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/MZzkn17IcrulH9WLNQ6p0tJJzz5hdqmt+9izhYMovc=;
        b=kzise2AF8KYRLZwkHfS35DzLRtCshoNDIEmWtL4M6bxQkAZpKpX4cWxq3Eq/XXKU3Y
         PCTHlGsc2dAK+mUp0thZN8izuHot36cJMzngm9VdFngfatVkp6kGzn3kun8CCsCzy5BB
         YEy9rFhhvCXXQuj0ni3xik6VCnblKIH/L43ipu7wohV1GXz4QY0bcUvfVgShZvxcYQoy
         92CQ2ajhnVKCnPGj+ZsCOCqIpR+hTsVoaHto20EZeKkPmGz5eu6NJ7WnPxC2IRJ+mPuo
         W5ewkMGbKcz2YY4EEvSyeEB6btVP1Y9B5Y+KgAHgmyPQZLxzg/sIZSG2vviLKADCksZW
         AIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721907; x=1790326707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MZzkn17IcrulH9WLNQ6p0tJJzz5hdqmt+9izhYMovc=;
        b=VNDGySHvGjeNC5pOF/doLRJpNhGfOu1UpVfC5fmIiwBpgmH8XhODN80+BlljWEcS6S
         WTep/0lTYiQBhLoTyonRKQ+Xs9DvfJ9oAodItQarfMdNwPuECRp098zWKuxZwfSz0U0J
         hQDuDJ5STw9+pNq2ZHyLqp2/p8O8DoJdE4nGW/rllRZwBOls/y9lIsxU2hPKrFZXQIKx
         kkmCe7ymVzinxV9CqvkJOcfWPG9M6qVoLj4wcgsqwFanANDumTzf0QcWvLOwEuaYF375
         OEAo4emFJ7Wm2IteEx5eNqN1Rtk93Et/ajrFA4SgxAdbckFwjmGG6AYxpgQRuzgxpVdC
         meJg==
X-Gm-Message-State: AFuF++msixkUdZ4r11vGwedmsrcclufpIOmmsuQf2HmOXO/L0YNIH0B0
	6ZQ/RP/HQ0ynekS3dRnizxqA8zwEnqbT+Sdi6/UFqqnLh77DuGIEOhvHvGPULy+hJnpo7FzUme4
	iFDgd3PrdqvTlwV2JsoT+2UN1vpbi9fM=
X-Gm-Gg: AYBFou2YXnfzqhcxze+HZ2W6mmjLrFV1u24qM6PoyicCoSzMiTKKWtQwY6IPhMTaEch
	ZCIGRhpjjFyVQNBOhYpp98QWhMRXagLXl9g+JWi+fqVeLQquBSusG2SGaTa0+obiQrQod4g8W+v
	ArtoLPRxirAsMq243Yy6NU6i3eCRI8aRxDqzqsVE44S6Guz7zJHyTLZyKKv4t4R4Mx8QXXg5KIZ
	CAbMk/KdYWvf2hVYNSaeimvBlndSvVs6mByRHlG23292nM7LFlyAKWDpF5m0fu7XCULvh1ltIV+
	E9MFH+YGGn45T2dZK5tGUmdRJKdF/1gi7GXwK5QlUU0VlnIDsqRlBU0D
X-Received: by 2002:a05:622a:c0e:b0:532:9adc:63b1 with SMTP id
 d75a77b69052e-5329e4fc776mr27603961cf.66.1789721906984; Fri, 18 Sep 2026
 01:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788800732.git.caoruide123@gmail.com> <6cb7409a-4be0-6d9a-8206-ae38f5f9eff2@gmail.com>
In-Reply-To: <6cb7409a-4be0-6d9a-8206-ae38f5f9eff2@gmail.com>
From: Ruide Cao <caoruide123@gmail.com>
Date: Fri, 18 Sep 2026 16:58:17 +0800
X-Gm-Features: AcwNN1XEzkUbY-mMDGd5u-fMPWn5ioVOnVWdZ7uOiTBEO_3AFp10BhNUXTVrINo
Message-ID: <CACveakSFCFOrD6eCpV1NNM0CXhW6NtTELm4DzBoMezCxQJLJyg@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] mptcp: fix request migration ownership
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

A brief follow-up on v6 of this series, posted on September 9.

Patchwork still shows the MPTCP series as =E2=80=9Chandled-elsewhere=E2=80=
=9D and the
netdev copied as =E2=80=9Cawaiting-upstream=E2=80=9D, but no commit has bee=
n applied yet.

Could you please let us know whether the series is in your queue and
whether any further changes are needed?

Also, the netdev Sashiko check was reported as =E2=80=9CCanceled=E2=80=9D:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788800732.git.ca=
oruide123%40gmail.com
while the independent Sashiko review was completed with no findings:
https://sashiko.dev/#/patchset/cover.1788800732.git.caoruide123%40gmail.com

Do you know whether the cancellation was due to an infrastructure
issue or was expected?

Thanks,
Ruide

MPTCP CI <wpasupplicant.patchew@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=88=
9=E6=97=A5=E5=91=A8=E4=B8=89 01:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ruide,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
> - KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
> - Perf:
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3425=
5318335
>
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e19ab209=
91c2
> Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D1160=
691
>
>
> If there are some issues, you can reproduce them using the same environme=
nt as
> the one used by the CI thanks to a docker image, e.g.:
>
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it =
\
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
>
> For more details:
>
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Please note that despite all the efforts that have been already done to h=
ave a
> stable tests suite when executed on a public CI like here, it is possible=
 some
> reported issues are not due to your modifications. Still, do not hesitate=
 to
> help us improve that ;-)
>
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
