Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1E3E8340
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629137; cv=none; b=rBFm6R4UyvGQQW0nI+Do7c3jzKJpyjk3pUEF4eO/c3CmVYp+jdUI+zPl0gNbkWZ8l0ZsvH4u2ELUcId5+s6rpIE1Y2tdKklQdqFV40maNFq6r53Se6FCCoS4LWFHfVJyBuizPo5gmextu1J1XeRhuqgJAAYPeYXHGDEbr2g3Q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629137; c=relaxed/simple;
	bh=z3kvYvrWfjzuErTaf+vhCmHXUKDAA35Zvh/joZo6PmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PME+/tVJQ2gi4EHUkA/A6D0rX2deIgVaNfPwK09/T6hlLf55VTyrktNkbidtG5H6ztgdk1QlQdMHnWBnCG/GXtstCF0Lm41UV75HVO0kIOOmopA9iOF08r0goEvOWNEA3xRWUJJ+6hPGtyEQreC3PJRyX3KYCmV/Tq7l1iY1Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9Tnq1vd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9Tnq1vd"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848743155bcso17210b3a.0
        for <mptcp@lists.linux.dev>; Thu, 09 Jul 2026 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783629131; x=1784233931; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3y0rmvYDoDH17tB7iBUHQJAn6IlEpSIlNbTk3qO2Ts=;
        b=G9Tnq1vd4cZGkweXr2BW3nD0A1dN6Eb+4eAi7E9u8DngB4qHIGY4vKjNpWzw2eg89S
         RgdeiScDb9ax0WzgueA7K59YwrvDZ3z73vOEE2lxzF9DIL89fit+S4r1nkqbIKMNDVqM
         tbptToqp/M0lU0OeaSTOvOt83AQpEBGhXOSk15lOdTKqtGdzZ1ZIz0QT9K0L/rAmdtkN
         4Pa/GLKfCCC+d+Y5+0pSlyw+eIjlliUW1wubemZDiRIkJAbAvb+7qrUF1qTPjTaf+muH
         dV29heZ/XkNtGCDauW5hL63XjElSNPiDxq8OFVgydnGrviwXqbx0GhXBw+log14IEvjd
         2HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629131; x=1784233931;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3y0rmvYDoDH17tB7iBUHQJAn6IlEpSIlNbTk3qO2Ts=;
        b=KMv3HdD+T2Z81ThY3PZrIIl1PPQ+ImPtLtYKvQmqvcPLhYDVxtqldNM3UlEJl8o633
         dRDDD1vruZM+/kpLh77KkEF3d6KbBrI6Es0njzC0GyPA/HjPhGwVXwb8HlGvdlydU9dX
         fV1lQh9GEbNhQAkJmPWPTIe2rMkS32MkUBvS6KVIVmjDJm3C2nH1wsRDUUiHPRTVb76H
         PP5uPKprtiyIE1MKwz2BcteynhxpCnaXSahzcwqYKkjtHhP4shPOW7hAEh45cK7OJRvs
         cXL97RMoXgSEyoTO7Jy9y3n1r4rta8zzKq5+8tfLnc/qAed03CSCSd8MwdhFCuOZ5rPI
         ulCg==
X-Gm-Message-State: AOJu0YyZy04s0knggXseJ7l+PDW46H3bE9ITKv4o//beFqo/HNZc0q57
	PZurA1LAOiZAr4keQ3G19/5Ngaqy5OQ1SFhjFxUipOU9hKEY0ACyswGCGxgE
X-Gm-Gg: AfdE7ckMH1dqOtI+LmWHxmpzCN/3lSxi/+XF6iQZ+6iADAno9UiOMN4uzpD9VEQ09xh
	Ik8O3SoeNwdo+k04FjCeJ2v+mHgsNA96hECWD0WgrJ/yJcv5SKOKXmaAliKRgJY7sKoqI4JuFUV
	meWJbFQzf4Gkl4nbISstUjWT74EdKArWWzgbC1nhfpnSeQJrDn3QSwv36HxPjGvCrysea1SOnFD
	SRVQ7CjNTeedEEcapDD7SXuURVjT9HdEIQmRk2cZbUZvuOr04CAuQ8a59ZlkajAlLhSaHi7dsFv
	GpI3/GPb3sytkBcOdIPemqbaWYAUU/cRyQ59isbK0FJBNhX1XinAXaR7laaZ/RajCvti49Qnfuv
	/6K2HVcXxuexNYCJZxZpL1je0D0I5RvQVa/BVuX97J2Z7yDpqYEU9kBeHHptfZeHDO/2mMV58af
	bwhT/9mBT/OexDL65a8WRsBlg=
X-Received: by 2002:a05:6a21:7d04:b0:3bf:6c08:2b2d with SMTP id adf61e73a8af0-3c0bcbdc314mr10426301637.53.1783629130572;
        Thu, 09 Jul 2026 13:32:10 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.4.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm33232324c88.0.2026.07.09.13.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:32:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260709191925.2811195-1-michael.bommarito@gmail.com>
References: <20260709191925.2811195-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is
 present
Message-ID: <d8057758-ed78-44cf-0c4a-1a36a7640985@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:32:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Michael,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/290454=
44726

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4b439011e567
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1124929


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
