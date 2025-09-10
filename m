Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A75245005
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503231; cv=none; b=M+DqZ3tSF/mbaqZgRwad+0kw9zpWOwATM/dbXPxT7GIxlsKaL/QuSR3BLFAPp2Zn7TCtOx9P0jNdpQ1sGBzNRPvlvjKIxjw1yH39O7mhEpIG3TKwmazDxOxVYdnpLv3nKUT2w1zakMNK8PeHDETD4v2kjq6dPFTgfUUlfptTWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503231; c=relaxed/simple;
	bh=AHOgiQEaYXj7eTbeLMCicKJNUy0zFe7UISIcxnwbniU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FR3XsEHzjKe0Gs+XOmXOv2kBtq9MknWwt5m/h8PXuQnVjftvmRSIxONi1k1v4MtAmgQ/LJ2Po4rs2UbkpdyYPg4J5t+TaXZGkeRYBaTTdBWlK6GtL2bVEOVRTUyKvOfW17muBazAHNU+Ym3D+6/DpYav6B8wzwm0megH9rJFqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAh8MQUe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAh8MQUe"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b6304714a1so1291711cf.2
        for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503229; x=1758108029; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rDtsBCwnLkBArKkbL+RQV/Ab7+PBZZLDdHJk4f/wQ8=;
        b=LAh8MQUexPsb2eFKDW7GCLjmmLPjfLaj5mgRSExmFXxAUkTn49gujSfurB8zvSA9wD
         7uFJ61edNPXrmzRunxGMefS4TGX5l9jsntnpx97HHlaiBO9L6h8bSl4mJvb67NkCWyhO
         SXlYcJA2zUrkcoz9XTzwaN7GaT3vh616Vx9h95nJk5jPJQpvAH/N9XGiSMKn6am7eDLC
         GXZLPo/bzf4wGDFgYSb3imCtPLkJ+2hLJOqsKxdMlgSesAycMSFJsNdIIwHCASp+Nit+
         MtREFCTOa8kAJqtQ2iJLr57wbyJ7AhnUtfv6+2QTyDUcdXlZiNFI6IS6HT2+rEtQ6hQp
         rOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503229; x=1758108029;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rDtsBCwnLkBArKkbL+RQV/Ab7+PBZZLDdHJk4f/wQ8=;
        b=crCb4OIbnVQm5zj6iwGnc20QEv/7p/rRtOm9YY93llmr3KgpRBfvjoGVka8k68sPVX
         08ncfgn98Q09yhlcXWfvASK7SU9IQgS31W3E49OHaLtxLDnsApdOToje5bk3Gb8RNF7s
         peHStrVpHWiciIfCD+7F4SYhyT6wnvuEpQ02cOXlbO0AIY19RLZYpzXM0XBcv9gfCkEQ
         zQa1yhB9oQwUfV2ptM7L67ootBDy/GKdTbmVFwk1DOZ3ssdVQPvwqflP7/3y1wSeHR/H
         nXqBLRMljmkzBem/y+3RTEUE4s0ON0LGLper/azLWmotQRoTezrHH3I2hH+V0u6R39QC
         YUKg==
X-Gm-Message-State: AOJu0Yw7HNK6YrYdCMfIJqao9zSqUXP+4YAuWJ3Ip3IOUWytGWyB0OGJ
	FhKm604AwPl1aDYXnabMhHPHyJ3rIYsIyu6Auqd/LV2ezwlGsVofvgg=
X-Gm-Gg: ASbGnct7OdRzz4U8XRTBwDW503w3l8ANXwsAiWobLxJRbJN2QcfpqNbnr4z1St+dcn6
	RiKyn0AtD8zNJlrBqUbdMy5QTbRCd6eX0t6KjJfuIM2WxeO2qIcAEosbh5eS6ghmsuCwA6Vz32k
	P8iINIRhxBp04B1OJAY2PtrSTmE2wcHWIyUcrPZxL0hCURDQZaokEZFjfR7jSJVuwFBpjUgyI3i
	EA6l2kLR1JfwRQ4Uhj2BU+mcjdEzYGGnHF9vRMqtWIq1vhQ2r2XAw6QBMGg42CxWbSZHnT00AGu
	XpbPYwQUOlbx+oJ+6MpoL2KgwKfJSggEEIuJ8hOKUoXnR44Egk3u9xbMLc0tfPxY9gS1kSPOrlW
	EjqEBli0hjFII/BtDubojnaTjyZO2aUAQ+GQ=
X-Google-Smtp-Source: AGHT+IHo3FaeqpJ7Ys7BqPfQ7ntGpsB44tym0uRbZQKYE2Xop8k1v/kgZc5rSd9y4GpS+U71ISxIrw==
X-Received: by 2002:a05:622a:5a07:b0:4b6:2360:2ed with SMTP id d75a77b69052e-4b623600480mr48408551cf.16.1757503229078;
        Wed, 10 Sep 2025 04:20:29 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81d97fdcc6fsm123409085a.42.2025.09.10.04.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:20:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/5] selftests: mptcp: avoid spurious
 errors on TCP disconnect
Message-ID: <afaa2b07-460c-1751-a668-a3696668de80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 11:20:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 3 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug: Unstable: 3 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/176090=
32414

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4c0b302d6616
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1000860


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
