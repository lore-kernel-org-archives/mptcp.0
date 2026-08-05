Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91043B3C4
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942741; cv=none; b=FtPDHolHlUCPF3hBuk+mE6W1wHcTqkqRZPb5Gw4lEpEOqjHhVKuHt4Ci163M17eLIClBGSqx01eCTdIrLcSzlQdYcR5PIQEgxjEqA0RzLrPi+z/Kq17/e6e5/PS7ZoWXwY58vknmegaqBXc4H+jFPk5pji0W1T+Wfg9Vy1PHtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942741; c=relaxed/simple;
	bh=vaCSGwCmCIOsX5GHP8GwRIsW2FbV6l7cNI/N4JgLOi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=i9PgS2kHOL1tvxm/gDwihDvB83vVH3llMic/jqAhmRX0VDVpcokP1o2oa4kz0NaAtEAa7Z6CUCk76er+gkisW19YgeL2KwQhD/QQgALApFi+gid+ArcPPqm/o7uZOdfLb2otY5+AKuM6lIv7+5hErPpmxf0wIpD68chkaGZFHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCGM4k+F; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCGM4k+F"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-499f6e0bbabso712729b6e.0
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785942737; x=1786547537; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+0vHLsLqGwg17UYt4mZSr6FSVU5eiP68K92yFFTBxk=;
        b=tCGM4k+F4pAMooID6nWEk+I6M6/wqz63CYKIUXTfmAj30oytTaRihfG5D8KQRi50OG
         MzepTbFGeg4YmZn3/yT3KhUeKqB0pITTEgfP1iQxf1XM6pausFVeJkLbb9GQOIVM5nPi
         WM5h3i8ts5M9q/JMQflPrqMd/JqZXkgi/M8+PBcss3+6dnyqPbNDB0lbNBwQoESjEMtt
         CZ2NFzdyQAj+U+DnY4+DiIIlW9PxMrluIQmn/NqrtMU+Cfz5sh4WTfb6tnW7hQmK5U/1
         r7ii1OdO1IF53mdXBIyG5t+3WRRemzYCMH9/x29DBJnGIwPlDnWAiK8sLjEGoAmDKzEq
         lFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942737; x=1786547537;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+0vHLsLqGwg17UYt4mZSr6FSVU5eiP68K92yFFTBxk=;
        b=s4mcjL3c6de79VvZF6OfUkDB/pGuBbo6XtvrjfoD9Po1ByxZInlw1BTD1DOrmJnXW0
         pl7ZHAIBOILqym0tADSC8U/VVlClwIAQ+kXsqfkhxnHqnR9PPH90GDCXCpmhRMt/1IZa
         BOvjdTq6Q9F1br32WN9aHZMU3o98iCh7CodZnMTtA9lTzr7hvhTAlTSsACkUVPz9r3Rv
         +Jrwxk5alixwobEhFYHwr4shG/St+umfj6ZJz9YceE2kunmeiJVJa5+ioV/EXr/+EixE
         ZD20YCPS7NNTz27MVOr9rpI6pWPB2oh/EKF+b4QP06gvV75hwW5tvAsgoyuJsQuWQMEG
         rw0Q==
X-Gm-Message-State: AOJu0YwFildPiES/e5ypTaP/+9wVUfqZAqxb4xBIlR7i3Sf4+r1UNzHF
	7WYGnSZoTG3PpVI5Vb5Mvn0KxRyRCfSQ/Ai3eyMvY4AhPZEhOji2gbA=
X-Gm-Gg: AR+sD10+nSalh4GzT+o19gG+IFEab7TnrRWk01SrtVKAwawB/LfirHnMRq0KxGRpcTr
	3Bj4IE6tG4EzMxL/yDSlmg2pFmTsAJat5JKUZLGVQs+MGQ29GoXYHUE4/FvdwFc8JImeSu/feip
	3yRdDJx3GZTDLOlcj0r6VEgGHepf43MOUeajEhxyS/4hvjRCghyv0lZ0rNRmrKXS1Aqr/TD12Ry
	fo0UfXAuzDUC7WDcazrhftPpg5jWNhDFNDAL1Oov6eTC4XYbAdzmsmGWyFglp/Ho3uDlWyV0Mh2
	ixUvBaWYMG5zxxaxvhmwJnQbsCtIEaKcvLFv5OhFpFB/g+h7P7Wc/EyCfzJvxhMdGVBs6e/1NJW
	coqxLTYQjkgNIr1OjWv2jAB5veH8War0NnYwWsX6piSb7YoLd1hjypHZMJQKBy9zGzg5tvYH/3+
	kilYY+WbOzfgEVfKLCD8fK+vr97iS4GDjMMN29srJpbYJQCvROfNVBv3wrpxvv0fz1WXab26PQA
	w==
X-Received: by 2002:a05:6808:c196:b0:4a4:adaf:5576 with SMTP id 5614622812f47-4afaddd82cemr4180489b6e.4.1785942737141;
        Wed, 05 Aug 2026 08:12:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.140.115])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae7583eesm2198015b6e.13.2026.08.05.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:12:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org>
References:
 <20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: reset retrans_time when ADD_ADDR
 entry is reused
Message-ID: <865dc5cf-0db0-d7be-cc33-75ea695b61e6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:12:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310152=
86192

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c0750c235b43
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1140834


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
