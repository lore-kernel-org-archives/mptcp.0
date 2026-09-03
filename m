Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E03E3C68
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418095; cv=none; b=ckrqaiCGqe45mGnhpk6mxcHSBftyEFm7SG/9NCH05V6tCetqCMUKpJINavCGwrDoxb78lUptMDV1DA0b8HTkUkm0zgqrVR44RUuJg0j/SaZ3GBvP+Bujl1bAF4Rm9kE5Q3VaVYuO+8Qf4PvESbTUPJTCuJJ6midtlt5YyK0Wu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418095; c=relaxed/simple;
	bh=z7fQyzQOYtzE3xJwAkIBMnju+kT3bincVk45Oaod6L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Y++Z96EehkYLhMCSOMBnwKB8CxVjvZJS00Q37BTkv8FlIfYFASniqFH3nk8B5t3QyaQ5HH2f7dntcAsPPUzvDE9eDHCwrmbC+v999WuZvuYDdclJlSZSmq0/eaGEeQ6YlRRsV5DPeV6FmgK2CcQJ0CVFNEq7DBI+lwSkan7lu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBVFEWxJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBVFEWxJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-853e2610bb4so491101b3a.0
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788418093; x=1789022893; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AzwEbWVMmybtadAdbHhoTfjlCf4cR9ewTEj1jI3D+Xc=;
        b=bBVFEWxJcIIvvf2xTN/72jsuvmXve/nbatEbV7QIwkN+kp71LPXqL9WdhJWLwFRis1
         cDXA2+XGyotxL5uB9/Uh6rfXtPlt5wfJbbFzUXx3H2pz0R9jRCCMaPmLCPxKFo4yQBF7
         P/mXN+lxo6iJZxlXRXDBH9gui2mq57i591ZHlP8S7m3XEv1lha4spVgetotvzCS+FzvE
         Nf5nziHhmHLWH+FxMsnB2pxt2crk9h8XiWvq1EiVr30lrfk+QZUsi6tZHAuX7PsLBG/8
         zhfVew52qJZWdO5018FRxF8Or36W+lSyRxgRAYrAhwT1qGGQqX5SyLNwQkdAaGTRpEW9
         YsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418093; x=1789022893;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzwEbWVMmybtadAdbHhoTfjlCf4cR9ewTEj1jI3D+Xc=;
        b=Pjh8SbrTaCOpslX08h9QyJLSK2RwCvrv35gWF/RW/W72vOdjbRiNUcEVgY/TVAYwZK
         K+7BSbK3YiMTnN8fX7a7v8oBq906PZVgQdQAqk3IOPBbfRlkmRlkDmRfGG+DHuqDb1fT
         gEO7mb6NsO/G5Xoea4l+ep2hSQO7n220QQbM67HKCvyPw01TJGxnoyFhPkCfw9JjHCWH
         CbVAWjP6UWjnK+gYOcVRkbUO7vD+EDWp07ZWEUJWNc5VJ4rJ3fuFx1PIGwvTQQckb8oQ
         83oa4Kexh22I07kDao6HN30E27ttLORjEpsmged/xzcM1/AEpgXclljwYkxNYwzVk+Bm
         5ycw==
X-Gm-Message-State: AFuF++k9PIlZe5YKHE7xBwMWzM62R6vbNTVECbOkxDMpy3ey6mWLMzCC
	dWjMkxUUz6zND/81Fk/R2c/VEWSNVg9XSPV7+TAkn2BWebKzaTemcAI=
X-Gm-Gg: AYBFou0EOKAivweZ8ECLhgW0eJvLzGlZeEXQJ8r5fFOKWKD9f/7y9X9aCKjSXRjctRA
	+xlzExketx0XQn5J07V84dwuiB0MZ/RpWJQGdUxJyoIc0mN86GpZftgTxhVVAlBtmM/kGgHy9bh
	F3G+3e4IPD24+XKLNVKa3MYLcZcjDY6BT2YOBywTztFg9CEfohu+jcTHZ0KZUWsH9IA3PY/vL+u
	Fp+5zH8AebkUMWPOsY2ueCTVvmckjGZK38pTxLtsprUfmaYkN2zm6UZGkAMfVJbvj3cDfVX2Hpk
	WHvwRJE+kKbJL4IIQD+omDgoSagVTCQBZ0lio3ZCJ8zRLevrR3CmYT0CWI97iTS2jq2PJmuA6KW
	OuW9JJJvtjd4MVrxeEvuxLHPY7Bs4eXLk+KmmsAw9JSXeohOLqgLSXoE2G372oKW7wGE1RFzkGH
	m83oIG5q++4sTBlZXcT86WKtxieEcDSBpPo5kIdIcHn+lSTZT7h/pPvxr8Dl/WJsYnKRYUTw==
X-Received: by 2002:a05:6a21:645c:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3da215a6dedmr3726732637.14.1788418093354;
        Wed, 02 Sep 2026 23:48:13 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.4.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534c50dsm3744317eec.7.2026.09.02.23.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:48:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com>
References: <20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v4] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <5f1a82ce-7c05-494d-9e14-0160753bd81a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:48:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

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
runs/33721505735

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d7b6ca0c46b5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156691


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
