Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3022232B
	for <mptcp@lists.linux.dev>; Thu, 25 Apr 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017951; cv=none; b=PzAskeZJEWm7A10JEY3UJmR44HGFiGN9B03KjVxl12QloId+Bi5wi1WluJT+NTrvEfPdh0ID+XykhfOSd+x5sWJiWHExo1NFbxS90skJIoZ8wRYIvpcKItXVHWanZ7IgNxBhqhK0ZK6KNa9LnW85UTtJnszT0+x/ePOKnpqID5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017951; c=relaxed/simple;
	bh=IAJhhrDCgRxgsbl+NYI/k2BSaF+rt0hffdU85xTsFxo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NopEvTr0QF5511y49jvmeZPjSofzxh/s01LkX5jNXxCFSY8do6Gsb5LPicHxx0dfQ1y5R+uB9McVKjGv0S1RTJAqV7nNUpnLeJucvkYLGc/ZsT/fen2i525SL/KRpRCo7KKedUm/GbfBYLCfjgeuAAYZBw9KhvOYoA5ooCj+AVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG/OdCoX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG/OdCoX"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a04bae512aso3426526d6.2
        for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714017949; x=1714622749; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24/MTMXLlU1RBrDPf3t7Il6u5PaRzSeVpHCW50+Nudk=;
        b=gG/OdCoXX0WSA7efa7z9Lvt9qZgx74P6mPgNOdgs4ef/rx9N+jjM8yWxqdnWME01/9
         hGF5wXal2QXSHCJ8qWFmREPhPTmKH/2d8mrLPOdkRwWH3d8Qnk2ZYqgZwKekQwm6xk1m
         jBWljDJ8SgMuCrw1xRg5DB73iKsQfJWMSD5JX5NRGzvkDBSChPUlqU6lMrmXdBzwsXp9
         AXJR8mX0ZmkH5WblKXa1NCbbQfdx1/jH5X+gdlSwEHCQfAIJNLBDsKWrriZDXvyx7muY
         YuFio+DF579pNnms2C9Igvd+nUfcANqlsYKQOQ/rb4b6Yn16UkaMA88TEo6BBxhE69+B
         ux5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714017949; x=1714622749;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24/MTMXLlU1RBrDPf3t7Il6u5PaRzSeVpHCW50+Nudk=;
        b=mi9F7YCbrTLdurdcU7cIvgZqhxdBSR0z4bO4SBnREE/qeaAbvLPycjuInL+IvrPi+9
         bpIO937SolMdVEF/DXA1BaritX7psmd6cDlDZOBEpzN/3wkhPDaBr+YBX58HORKw3iDf
         aJR70BG663oHIaRMi3IPoOJCShlC5sCgtPoBBuU36JNr6dnYQ6fd5FWGCEua3rfoX8ha
         KwEgHLVLRGL4XsMNAlGGHbKRHd8Esb7CF4HAd7YzmPURzNeM3KzYMAgTrPAAq664DKZn
         wo/QKcAI2KsnrE2IF9oB73lP+OqFftTGy3DvKRr/jUuj0H4gTuf+oRAjS6ERERoPULCS
         s14w==
X-Gm-Message-State: AOJu0YwuHgSK2OiuF67yaqsuL4pvdM0BYJPsUcy7YA2Iy6hfQqpyc8A0
	7PTFE0a+GkxQOq+NzceO2dQgXm4iVYPoa1py4bMMzp2hprkJdQHSaOx0
X-Google-Smtp-Source: AGHT+IEmrJC6tjo4eChVM7P8VyrLzP+qPaqqBjG+4FzZxHLOnrwv8JJLpkgldxmqlAcUMY6GkrZFDA==
X-Received: by 2002:a0c:e0cf:0:b0:6a0:8559:d137 with SMTP id x15-20020a0ce0cf000000b006a08559d137mr5496948qvk.61.1714017948954;
        Wed, 24 Apr 2024 21:05:48 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.14.240])
        by smtp.gmail.com with ESMTPSA id w16-20020a0cef90000000b006a05e9bb2easm5821340qvr.99.2024.04.24.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 21:05:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v9 0/7] Implement reset reason mechanism to
 detect
Message-ID: <c2774c7e-a51c-d05e-4331-596c32dd9d1d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Apr 2024 04:05:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/882658=
2727

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6c65c8973587
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D847691


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
