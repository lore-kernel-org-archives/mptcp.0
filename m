Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D617868B
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085889; cv=none; b=Rxp8sBfbhHac5poy78L11wWE57nU6hMsrXGGD+4gZI3bnMdUERDZrchCYvVyRJLfftMptoArtwCvW87iLMgAhxIeXMrybfB5/c5iAPa/2+TtHVxJArXyfesU/OEEmnkHPLXCCS9Fd+LZPoZU/Wn4xFH0wmpTVkwP8T6WpCEpTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085889; c=relaxed/simple;
	bh=bpKnS+2s9iMnc8+UoVx0dfSOROPO1lR1Up3i3GkScKU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r/t1ZDegsZCHKL2a98eCdtq1O6Calb55fODogN7Cga9/GR4GFon6jHALhG3u7uN4HYyzDb0mFUCIbtLG9y2PRTjMdmUoAuQTa4tb0N1PWiddsUpIWU5G+xLFE8c/YNJupbJEfTeySToD68rglg7Nt7qLQhzA/q8L6T4KWyhbiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGMf8Pbv; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGMf8Pbv"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68f006fe28bso20354946d6.1
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 04:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708085887; x=1708690687; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69KMwGRockirLEVEquGu00XFKUJ3YTLY0gG8cOOnZRY=;
        b=bGMf8PbvfdjQpvCZKoxct/yDM0ERiHbdNwhTutk0tGXi+0d8FDmFcROGW/ZNyvq13Z
         OoQnPCaXdLnHOxGu5FZMvg7tr22OVhu3171yEfR1OE6s/3hU5cJmzXAAmNmZwCmQbQIf
         wEaO8+AFQDPPIONkVff9XxEUPAjs/VJBXttivBLR1gkuty3jSgBSIbt1YnXCF+x9lBSX
         n2H3/gOUyzvcXtc4rUBjd5HVpoQnFkqessSzcHQwF7RkYtIyN0oufA/ZLGNla+ikx8zU
         hVRP14qobuH0Ko4+SrUQs1oBErCJIBpoH3cmMMROH1SFFHrcMJ+HZZ1ko95offdCX8/4
         tvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708085887; x=1708690687;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69KMwGRockirLEVEquGu00XFKUJ3YTLY0gG8cOOnZRY=;
        b=MIHUpXZPYoW0kZbI8blsUuvEs3ETGYWyHnB7Ifph/UEFQqKI/8619/fgUMTEgZwKRm
         oRutSYUDIvtLXhK4wv7JncQviyxeotQEA8t/ef7Lj4/LDloIu0Uzl/xt3zETqbwN+0wC
         qerJ0VBVo+MEFLkWhrE9TAs1ADS9kJZRBHCqpfQ8f6wzTAB8pNhrU5YQG8/IrIDCwPNb
         AHmMI92RIEXAJ6JFtTUgd6Ag38J1aYSShsgu51TwTDIUYIaWy2ltntl4gQ1Rm7Tc+vuv
         pftIUD/jS44+yp59OABBjvPAiRzRcEF2moLBMEIhjgMwoavYvtzbrD5iwixLtLHiehfI
         zMiA==
X-Gm-Message-State: AOJu0Yy5m2OebIBHDunuKIDSSCv7DCIBT+81X0PqZep7FGFijuWpQMwT
	JUp5lEflnij1W+cyEdcXuiMRuYpd6jyxrYMd1m+L2U9G4GYatz4=
X-Google-Smtp-Source: AGHT+IEIVS2+0IBH9UeIumbXaeQxTBOeiNIYgiuPvw64CSmzhPaEgPrbsUKQgA62LiAXMQkLVWtXRg==
X-Received: by 2002:a05:6214:5d8e:b0:68c:a6c3:d399 with SMTP id mf14-20020a0562145d8e00b0068ca6c3d399mr11936335qvb.30.1708085886777;
        Fri, 16 Feb 2024 04:18:06 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.167])
        by smtp.gmail.com with ESMTPSA id f14-20020ac86ece000000b0042c64992b92sm1480430qtv.57.2024.02.16.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:18:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
References:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <05ef41a2-b0b9-3cc7-96a2-3b0d1c96df90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 12:18:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7930042401

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4601bea9a9c5


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
