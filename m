Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A01CF5E2
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386466; cv=none; b=urnkaUkzUkvDSqE61GlIua+VOTa8Tvzc3A/vdFVzAKjpgbiBCdVGRgQga6f+MIs3wwtbx/XHwZAZvRBMmYvGjaQPxLeVuH3Lr+4ZnRnvKxqWOxUt7Q7nJM6TZLfQi1oc+mO3nmWn/6wg/3Ds3kuEoxURukXzsNu962pojE6iFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386466; c=relaxed/simple;
	bh=CQEecq6nIiGB6KI7/15nH2LqqKDVlxeRp/cI3nPx7zc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aMZiJGvc+LVr7tMKm0e26nH2UEO4IKIlugk981RH5IIIR+TrNlJBsUMoj07kuLIA+lNoYtmpt6Ef0ZVJzUnI6UavY02XODUCt15oa4ipXUCCwflePUp3TNaJR6PA9oKNCFa/IP/cqdLO/xypPh01wHLWkQVFVROGBA8a+M2FCiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d724geL9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d724geL9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215936688aeso5006475ad.1
        for <mptcp@lists.linux.dev>; Thu, 05 Dec 2024 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733386464; x=1733991264; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ZEHHsKPqw1zEm1SmGPBJNBICgPGqNOvVo8kixm5kE=;
        b=d724geL9BEQKya5wtN4OZPl8fvLKvHDgesnWBRqU8cEZT5EK+NjGNTrVq6xZFj2hFR
         e8gmJjl8t97OMaRABQWjcKeBHpDCXZuwDtvMlMY9AUgwR1C6p+PWe7dDtYkvaV62xBjX
         iFjiYzI5GJlAF1iZG4gF4hPYpLFrzjlD71tButLiMqm1nByrQ+i1ohcASbsQIY8cZPAC
         u4H60/Uy1VfSuMUpso3WzXGcM2lvpqLWJ4eSMghUkKZBOqDO4rTRP3d1H+WsK9QDCpv6
         tWMZIs92JH9kALJzLj+w25eHtvunTgsdbrimK7PiIs5QL3rgUxoEIkMCoW2MRXlbYQjz
         pf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733386464; x=1733991264;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+ZEHHsKPqw1zEm1SmGPBJNBICgPGqNOvVo8kixm5kE=;
        b=FC3hSzz+/qUbYbjwY7V4+pdmF1hQlObBwyxXFYxse8PKDUnwAyXmQO1Anc1O8ntO7K
         61vByGS32F7MfUVM8l3Hwux8EKmJTLeGuQZOOjEANvWm4H9dFKY9rv/XamnyTqSiBRV0
         cOc/BbOIHpMOK8C8oKm4P0nirXWjwshbBRqrqI9xXXTb2bT6c7I5eE5oyt/Mc1oeZhPw
         P2h4Yig/IchI40KOkBoBqbSA6MtGBeb0orp6PYVllqPMVg122bNiYX4ajNg3F0CQtiMl
         sI61uMb/IE2KtybmJnCrC7nv99fORCTDXXgRIJxhVE/TcAynhjLv6unbJrz62VIA8LGE
         FFog==
X-Gm-Message-State: AOJu0YzTL66O1SZlloPVuooPp7M6oTJd7h1e6VdqIpXFsGp9AqkroZ7f
	ybbppw5/MO2vUkGtMY4myztUiTbj8pJ+FYqtnaN48A6zIrnbuziKUM9f
X-Gm-Gg: ASbGncs/hb65CnC0opHdEsIWBYHt9KibnDO5+wC7mapMwWl/2fAMMknra7azHHxABbt
	y/qp+an6mYmDKI6n/W+mE38+BGD/AX8eZafIDWN8gbaoAMpr0hykMGOyXV94wqWWEQ8HOw/+N0z
	ARtc41x8bdytO8Eca038De6OI4zNBGiX+saAakuhhxiBYF1y4LM8A+B73TR6qym81HDnpkIICN2
	Wkby6uJvCZlzVG3Pczn9/hPAqK+Ur9F6gZEKYywyd60gcXT8pL9ru7j1XQ0Kw==
X-Google-Smtp-Source: AGHT+IGW09Cr1+SdI9PWfnn23z1ah2e/ijx0GeBgzypkTNwuFgq4VzzOTfH1Rj2VzI7HxWaAu+RcXQ==
X-Received: by 2002:a17:902:e80d:b0:215:352c:af73 with SMTP id d9443c01a7336-215d003e8a9mr107022635ad.18.1733386464487;
        Thu, 05 Dec 2024 00:14:24 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ef29sm7366075ad.50.2024.12.05.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:14:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/7] BPF path manager, part 1
Message-ID: <4de50959-ec08-4b85-8359-772675c99585@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Dec 2024 08:14:23 +0000
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
uns/12175193284

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fb1a4a4e6dee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D914798


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
