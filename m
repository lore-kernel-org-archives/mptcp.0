Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616925CB5
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717562; cv=none; b=PNX4pizn/TEHyCCCGpfT1ejpve2T2hxeYxlTq0xzZbLcbmatbC2MPfxIaDAW2EO1F9pefeTOvl9YpYRZPEV9Fh1d8lCc9sTyrkUl7+Yy3Al7uwqh9CS/rPNH98O+9N7BcP58/JdfWtmElw+OkxRxieF059cjxLl+OhuGh7GGTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717562; c=relaxed/simple;
	bh=p2xppcrga49kReTUMZIpW6hqHRUEwH7Pu/CCVzt0BBU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZnfNNPcqSgj6T4xplkRcDppntUGnZnmhJzan8TkVbqd25kRRsbpZz3pkEG/v3UnU/lOl+OVD4aK7aAMoIFe5HctCCehBWwcs66uR4Z60iPO4mIzogQoN0PkvRuB+0QsXB4QMqWBzbHjytGPiXCI/W67d6D3HXKzvcR+IvDmgk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBCN+b+P; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBCN+b+P"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea1189de94so2168869a34.0
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712717560; x=1713322360; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEpYeHJweiGKo7AuVKZkbVR0ocaQW6Dd1lr7lMuY6Uw=;
        b=OBCN+b+P2LqZdHT/FO9uB1JZCgOOgiaN+uhKE30vEISDq1HTzQrWFv7EN6mDWH83Bb
         Zxco07MoFNDoIwE0ZautyViGiaPseCZFFFvLPk/KaMXgjjiO7uc7ZI2+CHB6p1ME0126
         jSW+dpD54i2Wi2PzDOxUlqG6rBQgvXjTTjychK9IjCyQtbG9Yx2wVXnLfYcIf/KlV+vy
         JHEHUZlaqTCnjY3PAnrFB2xSbLS7RB1gmS58kce2GFnCFOCRJs0b9orRojtYck+1Wc3o
         WaO3aC+kBh6ZQKxF89fCrHmufRl8zC6U7OMqlh6x3ocEU2Y58Dm9wniX8p48rItmo4h6
         2E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712717560; x=1713322360;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEpYeHJweiGKo7AuVKZkbVR0ocaQW6Dd1lr7lMuY6Uw=;
        b=kI2KM0u+eHSxFmONQLajU10KDHKbpGms0zvPEuYOEdVUxjR64XFWDxRgnoYHRoW+ty
         FqHbYhHcXfS51Q6q4+qzsjXBD3Ehvzk6L3DcICzSgmTnJgNohR9uSyr14NBKGQVNlHr/
         0skvpI4GrfufzexeV36ZZYcU7MqM9UU7ylDSgoKRlC4O2wlWYoFcqc7N/4udplyMJGs5
         CI8Fep+wdpWo2y+YVa7a4ckm82x69hh0Qil+liUoPLlVAUc7Jv5sR67hFUWNuvrnl4wx
         COiVEGUNK6tMTVmF/fhe1oLLgXCPYLwbfNPOy5/Y56wDRP5J/5M93Hil85TAfEyMsDaA
         GqSA==
X-Gm-Message-State: AOJu0Yxk3wkXjB60yWFTTlHIIATwB/Xr+75V3u+8h51KDniY6fWofPdF
	9hYqFJuJX+Zorn+DQJgm4l9J3Gm6fTrokCwZmw4FdxcSm+2oWlippEOXu2c=
X-Google-Smtp-Source: AGHT+IF22KeuyRMaY/agVAKhUJbyO2OZ373kYWn6HIb590aFrdi6EazYtLvI7bvItmyIMFx+UYegFw==
X-Received: by 2002:a9d:6e8e:0:b0:6ea:1fa9:82bd with SMTP id a14-20020a9d6e8e000000b006ea1fa982bdmr1464908otr.10.1712717560313;
        Tue, 09 Apr 2024 19:52:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.27.68])
        by smtp.gmail.com with ESMTPSA id 27-20020a630f5b000000b005dc5289c4edsm8890010pgp.64.2024.04.09.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 19:52:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/9] refactor mptcp bpf tests
Message-ID: <36c076a4-72d6-4da3-bc2f-9245f0703fc0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 02:52:39 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8625025591

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/af9fda70e97a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D843048


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
