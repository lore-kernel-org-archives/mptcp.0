Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1440E8E2
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668556; cv=none; b=oY9j6Ar+SugjmhM1V/zMv83eGEO34moLRT9ZRXgU75kFL4vyfxoF571mHAiv8rw2RGZW2G4L27LTfFFeUot3mCvgpsI1lrLYWNIOpVuLGPvz4ouxgsUx9JEzNDAvh1nUvc50ux92OfbS4dKxNMwI/cXWYLsFGD/2yUhHRM6fmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668556; c=relaxed/simple;
	bh=czrM8YuWiubPGoVkyxyXQlK+4ncMCbf+X/OKVehGEHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=TnWkAGFxNwoOq8BbQIeiuvXXiGu9R4giBjO/yeZEg6MkG218v0IY5FRomiP6XnyuNCw9bucSTFfH4yQoJD41ODNNzzLIzjqYKykF5zveQsScnWd2i1rd3Y33Nx3aPcqhFm8p+kPY6bOo/oXfXi1g1fFHIHqVqEp8QFqz7vO2RSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOfXUkSR; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOfXUkSR"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304d8362a58so1160279eec.1
        for <mptcp@lists.linux.dev>; Fri, 05 Jun 2026 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780668554; x=1781273354; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKX+1B4jgvpq9ZUPGO8naVhGN6XJNgLVR1QRjEZEJII=;
        b=cOfXUkSROrR82rvYtzG7Yu1SrPL4xtBhDiwjGvuVujJS2+o3nLlvgUSwsd4XWkraLf
         IijveyaEY74GZM4EesUKYUHH1GluC0DuK9tt/Iq3iogtJi9ODoDleQTSMJ52ak8whKgb
         Gp/rr4SUPnmDB8MzZAYGpJDTsTLrhNwKSVEj1y/I2ioMv6KCTrtpqJsnlQ72vvQHWDyW
         HHCKpkFtds98+UgbRmeb2Pan7IGaJ193soli0egOmxGEVtxWILdpbR4loYYuBTOnb2Pm
         bqbUMfs0pNjRiTQVtmg8VallhUPSFhKGtuFjzdnGwDkXkKqD0MQo0JY60x7NbdirkvkF
         tpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668554; x=1781273354;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKX+1B4jgvpq9ZUPGO8naVhGN6XJNgLVR1QRjEZEJII=;
        b=EIPPrKYI3YGQTsuSzZ2SfU/hvuVvUxYxB2PKbAS7kNrZoR0CKyn6sGpmQa52Bmz7QL
         Y936bHvHzs0I0sacj5310g3cTjCzP130CGOkDZABHY74dswPU/E9zsXjUckIZGwX+teV
         TJK+gspCQeACB2OjeVqBuXQWGxIpuZ3HN1SzL9bbAbrF5gLBYBN/zDR8otUDnzAaHuCj
         +jmusfA4eCJWXSGmUjpRIgu03r2LMOtePecX+2cibQoTPi8wjYxMMPtBezUoqDrBEAJm
         7ijzXZSAKqMe9Gx8o+TLc04rbzsH+0dm1zVG6auSKfg+/VNPvxkk3gdJd8Hw8QLvO7Tc
         P5Lg==
X-Gm-Message-State: AOJu0YyNqfKqnmamWuJowrbtKrIFpf5xYR7pH4B8zmjQlzdRopzt3r8w
	yPw10qFx/CQFjKnezW+f0migc0IkUNiQmUVzltYa8HrmiR5yAduImsSSRoBR
X-Gm-Gg: Acq92OEXoanfxNLUVHI/hQSEYpDOI1AjpmqZvCjONTKqBMsCu6tX4apKZu5ih0CGKyx
	J/crN9QafPeZw/GZ6rmA2gi7fBMG+Sh8OefrRKz+sAXoXbfUlQsbCwpQ5QvE782vVuiVtIpPzhi
	dxpnLk15MVibPm/mNZN4tCJAcx5Uo6Ekiwxu9ECrGKU4HjSfgTvgzPTlmhibNHL3OzdCUPV1L/k
	izj5itGxgWdsRDHRFTSjzPjdLaCAqG/C8WLgtgaw7xdEjuOVqZeQ4ez2Sf4oicmX4XD3pEx/97X
	4Erdw/zsUoQLiS3x24qG9F1cw9IqLOUWvPQGCNvVYOn9ttyQ67D9wTY/RkQIlzBLs2l6m53vy4+
	k0EWSt+Ya6L6z8SMmX2c/M53S8BCXalR3NcdbAB+k/TFNecKATQqMKe8Tg0DH8R3C5MbDJzleZ4
	lTnPFD+iHD86nBFT3JDgxwly+RTE3RYQZrrqCSgQP9xHpMzaVu1iRMt0kI
X-Received: by 2002:a05:7300:dc05:b0:2be:17b1:e49f with SMTP id 5a478bee46e88-3077fd76b6dmr1488843eec.4.1780668554009;
        Fri, 05 Jun 2026 07:09:14 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm7533235eec.17.2026.06.05.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:09:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
References:
 <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
Message-ID: <afc2d34e-eb9b-55d4-b5fc-3023714b9bd4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:09:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/270171=
57085

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/854fb4e76a75
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1106620


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
