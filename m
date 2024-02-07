Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E5F9DA
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274188; cv=none; b=HWqSc5Pw77RiLRYo5htXF2loHjwPpJ4EFV2SYgZSVigCZVcNTw3qyfgr2/U7T6y4LEIjrI2JOMaiJPAzC7CaIjgSh7fAEmGjaaP3FSwuywSQl/YPzitO9ogiRfGjT/VicfzNMrXoCVK/y+4TQTUCAOigLpvNM8va5pfJevrbtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274188; c=relaxed/simple;
	bh=dlQjt1cK6u3NDqM+hXlBRHFAXgTbieXB25Yr9/KHlHw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oG0BNiOmi+OkYXw9ByrztXA5seUlvY4P7S3j0+UEkwMHOSO5/+ym0YC4m2NbihF2qagOi1fXFY8SZ20V3hOht8HqKjB5Ae72vxvuptFRds5BKGn19Ak58SdSBNWpMLSVo0Hm0Vyln+E8kTuUoJ8yGzxnNS5+9q4lQ1Khfnl+2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf+Q5Pdp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf+Q5Pdp"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c4300518bso790556d6.3
        for <mptcp@lists.linux.dev>; Tue, 06 Feb 2024 18:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707274186; x=1707878986; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2RlrJPCY1t+W9/HXZoLCvpKYA5Xg36eAio1tOVs4NY=;
        b=Bf+Q5PdpRsU+xfaOpbatnAd/bAQZTUHh77ChozR6G3w7FQItYqzS3TtR8KQbilz/zP
         PzQYy4bh2RR02wcPfs7A0i2LXKZQleHH8wvm9BGtquVQAx4v0dGAvdffdgBQHqzQ67XQ
         B05oVEmw5OdH/0xBq/CF0cWPmKTlmlCQGeJik2Pxj7qVutp5vl+8Qo2tjLKyFKGTrjef
         ar+o+NOgPZU9Wz9aWBSUG3pqSTHv7TV7IqQnNYaKe2x2LsHA0D31tOBpBo/I8L+DTLci
         qtUs0d7LahRrP8Lr6qjaeDu9lpHWYIv1OMOCJrVD7rH7OqrhfNiKcQs6qKSF5EyVAZ3E
         Ydtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707274186; x=1707878986;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2RlrJPCY1t+W9/HXZoLCvpKYA5Xg36eAio1tOVs4NY=;
        b=T20wKXFikVweoWmUy7A9p0p30uR8stYRl8ptkGfFL8C+7HfrqjR7sxl/7be8eveFKO
         E8bBCQRHhT9BwBiEUqQAg19outynoEP2P3bCQVdeSL0pZy6XgAUz2k2N56wTNfnH0NIi
         ZvZR93SXVU6zdIh0jJu2LdQZhn90tV9td/BK3EMtBhpNhMssBRYjUCi2wY7MAIHWhaFv
         ntjg3QCaa6WcPGzJxXYBVYO2wOPsQWrYfxo9OIG7FuF7HYH8XN43DjJ1/KTRy6VFQcEo
         fbDxvPXKMiRBNw6Nbp+L8vIQlOwGbPEGndCaBdaHddTIPgQ4ZjaFRm3O5Ztw3SIEcz9K
         WI8Q==
X-Gm-Message-State: AOJu0Yw+gJ4IDTHAvrvtAFJXn5kAjDUgqH7oU4iOOFinng2/fS1RGtI6
	zYLLpqeHwyFZC6jO0UavGS6uR2NV3ZuzJMkKyPb1h/UL8jUAkn/LShTMbu0=
X-Google-Smtp-Source: AGHT+IFoyUZBBA3eNp8Xzu9vent2bWhUhaRhTQeHwsaiAeAEfPTNCF1CP1eMkuOKSiXd8uxXsJav0Q==
X-Received: by 2002:a05:6214:c67:b0:68c:aecf:a3db with SMTP id t7-20020a0562140c6700b0068caecfa3dbmr5692185qvj.26.1707274185657;
        Tue, 06 Feb 2024 18:49:45 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.32])
        by smtp.gmail.com with ESMTPSA id ek15-20020ad4598f000000b0068c6a8256b4sm138993qvb.71.2024.02.06.18.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 18:49:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
References:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <fca8bc8b-d3e6-5c83-a1ed-3ad4bfa4c002@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 02:49:44 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7808971609

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d954c612ab76


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
