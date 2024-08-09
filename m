Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E9191F7F
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199906; cv=none; b=agoHJaSqk/+t0gumrraF7q0TRcmsOSRB5gwIgE79dlzQnO4e4aatgYuk17wEnMeiy6Z68aHQ0nunD9QRGdk5RyCcvKtOdrKounOtcE1ZMne4UvkS9nRZNVjElfFAs5+H72UEekRtys62JFRSqZEiPdS1uKvo0ATBTHwtOoP0WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199906; c=relaxed/simple;
	bh=FR7q0MXZ5LNWrJgGneB5fINj7OR+CbsYMnoaa5cOfG8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IyHPWu6infu2ZeyBFCvDTKPMUfV5EbYAbyMnZ6mV7stMv2kJcSMCSdvH+8cyaQXWAc+hitBrVXwQgQRR+i9G2OiIXQbxpq79QSlZ4TKZJn6Qj0J9BJ3klHShVRbWO2OF/YG0YSKDUxCs7kBMf20grrb39M3SHO7xERJCfTP68T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/flk2AD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/flk2AD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5f24d9df8so968991eaf.2
        for <mptcp@lists.linux.dev>; Fri, 09 Aug 2024 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723199904; x=1723804704; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQjVFNB+58A3qeJCyd6HFlXOORpcHyO6DiAnJIb2R4c=;
        b=M/flk2ADczoG8mKGQKqlvZ3SFIfqGppnOywTLAKnaRmq5Vp8CHEdnIBbC4hPF+MscK
         wmQ/fHtl9Z/7EqsDWjazRUBZZIXAKDeOJJgf4SG7jS6vpVEC4RpH5fsnvAe+pTmp26hm
         HWcvLZU3zIZG0ioQ3OvO9ffxwavUHfy5x8HXI5buQntVS8lFr/MIxMTIc9CYl49zm+j6
         9rQNITr12YUMwEpsHmWksLNEX55xS8MpsdFxkQ+fU7Cjnn7rUq6bp15N/eBoaPLFTr6b
         qWoHbdB7IktZKJyYxx9dgzqmyMphVKEMTjph7gQD08KbJS8vXhDzfI77FEezVRDhKNxy
         L91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723199904; x=1723804704;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQjVFNB+58A3qeJCyd6HFlXOORpcHyO6DiAnJIb2R4c=;
        b=RPwO4b5MCUmkcGMo/TwWx2voeQi7JY6S6s2rt2JV822PW9rMpQOxweheOsWpbQIrCi
         CaJE8TvLa71XhQYb2xYGdVAO44x4bePK0/Rwh/IFchN0VvRfmK82TN9fY9cBFMEylKOY
         ZNY0GNDT/J/EnOB3AsG2s7A0mzkz14n42yJdWaKL3zBDJ/CDjBPTyh7Xybxx/YXBgY9K
         bT3+D2T4HLbnsUEK65awepxflIYeZ75PJNV8BakQKhTYSkT++ViSZkQKgaLTR199RHFV
         lmOU4JIBVMq09wBC0E8+LDhytm/L2tIvA4SGlthPl3qLHrN1w/GWU2szySrqfnzQg/77
         Ydzg==
X-Gm-Message-State: AOJu0YxA32Sn8HSnsG6gJoOZEwjsCQuzYgDCQVzsor+zeg8pzUc8qdz2
	pyDrIB+xHLa9shOGhX4/HS6XCK7FLrnZVuE0LdMv/H1nLsrBMaE=
X-Google-Smtp-Source: AGHT+IF7mhpBlmwonFImGBSfKDEajfj8yVnptZ5tOMJ9nTrZoLJGoysSMVIIqAANYPaQcLugr1dzYQ==
X-Received: by 2002:a05:6358:2905:b0:1a5:2f55:c46e with SMTP id e5c5f4694b2df-1b176f2607cmr106993855d.9.1723199903715;
        Fri, 09 Aug 2024 03:38:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.207.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c868b5asm75618016d6.117.2024.08.09.03.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 03:38:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240809094321.GA8122@asgard.redhat.com>
References: <20240809094321.GA8122@asgard.redhat.com>
Subject: Re: [PATCH] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved
 size
Message-ID: <b0310187-ea0c-980d-0fcb-267731cc7336@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Aug 2024 10:38:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eugene,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10317353849

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f842e648d7b6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D878144


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
