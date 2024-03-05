Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150626AD8
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640841; cv=none; b=k76aJ6EpPA08BFALCl0sIa1gp9+b9OEIWogbI8Y3aGu4oyUKkZCgttFrfktDu8IaWfcQVVYQOm9IcrfZ5es3r86U46uhaTlkUEYcijf7VL8dxVEJ4vF0Dd9eMCnA7l5Z8PXSLKZbOzKpoEZJyUOt3rjfthqC6KPPn4zKCWPOA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640841; c=relaxed/simple;
	bh=Z2TQXx8+iawA0dFgT3LOO7Mq+sebekfTXmYJ3DQv2so=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K4LguKyL7oKr5VC5WGNMvgzOMKx1P7u7+SEUDFs+/LqaoDxdYi+2GtxQeM24Nl4Mk9FPL9ltINtfUzqN3RYRlhuEnWp+Bbk37Iziv58rAkailgpRjBPCUV/Sl7JDXV9GrDBQy1eZbkoiLYNQr98zSSpQuc9mVU1rWsXh/jqA588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2dK7SDZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2dK7SDZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7881fae7208so32193485a.0
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709640839; x=1710245639; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwOrA4SMk4MsvJBZ5DaGg5aqoGfeAgR9sKTAyX2K+LM=;
        b=i2dK7SDZzIB6Ng04oPwK5Pm2Qz/j/rSwfjAonE2XmHUP4OE6JXeTJ9dznqCOcpZjqs
         xuvji9bgxIxw3xrQmaaba/gX+2jFKDpaXfW4e3UKARXCxOKl8aK6lxd1gYVuIoHsff9W
         +DNCp0Ve1yt1kwRSS2HBu9xr8dSoBoXN2j/f35A5tz94YXE1DlTv/w3OjjQvZt9BX/qh
         V+w2ZjuB7rhk/k/kKl38b5n8E7J9ZZvxeQD+uvuPFOfq3X/vIYBPRBsHuetoq75ajZhU
         +A6OutyplKEqzO+6uSTAfZiu/SObrnrq+ihLuzkE5+BLmy6cK0lligNcp8tWZTTHaDqF
         oSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640839; x=1710245639;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwOrA4SMk4MsvJBZ5DaGg5aqoGfeAgR9sKTAyX2K+LM=;
        b=WvszaF+iRxXAnPaFBAGZRgEacIuh80dT9na5ut8ls23ma4K3fwqD77iJQFOMde+tIh
         hAhaNS8iFjX3wI6upEBw1bcBICbeW0LcyzF8ocm+wh5nzdcWi17kHox5qKoVMYCLUfZz
         nl1Z62sdC4wK9FIw0MV9wVRakfF4d0nT1Fj6Z2LWtzQA1AvxDZTJRXf6bq3UiHy11AWj
         oMYCPKYHH704c3srnAP6l3gAcH+yqZtYrY1Vrnj4FSJ6XvAeg+3r7xR9zLRiiE4cq8Za
         RHyOROUOilhr6lSkyOdEA8IO22VCPMlYw74v7so16C614XzG83xeIJfY+JPya5J1h/bV
         OmrA==
X-Gm-Message-State: AOJu0Yx2AhXAXs8Du705FEi10wo/IFGud93IpKoSXUK1hD6I+ajBvvn5
	Gjm/1Le4ZtNTEVqfFfIDBEGq6xVogxQFza+WpDehc4KspFlpNuF61jiYC5U=
X-Google-Smtp-Source: AGHT+IG3btuH2kV0Fej7CEM9MvsDPFZ0kUkgJr4H4i8ImskorAsrptyQgvZ5lRkJ7qBvgPXfpJDP6A==
X-Received: by 2002:a05:620a:8123:b0:787:7cf8:dcfa with SMTP id os35-20020a05620a812300b007877cf8dcfamr1508977qkn.76.1709640839386;
        Tue, 05 Mar 2024 04:13:59 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.100])
        by smtp.gmail.com with ESMTPSA id h24-20020ae9ec18000000b00787d6a14d0bsm5413945qkg.10.2024.03.05.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:13:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
References:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <2200fca2-f041-a250-2b89-729ad37b461f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 12:13:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8155608810

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bccac410551e


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
