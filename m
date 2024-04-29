Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EF1DDEB
	for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433816; cv=none; b=iLe+CXBawR1lHgpQIQPwWbAltNC6Eccq8KW/oJwrmPdSiOwcbhbAtDyy4PsyCxXNI2ccsWfOCn2Y6PbAtcrA8o/wtfhgiAe8qdQKXOyNHzy0cHNLVBOKdmc4Y2izjJAnD1G4tZVzTtXjkeRDQOW25wI3/dmK7Yf8zVWT7qS39U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433816; c=relaxed/simple;
	bh=6Gji5/b6R985BZdLbpVFP+5EIoWsHU4JVI7qsu7eo2A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Aoa1l2lLywcFFfVQL29nnQNkpFkcHa9T8J/77l14UzTtgIenQZ7gjgZoi4/b5rANVeXdQrQ1HvaizKD9N98KMWerRU8UEYMelhqXrp/GeLkYwNX+D6vnPV2OWZ1zRd3RvMycYDnN6WGTRvBxBLhe3trNUPRwGmiCUo65CRMfKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcHfxC4D; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcHfxC4D"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b4454e2f1so21727686d6.0
        for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714433814; x=1715038614; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaSq9ubPNsnTuvWqvYKkp8w1z96K8tFtb4y6f9rbBFg=;
        b=mcHfxC4DvnyDzxKjnogBbGI1+jl4jikGHoaZyqO3d9GMuoKzYxf7iWVMtmKctrVVMC
         OZ19a4MI1VAHxeUla/c+WWuQ4a5+FjdQRZL6sz6ABXyYRh4hedzXLw2bS2TjEoAK9/9l
         NjE/BPd4yvARTBBnAA2f1NKBb4eooGs7Z/BODD0SkrrgFNLTsMCLcDWfKsaQ0yMtiG5g
         EzeAdwz8hQ4aPOZhtnX9ncTselEBL6cvlNANJhbkjqfFfqBNlA5pFgRUG7XAFG+1FHTE
         eP4a5guBAeVE8RzE8nDiJ/UB4XXB4V2+vAAIpw3XCp9tx7+j0T+CYWX/UCSGLA3B4AhI
         VabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433814; x=1715038614;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaSq9ubPNsnTuvWqvYKkp8w1z96K8tFtb4y6f9rbBFg=;
        b=qlzDax8XW8ojSZ54Tr4nFHwG8KrrRVCkv4MdDHO8wFmkrba/UYXJnAMmfFyi4DLAQi
         +ME2Eo/cL98zrdRIt8MLdXGq763uja2nEMu6WHcxrSm5XPy36hwDhV8cUcpiopOkIE55
         9uwGwefj5d2jLnZufgCRQWpAlVkXe/IBrK9ep+DTdVq2PqK0b+oVTz79We9qUGoxej5S
         h6HXbb62d+BFrnfrDleRoNFeHimHCj9KB8RcbeCt1rj9PooxYhYQx40EHNCIu5AY3TJ5
         d2B5UzvqUDh2ghAx+mXDThp1Dh5m2zu2fpXKFWxICgM36Alzmi5CXOAc6x8bKmbSerun
         +CAA==
X-Gm-Message-State: AOJu0YyB1so2wAo5La8YP5lEP51cP2G6NikHM/oGQkXIExLVIgcBFswY
	ouIzPzjssZZ4NE+YNOr1rRX1oUEC4LAv0w5oZZuV55+YJr6a/45faBAh
X-Google-Smtp-Source: AGHT+IH1hW4Oo9JO9XfgH3vKjMuxfUCpNm+d9ha7mp6vdOTXAfelaYpdfPaj0WnYq0JZ0dB4UQPrQQ==
X-Received: by 2002:a05:6214:766:b0:6a0:c162:2944 with SMTP id f6-20020a056214076600b006a0c1622944mr9014033qvz.29.1714433813991;
        Mon, 29 Apr 2024 16:36:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.52.203])
        by smtp.gmail.com with ESMTPSA id v1-20020a0ced41000000b006a0d170999dsm1217406qvq.126.2024.04.29.16.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:36:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "Shi-Sheng Yang" <fourcolor4c@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
References: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
Subject: Re: [PATCH] mptcp: subflow.c: fix typo
Message-ID: <a833789b-0da5-9eda-ae0c-b3bf563a3f4a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2024 23:36:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Shi-Sheng,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8886551433

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b0b2f391531a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849072


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
