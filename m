Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86709333729
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499971; cv=none; b=ebvJCN11PwSmyRgABVQs9PcdoZ49C7IWZoD3tclQbMamj3mGaAKK0GX86YnU1kxQ9/dI+Q/84S/ERH9duCoVlI2c4UMjE6zfI6f+/eMZ0MiE1lffOkz9iMZdqQObFL9PTH7OZuHyhe3PuQtd04LU9a3TY5+jZmISML/TFYY4/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499971; c=relaxed/simple;
	bh=j5yaUbNVrCUtAeMCNTWvf8I9mT52M5/hLhG0YjaO+vc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=u39dgHRt+lEnrpampxxVQS2dBHHN4Dol5vsDz4llUUmLhicM9eBH5cFjQTEqWRr1W98g12HMcYGb+D0wFe+2Bvr/s2TxRGynDcjiyfkQ3zDcyqRa8EGSWAmqjT2mwoNRs/h2GRr9iZiVIaYlxCPw3pkeS1iQnUqmrlqlnByowNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6CKpxKD; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6CKpxKD"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb3dfb3461so82230885a.3
        for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771499969; x=1772104769; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktMCTsyzuxJ1Hye4+KY6h3bU/qg50sehgZAajkE5beI=;
        b=g6CKpxKDvcv817vt2MtNjT844O1J5jUSpmjVWzALiTNs+q/gt4J1ozYRaVaOZ+f2WL
         DqV3k44uL1/uxn84CSQbWZXfR5x6+wDVB2naOpBvMDxSdrN1v2A1zllS8LdzbE6LkM+k
         0nCJ+4ikgid37wB27NXghTs91825xcIwPzHcu1dl15AVkoW1P4Lt4jEklqYqXb1zsjI7
         2YL8m8gcZNp//5K5GBQRDmOnvI3arXF2gns99WKcjTETrOFr2g83cGEVVWLdA29HOanZ
         VFO2MDAtSzvboJcZanl2qdQ+Z4A5YRIUjRNcVVfWNvYs0LnAsu548qYR64YimXu7vWXL
         3yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771499969; x=1772104769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktMCTsyzuxJ1Hye4+KY6h3bU/qg50sehgZAajkE5beI=;
        b=nZpaIYga5FEKd55vZGQsTd2Z4HM85t5tdyR3PHJnbKKbWjB6t+75WkzmmG8j8c43Qp
         rwgYwqU2RETxlZ0TteaVOWqius+J0dZH7VCKtzNco4UJ+CU7X7+gM8vX4QFfzwyKCfXP
         d3aoz3u0YPQ2oZq6sxK5a9/Zd6u5+0PkJChBL0P2mcoUQ4s9pMsvPxTxnBj7OXKFZ4Id
         Hk9hT205rt9sF1hYKCHko5cGgoJ8cI+3TGtjg4zdN0ibXNGa/htWp9056EJftFKEA1RE
         so/h1pk3VXa2Je7EYjfo7jUsxAISmkcluxG6MJdUhk53yGiYh3dug2oeN+qgZE/tlEfP
         D8Nw==
X-Gm-Message-State: AOJu0Yzzs4OalM5k89OBfedMme1kA1qLC2iVYNNdDw+nNkwRL2OUizea
	ub4ZLBmniuiJnkCHIV5gYwFmZJKqv5pbgXS3pkwcZMUhTUfhY+4gMtI=
X-Gm-Gg: AZuq6aKw5GCuGR5glx257QrqB/leTFvqsXh7ur6zFTHUTCQ9syfsyvaogYVLVfxfwIF
	tYgC0ifr/PQpO3BbFQlog+k5Bg0gSCO3ZanxO+lyvLRoG4fXdyMRDEl4GTYYLss2uhKMY03o2kU
	SI4azBkQ2wA1vry4tCa/mFMxQZN+OCuD/rI2fIUfKkFskRch88eZZ3wxyhryZSE/F/++Hya57/c
	gWGREa1/ld3qVmH3igZ9464MHFoLcw1FH6vfaOsj3/ln3Vw4J4qK7B0p84YTztjTW7RZYXdpjfc
	bNSaAw0psKAnu/04TjBgncCYr1pY5LBZHaY/SDoRCXcEuZ/iO7khYDw0VYAjuDQk8iud126BNpg
	zu6IfEf/HoXR0oEAnIscnfcD/llpQpQgfyPJXB31cyEydUM2x+8dOoIA4aTq7+HX6/kgI9JO7z1
	+ZI+T/ysQL5Lg4SvAbyobnLhl0f5j0dbB3Jg==
X-Received: by 2002:a05:620a:4505:b0:8c6:a723:415a with SMTP id af79cd13be357-8cb4081fa72mr2528164485a.11.1771499969148;
        Thu, 19 Feb 2026 03:19:29 -0800 (PST)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c883dsm1988474485a.32.2026.02.19.03.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 03:19:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260219101033.716403-2-matttbe@kernel.org>
References: <20260219101033.716403-2-matttbe@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: check removing
 signal+subflow endp
Message-ID: <e3c2c6c5-8479-c855-14c2-b8304d60d19b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Feb 2026 11:19:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect - Notice: Call Traces at boot time, =
rebooted and continued =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/22177895301

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/970da72339eb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1055468


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
